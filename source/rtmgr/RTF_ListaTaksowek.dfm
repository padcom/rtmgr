object FrmListaTaksowek: TFrmListaTaksowek
  Left = 166
  Top = 90
  BorderStyle = bsDialog
  Caption = 'FrmListaTaksowek'
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
  object LblListaTaksowek: TLabel
    Left = 0
    Top = 40
    Width = 71
    Height = 13
    Caption = 'Lista taks'#243'wek'
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
  object LbxListaTaksowek: TListBox
    Left = 0
    Top = 56
    Width = 244
    Height = 251
    Style = lbOwnerDrawFixed
    Anchors = [akLeft, akTop, akRight, akBottom]
    IntegralHeight = True
    ItemHeight = 13
    Sorted = True
    TabOrder = 6
    OnClick = LbxListaTaksowekClick
    OnDblClick = LbxListaTaksowekDblClick
    OnDrawItem = LbxListaTaksowekDrawItem
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
    TabOrder = 1
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
    TabOrder = 2
  end
  object BtnNowa: TBitBtn
    Left = 249
    Top = 219
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Nowa'
    TabOrder = 3
    OnClick = BtnNowaClick
  end
  object BtnPopraw: TBitBtn
    Left = 249
    Top = 251
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Popraw'
    TabOrder = 4
    OnClick = BtnPoprawClick
  end
  object BtnUsun: TBitBtn
    Left = 249
    Top = 283
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Usun'
    TabOrder = 5
    OnClick = BtnUsunClick
  end
end
