unit RTF_ListaKursowTaksowki;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ExtCtrls, JvUIB, JvUIBLib;

type
  TFrmListaKursowTaksowki = class(TForm)
    PnlButtons: TPanel;
    Button1: TButton;
    GrdKursy: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure DisplayKurs(Kurs: TSQLResult; Index: Integer);
    procedure DisplayKursy;
  public
    { Public declarations }
    Taxi: String;
    Date: TDateTime;
  end;

implementation

uses
  RT_Tools, RT_SQL, RT_Base;

{$R *.DFM}

{ TFrmListaKursowTaksowki }

{ Private declarations }

procedure TFrmListaKursowTaksowki.DisplayKurs(Kurs: TSQLResult; Index: Integer);
begin
  with GrdKursy do
  begin
    if RowCount < Index + 1 then
      RowCount := Index + 1;
    Cells[0, Index] := IntToStr(Index);
    Cells[1, Index] := Kurs.ByNameAsString['ULICA'];
    Cells[2, Index] := Kurs.ByNameAsString['DOM'];
    Cells[3, Index] := Kurs.ByNameAsString['MIESZKANIE'];
    Cells[4, Index] := Kurs.ByNameAsString['NRWYWOLAWCZY'];
    Cells[5, Index] := FormatDateTime('YYYY-MM-DD HH:MM', Kurs.ByNameAsDateTime['PRZYJECIE']);
    Cells[6, Index] := 'Normalny';
    Cells[7, Index] := FormatDateTime('YYYY-MM-DD HH:MM', Kurs.ByNameAsDateTime['PRZYJECIE']);
  end;
end;

procedure TFrmListaKursowTaksowki.DisplayKursy;
var
  Index: Integer;
begin
  GrdKursy.DefaultRowHeight := 18;
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT * FROM KURSY WHERE PRZYJECIE BETWEEN %s AND %S AND NRWYWOLAWCZY=%s', [
        QuotedStr(FormatDateTime('YYYY-MM-DD', Date)),
        QuotedStr(FormatDateTime('YYYY-MM-DD', Date + 1)),
        Taxi
      ]);
      Open; Index := 1;
      while not Eof do
      begin
        DisplayKurs(Fields, Index);
        Inc(Index);
        Next;
      end;
    finally
      Free;
    end;
  if GrdKursy.RowCount = 1 then
    GrdKursy.RowHeights[0] := -1
  else
    GrdKursy.FixedRows := 1;
end;

{ Public declarations }

{ Event handlers }

procedure TFrmListaKursowTaksowki.FormCreate(Sender: TObject);
begin
  with GrdKursy do
  begin
    ColCount := 8;
    Cells[0, 0] := 'L.p.';            ColWidths[0] := 32;
    Cells[1, 0] := 'Ulica';           ColWidths[1] := 183;
    Cells[2, 0] := 'Dom';             ColWidths[2] := 48;
    Cells[3, 0] := 'Miesz.';          ColWidths[3] := 48;
    Cells[4, 0] := 'Taxi';            ColWidths[4] := 48;
    Cells[5, 0] := 'Data zamowienia'; ColWidths[5] := 96;
    Cells[6, 0] := 'Rodzaj kursu';    ColWidths[6] := 68;
    Cells[7, 0] := 'Data przyjecia';  ColWidths[7] := 96;
  end;
end;

procedure TFrmListaKursowTaksowki.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmListaKursowTaksowki.FormShow(Sender: TObject);
begin
  Left := -3;
  Top := -3;
  Width := Screen.Width + 6;
  Height := Screen.Height + 6;

  if Taxi <> '' then
  begin
    Caption := Format('Lista kursów taksówki %s z dnia %s', [
      Taxi,
      FormatDateTime('YYYY-MM-DD', Date)
    ]);
  end
  else
    Caption := 'B³êdnie zadana taksówka !';

  DisplayKursy;
  GrdKursy.SetFocus;
end;

end.

