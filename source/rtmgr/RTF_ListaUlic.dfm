object FrmListaUlic: TFrmListaUlic
  Left = 49
  Top = 18
  BorderStyle = bsDialog
  Caption = 'FrmListaUlic'
  ClientHeight = 359
  ClientWidth = 457
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
  DesignSize = (
    457
    359)
  PixelsPerInch = 96
  TextHeight = 13
  object LblQuickSearch: TLabel
    Left = 0
    Top = 0
    Width = 105
    Height = 13
    Caption = 'Szybkie wyszukiwanie'
    FocusControl = EdtQuickSearch
  end
  object LblListaUlic: TLabel
    Left = 0
    Top = 40
    Width = 41
    Height = 13
    Caption = 'Lista ulic'
    FocusControl = LbxListaUlic
  end
  object Bevel1: TBevel
    Left = 0
    Top = 288
    Width = 452
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object LblPostoj1Desc: TLabel
    Left = 0
    Top = 296
    Width = 38
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Post'#243'j 1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LblPostoj1: TLabel
    Left = 56
    Top = 296
    Width = 60
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'LblPostoj1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblPostoj2Desc: TLabel
    Left = 0
    Top = 312
    Width = 38
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Post'#243'j 2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LblPostoj2: TLabel
    Left = 56
    Top = 312
    Width = 60
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'LblPostoj2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblPostoj3Desc: TLabel
    Left = 0
    Top = 328
    Width = 38
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Post'#243'j 3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LblPostoj3: TLabel
    Left = 56
    Top = 328
    Width = 60
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'LblPostoj3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblPostoj6Desc: TLabel
    Left = 224
    Top = 312
    Width = 38
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Post'#243'j 6'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LblPostoj6: TLabel
    Left = 280
    Top = 312
    Width = 60
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'LblPostoj6'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblPostoj5: TLabel
    Left = 280
    Top = 296
    Width = 60
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'LblPostoj5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblPostoj5Desc: TLabel
    Left = 224
    Top = 296
    Width = 38
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Post'#243'j 5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LblPostoj4Desc: TLabel
    Left = 0
    Top = 344
    Width = 38
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Post'#243'j 4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LblPostoj4: TLabel
    Left = 56
    Top = 344
    Width = 60
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'LblPostoj4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblPostoj8Desc: TLabel
    Left = 224
    Top = 344
    Width = 38
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Post'#243'j 8'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LblPostoj8: TLabel
    Left = 280
    Top = 344
    Width = 60
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'LblPostoj8'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblPostoj7: TLabel
    Left = 280
    Top = 328
    Width = 60
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'LblPostoj7'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblPostoj7Desc: TLabel
    Left = 224
    Top = 328
    Width = 38
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Post'#243'j 7'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LbxListaUlic: TListBox
    Left = 0
    Top = 56
    Width = 376
    Height = 228
    Style = lbOwnerDrawFixed
    Anchors = [akLeft, akTop, akRight, akBottom]
    IntegralHeight = True
    ItemHeight = 16
    TabOrder = 0
    OnClick = LbxListaUlicClick
    OnDblClick = LbxListaUlicDblClick
    OnDrawItem = LbxListaUlicDrawItem
  end
  object EdtQuickSearch: TEdit
    Left = 0
    Top = 16
    Width = 376
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    OnChange = EdtQuickSearchChange
    OnKeyDown = EdtQuickSearchKeyDown
  end
  object BtnZamknij: TButton
    Left = 380
    Top = 16
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object BtnAnuluj: TButton
    Left = 380
    Top = 48
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Anuluj'
    ModalResult = 2
    TabOrder = 3
  end
  object BtnNowa: TBitBtn
    Left = 380
    Top = 197
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Nowa'
    TabOrder = 4
    OnClick = BtnNowaClick
  end
  object BtnPopraw: TBitBtn
    Left = 380
    Top = 229
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Popraw'
    TabOrder = 5
    OnClick = BtnPoprawClick
  end
  object BtnUsun: TBitBtn
    Left = 380
    Top = 259
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Usun'
    TabOrder = 6
    OnClick = BtnUsunClick
  end
end
