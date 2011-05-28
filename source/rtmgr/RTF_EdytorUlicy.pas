unit RTF_EdytorUlicy;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, JvUIB, JvUIBLib;

type
  TFrmEdytorUlicy = class(TForm)
    GbxDaneOgolne: TGroupBox;
    EdtNazwa: TEdit;
    LblNazwa: TLabel;
    EdtPoczatek: TEdit;
    LblPoczatek: TLabel;
    EdtKoniec: TEdit;
    LblKoniec: TLabel;
    GbxPostoje: TGroupBox;
    BtnOK: TButton;
    BtnAnuluj: TButton;
    LbxAvailablePostoje: TListBox;
    LbxSelectedPostoje: TListBox;
    BtnAdd: TBitBtn;
    BtnRemove: TBitBtn;
    BtnMoveUp: TBitBtn;
    BtnMoveDown: TBitBtn;
    LblAvailablePostoje: TLabel;
    LblAssignedPostoje: TLabel;
    TmrUpdateButtons: TTimer;
    CbxObszar: TComboBox;
    LblObszar: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdtPoczatekKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnRemoveClick(Sender: TObject);
    procedure BtnMoveUpClick(Sender: TObject);
    procedure BtnMoveDownClick(Sender: TObject);
    procedure TmrUpdateButtonsTimer(Sender: TObject);
    procedure LbxAvailablePostojeDblClick(Sender: TObject);
    procedure LbxSelectedPostojeDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FId: Integer;
    FObszarId: Integer;
    procedure DisplayObszary;
    procedure DisplayAssignedPostoje;
    procedure DisplayAvailablePostoje;
    procedure ClearAssignedPostoje;
    procedure ClearAvailablePostoje;
  public
    { Public declarations }
    procedure SetData(Fields: TSQLResult);
  end;

implementation

uses
  Math, RT_Tools, RT_SQL;

{$R *.DFM}

type
  TPostoj = class (TObject)
    Id: Integer;
    Nazwa: String;
    constructor Create(AId: Integer; ANazwa: String);
  end;

constructor TPostoj.Create(AId: Integer; ANazwa: String);
begin
  inherited Create;
  Id := AId;
  Nazwa := ANazwa;
end;

{ TFrmEdytorUlicy }

{ Private declarations }

procedure TFrmEdytorUlicy.DisplayObszary;
var
  Index: Integer;
begin
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := 'SELECT ID,NAZWA FROM OBSZAR';
      Open;
      while not Eof do
      begin
        Index := CbxObszar.Items.AddObject(Fields.ByNameAsString['NAZWA'], Pointer(Fields.ByNameAsInteger['ID']));
        if Fields.ByNameAsInteger['ID'] = FObszarId then
          CbxObszar.ItemIndex := Index;
        Next;
      end;
    finally
      Free;
    end;
end;

procedure TFrmEdytorUlicy.DisplayAssignedPostoje;
begin
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT * FROM POSTOJ WHERE ID NOT IN (SELECT POSTOJID FROM POSTOJNAULICY WHERE POSTOJNAULICY.ULICAID = %d)', [
        FId
      ]);
      Open;
      while not Eof do
      begin
        LbxAvailablePostoje.AddItem(Fields.ByNameAsString['NAZWA'], TPostoj.Create(Fields.ByNameAsInteger['ID'], Fields.ByNameAsString['NAZWA']));
        Next;
      end;
    finally
      Free;
    end;
end;

procedure TFrmEdytorUlicy.DisplayAvailablePostoje;
begin
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT POSTOJ.ID, POSTOJ.NAZWA FROM POSTOJNAULICY INNER JOIN POSTOJ ON (POSTOJNAULICY.POSTOJID = POSTOJ.ID) WHERE POSTOJNAULICY.ULICAID = %d ORDER BY POSTOJNAULICY.INDEKS', [
        FId
      ]);
      Open;
      while not Eof do
      begin
        LbxSelectedPostoje.AddItem(Fields.ByNameAsString['NAZWA'], TPostoj.Create(Fields.ByNameAsInteger['ID'], Fields.ByNameAsString['NAZWA']));
        Next;
      end;
    finally
      Free;
    end;
end;

