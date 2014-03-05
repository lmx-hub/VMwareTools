object frmMain: TfrmMain
  Left = 0
  Top = 0
  Margins.Bottom = 100
  BorderStyle = bsDialog
  Caption = 'VMware tools'
  ClientHeight = 70
  ClientWidth = 181
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clHighlight
  Font.Height = -27
  Font.Name = #24494#36719#38597#40657
  Font.Style = [fsBold]
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 36
  object TrayIconEx: TTrayIconEx
    Animate = False
    PopupMenu = PopupMenu
    Visible = True
    Left = 40
    Top = 8
  end
  object PopupMenu: TPopupMenu
    AutoHotkeys = maManual
    AutoLineReduction = maManual
    OnPopup = PopupMenuPopup
    Left = 8
    Top = 8
    object nStart: TMenuItem
      Caption = 'VMware '#21551#21160
      OnClick = btnStartClick
    end
    object nBar: TMenuItem
      Caption = 'VMware '#24037#20855#26639
      OnClick = btnBarClick
    end
    object nMax: TMenuItem
      Caption = 'VMware '#26368#22823#21270
      OnClick = btnMaxClick
    end
    object nQuit: TMenuItem
      Caption = 'VMware '#36864#20986
      OnClick = nQuitClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object nExit: TMenuItem
      Caption = #36864#20986
      OnClick = nExitClick
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 72
    Top = 8
  end
end
