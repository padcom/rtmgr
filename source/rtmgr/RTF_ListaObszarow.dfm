object FrmListaObszarow: TFrmListaObszarow
  Left = 414
  Top = 227
  Width = 411
  Height = 347
  Caption = 'FrmListaObszarow'
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
  DesignSize = (
    403
    320)
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
  object LblListaObszarow: TLabel
    Left = 0
    Top = 40
    Width = 70
    Height = 13
    Caption = 'Lista obszar'#243'w'
    FocusControl = LbxListaObszarow
  end
  object EdtQuickSearch: TEdit
    Left = 0
    Top = 16
    Width = 317
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    OnChange = EdtQuickSearchChange
    OnKeyDown = EdtQuickSearchKeyDown
  end
  object BtnZamknij: TButton
    Left = 322
    Top = 16
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = '&Zamknij'
    ModalResult = 1
    TabOrder = 1
  end
  object BtnNowy: TBitBtn
    Left = 322
    Top = 219
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Nowy'
    TabOrder = 2
    OnClick = BtnNowyClick
  end
  object BtnPopraw: TBitBtn
    Left = 322
    Top = 251
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Popraw'
    TabOrder = 3
    OnClick = BtnPoprawClick
  end
  object BtnUsun: TBitBtn
    Left = 322
    Top = 283
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Usun'
    TabOrder = 4
    OnClick = BtnUsunClick
  end
  object LbxListaObszarow: TListBox
    Left = 0
    Top = 56
    Width = 317
    Height = 251
    Style = lbOwnerDrawFixed
    Anchors = [akLeft, akTop, akRight, akBottom]
    IntegralHeight = True
    ItemHeight = 13
    TabOrder = 5
    OnClick = LbxListaObszarowClick
    OnDblClick = LbxListaObszarowDblClick
    OnDrawItem = LbxListaObszarowDrawItem
  end
  object BtnAnuluj: TButton
    Left = 322
    Top = 48
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Anuluj'
    ModalResult = 2
    TabOrder = 6
  end
end
