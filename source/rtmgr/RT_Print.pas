unit RT_Print;

interface

uses
  Windows, Classes, SysUtils, Printers, Grids, Graphics;

type
  PPrintGridData = ^TPrintGridData;
  TPrintGridData = record
    Grid: TStringGrid;
    PageMark: String;
    Title: String;
    TitleHeight: Integer;
    Margins: record
      Left  : Double;
      Top   : Double;
      Right : Double;
      Bottom: Double;
    end;
    PPI_X, PPI_Y: Integer;
    SizeX, SizeY: Integer; // size in pixels
    DrawMargins: Boolean;
  end;

var
  PrintData: TPrintGridData;

procedure PrintGrid;

implementation

uses
  RTF_PrintPreview, RT_Tools;

procedure PrintMe(Canvas: TCanvas; var PrintPage: Integer); 
var
  ScaleX, ScaleY: Double;
  L, T, R, B: Integer;
  Bounds: TRect;
  Page, Column, Row: Integer;
  X, Y: Integer;
  S: String;
  Done: Boolean;
  LeftCol, VisibleCols: Integer;
  function ColWidht: Integer;
  begin
    Result := Round(PrintData.Grid.ColWidths[Column] * ScaleX);
  end;
  function RowHeight: Integer;
  begin
    Result := Round(PrintData.Grid.RowHeights[Row] * ScaleY);
  end;
  procedure DrawTitle;
  begin
    if Page = 1 then
    begin
      // narysuj tytu³ wydruku
      Canvas.Font.Size := PrintData.TitleHeight;
      S := PrintData.Title;
      X := L + ((R - L) div 2) - (Canvas.TextWidth(S) div 2);
      Y := Y + Canvas.TextHeight(S);
      Bounds := Rect(L, Y, R, Y + Canvas.TextHeight(S));
      if Page = PrintPage then Canvas.TextRect(Bounds, X, Y, S);
      Y := Y + Canvas.TextHeight(S) * 2;
    end;
  end;
  procedure DrawAddons;
  var
    Temp: Integer;
  begin
    if Page = PrintPage then
    begin
      Canvas.Font.Size := 8;
      Canvas.Pen.Style := psSolid;

      S := PrintData.PageMark;
      Temp := L + Canvas.TextWidth(S);
      Bounds := Rect(L, T - Canvas.TextHeight(S) - 2, Temp, T - 2);
      Canvas.TextRect(Bounds, Bounds.Left, Bounds.Top, S);
      Canvas.MoveTo(L, T); Canvas.LineTo(R, T);

      S := 'Strona ' + IntToStr(Page);
      Temp := L + (R - L) div 2 - Canvas.TextWidth(S) div 2;
      Bounds := Rect(Temp, B + 5, Temp + Canvas.TextWidth(S) + 5, B + Canvas.TextHeight(S) + 5);
      Canvas.TextRect(Bounds, Bounds.Left, Bounds.Top, S);
      Canvas.MoveTo(L, B); Canvas.LineTo(R, B);
    end;
  end;
  procedure DrawLine;
  begin
    X := L;
    Column := LeftCol;
    while Column < PrintData.Grid.ColCount do
    begin
      S := PrintData.Grid.Cells[Column, Row];
      Bounds := Rect(X, Y, X + ColWidht, Y + RowHeight);
      if Bounds.Right > R then
      begin
        Beep;
        Break;
      end;
      if Page = PrintPage then Canvas.TextRect(Bounds, X, Y, S);
      X := X + ColWidht;
      Inc(Column);
    end;
    VisibleCols := Column;
    Y := Y + RowHeight;
  end;
  procedure DrawHeader;
  var
    TmpRow: Integer;
  begin
    if PrintData.Grid.FixedRows > 0 then
    begin
      Canvas.Brush.Color := PrintData.Grid.FixedColor; 
      TmpRow := Row;
      Row := 0;
      while Row < PrintData.Grid.FixedRows do
      begin
        if Page = PrintPage then
        begin
          Bounds := Rect(L, Y, R, Y + RowHeight);
          Canvas.FillRect(Bounds);
        end;
        DrawLine;
        Inc(Row);
      end;
      Row := TmpRow;
      Canvas.Brush.Color := PrintData.Grid.Color; 
    end;
  end;
begin
  Canvas.Lock;
  // wyczyszczenie p³utna
  Canvas.Brush.color := clWhite;
  Canvas.FillRect(Canvas.ClipRect);

  Canvas.Font.Name := 'Arial CE';
  // obliczenie margonesów p³utna
  ScaleX := PrintData.PPI_X / 25.4;
  ScaleY := PrintData.PPI_Y / 25.4;
  L := Round(ScaleX * PrintData.Margins.Left);
  R := Round(PrintData.SizeX - (ScaleX * PrintData.Margins.Right));
  T := Round(ScaleY * PrintData.Margins.Top);
  B := Round(PrintData.SizeY - (ScaleY * PrintData.Margins.Bottom));
  // w razie potrzeby mo¿na je wydrukowaæ
  if PrintData.DrawMargins then
  begin
    Canvas.Pen.Style := psDot;
    Canvas.MoveTo(L, 0);
    Canvas.LineTo(L, PrintData.SizeY);
    Canvas.MoveTo(R, 0);
    Canvas.LineTo(R, PrintData.SizeY);
    Canvas.MoveTo(0, T);
    Canvas.LineTo(PrintData.SizeX, T);
    Canvas.MoveTo(0, B);
    Canvas.LineTo(PrintData.SizeX, B);
  end;

  ScaleX := PrintData.PPI_X / 72 * 0.8;
  ScaleY := PrintData.PPI_Y / 72 * 0.9;
  Page := 1; LeftCol := 0; Inc(L);

  Row := PrintData.Grid.FixedRows;
  repeat
    Y := T;
    DrawAddons;
    DrawTitle;
    Canvas.Font.Size := -12;
    DrawHeader;

    while Row < PrintData.Grid.RowCount do
    begin
      X := L;
      // wydrukowanie linii tabelki
      DrawLine;

      Inc(Row);

      if Y + RowHeight > B then
      begin
        Inc(Page);
        Y := T;
        Break;
      end;
    end;

    Done := (Row = PrintData.Grid.RowCount);
    if Done then
    begin
      if VisibleCols < PrintData.Grid.ColCount then
      begin
        LeftCol := VisibleCols;
        Row := PrintData.Grid.FixedRows;
        Inc(Page);
        Done := False;
        Continue;
      end;
    end;
  until Done;
  PrintPage := Page;
end;

procedure PrintGrid;
begin
  if Printer.Printers.Count = 0 then
  begin
    ShowError('W systemie nie ma zainstalowanej drukarki !'#13#10'Aby zainstalowaæ drukarkêkliknij ikonê "Drukarki" z folderu mój komputer lub z folderu "Panel sterowania"');
    Exit;
  end;
  with TFrmPrintPreview.Create(nil) do
    try
      PrintProc := PrintMe;
      ShowModal;
    finally
      Free;
    end;
end;

end.
