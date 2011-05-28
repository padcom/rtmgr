unit RTF_Zestawienia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, Printers, DateUtils, JvUIB, JvUIBLib,
  RT_Tools, RT_SQL;

type
  TZestawienieKind = (zkDzien, zkOkres);

  TFrmZestawienia = class(TForm)
    GrdZestawienie: TStringGrid;
    PnlButtons: TPanel;
    BtnPrint: TButton;
    BtnExcel: TButton;
    BtnClose: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure BtnExcelClick(Sender: TObject);
    procedure GrdZestawienieKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure SetupAsZestawienieZZakresu(Date1, Date2: TDateTime);
  public
    { Public declarations }
    DialogKind: TZestawienieKind;
    procedure SetupAsZestawienieZDnia(Date: TDateTime);
    procedure SetupAsZestawienieWszystkichTaksowekZMiesiaca(Date: TDateTime);
    procedure SetupAsZestawienieKoncoweZDnia(Data: TDateTime);
  end;

implementation

uses
  Math, RT_Print;

{$R *.DFM}

{ TFrmZestawienia }

{ Private declarations }

procedure TFrmZestawienia.SetupAsZestawienieZZakresu(Date1, Date2: TDateTime);
var
  RowIndex, TotalCount: Integer;
begin
  Caption := 'Zestawienie kursów z dnia: ' + FormatDateTime('YYYY-MM-DD', Date);
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT * FROM Zestawienie (%s, %s);', [
        QuotedStr(FormatDateTime('YYYY-MM-DD', Date1)),
        QuotedStr(FormatDateTime('YYYY-MM-DD', Date2))
      ]);
      Open;
      FetchAll;
      with GrdZestawienie do
      begin
        ColCount := 5;
        RowCount := 2;

        FixedRows := 1;
        Cells[0, 0] := 'L.p.';             ColWidths[0] := 32;
        Cells[1, 0] := 'Imiê, nazwisko';   ColWidths[1] := 291;
        Cells[2, 0] := 'Numer wywo³.';     ColWidths[2] := 85;
        Cells[3, 0] := 'Numer boczny';     ColWidths[3] := 85;
        Cells[4, 0] := 'Iloœæ kursów';     ColWidths[4] := 120;

        First;
        RowIndex := 1; TotalCount := 0;
        while not Eof do
        begin
          RowCount := RowIndex + 1;
          Cells[0, RowIndex] := IntToStr(RowIndex);
          Cells[1, RowIndex] := Fields.ByNameAsString['NAZWA'];
          Cells[2, RowIndex] := Fields.ByNameAsString['NRBOCZNY'];
          Cells[3, RowIndex] := Fields.ByNameAsString['NRWYWOLAWCZY'];
          Cells[4, RowIndex] := Fields.ByNameAsString['ILOSCKURSOW'];
          Inc(RowIndex);
          Inc(TotalCount, Fields.ByNameAsInteger['ILOSCKURSOW']);
          Next;
        end;
        RowCount := RowCount + 2;
        Cells[ColCount - 2, RowCount - 1] := 'Razem:';
        Cells[ColCount - 1, RowCount - 1] := IntToStr(TotalCount);
      end;
      Close;
    finally
      Free;
    end;
end;

procedure TFrmZestawienia.GrdZestawienieKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RIGHT then with GrdZestawienie do
  begin
    if VisibleColCount < ColCount - LeftCol then
    begin
      if ssCtrl in Shift then
        LeftCol := ColCount - LeftCol
      else
        LeftCol := LeftCol + 1;
    end;
    Key := 0;
  end;
  if Key = VK_LEFT then with GrdZestawienie do
  begin
    if LeftCol > 0 then
    begin
      if ssCtrl in Shift then
        LeftCol := 0
      else
        LeftCol := LeftCol - 1;
    end;
    Key := 0;
  end;
end;

