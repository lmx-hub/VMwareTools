unit vmware;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, shellapi, ShapeBtn, Menus, TrayIconEx;
type
  TWMware = class(TObject)
  public
    procedure SetStyle;
    procedure SetMaxOrNomal(bMax:boolean=true);
    procedure ShowBar;
    function Start:boolean;
    procedure Exit;

    function GetMain: HWND;
    function GetBar: HWND;
    function IsMainVisible: boolean;
    function IsBarVisible: boolean;
    function IsMaxed: boolean;
  end;

implementation

function TWMware.GetMain: HWND;
begin
  Result := FindWindow('#32770', 'Win10');
  if Result = 0 then
    Result := FindWindow('#32770', 'Win8');
  if Result = 0 then
    Result := FindWindow('#32770', 'Win7');
end;

function TWMware.GetBar: HWND;
begin
  Result := FindWindowEx(GetMain, 0, 'WswcFSBar', '');
end;  

function TWMware.IsMainVisible: boolean;
begin
  Result := IsWindowVisible(GetMain);
end;

function TWMware.IsBarVisible: boolean;
begin
  Result := IsWindowVisible(GetBar);
end;  

function TWMware.IsMaxed: boolean;
begin
  result := GetWindowLong(GetMain, GWL_STYLE) and WS_MAXIMIZE = WS_MAXIMIZE;
end;

procedure TWMware.SetStyle;
var
  id: HWND;
  lStyle: DWord;
begin
  id := GetMain;
  if id=0 then
    exit;

  lStyle := GetWindowLong(id, GWL_STYLE);
  if (lStyle and WS_THICKFRAME) = WS_THICKFRAME then
  begin
    lStyle := lStyle and not WS_THICKFRAME;
    SetWindowLong(id, GWL_STYLE, lStyle);
  end;

  lStyle := GetWindowLong(id, GWL_EXSTYLE);
  if (lStyle and WS_EX_WINDOWEDGE) = WS_EX_WINDOWEDGE then
  begin
    lStyle := lStyle and not WS_EX_WINDOWEDGE;
    SetWindowLong(id, GWL_EXSTYLE, lStyle);
  end;
end;

procedure TWMware.SetMaxOrNomal(bMax:boolean=true);
var
  id:HWND;
  rect:TRect;
  winfull:WINDOWPLACEMENT;
begin
  id := GetMain;
  if id=0 then
    exit;

  SetStyle;

  rect := screen.WorkAreaRect;
  rect.Left:=-8;
  rect.Right:=screen.WorkAreaWidth*2+8;
  rect.Top:=-34;
  rect.Bottom:=screen.WorkAreaHeight+20;

  winfull.length:=sizeof(WINDOWPLACEMENT);
  winfull.flags:=WPF_RESTORETOMAXIMIZED;
  if bMax then
    winfull.showCmd:= SW_SHOWMAXIMIZED
  else
    winfull.showCmd:= SW_SHOWNORMAL;
  winfull.ptMaxPosition:=rect.BottomRight;
  winfull.rcNormalPosition:=rect;
  SetWindowPlacement(id, @winfull);

  if not bMax then
    ShowBar;
end;

procedure TWMware.ShowBar;
var
  id: HWND;
  rect:TRect;
  pt:TPoint;
  Left, Top:cardinal;
  procedure Click;
  begin
    GetCursorPos(pt);
    SetCursorPos(Left, Top);
    mouse_event(MOUSEEVENTF_LEFTDOWN or MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
    SetCursorPos(pt.x, pt.y);
  end;
begin
  id := GetBar;
  if (id<>0) and not IsWindowVisible(id) then
  begin
    ShowWindow(id, SW_SHOW);
    GetWindowRect(id, rect);
    Left := (screen.WorkAreaWidth-(rect.Right-rect.Left)) div 2;
    Top := screen.WorkAreaTop;
    MoveWindow(id, Left, Top+34, rect.Right-rect.Left, rect.Bottom-rect.Top, true);

    //两次单击工具栏锚点按钮
    Left := Left + 12;
    Top := Top + 5;

    Click;
    sleep(GetDoubleClickTime + 20);
    Click;
  end;
end;

function TWMware.Start:boolean;
var
  id:HWND;
begin
  id := GetMain;
  result := id = 0;
  if not result then
    exit;

  ShellExecute(0, 'Open',
    'D:\Program Files\VMware\VMware View\Client\bin\wswc.exe',                                                                  //windowLarge fullscreen
    '-nonInteractive -serverUrl 192.168.23.250 -userName lmx -password 2022865.w -domainName YFB -desktopName Win8 -desktopLayout multimonitor -desktopProtocol PCoIP',
    nil, SW_SHOW);
end;   

procedure TWMware.Exit;
var
  id:HWND;
begin
  id := GetMain;
  if id=0 then
    exit;

  ShellExecute(0, 'Open',
    'D:\Program Files\VMware\VMware View\Client\bin\wswc.exe',
    '-shutdown',
    nil, SW_SHOW);
end;

end.
