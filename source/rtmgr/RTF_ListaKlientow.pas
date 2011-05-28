unit RTF_ListaKlientow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, JvUIB, JvUIBLib,
  RT_Tools;

type
  TFrmListaKlientow = class(TForm)
    LblQuickSearch: TLabel;
    LblListaKlientow: TLabel;
    EdtQuickSearch: TEdit;
    BtnZamknij: TButton;
    BtnNowy: TBitBtn;
    BtnPopraw: TBitBtn;
    BtnUsun: TBitBtn;
    LbxListaKlientow: TListBox;
    BtnAnuluj: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LbxListaKlientowClick(Sender: TObject);
    procedure EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtQuickSearchChange(Sender: TObject);
    procedure BtnNowyClick(Sender: TObject);
    procedure BtnPoprawClick(Sender: TObject);
    procedure BtnUsunClick(Sender: TObject);
    procedure LbxListaKlientowDblClick(Sender: TObject);
    procedure LbxListaKlientowDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
    DialogKind: TDialogKind;
    Klienci: TJvUIBQuery;
    procedure DisplayKlienci;
  public
    { Public declarations }
    procedure SetupAsSelector;
    procedure SetupAsEditor;
  end;

implementation

uses
  RTF_EdytorKlienta, RT_SQL;

{$R *.DFM}

{ TFrmListaKlientow }

{ Private declarations }

procedure TFrmListaKlientow.DisplayKlienci;
begin
  LbxListaKlientow.Items.BeginUpdate;
  LbxListaKlientow.Clear;
  Klienci.Close(etmRollback);
  Klienci.Open;
  while not Klienci.Eof do
  begin
    LbxListaKlientow.AddItem(Klienci.Fields.ByNameAsString['ULICA'], nil);
    Klienci.Next;
  end;
  LbxListaKlientow.ItemIndex := -1;
  LbxListaKlientow.Items.EndUpdate;
end;

{ Public declarations }

procedure TFrmListaKlientow.SetupAsEditor;
begin
  DialogKind := dkEditor;
  Caption := 'Edytor klientów';
  BtnZamknij.Caption := '&Zamknij';
  BtnZamknij.Cancel := True;
  BtnAnuluj.Visible := False;
  BtnNowy.Visible := True;
  BtnPopraw.Visible := True;
  BtnPopraw.Default := True;
  BtnUsun.Visible := True;
end;

procedure TFrmListaKlientow.SetupAsSelector;
begin
  DialogKind := dkSelector;
  Caption := 'Wybierz klienta';
  BtnZamknij.Caption := '&OK';
  BtnZamknij.Default := True;
  BtnAnuluj.Visible := True;
  BtnAnuluj.Cancel := True;
  BtnNowy.Visible := False;
  BtnPopraw.Visible := False;
  BtnUsun.Visible := False;
end;

{ Event handlers }

procedure TFrmListaKlientow.FormCreate(Sender: TObject);
begin
  Klienci := TSQL.Instance.CreateQuery;
  Klienci.SQL.Text := 'SELECT * FROM KLIENT ORDER BY ULICA,DOM;';
end;

procedure TFrmListaKlientow.FormDestroy(Sender: TObject);
begin
  Klienci.Free;
end;

procedure TFrmListaKlientow.FormShow(Sender: TObject);
begin
  DisplayKlienci;
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
end;

procedure TFrmListaKlientow.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (DialogKind = dkSelector) and (LbxListaKlientow.ItemIndex = -1) and (ModalResult <> mrCancel) then
  begin
    CanClose := False;
    EdtQuickSearch.SetFocus;
    EdtQuickSearch.SelectAll;
  end;
end;

procedure TFrmListaKlientow.LbxListaKlientowClick(Sender: TObject);
var
  Temp: TNotifyEvent;
begin
  Temp := EdtQuickSearch.OnChange;
  EdtQuickSearch.OnChange := nil;
  if LbxListaKlientow.ItemIndex >= 0 then
    EdtQuickSearch.Text := LbxListaKlientow.Items[LbxListaKlientow.ItemIndex]
  else
    EdtQuickSearch.Text := '';
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
  EdtQuickSearch.OnChange := Temp;
end;

procedure TFrmListaKlientow.EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DOWN) or (Key = VK_UP) or (Key = VK_PRIOR) or (Key = VK_NEXT) or (Key = VK_HOME) or (Key = VK_END) then
  begin
    SendMessage(LbxListaKlientow.Handle, WM_KEYDOWN, Key, 0);
    Key := 0;
  end;
end;

procedure TFrmListaKlientow.EdtQuickSearchChange(Sender: TObject);
var
  I: Integer;
  S: String;
begin
  for I := 0 to LbxListaKlientow.Items.Count - 1 do
  begin
    S := Copy(LbxListaKlientow.Items[I], 1, Length(EdtQuickSearch.Text));
    if AnsiCompareText(EdtQuickSearch.Text, S) <= 0 then
    begin
      LbxListaKlientow.ItemIndex := I;
      Break;
    end;
  end;
end;

procedure TFrmListaKlientow.BtnNowyClick(Sender: TObject);
begin
  with TFrmEdytorKlienta.Create(nil) do
    try
      if ShowModal = mrOk then
        DisplayKlienci;
    finally
      Free;
    end;
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
end;

procedure TFrmListaKlientow.BtnPoprawClick(Sender: TObject);
begin
  if LbxListaKlientow.ItemIndex = -1 then
    Exit;

  with TFrmEdytorKlienta.Create(nil) do
    try
      Klienci.Fields.GetRecord(LbxListaKlientow.ItemIndex);
      SetData(Klienci.Fields);
      if ShowModal = mrOK then
        DisplayKlienci;
    finally
      Free;
    end;
end;

procedure TFrmListaKlientow.BtnUsunClick(Sender: TObject);
begin
  if LbxListaKlientow.ItemIndex = -1 then
    Exit;

  if MessageDlg('Czy na pewno chcesz usun¹æ tego klienta ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Klienci.Fields.GetRecord(LbxListaKlientow.ItemIndex);
    with TSQL.Instance.CreateQuery do
      try
        SQL.Text := Format('EXECUTE PROCEDURE DELETE_KLIENT %d', [
          Klienci.Fields.ByNameAsInteger['ID']
        ]);
        Execute;
        Transaction.Commit;
      finally
        Free;
      end;
    DisplayKlienci;
    LbxListaKlientowClick(Sender);
    EdtQuickSearch.Text := '';
    EdtQuickSearch.SetFocus;
  end;
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
end;

procedure TFrmListaKlientow.LbxListaKlientowDblClick(Sender: TObject);
begin
  if DialogKind = dkEditor then
    BtnPopraw.Click
  else
    BtnZamknij.Click;
end;

procedure TFrmListaKlientow.LbxListaKlientowDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Rest: Integer;
begin
  TListBox(Control).Canvas.FillRect(Rect);

  Klienci.Fields.GetRecord(Index);

  Rest := Rect.Right - 220;
  Rect.Right := Rect.Left + 220;
  TListBox(Control).Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top, TListBox(Control).Items[Index]);

  Rect.Right := 220 + Rest;
  Rect.Left := 220;
  TListBox(Control).Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top, Klienci.Fields.ByNameAsString['TELEFON']);
end;

end.

