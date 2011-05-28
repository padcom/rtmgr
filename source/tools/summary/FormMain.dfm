object FrmMain1: TFrmMain1
  Left = 4
  Top = 103
  Width = 635
  Height = 332
  Caption = 'Podsumowanie kurs'#243'w'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TabSet: TTabSet
    Left = 0
    Top = 245
    Width = 627
    Height = 21
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    OnChange = TabSetChange
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 266
    Width = 627
    Height = 19
    Panels = <>
  end
  object GrdKursy: TDrawGrid
    Left = 0
    Top = 0
    Width = 627
    Height = 245
    Align = alClient
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goThumbTracking]
    TabOrder = 2
    OnDrawCell = GrdKursyDrawCell
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 24
    object MnuPlik: TMenuItem
      Caption = '&Plik'
      object MniDrzewoPostojow: TMenuItem
        Caption = 'Drzewo postoj'#243'w'
        ShortCut = 120
        OnClick = MniDrzewoPostojowClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MniKoniec: TMenuItem
        Caption = '&Koniec'
        ShortCut = 32883
        OnClick = MniKoniecClick
      end
    end
    object MnuEdycja: TMenuItem
      Caption = '&Edycja'
      object MniPoprawKurs: TMenuItem
        Caption = '&Popraw kurs'
        ShortCut = 115
        OnClick = MniPoprawKursClick
      end
      object MniUsuKurs: TMenuItem
        Caption = '&Usun kurs'
        ShortCut = 119
        OnClick = MniUsuKursClick
      end
    end
    object MnuPomoc: TMenuItem
      Caption = 'P&omoc'
      object MniOProgramie: TMenuItem
        Caption = '&O programie'
        ShortCut = 112
        OnClick = MniOProgramieClick
      end
    end
  end
end
