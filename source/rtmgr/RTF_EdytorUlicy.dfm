object FrmEdytorUlicy: TFrmEdytorUlicy
  Left = 405
  Top = 269
  BorderStyle = bsDialog
  Caption = 'Edycja wpisu ulicy'
  ClientHeight = 300
  ClientWidth = 603
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GbxDaneOgolne: TGroupBox
    Left = 8
    Top = 8
    Width = 505
    Height = 65
    Caption = 'Dane og'#243'lne'
    TabOrder = 0
    object LblNazwa: TLabel
      Left = 8
      Top = 16
      Width = 33
      Height = 13
      Caption = 'Nazwa'
    end
    object LblPoczatek: TLabel
      Left = 240
      Top = 16
      Width = 45
      Height = 13
      Caption = 'Poczatek'
    end
    object LblKoniec: TLabel
      Left = 304
      Top = 16
      Width = 33
      Height = 13
      Caption = 'Koniec'
    end
    object LblObszar: TLabel
      Left = 368
      Top = 16
      Width = 33
      Height = 13
      Caption = 'Obszar'
    end
    object EdtNazwa: TEdit
      Left = 8
      Top = 32
      Width = 225
      Height = 21
      TabOrder = 0
    end
    object EdtPoczatek: TEdit
      Left = 240
      Top = 32
      Width = 57
      Height = 21
      TabOrder = 1
      OnKeyPress = EdtPoczatekKeyPress
    end
    object EdtKoniec: TEdit
      Left = 304
      Top = 32
      Width = 57
      Height = 21
      TabOrder = 2
      OnKeyPress = EdtPoczatekKeyPress
    end
    object CbxObszar: TComboBox
      Left = 368
      Top = 32
      Width = 129
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
  end
  object GbxPostoje: TGroupBox
    Left = 8
    Top = 80
    Width = 585
    Height = 212
    Caption = 'Postoje przypozadkowane do tego zakresu ulicy'
    TabOrder = 1
    object LblAvailablePostoje: TLabel
      Left = 8
      Top = 24
      Width = 83
      Height = 13
      Caption = 'Dostepne postoje'
    end
    object LblAssignedPostoje: TLabel
      Left = 296
      Top = 24
      Width = 124
      Height = 13
      Caption = 'Przypozadkowane postoje'
    end
    object LbxAvailablePostoje: TListBox
      Left = 8
      Top = 40
      Width = 233
      Height = 161
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      OnDblClick = LbxAvailablePostojeDblClick
    end
    object LbxSelectedPostoje: TListBox
      Left = 296
      Top = 40
      Width = 233
      Height = 161
      ItemHeight = 13
      TabOrder = 1
      OnDblClick = LbxSelectedPostojeDblClick
    end
    object BtnAdd: TBitBtn
      Left = 256
      Top = 80
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 2
      OnClick = BtnAddClick
    end
    object BtnRemove: TBitBtn
      Left = 256
      Top = 112
      Width = 25
      Height = 25
      Caption = '<'
      TabOrder = 3
      OnClick = BtnRemoveClick
    end
    object BtnMoveUp: TBitBtn
      Left = 544
      Top = 80
      Width = 25
      Height = 25
      Caption = '/\'
      TabOrder = 4
      OnClick = BtnMoveUpClick
    end
    object BtnMoveDown: TBitBtn
      Left = 544
      Top = 112
      Width = 25
      Height = 25
      Caption = '\/'
      TabOrder = 5
      OnClick = BtnMoveDownClick
    end
  end
  object BtnOK: TButton
    Left = 520
    Top = 14
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object BtnAnuluj: TButton
    Left = 520
    Top = 46
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Anuluj'
    ModalResult = 2
    TabOrder = 3
  end
  object TmrUpdateButtons: TTimer
    Interval = 10
    OnTimer = TmrUpdateButtonsTimer
    Left = 552
    Top = 96
  end
end
