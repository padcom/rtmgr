object FrmSelectMonth: TFrmSelectMonth
  Left = 271
  Top = 280
  BorderStyle = bsDialog
  Caption = 'FrmSelectMonth'
  ClientHeight = 112
  ClientWidth = 278
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LblYear: TLabel
    Left = 8
    Top = 8
    Width = 20
    Height = 13
    Caption = 'Rok'
  end
  object LblMonth: TLabel
    Left = 144
    Top = 8
    Width = 36
    Height = 13
    Caption = 'Miesi'#261'c'
  end
  object CbxYear: TComboBox
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object CbxMonth: TComboBox
    Left = 144
    Top = 24
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
  end
  object BtnOK: TButton
    Left = 112
    Top = 72
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object BtnCancel: TButton
    Left = 192
    Top = 72
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Anuluj'
    ModalResult = 2
    TabOrder = 3
  end
  object TmrUpdater: TTimer
    Interval = 100
    OnTimer = TmrUpdaterTimer
    Left = 16
    Top = 64
  end
end
