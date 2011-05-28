object FrmDrzewoPostojow: TFrmDrzewoPostojow
  Left = 192
  Top = 107
  Width = 494
  Height = 454
  Caption = 'Drzewo postoj'#243'w'
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
    486
    427)
  PixelsPerInch = 96
  TextHeight = 13
  object LblZnajdz: TLabel
    Left = 0
    Top = 0
    Width = 59
    Height = 13
    Caption = 'ZnajdY ulice'
  end
  object TrvPostoje: TTreeView
    Left = 0
    Top = 40
    Width = 385
    Height = 385
    Anchors = [akLeft, akTop, akRight, akBottom]
    HotTrack = True
    Indent = 19
    ReadOnly = True
    RightClickSelect = True
    SortType = stText
    TabOrder = 0
  end
  object BtnZamknij: TBitBtn
    Left = 392
    Top = 64
    Width = 89
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = '&Zamknij'
    TabOrder = 3
    OnClick = BtnZamknijClick
  end
  object EdtZnajdz: TEdit
    Left = 0
    Top = 16
    Width = 385
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object BtnZnajdz: TButton
    Left = 392
    Top = 16
    Width = 89
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'ZnajdY'
    Default = True
    TabOrder = 2
    OnClick = BtnZnajdzClick
  end
end
