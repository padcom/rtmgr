unit RTF_ListaUlic;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, JvUIB, JvUIBLib,
  RT_Tools;

type
  TFrmListaUlic = class(TForm)
    LbxListaUlic: TListBox;
    EdtQuickSearch: TEdit;
    LblQuickSearch: TLabel;
    LblListaUlic: TLabel;
    BtnZamknij: TButton;
    BtnAnuluj: TButton;
    Bevel1: TBevel;
    LblPostoj1Desc: TLabel;
    LblPostoj1: TLabel;
    LblPostoj2Desc: TLabel;
    LblPostoj2: TLabel;
    LblPostoj3Desc: TLabel;
    LblPostoj3: TLabel;
    LblPostoj4Desc: TLabel;
    LblPostoj4: TLabel;
    LblPostoj5Desc: TLabel;
    LblPostoj5: TLabel;
    LblPostoj6Desc: TLabel;
    LblPostoj6: TLabel;
    LblPostoj7Desc: TLabel;
    LblPostoj7: TLabel;
    LblPostoj8Desc: TLabel;
    LblPostoj8: TLabel;
    BtnNowa: TBitBtn;
    BtnPopraw: TBitBtn;
    BtnUsun: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LbxListaUlicClick(Sender: TObject);
    procedure LbxListaUlicDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtQuickSearchChange(Sender: TObject);
    procedure BtnNowaClick(Sender: TObject);
    procedure BtnPoprawClick(Sender: TObject);
    procedure BtnUsunClick(Sender: TObject);
    procedure LbxListaUlicDblClick(Sender: TObject);
  private
    { Private declarations }
    DialogKind: TDialogKind;
    Ulice: TJvUIBQuery;
    procedure DisplayUlica(Index: Integer);
    procedure DisplayUlice;
  public
    { Public declarations }
    function SelectedUlica: TSQLResult;
    procedure SetupAsSelector;
    procedure SetupAsEditor;
  end;

implementation

uses
  Math, RTF_EdytorUlicy, RT_SQL;

{$R *.DFM}

{ TFrmListaUlic }

{ Private declarations }

procedure TFrmListaUlic.DisplayUlica(Index: Integer);
var
  I: Integer;
  Temp: TNotifyEvent;
begin
  Temp := EdtQuickSearch.OnChange;
  EdtQuickSearch.OnChange := nil;

  for I := 1 to 8 do
    GetLabelByName(Self, Format('LblPostoj%d', [I])).Caption := '';
  with TSQL.Instance.CreatePostojeNaUlicyQuery(Ulice.Fields.ByNameAsInteger['ID']) do
    try
      Open;
      I := 0;
      while (I < 8) and (not Eof) do
      begin
        GetLabelByName(Self, Format('LblPostoj%d', [I + 1])).Caption := Fields.ByNameAsString['NAZWA'];
        Inc(I);
        Next;
      end;
    finally
      Free;
    end;

  EdtQuickSearch.OnChange := Temp;
end;

procedure TFrmListaUlic.DisplayUlice;
begin
  Ulice.Close(etmRollback);
  Ulice.Open;
  LbxListaUlic.Items.BeginUpdate;
  LbxListaUlic.Items.Clear;
  while not Ulice.Eof do
  begin
    LbxListaUlic.AddItem(Ulice.Fields.ByNameAsString['NAZWA'], nil);
    Ulice.Next;
  end;
  LbxListaUlic.ItemIndex := -1;
  LbxListaUlic.Items.EndUpdate;
end;

{ Public declarations }

function TFrmListaUlic.SelectedUlica: TSQLResult;
begin
  Ulice.Fields.GetRecord(LbxListaUlic.ItemIndex);
  Result := Ulice.Fields;
end;

procedure TFrmListaUlic.SetupAsEditor;
begin
  DialogKind := dkEditor;
  Caption := 'Edytor ulic';
  BtnZamknij.Caption := '&Zamknij';
  BtnZamknij.Cancel := True;
  BtnAnuluj.Visible := False;
  BtnNowa.Visible := True;
  BtnPopraw.Visible := True;
  BtnPopraw.Default := True;
  BtnUsun.Visible := True;
end;

procedure TFrmListaUlic.SetupAsSelector;
begin
  DialogKind := dkSelector;
  Caption := 'Wybierz ulice';
  BtnZamknij.Caption := '&OK';
  BtnZamknij.Default := True;
  BtnZamknij.Cancel := False;
  BtnAnuluj.Visible := True;
  BtnAnuluj.Cancel := True;
  BtnNowa.Visible := False;
  BtnPopraw.Visible := False;
  BtnUsun.Visible := False;
end;

{ Event handlers }

