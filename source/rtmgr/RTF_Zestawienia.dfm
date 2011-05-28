object FrmZestawienia: TFrmZestawienia
  Left = 30
  Top = 78
  BorderStyle = bsDialog
  Caption = 'FrmZestawienia'
  ClientHeight = 309
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GrdZestawienie: TStringGrid
    Left = 0
    Top = 0
    Width = 509
    Height = 276
    Align = alClient
    ColCount = 1
    DefaultColWidth = 18
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goRowSelect, goThumbTracking]
    TabOrder = 0
    OnKeyDown = GrdZestawienieKeyDown
  end
  object PnlButtons: TPanel
    Left = 0
    Top = 276
    Width = 509
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      509
      33)
    object BtnPrint: TButton
      Left = 8
      Top = 6
      Width = 121
      Height = 25
      Caption = '&Drukuj'
      TabOrder = 0
      OnClick = BtnPrintClick
    end
    object BtnExcel: TButton
      Left = 136
      Top = 6
      Width = 121
      Height = 25
      Caption = 'Eksport do MS-Excel'
      Enabled = False
      TabOrder = 1
      OnClick = BtnExcelClick
    end
    object BtnClose: TButton
      Left = 426
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Zamknij'
      ModalResult = 1
      TabOrder = 2
    end
  end
end
