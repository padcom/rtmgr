unit RTF_ListaTaksowek;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, JvUIB, JvUIBLib,
  RT_Tools;

type
  TFrmListaTaksowek = class(TForm)
    EdtQuickSearch: TEdit;
    LbxListaTaksowek: TListBox;
    BtnAnuluj: TButton;
    BtnZamknij: TButton;
    BtnNowa: TBitBtn;
    BtnPopraw: TBitBtn;
    BtnUsun: TBitBtn;
    LblQuickSearch: TLabel;
    LblListaTaksowek: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LbxListaTaksowekClick(Sender: TObject);
    procedure LbxListaTaksowekDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnNowaClick(Sender: TObject);
    procedure BtnPoprawClick(Sender: TObject);
    procedure BtnUsunClick(Sender: TObject);
    procedure LbxListaTaksowekDblClick(Sender: TObject);
    procedure EdtQuickSearchChange(Sender: TObject);
  private
    { Private declarations }
    Taksowki: TJvUIBQuery;
    DialogKind: TDialogKind;
    procedure DisplayTaksowki;
  public
    { Public declarations }
    procedure SetupAsEditor;
    procedure SetupAsSelector;
  end;

implementation

uses
  RTF_EdytorTaksowki, RT_SQL;

{$R *.DFM}

{ TFrmListaTaksowek }

{ Private declarations }

procedure TFrmListaTaksowek.DisplayTaksowki;
begin
  LbxListaTaksowek.Items.BeginUpdate;
  LbxListaTaksowek.Items.Clear;
  Taksowki.Close(etmRollback);
  Taksowki.Open;
  while not Taksowki.Eof do
  begin
    LbxListaTaksowek.AddItem(Taksowki.Fields.ByNameAsString['NRWYWOLAWCZY'], nil);
    Taksowki.Next;
  end;
  LbxListaTaksowek.ItemIndex := -1;
  LbxListaTaksowek.Items.EndUpdate;
end;

{ Public declarations }

procedure TFrmListaTaksowek.SetupAsEditor;
begin
  DialogKind := dkEditor;
  Caption := 'Edytor taksówek';
  BtnZamknij.Caption := '&Zamknij';
  BtnZamknij.Cancel := True;
  BtnAnuluj.Visible := False;
  BtnNowa.Visible := True;
  BtnPopraw.Visible := True;
  BtnPopraw.Default := True;
  BtnUsun.Visible := True;
end;

procedure TFrmListaTaksowek.SetupAsSelector;
begin
  DialogKind := dkSelector;
  Caption := 'Wybierz taksówke';
  BtnZamknij.Caption := '&OK';
  BtnZamknij.Default := True;
  BtnAnuluj.Visible := True;
  BtnAnuluj.Cancel := True;
  BtnNowa.Visible := False;
  BtnPopraw.Visible := False;
  BtnUsun.Visible := False;
end;

{ Event handlers }

procedure TFrmListaTaksowek.FormCreate(Sender: TObject);
begin
  Taksowki := TSQL.Instance.CreateQuery;
  Taksowki.SQL.Text := 'SELECT * FROM TAKSOWKA ORDER BY NRWYWOLAWCZY';
end;

procedure TFrmListaTaksowek.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmListaTaksowek.FormShow(Sender: TObject);
begin
  ActiveControl := EdtQuickSearch;
  DisplayTaksowki;
end;

procedure TFrmListaTaksowek.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (DialogKind = dkSelector) and (LbxListaTaksowek.ItemIndex = -1) and (ModalResult <> mrCancel) then
  begin
    CanClose := False;
    EdtQuickSearch.SetFocus;
    EdtQuickSearch.SelectAll;
  end;
end;

procedure TFrmListaTaksowek.LbxListaTaksowekClick(Sender: TObject);
var
  Temp: TNotifyEvent;
begin
  Temp := EdtQuickSearch.OnChange;
  EdtQuickSearch.OnChange := nil;
  if LbxListaTaksowek.ItemIndex <> -1 then
    EdtQuickSearch.Text := LbxListaTaksowek.Items[LbxListaTaksowek.ItemIndex]
  else
    EdtQuickSearch.Text := '';
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
  EdtQuickSearch.OnChange := Temp;
end;

procedure TFrmListaTaksowek.LbxListaTaksowekDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Rest: Integer;
begin
  TListBox(Control).Canvas.FillRect(Rect);

  Taksowki.Fields.GetRecord(Index);

  Rest := Rect.Right - 32;
  Rect.Right := Rect.Left + 32;
  TListBox(Control).Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top, Taksowki.Fields.ByNameAsString['NRWYWOLAWCZY']);

  Rect.Right := 32 + Rest;
  Rect.Left := 32;
  TListBox(Control).Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top, Taksowki.Fields.ByNameAsString['NAZWA']);
end;

procedure TFrmListaTaksowek.EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DOWN) or (Key = VK_UP) or (Key = VK_PRIOR) or (Key = VK_NEXT) or (Key = VK_HOME) or (Key = VK_END) then
  begin
    SendMessage(LbxListaTaksowek.Handle, WM_KEYDOWN, Key, 0);
    Key := 0;
  end;
end;

procedure TFrmListaTaksowek.BtnNowaClick(Sender: TObject);
begin
  with TFrmEdytorTaksowki.Create(nil) do
    try
      if ShowModal = mrOK then
        DisplayTaksowki;
    finally
      Free;
    end;
end;

procedure TFrmListaTaksowek.BtnPoprawClick(Sender: TObject);
begin
  if LbxListaTaksowek.ItemIndex = -1 then
    Exit;

  with TFrmEdytorTaksowki.Create(nil) do
    try
      Taksowki.Fields.GetRecord(LbxListaTaksowek.ItemIndex);
      SetData(Taksowki.Fields);
      if ShowModal = mrOK then
        DisplayTaksowki;
    finally
      Free;
    end;
  LbxListaTaksowekClick(Sender);
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
end;

procedure TFrmListaTaksowek.BtnUsunClick(Sender: TObject);
begin
  if LbxListaTaksowek.ItemIndex = -1 then
    Exit;
  if MessageDlg('Czy chcesz usun¹ t¹ taksówkê ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with TSQL.Instance.CreateQuery do
      try
        Taksowki.Fields.GetRecord(LbxListaTaksowek.ItemIndex);
        SQL.Text := Format('EXECUTE PROCEDURE DELETE_TAKSOWKA %d;', [
          Taksowki.Fields.ByNameAsInteger['ID']
        ]);
        Execute;
        Transaction.Commit;
        DisplayTaksowki;
        LbxListaTaksowekClick(Sender);
      finally
        Free;
      end;
  EdtQuickSearch.SetFocus;
  EdtQuickSearch.SelectAll;
end;

procedure TFrmListaTaksowek.LbxListaTaksowekDblClick(Sender: TObject);
begin
  if DialogKind = dkEditor then
    BtnPopraw.Click
  else
    BtnZamknij.Click;
end;

procedure TFrmListaTaksowek.EdtQuickSearchChange(Sender: TObject);
var
  I: Integer;
  S1, S2: String;
begin
  S1 := EdtQuickSearch.Text;
  I := 0;
  while I < LbxListaTaksowek.Items.Count do
  begin
    S2 := Copy(LbxListaTaksowek.Items[I], 1, Length(S1));
    if AnsiCompareText(S1, S2) <= 0 then Break;
    Inc(I);
  end;
  if I < LbxListaTaksowek.Items.Count then
    LbxListaTaksowek.ItemIndex := I;
end;

end.
