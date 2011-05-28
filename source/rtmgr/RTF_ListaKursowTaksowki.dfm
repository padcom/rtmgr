object FrmListaKursowTaksowki: TFrmListaKursowTaksowki
  Left = 117
  Top = 108
  BorderStyle = bsDialog
  Caption = 'FrmListaKursowTaksowki'
  ClientHeight = 273
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlButtons: TPanel
    Left = 0
    Top = 232
    Width = 427
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      427
      41)
    object Button1: TButton
      Left = 344
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&Zamknij'
      ModalResult = 1
      TabOrder = 0
    end
  end
  object GrdKursy: TStringGrid
    Left = 0
    Top = 0
    Width = 427
    Height = 232
    Align = alClient
    ColCount = 1
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowSelect, goThumbTracking]
    TabOrder = 1
  end
end
