object FrmEdytorObszaru: TFrmEdytorObszaru
  Left = 192
  Top = 114
  Width = 418
  Height = 154
  Caption = 'Edytor obszaru'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GbxDaneObszaru: TGroupBox
    Left = 8
    Top = 8
    Width = 313
    Height = 105
    Caption = 'Dane obszaru'
    TabOrder = 0
    object LblNazwa: TLabel
      Left = 8
      Top = 16
      Width = 33
      Height = 13
      Caption = 'Nazwa'
    end
    object LblSkrot: TLabel
      Left = 8
      Top = 56
      Width = 25
      Height = 13
      Caption = 'Skr'#243't'
    end
    object EdtNazwa: TEdit
      Left = 8
      Top = 32
      Width = 297
      Height = 21
      MaxLength = 80
      TabOrder = 0
    end
    object EdtSkrot: TEdit
      Left = 8
      Top = 72
      Width = 121
      Height = 21
      MaxLength = 16
      TabOrder = 1
    end
  end
  object BtnOk: TButton
    Left = 328
    Top = 13
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object BtnCancel: TButton
    Left = 328
    Top = 45
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Anuluj'
    ModalResult = 2
    TabOrder = 2
  end
end