procedure TFrmZestawienia.SetupAsZestawienieKoncoweZDnia(Data: TDateTime);
  function GetAddress(Kurs: TSQLResult): String;
  begin
    Result := Kurs.ByNameAsString['ULICA'];
    if Kurs.ByNameAsString['DOM'] <> '' then
      Result := Result + ' ' + Kurs.ByNameAsString['DOM'];
    if Kurs.ByNameAsString['MIESZKANIE'] <> '' then
      Result := Result + '/' + Kurs.ByNameAsString['MIESZKANIE'];
  end;
  procedure WypiszKurs(Kurs: TSQLResult; Index: Integer);
  var
    Column, Row: Integer;
  begin
    Column := (Index div ((Kurs.RecordCount + 1) div 2)) * 4;
    Row := Index mod ((Kurs.RecordCount + 1) div 2) + 1;
    if Column = 0 then
      GrdZestawienie.RowCount := GrdZestawienie.RowCount + 1;
    GrdZestawienie.Cells[Column, Row] := IntToStr(Index + 1);
    GrdZestawienie.Cells[Column + 1, Row] := GetAddress(Kurs);
    GrdZestawienie.Cells[Column + 2, Row] := Kurs.ByNameAsString['NRWYWOLAWCZY'];
    GrdZestawienie.Cells[Column + 3, Row] := FormatDateTime('HH:NN', Kurs.ByNameAsDateTime['PRZYJECIE']);
  end;
  procedure WypiszTaksowka(Taksowka: TSQLResult; Index: Integer);
  var
    Column, Row: Integer;
  begin
    Column := (Index mod 2) * 4;
    Row := Index div 2 + 1;
    if Column = 0 then
      GrdZestawienie.RowCount := GrdZestawienie.RowCount + 1;
    GrdZestawienie.Cells[Column + 1, Row] := Taksowka.ByNameAsString['NAZWA'];
    GrdZestawienie.Cells[Column + 2, Row] := Taksowka.ByNameAsString['NRWYWOLAWCZY'];
    GrdZestawienie.Cells[Column + 3, Row] := Taksowka.ByNameAsString['ILOSCKURSOW'];
  end;
var
  Index: Integer;
  S: String;
begin
  with GrdZestawienie do
  begin
    ColCount := 8;
    FixedCols := 0;
    Cells[0, 0] := 'L.P.';      ColWidths[0] := 32;
    Cells[1, 0] := 'Adres';     ColWidths[1] := 164;
    Cells[2, 0] := 'Taxi';      ColWidths[2] := 54;
    Cells[3, 0] := 'Godzina';   ColWidths[3] := 64;
    Cells[4, 0] := 'L.P.';      ColWidths[4] := 32;
    Cells[5, 0] := 'Adres';     ColWidths[5] := 164;
    Cells[6, 0] := 'Taxi';      ColWidths[6] := 54;
    Cells[7, 0] := 'Godzina';   ColWidths[7] := 64;
    RowCount := 2;
    FixedRows := 1;
  end;

  Caption := 'Zestawienie koñcowe kursów z dnia ' + FormatDateTime('YYYY-MM-DD', Data);
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT NRWYWOLAWCZY,ULICA,DOM,MIESZKANIE,PRZYJECIE FROM KURSY WHERE PRZYJECIE BETWEEN %s AND %s', [
        QuotedStr(FormatDateTime('YYYY-MM-DD', Data)),
        QuotedStr(FormatDateTime('YYYY-MM-DD', Data + 1))
      ]);
      Open; Index := 0;
      FetchAll;
      First;
      while not Eof do
      begin
        WypiszKurs(Fields, Index);
        Inc(Index);
        Next;
      end;
      Close;

      S := Format('SELECT * FROM zestawienie (%s, %s);', [
        QuotedStr(FormatDateTime('YYYY-MM-DD', Data)),
        QuotedStr(FormatDateTime('YYYY-MM-DD', Data + 1))
      ]);
      SQL.Text := S;
      if Odd(Index) then Inc(Index);
      Open; Index := (Index div 2) * 2 + 4;
      while not Eof do
      begin
        WypiszTaksowka(Fields, Index);
        Inc(Index);
        Next;
      end;
      Close;
    finally
      Free;
    end;
end;

{ Public declarations }

procedure TFrmZestawienia.SetupAsZestawienieZDnia(Date: TDateTime);
begin
  DialogKind := zkDzien;
  SetupAsZestawienieZZakresu(Date, Date + 1);
end;

procedure TFrmZestawienia.BtnPrintClick(Sender: TObject);
begin
  PrintData.PageMark := 'RadioTaxi Manager v3.1  (c) 2001 by Maciej Hryniszak';
  PrintData.Title := Caption;
  PrintData.Grid := GrdZestawienie;
  PrintGrid;
end;

procedure TFrmZestawienia.SetupAsZestawienieWszystkichTaksowekZMiesiaca(Date: TDateTime);
var
  Y, M, D: Word;
begin
  DecodeDate(Date, Y, M, D);
  Date := EncodeDate(Y, M, 1);
  SetupAsZestawienieZZakresu(Date, IncMonth(Date));
end;

{ Event handlers }

procedure TFrmZestawienia.FormCreate(Sender: TObject);
begin
  Left := 0;
  Top := 0;
  Width := Screen.Width;
  Height := Screen.Height;
end;

procedure TFrmZestawienia.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmZestawienia.FormShow(Sender: TObject);
begin
  BtnClose.Left := Width - BtnClose. Width - 14;
end;

procedure TFrmZestawienia.BtnExcelClick(Sender: TObject);
begin
//
end;

end.

