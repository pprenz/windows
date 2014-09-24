import csv
#ifile  = open('/cygdrive/j/aspire/child.csv', 'rb')
ifile  = open('j:/aspire/child.csv', 'rb')
reader = csv.reader(ifile)
ofile  = open('j:/aspire/child_pipe.csv', "wb")
writer = csv.writer(ofile, delimiter='|')
for row in reader:
    writer.writerow(row)
ifile.close()
ofile.close()
