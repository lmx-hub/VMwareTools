unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, shellapi, ShapeBtn, Menus, TrayIconEx, vmware;

type
  TfrmMain = class(TForm)
    TrayIconEx: TTrayIconEx;
    PopupMenu: TPopupMenu;
    nStart: TMenuItem;
    nMax: TMenuItem;
    nBar: TMenuItem;
    N1: TMenuItem;
    nExit: TMenuItem;
    nQuit: TMenuItem;
    Timer: TTimer;
    procedure btnMaxClick(Sender: TObject);
    procedure btnBarClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure nExitClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure nQuitClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    FWMware: TWMware;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnMaxClick(Sender: TObject);
begin
  FWMware.SetMaxOrNomal;
end;

procedure TfrmMain.btnBarClick(Sender: TObject);
begin
  FWMware.ShowBar;
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  Timer.Enabled := FWMware.Start;
end;   

procedure TfrmMain.TimerTimer(Sender: TObject);
begin
  if not FWMware.IsMainVisible then
    exit;

  Timer.Enabled := false;
  sleep(2000);

  FWMware.SetMaxOrNomal(false);
  FWMware.ShowBar;
end;

procedure TfrmMain.nQuitClick(Sender: TObject);
begin
  FWMware.Exit;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TfrmMain.FormActivate(Sender: TObject);
begin   
  showwindow(Handle,SW_HIDE);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin               
  if ParamCount>=1 then
    btnStartClick(nil);

  TrayIconEx.Icon:=application.Icon;
  TrayIconEx.Visible:=true;
end;

procedure TfrmMain.nExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.PopupMenuPopup(Sender: TObject);
begin
  nStart.Enabled  := FWMware.GetMain = 0;
  nQuit.Enabled   := not nStart.Enabled;
  nMax.Enabled    := nQuit.Enabled and not FWMware.IsMaxed;
  nBar.Enabled    := nQuit.Enabled and not FWMware.IsBarVisible;
end;

end.
