object FrmEdytorTaksowki: TFrmEdytorTaksowki
  Left = 160
  Top = 158
  BorderStyle = bsDialog
  Caption = 'Edycja wpisu taks'#243'wki'
  ClientHeight = 163
  ClientWidth = 443
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
  PixelsPerInch = 96
  TextHeight = 13
  object GbxDaneOgolne: TGroupBox
    Left = 8
    Top = 8
    Width = 345
    Height = 145
    Caption = 'Dane og'#243'lne'
    TabOrder = 0
    object LblNazwa: TLabel
      Left = 8
      Top = 16
      Width = 69
      Height = 13
      Caption = 'Imie, nazwisko'
    end
    object LblNumerBoczny: TLabel
      Left = 8
      Top = 56
      Width = 68
      Height = 13
      Caption = 'Numer boczny'
    end
    object LblNumerWywolawczy: TLabel
      Left = 8
      Top = 96
      Width = 93
      Height = 13
      Caption = 'Numer wywolawczy'
    end
    object EdtNazwa: TEdit
      Left = 8
      Top = 32
      Width = 329
      Height = 21
      TabOrder = 0
    end
    object EdtNumerBoczny: TEdit
      Left = 8
      Top = 72
      Width = 65
      Height = 21
      TabOrder = 1
      OnKeyPress = EdtNumerBocznyKeyPress
    end
    object EdtNumerWywolawczy: TEdit
      Left = 8
      Top = 112
      Width = 65
      Height = 21
      TabOrder = 2
    end
  end
  object BtnOk: TButton
    Left = 360
    Top = 14
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object BtnAnuluj: TButton
    Left = 360
    Top = 46
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Anuluj'
    ModalResult = 2
    TabOrder = 2
  end
end
