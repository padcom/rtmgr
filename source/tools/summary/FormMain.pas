unit FormMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Grids, ComCtrls, Tabs, StdCtrls, FileCtrl, ComObj, ExcelConsts, ExtCtrls,
  JvUIB, JvUIBLib;

type
  TFrmMain1 = class(TForm)
    TabSet: TTabSet;
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    GrdKursy: TDrawGrid;
    MnuPlik: TMenuItem;
    N2: TMenuItem;
    MniKoniec: TMenuItem;
    MnuEdycja: TMenuItem;
    MniPoprawKurs: TMenuItem;
    MniUsuKurs: TMenuItem;
    MnuPomoc: TMenuItem;
    MniOProgramie: TMenuItem;
    MniDrzewoPostojow: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TabSetChange(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
    procedure MniKoniecClick(Sender: TObject);
    procedure MniPoprawKursClick(Sender: TObject);
    procedure MniUsuKursClick(Sender: TObject);
    procedure MniOProgramieClick(Sender: TObject);
    procedure MniDrzewoPostojowClick(Sender: TObject);
    procedure GrdKursyDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
    Kursy: TJvUIBQuery;
  public
    { Public declarations }
    procedure InitDays;
    procedure DisplayKursy(Date: String = '');
  end;

var
  FrmMain1: TFrmMain1;

implementation

uses
  RTF_EdytorKursu, 
  FormDrzewoPostojow,
  RT_SQL;

{$R *.DFM}

procedure TFrmMain1.FormCreate(Sender: TObject);
begin
  Kursy := TSQL.Instance.CreateQuery;
end;

procedure TFrmMain1.FormDestroy(Sender: TObject);
begin
  Kursy.Free;
end;

procedure TFrmMain1.FormShow(Sender: TObject);
begin
  Width := 648; Height := 480;
  if Screen.Width = 640 then
  begin
    Left := -4;
    Top := -4;
  end
  else
  begin
    Left := (Screen.Width - 648) div 2;
    Top := (Screen.Height - 480) div 2;
  end;
  InitDays;
  DisplayKursy('');
end;

procedure TFrmMain1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('Czy na pewno chcesz zakoñczyæ program ?', mtConfirmation, mbOKCancel, 0) = mrOK;
end;

procedure TFrmMain1.InitDays;
begin
  TabSet.Tabs.Clear;
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := 'SELECT DISTINCT CAST(REALIZACJA AS DATE) AS DATA FROM KURS ORDER BY DATA';
      Open;
      while not Eof do
      begin
        TabSet.Tabs.Add(Fields.ByNameAsString['DATA']);
        Next;
      end;
    finally
      Free;
    end;
  TabSet.TabIndex := TabSet.Tabs.Count - 1;
  DisplayKursy;
end;

procedure TFrmMain1.DisplayKursy(Date: String = '');
begin
  if Date = '' then
  begin
    if TabSet.TabIndex <> -1 then
      Date := TabSet.Tabs[TabSet.TabIndex]
    else
      Date := FormatDateTime('YYYY-MM-DD', 0);
  end;
  Kursy.Close(etmRollback);
  Kursy.SQL.Text := Format('SELECT ID, ULICA, ULICAID, DOM, MIESZK, TAKSOWKAID, NRWYWOL, PRZYJECIE, FLAGS, REALIZACJA, PRZESUNIECIE, CAST(REALIZACJA AS TIME) AS GODZINA FROM KURSY WHERE CAST(REALIZACJA AS DATE) = %s ORDER BY REALIZACJA', [
    QuotedStr(Date)
  ]);
  Kursy.Open;
  if Kursy.Eof then
  begin
    GrdKursy.ColCount := 1;
    GrdKursy.RowCount := 1;
    GrdKursy.ColWidths[0] := 0;
    GrdKursy.RowHeights[0] := 0;
  end
  else
  begin
    Kursy.Last;
    GrdKursy.ColCount := 6;
    GrdKursy.RowCount := Kursy.Fields.RecordCount + 1;
    GrdKursy.ColWidths[0] := 38;
    GrdKursy.ColWidths[1] := 288 + 32;
    GrdKursy.ColWidths[2] := 64;
    GrdKursy.ColWidths[3] := 64;
    GrdKursy.ColWidths[4] := 64;
    GrdKursy.ColWidths[5] := 64;
    GrdKursy.DefaultRowHeight := 18;
    GrdKursy.FixedCols := 0;
    GrdKursy.FixedRows := 1;
  end;
end;

procedure TFrmMain1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_LEFT) and (ssCtrl in Shift) and (TabSet.TabIndex > 0) then TabSet.TabIndex := TabSet.TabIndex - 1;
  if (Key = VK_RIGHT) and (ssCtrl in Shift) and (TabSet.TabIndex < TabSet.Tabs.Count - 1) then TabSet.TabIndex := TabSet.TabIndex + 1;