procedure TFrmEdytorUlicy.ClearAssignedPostoje;
var
  I: Integer;
begin
  for I := 0 to LbxAvailablePostoje.Count - 1 do
    LbxAvailablePostoje.Items.Objects[I].Free;
end;

procedure TFrmEdytorUlicy.ClearAvailablePostoje;
var
  I: Integer;
begin
  for I := 0 to LbxSelectedPostoje.Count - 1 do
    LbxSelectedPostoje.Items.Objects[I].Free;
end;

{ Public declarations }

procedure TFrmEdytorUlicy.SetData(Fields: TSQLResult);
begin
  FId := Fields.ByNameAsInteger['ID'];
  FObszarId := Fields.ByNameAsInteger['OBSZARID'];
  EdtNazwa.Text := Fields.ByNameAsString['NAZWA'];
  EdtPoczatek.Text := Fields.ByNameAsString['POCZATEK'];
  EdtKoniec.Text := Fields.ByNameAsString['KONIEC'];
end;

{ Event handlers }

procedure TFrmEdytorUlicy.FormCreate(Sender: TObject);
begin
//
end;

procedure TFrmEdytorUlicy.FormDestroy(Sender: TObject);
begin
  ClearAssignedPostoje;
  ClearAvailablePostoje;
end;


procedure TFrmEdytorUlicy.FormShow(Sender: TObject);
begin
  DisplayObszary;
  DisplayAssignedPostoje;
  DisplayAvailablePostoje;
end;

procedure TFrmEdytorUlicy.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  I1, I2{, J1, J2}: Integer;
  I: Integer;
begin
  if ModalResult = mrCancel then
    Exit;

  if EdtNazwa.Text = '' then
  begin
    EdtNazwa.SetFocus;
    ShowError('Nale¿y podaæ nazwê ulicy');
    CanClose := False;
    Exit;
  end;

  if EdtPoczatek.Text = '' then
  begin
    EdtPoczatek.SetFocus;
    ShowError('Nale¿y podaæ numer pocz¹tkowy, którego dotyczy wpis ulicy');
    CanClose := False;
    Exit;
  end;

  I1 := StrtoInt(EdtPoczatek.Text);
  if EdtKoniec.Text <> '' then
  begin
    I2 := StrtoInt(EdtKoniec.Text);
    if I1 > I2 then
    begin
      EdtKoniec.SetFocus;
      ShowError('Podany zakres, którego dotyczy wpis ulicy jest niepoprawny');
      CanClose := False;
      Exit;
    end;
  end;
//  else
//    I2 := MaxInt;

  if LbxSelectedPostoje.Count = 0 then
  begin
    CanClose := False;
    ShowError('Nale¿y przypisaæ chocia¿ jeden postój do danego wpisu ulicy');
    Exit;
  end;

  if CbxObszar.ItemIndex = -1 then
  begin
    CbxObszar.SetFocus;
    ShowError('Nale¿y wybraæ obszar do danego wpisu ulicy');
    CanClose := False;
    Exit;
  end;

  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('EXECUTE PROCEDURE UPDATE_ULICA %d,%s,%s,%s,%d;', [
        FId,
        QuotedStr(EdtNazwa.Text),
        QuotedStr(EdtPoczatek.Text),
        QuotedStr(EdtKoniec.Text),
        Integer(CbxObszar.Items.Objects[CbxObszar.ItemIndex])
      ]);
      Execute;
      FId := Fields.ByNameAsInteger['NEW_ID'];
      SQL.Text := Format('DELETE FROM POSTOJNAULICY WHERE ULICAID=%d', [
        FId
      ]);
      Execute;
      for I := 0 to LbxSelectedPostoje.Count - 1 do
      begin
        SQL.Text := FORMAT('EXECUTE PROCEDURE ADD_POSTOJ_DO_ULICY %d,%d;', [
          TPostoj(LbxSelectedPostoje.Items.Objects[I]).Id,
          FId
        ]);
        Execute;
      end;
      Transaction.Commit;
    finally
      Free;
    end;

