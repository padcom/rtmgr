object FrmSelectDate: TFrmSelectDate
  Left = 215
  Top = 234
  BorderStyle = bsDialog
  Caption = 'Data kurs'#243'w'
  ClientHeight = 75
  ClientWidth = 258
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    258
    75)
  PixelsPerInch = 96
  TextHeight = 13
  object LblDataKursow: TLabel
    Left = 8
    Top = 8
    Width = 23
    Height = 13
    Caption = 'Data'
    FocusControl = EdtDataKursow
  end
  object EdtDataKursow: TDateEdit
    Left = 8
    Top = 24
    Width = 153
    Height = 21
    NumGlyphs = 2
    TabOrder = 0
  end
  object BtnAnuluj: TButton
    Left = 179
    Top = 38
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    BiDiMode = bdLeftToRight
    Cancel = True
    Caption = '&Anuluj'
    ModalResult = 2
    ParentBiDiMode = False
    TabOrder = 1
  end
  object BtnOK: TButton
    Left = 179
    Top = 6
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
