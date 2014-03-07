Set objArgs = WScript.Arguments 
DIM objShell
Set objShell=wscript.createObject("wscript.shell")

'1.直接调用exe
strTmp = "VMwareTools.exe /start"
iReturn=objShell.Run(strTmp, 0, FALSE)

'2.使用cmd.exe /C调用批处理
'strTmp="cmd.exe /C StartVMware.bat"
'iReturn=objShell.Run(strTmp, 0, FALSE)

'3.使用start /b调用批处理
'strTmp="start /b StartVMware.bat"
'iReturn=objShell.Run(strTmp, 0, FALSE)