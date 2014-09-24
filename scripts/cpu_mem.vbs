Dim EmailSent 
Dim ScanSpeed 
Dim strComputer 
Dim intMaxLoad 
Dim intMaxBytes 
  
ScanSpeed   = 1 
strComputer = "." 
EmailSent   = False 
intMaxLoad  = 50 
intMaxMB    = 100 
  
Set ProcessorSink = WScript.CreateObject("WbemScripting.SWbemSink", "ProcessorSink_") 
Set Processor = GetObject("winMgmts:{(security)}\\" & strComputer & "\root\cimv2") 
Processor.ExecNotificationQueryAsync ProcessorSink, "select * FROM __InstanceModificationEvent WITHIN " & ScanSpeed & " where targetinstance isa 'Win32_Processor'" 
  
  
Set ProcessSink = WScript.CreateObject("WbemScripting.SWbemSink", "ProcessSink_") 
Set Process = GetObject("winMgmts:{(security)}\\" & strComputer & "\root\cimv2") 
Process.ExecNotificationQueryAsync ProcessSink, "select * from __InstanceModificationEvent WITHIN " & ScanSpeed & " where targetinstance isa 'Win32_Process'" 
  
Sub ProcessorSink_OnObjectReady(objObject, objAsyncContext) 
    intLoad = objObject.TargetInstance.LoadPercentage 
    if CInt(intLoad) > CInt(intMaxLoad) then 
        if NOT EmailSent then 
            'wscript.echo "Sending alert for CPU usage. Load = '" & intLoad & "%'" 
            SendEmail "CPU Usage over 50%","The server has logged CPU usage over 50%." 
            EmailSent = True 
        end if 
    else 
        EmailSent = False 
    end if 
End Sub 
  
Sub ProcessSink_OnObjectReady(objObject, objAsyncContext) 
    strName = objObject.TargetInstance.Name 
    strPath = objObject.TargetInstance.ExecutablePath 
    intSize = (objObject.TargetInstance.workingsetsize / 1024) / 1024 
    if CInt(intSize) > CInt(intMaxMB) then 
        'wscript.echo "Sending alert for memory usage. '" & strName & "' = " & intSize 
        SendEmail "Memory usage for process over 100 MB","The server has logged process '" & strName & "' is using more than 100 MB." 
    end if 
End Sub 
  
Sub SendEmail(messagesubject,messagebody) 
    On Error Resume Next 
    Dim objMessage 
    Set objMessage = CreateObject("CDO.Message") 
    with objMessage 
        .From = "someone@domain.com" 
        .To = "someone@domain.com" 
        .Subject = messagesubject 
        .TextBody = messagebody 
        .Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 
        .Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "your-exchange-server" 
        .Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
        .Configuration.Fields.Update 
        .Send 
      end with 
      Set objMessage = Nothing 
End Sub 
