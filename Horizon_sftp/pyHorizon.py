import pyodbc
import csv
import string

connect_string = 'DRIVER={SQL Server};SERVER=db.schoolofone.net;DATABASE=so1masterSQL_sept_clean;UID=sof1;PWD=dbAdmin@so1'

def get_data(tblName, cnxn):
    cursor = cnxn.cursor()
    query = "SELECT student_id, \
					RTRIM(test_id), \
					CONVERT(VARCHAR(10), start_time, 101) + ' ' + SUBSTRING(CONVERT(VARCHAR(15),CONVERT(TIME, start_time)),1,5), \
					CONVERT(VARCHAR(10), end_time, 101) + ' ' + SUBSTRING(CONVERT(VARCHAR(15),CONVERT(TIME, end_time)),1,5), \
					course_id \
			 FROM %s "  %(tblName)
    print query
    cursor.execute(query)
    return [row for row in cursor]

def get_columns(tblName, cnxn):
    cursor = cnxn.cursor()
    cursor.execute("SELECT * FROM INFORMATION_SCHEMA.Columns WHERE TABLE_NAME = '%s'" %string.split(tblName,'.')[1])
    return [row[3] for row in cursor]

def qexport(tblName):
    connection = pyodbc.connect(connect_string)
    outfile = open('%s.csv' %(tblName), 'wb')
    writer = csv.writer(outfile, delimiter = '\t')
    writer.writerow(get_columns(tblName, connection))
    writer.writerows(get_data(tblName, connection))
    outfile.close()

if __name__ == "__main__":
    import sys
    try:
        qexport(sys.argv[1])
    except:
        sys.exit(1)
