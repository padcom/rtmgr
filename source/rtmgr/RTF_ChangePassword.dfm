object FrmChangePassword: TFrmChangePassword
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Zmiana has'#322'a'
  ClientHeight = 151
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object LblPassword1: TLabel
    Left = 8
    Top = 8
    Width = 29
    Height = 13
    Caption = 'Has'#322'o'
  end
  object LblPassword2: TLabel
    Left = 8
    Top = 48
    Width = 68
    Height = 13
    Caption = 'Powt'#243'rz has'#322'o'
  end
  object EdtPassword1: TEdit
    Left = 8
    Top = 24
    Width = 233
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object EdtPassword2: TEdit
    Left = 8
    Top = 64
    Width = 233
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object BtnOK: TButton
    Left = 88
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Zmie'#324
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object BtnCancel: TButton
    Left = 168
    Top = 112
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Anuluj'
    ModalResult = 2
    TabOrder = 3
  end
  object TmrUpdate: TTimer
    Interval = 100
    OnTimer = TmrUpdateTimer
    Left = 16
    Top = 104
  end
end
