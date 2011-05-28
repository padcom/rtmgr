object FrmEdytorKursu: TFrmEdytorKursu
  Left = 142
  Top = 94
  BorderStyle = bsDialog
  Caption = 'Edytor kursu'
  ClientHeight = 374
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  DesignSize = (
    386
    374)
  PixelsPerInch = 96
  TextHeight = 13
  object BtnOK: TButton
    Left = 220
    Top = 340
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object BtnAnuluj: TButton
    Left = 300
    Top = 340
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    BiDiMode = bdLeftToRight
    Cancel = True
    Caption = '&Anuluj'
    ModalResult = 2
    ParentBiDiMode = False
    TabOrder = 1
  end
  object GbxDanePodstawowe: TGroupBox
    Left = 8
    Top = 40
    Width = 369
    Height = 105
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Dane podstawowe'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      369
      105)
    object LblUlica: TLabel
      Left = 8
      Top = 16
      Width = 24
      Height = 13
      Caption = 'Ulica'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BtnSelectUlica: TSpeedButton
      Left = 233
      Top = 32
      Width = 23
      Height = 21
      Anchors = [akTop, akRight]
      Flat = True
      OnClick = BtnSelectUlicaClick
    end
    object LblMieszkanie: TLabel
      Left = 316
      Top = 16
      Width = 36
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Mieszk.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblDom: TLabel
      Left = 264
      Top = 16
      Width = 22
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Dom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblTaksowka: TLabel
      Left = 8
      Top = 60
      Width = 50
      Height = 13
      Caption = 'Taks'#243'wka'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BtnSelectTaksowka: TSpeedButton
      Left = 89
      Top = 76
      Width = 23
      Height = 21
      Flat = True
      OnClick = BtnSelectTaksowkaClick
    end
    object LblDomMiszkDivider: TLabel
      Left = 307
      Top = 36
      Width = 7
      Height = 13
      Anchors = [akTop, akRight]
      Caption = '/'
    end
    object LblPostoj: TLabel
      Left = 205
      Top = 81
      Width = 148
      Height = 13
      AutoSize = False
    end
    object EdtUlica: TEdit
      Left = 8
      Top = 32
      Width = 225
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = EdtUlicaChange
      OnKeyDown = EdtUlicaKeyDown
    end
    object EdtDom: TEdit
      Left = 264
      Top = 32
      Width = 41
      Height = 21
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object EdtMieszkanie: TEdit
      Left = 316
      Top = 32
      Width = 41
      Height = 21
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object EdtTaksowka: TEdit
      Left = 8
      Top = 76
      Width = 81
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnKeyDown = EdtTaksowkaKeyDown
      OnKeyPress = EdtTaksowkaKeyPress
    end
  end
  object GbxPostoje: TGroupBox
    Left = 8
    Top = 248
    Width = 368
    Height = 85
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Postoje'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object LblPostoj1Desc: TLabel
      Left = 8
      Top = 16
      Width = 38
      Height = 13
      Caption = 'Post'#243'j 1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblPostoj1: TLabel
      Left = 64
      Top = 16
      Width = 60
      Height = 13
      Caption = 'LblPostoj1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblPostoj2Desc: TLabel
      Left = 8
      Top = 32
      Width = 38
      Height = 13
      Caption = 'Post'#243'j 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblPostoj2: TLabel
      Left = 64
      Top = 32
      Width = 60
      Height = 13
      Caption = 'LblPostoj2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblPostoj3Desc: TLabel
      Left = 8
      Top = 48
      Width = 38
      Height = 13
      Caption = 'Post'#243'j 3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblPostoj3: TLabel
      Left = 64
      Top = 48
      Width = 60
      Height = 13
      Caption = 'LblPostoj3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblPostoj4Desc: TLabel
      Left = 8
      Top = 64
      Width = 38
      Height = 13
      Caption = 'Post'#243'j 4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblPostoj4: TLabel
      Left = 64
      Top = 64
      Width = 60
      Height = 13
      Caption = 'LblPostoj4'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblPostoj5Desc: TLabel
      Left = 184
      Top = 16
      Width = 38
      Height = 13
      Caption = 'Post'#243'j 5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblPostoj5: TLabel
      Left = 240
      Top = 16
      Width = 60
      Height = 13
      Caption = 'LblPostoj5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblPostoj6Desc: TLabel
      Left = 184
      Top = 32
      Width = 38
      Height = 13
      Caption = 'Post'#243'j 6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblPostoj6: TLabel
      Left = 240
      Top = 32
      Width = 60
      Height = 13
      Caption = 'LblPostoj6'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblPostoj7Desc: TLabel
      Left = 184
      Top = 48
      Width = 38
      Height = 13
      Caption = 'Post'#243'j 7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblPostoj8Desc: TLabel
      Left = 184
      Top = 64
      Width = 38
      Height = 13
      Caption = 'Post'#243'j 8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblPostoj8: TLabel
      Left = 240
      Top = 64
      Width = 60
      Height = 13
      Caption = 'LblPostoj8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblPostoj7: TLabel
      Left = 240
      Top = 48
      Width = 60
      Height = 13
      Caption = 'LblPostoj7'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object PnlPrzyjecieKursu: TPanel
    Left = 8
    Top = 8
    Width = 369
    Height = 30
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    TabOrder = 4
    object LblDataPrzyjeciaKursu: TLabel
      Left = 96
      Top = 8
      Width = 128
      Height = 13
      Caption = 'LblDataPrzyjeciaKursu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblDataPrzyjeciaKursuDesc: TLabel
      Left = 8
      Top = 8
      Width = 77
      Height = 13
      Caption = 'Przyjecie kursu :'
    end
  end
  object GbxOpis: TGroupBox
    Left = 8
    Top = 152
    Width = 369
    Height = 89
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Opis'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object EdtOpis: TMemo
      Left = 8
      Top = 16
      Width = 350
      Height = 65
      TabOrder = 0
    end
  end
end
