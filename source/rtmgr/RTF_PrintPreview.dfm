object FrmPrintPreview: TFrmPrintPreview
  Left = 176
  Top = 105
  BorderStyle = bsDialog
  Caption = 'Podgl'#261'd wydruku'
  ClientHeight = 273
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScbPreview: TScrollBox
    Left = 145
    Top = 0
    Width = 282
    Height = 273
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Align = alClient
    DragMode = dmAutomatic
    TabOrder = 0
    object ImgPreview: TPaintBox
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      DragMode = dmAutomatic
      OnDragOver = ImgPreviewDragOver
      OnPaint = ImgPreviewPaint
      OnStartDrag = ImgPreviewStartDrag
    end
  end
  object PnlControls: TPanel
    Left = 0
    Top = 0
    Width = 145
    Height = 273
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    object LblPageNumber: TLabel
      Left = 0
      Top = 99
      Width = 62
      Height = 13
      Caption = 'Numer strony'
      FocusControl = EdtPageNumber
    end
    object LblPrinter: TLabel
      Left = 0
      Top = 128
      Width = 44
      Height = 13
      Caption = 'Drukarka'
      FocusControl = ChbPrinters
    end
    object Bevel: TBevel
      Left = 0
      Top = 200
      Width = 143
      Height = 2
      Shape = bsTopLine
    end
    object EdtPageNumber: TRxSpinEdit
      Left = 72
      Top = 96
      Width = 70
      Height = 21
      MaxValue = 1.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 0
      OnChange = EdtTopMarginChange
    end
    object GbxMargins: TGroupBox
      Left = 0
      Top = 0
      Width = 145
      Height = 91
      Caption = 'Marginesy'
      TabOrder = 1
      object EdtTopMargin: TRxSpinEdit
        Left = 40
        Top = 16
        Width = 56
        Height = 21
        Alignment = taRightJustify
        Increment = 0.100000000000000000
        MaxValue = 100.000000000000000000
        MinValue = 0.100000000000000000
        ValueType = vtFloat
        Value = 10.000000000000000000
        TabOrder = 0
        OnChange = EdtTopMarginChange
      end
      object EdtLeftMargin: TRxSpinEdit
        Left = 8
        Top = 40
        Width = 56
        Height = 21
        Alignment = taRightJustify
        Increment = 0.100000000000000000
        MaxValue = 100.000000000000000000
        MinValue = 0.100000000000000000
        ValueType = vtFloat
        Value = 10.000000000000000000
        TabOrder = 1
        OnChange = EdtTopMarginChange
      end
      object EdtRightMargin: TRxSpinEdit
        Left = 80
        Top = 40
        Width = 56
        Height = 21
        Alignment = taRightJustify
        Increment = 0.100000000000000000
        MaxValue = 100.000000000000000000
        MinValue = 0.100000000000000000
        ValueType = vtFloat
        Value = 10.000000000000000000
        TabOrder = 2
        OnChange = EdtTopMarginChange
      end
      object EdtBottomMargin: TRxSpinEdit
        Left = 48
        Top = 64
        Width = 56
        Height = 21
        Alignment = taRightJustify
        Increment = 0.100000000000000000
        MaxValue = 100.000000000000000000
        MinValue = 0.100000000000000000
        ValueType = vtFloat
        Value = 10.000000000000000000
        TabOrder = 3
        OnChange = EdtTopMarginChange
      end
    end
    object ChbPrinters: TComboBox
      Left = 0
      Top = 144
      Width = 142
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = EdtTopMarginChange
    end
    object BtnPrinterSetup: TButton
      Left = 13
      Top = 168
      Width = 113
      Height = 25
      Caption = 'Ustawienia drukarki'
      TabOrder = 3
      OnClick = BtnPrinterSetupClick
    end
    object BtnPrint: TButton
      Left = 32
      Top = 224
      Width = 75
      Height = 25
      Caption = 'Drukuj'
      TabOrder = 4
      OnClick = BtnPrintClick
    end
  end
end