procedure TFrmListaUlic.FormCreate(Sender: TObject);
begin
  Ulice := TSQL.Instance.CreateQuery;
  Ulice.SQL.Text := 'SELECT ULICA.ID,lower(ULICA.NAZWA) as NAZWA,lower(POCZATEK) as POCZATEK,lower(KONIEC) as KONIEC,OBSZARID,SKROT FROM ULICA INNER JOIN OBSZAR ON (ULICA.OBSZARID=OBSZAR.ID) ORDER BY NAZWA, POCZATEK';
end;

procedure TFrmListaUlic.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Ulice);
end;

procedure TFrmListaUlic.FormShow(Sender: TObject);
begin
  ActiveControl := EdtQuickSearch;
  LblPostoj1.Caption := '';
  LblPostoj2.Caption := '';
  LblPostoj3.Caption := '';
  LblPostoj4.Caption := '';
  LblPostoj5.Caption := '';
  LblPostoj6.Caption := '';
  LblPostoj7.Caption := '';
  LblPostoj8.Caption := '';
  DisplayUlice;
end;

procedure TFrmListaUlic.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (DialogKind = dkSelector) and (LbxListaUlic.ItemIndex = -1) and (ModalResult <> mrCancel) then
  begin
    CanClose := False;
    EdtQuickSearch.SetFocus;
    EdtQuickSearch.SelectAll;
  end;
end;

procedure TFrmListaUlic.LbxListaUlicClick(Sender: TObject);
begin
  DisplayUlica(LbxListaUlic.ItemIndex);
end;

procedure TFrmListaUlic.LbxListaUlicDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  S: String;
begin
  Ulice.Fields.GetRecord(Index);

  LbxListaUlic.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 1, Ulice.Fields.ByNameAsString['SKROT']);
  Inc(Rect.Left, 30);
  Dec(Rect.Right, 100);
  LbxListaUlic.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, Ulice.Fields.ByNameAsString['NAZWA']);

  Rect.Left := Rect.Right;
  Inc(Rect.Right, 45);
  LbxListaUlic.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, 'Od ' + Ulice.Fields.ByNameAsString['POCZATEK']);
  Rect.Left := Rect.Right;
  Inc(Rect.Right, 55);
  if Ulice.Fields.ByNameAsString['KONIEC'] = '' then
    S := 'koñca'
  else
    S := Ulice.Fields.ByNameAsString['KONIEC'];
  LbxListaUlic.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, 'Do ' + S);
end;

procedure TFrmListaUlic.EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DOWN) or (Key = VK_UP) or (Key = VK_PRIOR) or (Key = VK_NEXT) or (Key = VK_HOME) or (Key = VK_END) then
  begin
    SendMessage(LbxListaUlic.Handle, WM_KEYDOWN, Key, 0);
    Key := 0;
  end;
end;

procedure TFrmListaUlic.EdtQuickSearchChange(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to LbxListaUlic.Items.Count - 1 do
  begin
    if CompareTextPL(EdtQuickSearch.Text, LbxListaUlic.Items[I]) <= 0 then
    begin
      LbxListaUlic.ItemIndex := I;
      LbxListaUlicClick(Self);
      Break;
    end;
  end;
end;

procedure TFrmListaUlic.BtnNowaClick(Sender: TObject);
begin
  with TFrmEdytorUlicy.Create(nil) do
    try
      if ShowModal = mrOK then
        DisplayUlice
    finally
      Free;
    end;
  LbxListaUlicClick(Sender);
end;

procedure TFrmListaUlic.BtnPoprawClick(Sender: TObject);
begin
  if LbxListaUlic.ItemIndex = -1 then
    Exit;

  with TFrmEdytorUlicy.Create(nil) do
    try
      SetData(Ulice.Fields);
      if ShowModal = mrOK then
        DisplayUlice;
    finally
      Free;
    end;

  LbxListaUlicClick(Sender);
end;

procedure TFrmListaUlic.BtnUsunClick(Sender: TObject);
begin
  if LbxListaUlic.ItemIndex = -1 then
    Exit;
  if MessageDlg('Czy na pewno chcesz usun¹ t¹ ulicê ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with TSQL.Instance.CreateQuery do
      try
        Ulice.Fields.GetRecord(LbxListaUlic.ItemIndex);
        SQL.Text := Format('EXECUTE PROCEDURE DELETE_ULICA %d;', [
          Ulice.Fields.ByNameAsInteger['ID']
        ]);
        Execute;
        Transaction.Commit;
        DisplayUlice;
        EdtQuickSearch.Text := '';
        EdtQuickSearch.SetFocus;
        EdtQuickSearch.SelectAll;
      finally
        Free;
      end;
  LbxListaUlicClick(Sender);
end;

procedure TFrmListaUlic.LbxListaUlicDblClick(Sender: TObject);
begin
  if DialogKind = dkEditor then
    BtnPopraw.Click
  else
    BtnZamknij.Click;
end;

end.

