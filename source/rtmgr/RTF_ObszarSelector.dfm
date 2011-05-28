object FrmObszarSelector: TFrmObszarSelector
  Left = 299
  Top = 180
  BorderStyle = bsDialog
  Caption = 'Wybierz obszary dla tego stanowiska'
  ClientHeight = 306
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LblObszary: TLabel
    Left = 8
    Top = 8
    Width = 38
    Height = 13
    Caption = 'Obszary'
  end
  object LbxObszary: TCheckListBox
    Left = 8
    Top = 24
    Width = 241
    Height = 273
    ItemHeight = 13
    TabOrder = 0
  end
  object BtnOk: TButton
    Left = 256
    Top = 24
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object BtnCancel: TButton
    Left = 256
    Top = 56
    Width = 81
    Height = 25
    Cancel = True
    Caption = 'Anuluj'
    ModalResult = 2
    TabOrder = 2
  end
end
