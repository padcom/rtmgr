object FrmEdytorKlienta: TFrmEdytorKlienta
  Left = 78
  Top = 137
  BorderStyle = bsDialog
  Caption = 'Edycja danych klienta'
  ClientHeight = 123
  ClientWidth = 452
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
  object GbxDaneKlienta: TGroupBox
    Left = 8
    Top = 8
    Width = 353
    Height = 105
    Caption = 'Dane klienta'
    TabOrder = 0
    object LblUlica: TLabel
      Left = 8
      Top = 16
      Width = 24
      Height = 13
      Caption = 'Ulica'
    end
    object LblNumerDomu: TLabel
      Left = 248
      Top = 16
      Width = 22
      Height = 13
      Caption = 'Dom'
    end
    object LblPrzez: TLabel
      Left = 292
      Top = 36
      Width = 7
      Height = 13
      Caption = '/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblNumerMieszk: TLabel
      Left = 302
      Top = 16
      Width = 36
      Height = 13
      Caption = 'Mieszk.'
    end
    object BtnSelectUlica: TSpeedButton
      Left = 217
      Top = 32
      Width = 23
      Height = 21
      Flat = True
      OnClick = BtnSelectUlicaClick
    end
    object LblTelefon: TLabel
      Left = 8
      Top = 56
      Width = 36
      Height = 13
      Caption = 'Telefon'
    end
    object EdtUlica: TEdit
      Left = 8
      Top = 32
      Width = 209
      Height = 21
      MaxLength = 80
      TabOrder = 0
      OnKeyDown = EdtUlicaKeyDown
    end
    object EdtNumerDomu: TEdit
      Left = 248
      Top = 32
      Width = 41
      Height = 21
      MaxLength = 10
      TabOrder = 1
    end
    object EdtNumerMieszk: TEdit
      Left = 302
      Top = 32
      Width = 41
      Height = 21
      MaxLength = 10
      TabOrder = 2
    end
    object EdtTelefon: TEdit
      Left = 8
      Top = 72
      Width = 145
      Height = 21
      MaxLength = 15
      TabOrder = 3
    end
  end
  object BtnOK: TButton
    Left = 369
    Top = 14
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object BtnAnuluj: TButton
    Left = 369
    Top = 46
    Width = 75
    Height = 25
    BiDiMode = bdLeftToRight
    Cancel = True
    Caption = '&Anuluj'
    ModalResult = 2
    ParentBiDiMode = False
    TabOrder = 2
  end
end
