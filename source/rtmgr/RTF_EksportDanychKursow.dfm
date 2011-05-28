object FrmEksportDanychKursowSimple: TFrmEksportDanychKursowSimple
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Przenoszenie danych na dyskietk'#281
  ClientHeight = 78
  ClientWidth = 403
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
  object LblRok: TLabel
    Left = 0
    Top = 0
    Width = 20
    Height = 13
    Caption = '&Rok'
  end
  object LblMiesiac: TLabel
    Left = 104
    Top = 0
    Width = 36
    Height = 13
    Caption = '&Miesi'#261'c'
  end
  object LblKatalogDocelowy: TLabel
    Left = 0
    Top = 40
    Width = 84
    Height = 13
    Caption = '&Katalog docelowy'
  end
  object CbxRok: TComboBox
    Left = 0
    Top = 16
    Width = 97
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object CbxMiesiac: TComboBox
    Left = 104
    Top = 16
    Width = 129
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
  end
  object BtnPrzerzuc: TButton
    Left = 244
    Top = 14
    Width = 75
    Height = 25
    Caption = '&Przenie'#347
    Default = True
    TabOrder = 2
    OnClick = BtnPrzerzucClick
  end
  object BtnZamknij: TButton
    Left = 324
    Top = 14
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Zamknij'
    ModalResult = 1
    TabOrder = 3
  end
  object EdtKatalogDocelowy: TDirectoryEdit
    Left = 0
    Top = 56
    Width = 401
    Height = 21
    DialogKind = dkWin32
    NumGlyphs = 1
    TabOrder = 4
    Text = 'A:\'
  end
end
