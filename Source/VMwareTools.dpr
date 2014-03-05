program VMwareTools;

uses
  Forms,
  windows,
  main in 'main.pas' {frmMain},
  vmware in 'vmware.pas';

{$R *.res}

var
  hMutex:integer=0;
const
  NameMutex = 'Mutex_VMwareTools_LMX';

begin   
  if OpenMutex(MUTEX_ALL_ACCESS, False, NameMutex) <> 0 then
    Halt
  else
    hMutex := CreateMutex(nil, False, NameMutex);


  Application.Initialize;

  SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW or WS_EX_LAYERED);
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm:=false;

  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
  

  if hMutex<>0 then
    CloseHandle(hMutex);
end.
