unit RTF_ListaPostojow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, Buttons, JvUIB, JvUIBLib,
  RT_Tools;

type
  TFrmListaPostojow = class(TForm)
    EdtQuickSearch: TEdit;
    BtnZamknij: TButton;
    BtnNowy: TBitBtn;
    BtnPopraw: TBitBtn;
    BtnUsun: TBitBtn;
    LblQuickSearch: TLabel;
    LblListaPostojow: TLabel;
    LbxListaPostojow: TListBox;
    BtnAnuluj: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LbxListaPostojowClick(Sender: TObject);
    procedure EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtQuickSearchChange(Sender: TObject);
    procedure BtnNowyClick(Sender: TObject);
    procedure BtnPoprawClick(Sender: TObject);
    procedure BtnUsunClick(Sender: TObject);
    procedure LbxListaPostojowDblClick(Sender: TObject);
  private
    { Private declarations }
    DialogKind: TDialogKind;
    Postoje: TJvUIBQuery;
    procedure DisplayPostoje;
  public
    { Public declarations }
    procedure SetupAsSelector;
    procedure SetupAsEditor;
  end;

implementation

uses
  RT_SQL;

{$R *.DFM}

{ TFrmListaPostojow }

{ Private declarations }

procedure TFrmListaPostojow.DisplayPostoje;
begin
  LbxListaPostojow.Items.BeginUpdate;
  LbxListaPostojow.Items.Clear;
  Postoje.Close(etmRollback);
  Postoje.Open;
  while not Postoje.Eof do
  begin
    LbxListaPostojow.AddItem(Postoje.Fields.ByNameAsString['NAZWA'], nil);
    Postoje.Next;
  end;
  LbxListaPostojow.ItemIndex := -1;
  LbxListaPostojow.Items.EndUpdate;
end;

{ Public declarations }

procedure TFrmListaPostojow.SetupAsEditor;
begin
  DialogKind := dkEditor;
  Caption := 'Edytor postojów';
  BtnZamknij.Caption := '&Zamknij';
  BtnZamknij.Cancel := True;
  BtnAnuluj.Visible := False;
  BtnNowy.Visible := True;
  BtnPopraw.Visible := True;
  BtnPopraw.Default := True;
  BtnUsun.Visible := True;
end;

procedure TFrmListaPostojow.SetupAsSelector;
begin
  DialogKind := dkSelector;
  Caption := 'Wybierz postój';
  BtnZamknij.Caption := '&OK';
  BtnZamknij.Default := True;
  BtnAnuluj.Visible := True;
  BtnAnuluj.Cancel := True;
  BtnNowy.Visible := False;
  BtnPopraw.Visible := False;
  BtnUsun.Visible := False;
end;

{ Event handlers }

procedure TFrmListaPostojow.FormCreate(Sender: TObject);
begin
  Postoje := TSQL.Instance.CreateQuery;
  Postoje.SQL.Text := 'SELECT * FROM POSTOJ ORDER BY NAZWA';
end;

procedure TFrmListaPostojow.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Postoje);
end;

procedure TFrmListaPostojow.FormShow(Sender: TObject);
begin
  DisplayPostoje;
  EdtQuickSearch.SetFocus;
end;

procedure TFrmListaPostojow.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (DialogKind = dkSelector) and (LbxListaPostojow.ItemIndex = -1) and (ModalResult <> mrCancel) then
  begin
    CanClose := False;
    EdtQuickSearch.SetFocus;
    EdtQuickSearch.SelectAll;
  end;
end;

procedure TFrmListaPostojow.LbxListaPostojowClick(Sender: TObject);
var
  Temp: TNotifyEvent;
begin
  Temp := EdtQuickSearch.OnChange;
  EdtQuickSearch.OnChange := nil;
  if LbxListaPostojow.ItemIndex >= 0 then
    EdtQuickSearch.Text := LbxListaPostojow.Items[LbxListaPostojow.ItemIndex]
  else
    EdtQuickSearch.Text := '';
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
  EdtQuickSearch.OnChange := Temp
end;

procedure TFrmListaPostojow.EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DOWN) or (Key = VK_UP) or (Key = VK_PRIOR) or (Key = VK_NEXT) or (Key = VK_HOME) or (Key = VK_END) then
  begin
    SendMessage(LbxListaPostojow.Handle, WM_KEYDOWN, Key, 0);
    Key := 0;
  end;
end;

procedure TFrmListaPostojow.EdtQuickSearchChange(Sender: TObject);
var
  I: Integer;
  S: String;
begin
  //
  for I := 0 to LbxListaPostojow.Items.Count - 1 do
  begin
    S := Copy(LbxListaPostojow.Items[I], 1, Length(EdtQuickSearch.Text));
    if AnsiCompareText(EdtQuickSearch.Text, S) <= 0 then
    begin
      LbxListaPostojow.ItemIndex := I;
      Break;
    end;
  end;
end;

procedure TFrmListaPostojow.BtnNowyClick(Sender: TObject);
var
  S: String;
begin
  S := '';
  if InputQuery('Podaj nazwê nowego postoju', 'Nazwa', S) then
  begin
    with TSQL.Instance.CreateQuery do
      try
        SQL.Text := Format('EXECUTE PROCEDURE ADD_POSTOJ %s', [
          QuotedStr(S)
        ]);
        Execute;
        Transaction.Commit;
        DisplayPostoje;
        EdtQuickSearch.Text := S;
        EdtQuickSearch.SetFocus;
        EdtQuickSearch.SelectAll;
      finally
        Free;
      end;
  end;
end;

procedure TFrmListaPostojow.BtnPoprawClick(Sender: TObject);
var
  S: String;
begin
  if LbxListaPostojow.ItemIndex = -1 then
    Exit;
  Postoje.Fields.GetRecord(LbxListaPostojow.ItemIndex);
  S := Postoje.Fields.ByNameAsString['NAZWA'];
  if InputQuery('Podaj now¹ nazwê postoju', 'Nazwa', S) and (S <> Postoje.Fields.ByNameAsString['NAZWA']) then
    with TSQL.Instance.CreateQuery do
      try
        SQL.Text := Format('EXECUTE PROCEDURE UPDATE_POSTOJ %d, %s', [
          Postoje.Fields.ByNameAsInteger['Id'],
          QuotedStr(S)
        ]);
        Execute;
        Transaction.Commit;
        DisplayPostoje;
        EdtQuickSearch.Text := S;
        EdtQuickSearch.SetFocus;
        EdtQuickSearch.SelectAll;
      finally
        Free;
      end;
end;

procedure TFrmListaPostojow.BtnUsunClick(Sender: TObject);
begin
  if LbxListaPostojow.ItemIndex = -1 then
    Exit;

  Postoje.Fields.GetRecord(LbxListaPostojow.ItemIndex);
  if MessageDlg('Czy na pewno chcesz usun¹æ ten postój ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with TSQL.Instance.CreateQuery do
      try
        SQL.Text := Format('EXECUTE PROCEDURE DELETE_POSTOJ %d', [
          Postoje.Fields.ByNameAsInteger['Id']
        ]);
        Execute;
        Transaction.Commit;
        DisplayPostoje;
        EdtQuickSearch.Text := '';
        EdtQuickSearch.SetFocus;
        EdtQuickSearch.SelectAll;
      finally
        Free;
      end;
end;

procedure TFrmListaPostojow.LbxListaPostojowDblClick(Sender: TObject);
begin
  if DialogKind = dkEditor then
    BtnPopraw.Click
  else
    BtnZamknij.Click;
end;

end.

