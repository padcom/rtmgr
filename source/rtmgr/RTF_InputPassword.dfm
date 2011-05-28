object FrmInputPassword: TFrmInputPassword
  Left = 256
  Top = 297
  BorderStyle = bsDialog
  Caption = 'Podaj has'#322'o'
  ClientHeight = 115
  ClientWidth = 245
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
  object LblPassword: TLabel
    Left = 8
    Top = 16
    Width = 29
    Height = 13
    Caption = 'Has'#322'o'
  end
  object EdtPassword: TEdit
    Left = 8
    Top = 32
    Width = 225
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object BtnOK: TButton
    Left = 80
    Top = 72
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object BtnCancel: TButton
    Left = 160
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Anuluj'
    ModalResult = 2
    TabOrder = 2
  end
end
