unit RTF_ListaObszarow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,
  JvUIB, JvUIBLib,
  RT_Tools;

type
  TFrmListaObszarow = class(TForm)
    LblQuickSearch: TLabel;
    LblListaObszarow: TLabel;
    EdtQuickSearch: TEdit;
    BtnZamknij: TButton;
    BtnNowy: TBitBtn;
    BtnPopraw: TBitBtn;
    BtnUsun: TBitBtn;
    LbxListaObszarow: TListBox;
    BtnAnuluj: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LbxListaObszarowClick(Sender: TObject);
    procedure EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtQuickSearchChange(Sender: TObject);
    procedure BtnNowyClick(Sender: TObject);
    procedure BtnPoprawClick(Sender: TObject);
    procedure BtnUsunClick(Sender: TObject);
    procedure LbxListaObszarowDblClick(Sender: TObject);
    procedure LbxListaObszarowDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
    DialogKind: TDialogKind;
    Obszary: TJvUIBQuery;
    procedure DisplayObszary;
  public
    { Public declarations }
    procedure SetupAsSelector;
    procedure SetupAsEditor;
  end;

implementation

uses
  RT_SQL, RTF_EdytorObszaru;

{$R *.dfm}

{ TFrmListaObszarow }

{ Private declarations }

procedure TFrmListaObszarow.DisplayObszary;
begin
  LbxListaObszarow.Items.BeginUpdate;
  LbxListaObszarow.Clear;
  Obszary.Close(etmRollback);
  Obszary.Open;
  while not Obszary.Eof do
  begin
    LbxListaObszarow.AddItem(Obszary.Fields.ByNameAsString['NAZWA'], nil);
    Obszary.Next;
  end;
  LbxListaObszarow.ItemIndex := -1;
  LbxListaObszarow.Items.EndUpdate;
end;

{ Public declarations }

procedure TFrmListaObszarow.SetupAsSelector;
begin
  DialogKind := dkSelector;
  Caption := 'Wybierz obszar';
  BtnZamknij.Caption := '&OK';
  BtnZamknij.Default := True;
  BtnAnuluj.Visible := True;
  BtnAnuluj.Cancel := True;
  BtnNowy.Visible := False;
  BtnPopraw.Visible := False;
  BtnUsun.Visible := False;
end;

procedure TFrmListaObszarow.SetupAsEditor;
begin
  DialogKind := dkEditor;
  Caption := 'Edytor obszarów';
  BtnZamknij.Caption := '&Zamknij';
  BtnZamknij.Cancel := True;
  BtnAnuluj.Visible := False;
  BtnNowy.Visible := True;
  BtnPopraw.Visible := True;
  BtnPopraw.Default := True;
  BtnUsun.Visible := True;
end;

{ Event handlers }

procedure TFrmListaObszarow.FormCreate(Sender: TObject);
begin
  Obszary := TSQL.Instance.CreateQuery;
  Obszary.SQL.Text := 'SELECT * FROM OBSZAR ORDER BY NAZWA;';
end;

procedure TFrmListaObszarow.FormDestroy(Sender: TObject);
begin
  Obszary.Free;
end;

procedure TFrmListaObszarow.FormShow(Sender: TObject);
begin
  DisplayObszary;
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
end;

procedure TFrmListaObszarow.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (DialogKind = dkSelector) and (LbxListaObszarow.ItemIndex = -1) and (ModalResult <> mrCancel) then
  begin
    CanClose := False;
    EdtQuickSearch.SetFocus;
    EdtQuickSearch.SelectAll;
  end;
end;

procedure TFrmListaObszarow.LbxListaObszarowClick(Sender: TObject);
var
  Temp: TNotifyEvent;
begin
  Temp := EdtQuickSearch.OnChange;
  EdtQuickSearch.OnChange := nil;
  if LbxListaObszarow.ItemIndex >= 0 then
    EdtQuickSearch.Text := LbxListaObszarow.Items[LbxListaObszarow.ItemIndex]
  else
    EdtQuickSearch.Text := '';
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
  EdtQuickSearch.OnChange := Temp;
end;

procedure TFrmListaObszarow.EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DOWN) or (Key = VK_UP) or (Key = VK_PRIOR) or (Key = VK_NEXT) or (Key = VK_HOME) or (Key = VK_END) then
  begin
    SendMessage(LbxListaObszarow.Handle, WM_KEYDOWN, Key, 0);
    Key := 0;
  end;
end;

procedure TFrmListaObszarow.EdtQuickSearchChange(Sender: TObject);
var
  I: Integer;
  S: String;
begin
  for I := 0 to LbxListaObszarow.Items.Count - 1 do
  begin
    S := Copy(LbxListaObszarow.Items[I], 1, Length(EdtQuickSearch.Text));
    if AnsiCompareText(EdtQuickSearch.Text, S) <= 0 then
    begin
      LbxListaObszarow.ItemIndex := I;
      Break;
    end;
  end;
end;

procedure TFrmListaObszarow.BtnNowyClick(Sender: TObject);
begin
  with TFrmEdytorObszaru.Create(nil) do
    try
      if ShowModal = mrOk then
        DisplayObszary;
    finally
      Free;
    end;
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
end;

procedure TFrmListaObszarow.BtnPoprawClick(Sender: TObject);
begin
  if LbxListaObszarow.ItemIndex = -1 then
    Exit;

  with TFrmEdytorObszaru.Create(nil) do
    try
      Obszary.Fields.GetRecord(LbxListaObszarow.ItemIndex);
      SetData(Obszary.Fields);
      if ShowModal = mrOK then
        DisplayObszary;
    finally
      Free;
    end;
end;

procedure TFrmListaObszarow.BtnUsunClick(Sender: TObject);
begin
  if LbxListaObszarow.ItemIndex = -1 then
    Exit;

  if MessageDlg('Czy na pewno chcesz usun¹æ ten obszar ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Obszary.Fields.GetRecord(LbxListaObszarow.ItemIndex);
    with TSQL.Instance.CreateQuery do
      try
        SQL.Text := Format('EXECUTE PROCEDURE DELETE_OBSZAR %d', [
          Obszary.Fields.ByNameAsInteger['ID']
        ]);
        Execute;
        Transaction.Commit;
      finally
        Free;
      end;
    DisplayObszary;
    LbxListaObszarowClick(Sender);
    EdtQuickSearch.Text := '';
    EdtQuickSearch.SetFocus;
  end;
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
end;

procedure TFrmListaObszarow.LbxListaObszarowDblClick(Sender: TObject);
begin
  if DialogKind = dkEditor then
    BtnPopraw.Click
  else
    BtnZamknij.Click;
end;

procedure TFrmListaObszarow.LbxListaObszarowDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Rest: Integer;
begin
  TListBox(Control).Canvas.FillRect(Rect);

  Obszary.Fields.GetRecord(Index);

  Rest := Rect.Right - 220;
  Rect.Right := Rect.Left + 220;
  TListBox(Control).Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top, TListBox(Control).Items[Index]);

  Rect.Right := 220 + Rest;
  Rect.Left := 220;
  TListBox(Control).Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top, Obszary.Fields.ByNameAsString['SKROT']);
end;

end.