end;

procedure TFrmMain1.TabSetChange(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
begin
  DisplayKursy(TabSet.Tabs[NewTab]);
end;

procedure TFrmMain1.MniKoniecClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain1.MniPoprawKursClick(Sender: TObject);
begin
  if GrdKursy.Row = 0 then
    Exit;

  with TFrmEdytorKursu.Create(nil) do
    try
      Kursy.Fields.GetRecord(GrdKursy.Row - 1);
      SetData(Kursy.Fields);
      UpdateMiniManager := False;
      if ShowModal = mrOK then
        DisplayKursy;
    finally
      Free;
    end;
end;

procedure TFrmMain1.MniUsuKursClick(Sender: TObject);
begin
  if GrdKursy.Row = 0 then
    Exit;

  if MessageDlg('Czy na pewno chcesz usun¹æ ten kurs ?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  with TSQL.Instance.CreateQuery do
    try
      Kursy.Fields.GetRecord(GrdKursy.Row - 1);
      SQL.Text := Format('EXECUTE PROCEDURE DELETE_KURS %d', [
        Kursy.Fields.ByNameAsInteger['ID']
      ]);
      Execute;
      Transaction.Commit;
      DisplayKursy;
    finally
      Free;
    end;
end;

procedure TFrmMain1.MniOProgramieClick(Sender: TObject);
begin
  ShowMessage('Podsumowanie kursów 1.0'#13#10#13#10'Fragment programu RadioTaxi Manager 3.5'#13#10'(c) 2001 Maciej Hryniszak. Wszelkie prawa zastrze¿one');
end;

procedure TFrmMain1.MniDrzewoPostojowClick(Sender: TObject);
begin
  with TFrmDrzewoPostojow.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TFrmMain1.GrdKursyDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
const
  HEADERS: array[0..5] of String = (
    'Lp.', 'Ulica', 'Dom', 'Mieszk', 'Taksowka', 'Godznia'
  );
var
  S: String;
begin
  S := '';
  if ARow = 0 then
    S := HEADERS[ACol]
  else
  begin
    Kursy.Fields.GetRecord(ARow - 1);
    case ACol of
      0: S := IntToStr(ARow);
      1: S := Kursy.Fields.ByNameAsString['UlICA'];
      2: S := Kursy.Fields.ByNameAsString['DOM'];
      3: S := Kursy.Fields.ByNameAsString['MIESZK'];
      4: S := Kursy.Fields.ByNameAsString['NRWYWOL'];
      5: S := FormatDateTime('HH:NN', Kursy.Fields.ByNameAsDateTime['GODZINA']);
    end;
  end;
  Inc(Rect.Top, 2); Inc(Rect.Left, 2);
  DrawText(GrdKursy.Canvas.Handle, PChar(S), Length(S), Rect, DT_SINGLELINE or DT_END_ELLIPSIS);
end;

end.

