object FrmListaKlientow: TFrmListaKlientow
  Left = 162
  Top = 88
  BorderStyle = bsDialog
  Caption = 'FrmListaKlientow'
  ClientHeight = 309
  ClientWidth = 387
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
    387
    309)
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
  object LblListaKlientow: TLabel
    Left = 0
    Top = 40
    Width = 64
    Height = 13
    Caption = 'Lista klient'#243'w'
    FocusControl = LbxListaKlientow
  end
  object EdtQuickSearch: TEdit
    Left = 0
    Top = 16
    Width = 306
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    OnChange = EdtQuickSearchChange
    OnKeyDown = EdtQuickSearchKeyDown
  end
  object BtnZamknij: TButton
    Left = 311
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
    Left = 311
    Top = 219
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Nowy'
    TabOrder = 2
    OnClick = BtnNowyClick
  end
  object BtnPopraw: TBitBtn
    Left = 311
    Top = 251
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Popraw'
    TabOrder = 3
    OnClick = BtnPoprawClick
  end
  object BtnUsun: TBitBtn
    Left = 311
    Top = 283
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Usun'
    TabOrder = 4
    OnClick = BtnUsunClick
  end
  object LbxListaKlientow: TListBox
    Left = 0
    Top = 56
    Width = 306
    Height = 251
    Style = lbOwnerDrawFixed
    Anchors = [akLeft, akTop, akRight, akBottom]
    IntegralHeight = True
    ItemHeight = 13
    TabOrder = 5
    OnClick = LbxListaKlientowClick
    OnDblClick = LbxListaKlientowDblClick
    OnDrawItem = LbxListaKlientowDrawItem
  end
  object BtnAnuluj: TButton
    Left = 311
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
