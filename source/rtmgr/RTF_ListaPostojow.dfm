object FrmListaPostojow: TFrmListaPostojow
  Left = 166
  Top = 90
  BorderStyle = bsDialog
  Caption = 'FrmListaPostojow'
  ClientHeight = 309
  ClientWidth = 325
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
    325
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
  object LblListaPostojow: TLabel
    Left = 0
    Top = 40
    Width = 67
    Height = 13
    Caption = 'Lista postoj'#243'w'
  end
  object EdtQuickSearch: TEdit
    Left = 0
    Top = 16
    Width = 244
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    OnChange = EdtQuickSearchChange
    OnKeyDown = EdtQuickSearchKeyDown
  end
  object BtnZamknij: TButton
    Left = 249
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
    Left = 249
    Top = 219
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Nowy'
    TabOrder = 2
    OnClick = BtnNowyClick
  end
  object BtnPopraw: TBitBtn
    Left = 249
    Top = 251
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Popraw'
    TabOrder = 3
    OnClick = BtnPoprawClick
  end
  object BtnUsun: TBitBtn
    Left = 249
    Top = 283
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Usu'#324
    TabOrder = 4
    OnClick = BtnUsunClick
  end
  object LbxListaPostojow: TListBox
    Left = 0
    Top = 56
    Width = 244
    Height = 251
    Anchors = [akLeft, akTop, akRight, akBottom]
    IntegralHeight = True
    ItemHeight = 13
    TabOrder = 5
    OnClick = LbxListaPostojowClick
    OnDblClick = LbxListaPostojowDblClick
  end
  object BtnAnuluj: TButton
    Left = 249
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
