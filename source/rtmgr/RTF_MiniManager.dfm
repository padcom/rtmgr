object FrmMiniManager: TFrmMiniManager
  Left = 202
  Top = 144
  Width = 670
  Height = 583
  Caption = 'FrmMiniManager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 361
    Top = 0
    Height = 529
    OnMoved = Splitter1Moved
  end
  object PnlListaUlic: TPanel
    Left = 0
    Top = 0
    Width = 361
    Height = 529
    Align = alLeft
    Caption = 'PnlListaUlic'
    TabOrder = 0
    object PnlListaUlicZPostojami: TPanel
      Left = 1
      Top = 1
      Width = 359
      Height = 287
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        359
        287)
      object LblPostoj1Desc: TLabel
        Left = 8
        Top = 151
        Width = 74
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'LblPostoj1Desc'
      end
      object LblPostoj1: TLabel
        Left = 88
        Top = 151
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
      object LblPostoj2: TLabel
        Left = 88
        Top = 167
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
      object LblPostoj2Desc: TLabel
        Left = 8
        Top = 167
        Width = 74
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'LblPostoj2Desc'
      end
      object LblPostoj3Desc: TLabel
        Left = 8
        Top = 183
        Width = 74
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'LblPostoj3Desc'
      end
      object LblPostoj3: TLabel
        Left = 88
        Top = 183
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
      object LblPostoj4: TLabel
        Left = 88
        Top = 199
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
      object LblPostoj4Desc: TLabel
        Left = 8
        Top = 199
        Width = 74
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'LblPostoj4Desc'
      end
      object LblPostoj5Desc: TLabel
        Left = 8
        Top = 215
        Width = 74
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'LblPostoj5Desc'
      end
      object LblPostoj5: TLabel
        Left = 88
        Top = 215
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
      object LblPostoj6: TLabel
        Left = 88
        Top = 231
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
      object LblPostoj6Desc: TLabel
        Left = 8
        Top = 231
        Width = 74
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'LblPostoj6Desc'
      end
      object LblPostoj7Desc: TLabel
        Left = 8
        Top = 247
        Width = 74
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'LblPostoj7Desc'
      end
      object LblPostoj7: TLabel
        Left = 88
        Top = 247
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
      object LblPostoj8: TLabel
        Left = 88
        Top = 263
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
      object LblPostoj8Desc: TLabel
        Left = 8
        Top = 263
        Width = 74
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'LblPostoj8Desc'
      end
      object LblQuickSearch: TLabel
        Left = 8
        Top = 8
        Width = 76
        Height = 13
        Caption = 'LblQuickSearch'
      end
      object LbxUlice: TListBox
        Left = 8
        Top = 48
        Width = 345
        Height = 95
        Style = lbOwnerDrawFixed
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 16
        TabOrder = 0
        OnClick = LbxUliceClick
        OnDrawItem = LbxUliceDrawItem
      end
      object EdtQuickSearch: TEdit
        Left = 8
        Top = 24
        Width = 345
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        Text = 'EdtQuickSearch'
        OnChange = EdtQuickSearchChange
        OnKeyDown = EdtQuickSearchKeyDown
      end
    end
    object PnlListaKursowDoWyslania: TPanel
      Left = 1
      Top = 288
      Width = 359
      Height = 240
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        359
        240)
      object LblKursyDoWyslania: TLabel
        Left = 8
        Top = 0
        Width = 86
        Height = 13
        Caption = 'Kursy do wys'#322'ania'
      end
      object LbxListaKursowDoWyslania: TListBox
        Left = 8
        Top = 16
        Width = 345
        Height = 217
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 16
        ParentFont = False
        TabOrder = 0
        OnDblClick = LbxListaKursowDoWyslaniaDblClick
      end
    end
  end
  object PnlPostoje: TPanel
    Left = 364
    Top = 0
    Width = 298
    Height = 529
    Align = alClient
    Caption = 'PnlPostoje'
    TabOrder = 1
    DesignSize = (
      298
      529)
    object LblPostoje: TLabel
      Left = 8
      Top = 8
      Width = 49
      Height = 13
      Caption = 'LblPostoje'
    end
    object LblAktywneTaksowki: TLabel
      Left = 9
      Top = 432
      Width = 90
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Aktywne Taks'#243'wki'
    end
    object GrdPostoje: TDrawGrid
      Left = 8
      Top = 24
      Width = 282
      Height = 403
      Anchors = [akLeft, akTop, akRight, akBottom]
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      TabOrder = 0
      OnDragDrop = GrdPostojeDragDrop
      OnDragOver = GrdPostojeDragOver
      OnDrawCell = GrdPostojeDrawCell
      OnMouseDown = GrdPostojeMouseDown
      OnMouseUp = GrdPostojeMouseUp
      OnSelectCell = GrdPostojeSelectCell
      OnStartDrag = GrdPostojeStartDrag
    end
    object GrdAktywneTaksowki: TDrawGrid
      Left = 8
      Top = 448
      Width = 282
      Height = 77
      Anchors = [akLeft, akRight, akBottom]
      GridLineWidth = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goThumbTracking]
      TabOrder = 1
      OnDrawCell = GrdAktywneTaksowkiDrawCell
    end
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 72
    object Postawtaks1: TMenuItem
      Caption = 'Postaw taks'#243'wke na postoju (F1)'
      ShortCut = 112
      OnClick = Postawtaks1Click
    end
    object ZdejmijtakswkzpostojuF21: TMenuItem
      Caption = 'Zdejmij taks'#243'wke z postoju (F2)'
      OnClick = ZdejmijtakswkzpostojuF21Click
    end
    object ListaPude1: TMenuItem
      Caption = 'Lista Pude'#322' (F6)'
      ShortCut = 117
      OnClick = ListaPude1Click
    end
    object Gwnacz1: TMenuItem
      Caption = 'Gl'#243'wna czesc programu (ESC)'
      OnClick = Gwnacz1Click
    end
  end
  object TmrUpdater: TTimer
    Interval = 500
    OnTimer = TmrUpdaterTimer
    Left = 56
    Top = 72
  end
end