//  for I := 0 to TDatabase.Instance.Streets.Count - 1 do
//  begin
//    Street := TDatabase.Instance.Streets[I];
//    if (Data <> Street) and AnsiSameText(Street.Name, EdtNazwa.Text) then
//    begin
//      J1 := StrToInt(Street.Start);
//      if Street.Stop <> '' then
//        J2 := StrToInt(Street.Stop)
//      else
//        J2 := MaxInt;
//      if ((I1 >= J1) and (I1 <= J2)) or ((I2 >= J1) and (I2 <= J2)) then
//      begin
//        if (J1 = 1) and (J2 = MaxInt) then
//          EdtNazwa.SetFocus
//        else
//          EdtPoczatek.SetFocus;
//        ShowError('Podany zakres, którego dotyczy wpis ulicy koliduje z innym wpisem o tej samej nazwie');
//        CanClose := False;
//        Exit;
//      end;
//    end;
//  end;
end;

procedure TFrmEdytorUlicy.EdtPoczatekKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then Key := #0;
end;

procedure TFrmEdytorUlicy.BtnAddClick(Sender: TObject);
begin
  with LbxAvailablePostoje do
  begin
    LbxSelectedPostoje.AddItem(Items[ItemIndex], Items.Objects[ItemIndex]);
    Items.Delete(ItemIndex);
  end;
end;

procedure TFrmEdytorUlicy.BtnRemoveClick(Sender: TObject);
begin
  with LbxSelectedPostoje do
  begin
    LbxAvailablePostoje.AddItem(Items[ItemIndex], Items.Objects[ItemIndex]);
    Items.Delete(ItemIndex);
  end;
end;

procedure TFrmEdytorUlicy.BtnMoveUpClick(Sender: TObject);
var
  NewIndex: Integer;
begin
  with LbxSelectedPostoje do
  begin
    NewIndex := ItemIndex - 1;
    Items.Move(ItemIndex, NewIndex);
    ItemIndex := NewIndex;
  end;
end;

procedure TFrmEdytorUlicy.BtnMoveDownClick(Sender: TObject);
var
  NewIndex: Integer;
begin
  with LbxSelectedPostoje do
  begin
    NewIndex := ItemIndex + 1;
    Items.Move(ItemIndex, ItemIndex + 1);
    ItemIndex := NewIndex;
  end;
end;

procedure TFrmEdytorUlicy.TmrUpdateButtonsTimer(Sender: TObject);
begin
  BtnAdd.Enabled := LbxAvailablePostoje.ItemIndex <> -1;
  BtnRemove.Enabled := LbxSelectedPostoje.ItemIndex <> -1;
  BtnMoveUp.Enabled := LbxSelectedPostoje.ItemIndex > 0;
  BtnMoveDown.Enabled := (LbxSelectedPostoje.ItemIndex <> -1) and (LbxSelectedPostoje.ItemIndex < LbxSelectedPostoje.Count - 1);
end;

procedure TFrmEdytorUlicy.LbxAvailablePostojeDblClick(Sender: TObject);
var
  Index: Integer;
begin
  with LbxAvailablePostoje do
  begin
    Index := ItemAtPos(ScreenToClient(Mouse.CursorPos), True);
    if Index <> -1 then
    begin
      LbxSelectedPostoje.AddItem(Items[ItemIndex], Items.Objects[ItemIndex]);
      Items.Delete(ItemIndex);
    end;
  end;
end;

procedure TFrmEdytorUlicy.LbxSelectedPostojeDblClick(Sender: TObject);
var
  Index: Integer;
begin
  with LbxSelectedPostoje do
  begin
    Index := ItemAtPos(ScreenToClient(Mouse.CursorPos), True);
    if Index <> -1 then
    begin
      LbxAvailablePostoje.AddItem(Items[ItemIndex], Items.Objects[ItemIndex]);
      Items.Delete(ItemIndex);
    end;
  end;
end;

procedure TFrmEdytorUlicy.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  function IsUpperCase(S: String): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 1 to Length(S) do
      if not (S[I] in [' ', '0'..'9']) then
      begin
        Result := UpCase(S[I]) = S[I];
        Break;
      end;
  end;
begin
  if Key = VK_F9 then
  begin
    if IsUpperCase(EdtNazwa.Text) then
      EdtNazwa.Text := LowerCase(EdtNazwa.Text)
    else
      EdtNazwa.Text := UpperCase(EdtNazwa.Text);
  end;
end;

end.

