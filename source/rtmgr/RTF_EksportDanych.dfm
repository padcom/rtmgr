object FrmEksportDanychKursow: TFrmEksportDanychKursow
  Left = 80
  Top = 62
  BorderStyle = bsDialog
  Caption = 'Eksport danych kursow'
  ClientHeight = 325
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 217
    Height = 284
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 116
      Height = 13
      Caption = 'Lista danych zr'#243'dlowych'
    end
    object LbxSource: TListBox
      Left = 0
      Top = 16
      Width = 217
      Height = 268
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 217
    Top = 0
    Width = 47
    Height = 284
    BevelOuter = bvNone
    TabOrder = 1
    object BtnDodaj: TButton
      Left = 8
      Top = 32
      Width = 32
      Height = 25
      Caption = '>'
      TabOrder = 0
      OnClick = BtnDodajClick
    end
    object BtnUsun: TButton
      Left = 8
      Top = 64
      Width = 32
      Height = 25
      Caption = '<'
      TabOrder = 1
      OnClick = BtnUsunClick
    end
  end
  object Panel3: TPanel
    Left = 264
    Top = 0
    Width = 220
    Height = 284
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    object Label2: TLabel
      Left = 0
      Top = 0
      Width = 139
      Height = 13
      Caption = 'Lista danych do przeniesienia'
    end
    object LbxDest: TListBox
      Left = 0
      Top = 16
      Width = 220
      Height = 268
      ItemHeight = 13
      MultiSelect = True
      TabOrder = 0
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 284
    Width = 484
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object EdtKatalog: TDirectoryEdit
      Left = 0
      Top = 16
      Width = 297
      Height = 21
      DialogKind = dkWin32
      DialogText = 'Wskaz katalog docelowy do przeniesienia plik'#243'w kurs'#243'w'
      NumGlyphs = 1
      TabOrder = 0
    end
    object BtnPrzerzuc: TButton
      Left = 312
      Top = 14
      Width = 75
      Height = 25
      Caption = '&Przerzuc'
      TabOrder = 1
      OnClick = BtnPrzerzucClick
    end
    object BtnZamknij: TButton
      Left = 400
      Top = 14
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&Zamknij'
      ModalResult = 1
      TabOrder = 2
    end
  end
end
