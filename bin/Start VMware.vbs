Set objArgs = WScript.Arguments 
DIM objShell
Set objShell=wscript.createObject("wscript.shell")

'1.ֱ�ӵ���exe
strTmp = "VMwareTools.exe /start"
iReturn=objShell.Run(strTmp, 0, FALSE)

'2.ʹ��cmd.exe /C����������
'strTmp="cmd.exe /C StartVMware.bat"
'iReturn=objShell.Run(strTmp, 0, FALSE)

'3.ʹ��start /b����������
'strTmp="start /b StartVMware.bat"
'iReturn=objShell.Run(strTmp, 0, FALSE)