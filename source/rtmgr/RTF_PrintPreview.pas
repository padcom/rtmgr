unit RTF_PrintPreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, RXSpin,
  RT_Print, Mask;

type
  TFrmPrintPreview = class(TForm)
    ScbPreview: TScrollBox;
    PnlControls: TPanel;
    EdtPageNumber: TRxSpinEdit;
    GbxMargins: TGroupBox;
    EdtTopMargin: TRxSpinEdit;
    EdtLeftMargin: TRxSpinEdit;
    EdtRightMargin: TRxSpinEdit;
    EdtBottomMargin: TRxSpinEdit;
    LblPageNumber: TLabel;
    ChbPrinters: TComboBox;
    LblPrinter: TLabel;
    BtnPrinterSetup: TButton;
    Bevel: TBevel;
    BtnPrint: TButton;
    ImgPreview: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImgPreviewPaint(Sender: TObject);
    procedure EdtTopMarginChange(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure BtnPrinterSetupClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ImgPreviewDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ImgPreviewStartDrag(Sender: TObject; var DragObject: TDragObject);
  private
    { Private declarations }
    PPI_X1, PPI_X2, PPI_Y1, PPI_Y2: Integer;
  public
    { Public declarations }
    PrintProc: procedure(Canvas: TCanvas; var PageNo: Integer);
    procedure SetupCanvasWidth;
  end;

implementation

uses
  Printers;

{$R *.DFM}

const
  Inch = 2.54;

procedure TFrmPrintPreview.FormCreate(Sender: TObject);
begin
  Top := 0;
  Left := 0;
  Width := Screen.Width;
  Height := Screen.Height;
  SetupCanvasWidth;
  PrintData.Margins.Left := 10;
  PrintData.Margins.Top := 10;
  PrintData.Margins.Right := 10;
  PrintData.Margins.Bottom := 10;
  ChbPrinters.Items.Assign(Printer.Printers);
  if ChbPrinters.Items.Count > 0 then ChbPrinters.ItemIndex := Printer.PrinterIndex;
end;

procedure TFrmPrintPreview.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmPrintPreview.FormShow(Sender: TObject);
begin
  EdtLeftMargin.Value := PrintData.Margins.Left;
  EdtTopMargin.Value := PrintData.Margins.Top;
  EdtRightMargin.Value := PrintData.Margins.Right;
  EdtBottomMargin.Value := PrintData.Margins.Bottom;
end;

procedure TFrmPrintPreview.ImgPreviewPaint(Sender: TObject);
var
  Page: Integer;
begin
  PrintData.PPI_X := PPI_X1;
  PrintData.PPI_Y := PPI_Y1;
  PrintData.SizeX := ImgPreview.Width;
  PrintData.SizeY := ImgPreview.Height;
  PrintData.DrawMargins := True;
  Page := EdtPageNumber.AsInteger;
  if Assigned(PrintProc) then
  begin
    PrintProc(ImgPreview.Canvas, Page);
    EdtPageNumber.MaxValue := Page;
  end;
end;

procedure TFrmPrintPreview.SetupCanvasWidth;
begin
  PPI_X1 := GetDeviceCaps(ImgPreview.Canvas.Handle, LOGPIXELSX);
  PPI_Y1 := GetDeviceCaps(ImgPreview.Canvas.Handle, LOGPIXELSY);
  PPI_X2 := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
  PPI_Y2 := GetDeviceCaps(Printer.Handle, LOGPIXELSY);

  ImgPreview.Left := 0;
  ImgPreview.Top := 0;
  ScbPreview.HorzScrollBar.Range := Round(Printer.PageWidth * (PPI_X1/PPI_X2));
  ScbPreview.VertScrollBar.Range := Round(Printer.PageHeight * (PPI_Y1/PPI_Y2));
  ImgPreview.Align := alClient;
end;

procedure TFrmPrintPreview.EdtTopMarginChange(Sender: TObject);
begin
  if EdtPageNumber.Value > EdtPageNumber.MaxValue then
  begin
    EdtPageNumber.Value := EdtPageNumber.MaxValue;
    if Sender = EdtPageNumber then Exit;
  end;
  if EdtPageNumber.Value < EdtPageNumber.MinValue then
  begin
    EdtPageNumber.Value := EdtPageNumber.MinValue;
    if Sender = EdtPageNumber then Exit;
  end;
  if Sender = EdtPageNumber then
  begin
    ScbPreview.HorzScrollBar.Position := 0;
    ScbPreview.VertScrollBar.Position := 0;
  end;
  PrintData.Margins.Left := EdtLeftMargin.Value;
  PrintData.Margins.Right := EdtRightMargin.Value;
  PrintData.Margins.Top := EdtTopMargin.Value;
  PrintData.Margins.Bottom := EdtBottomMargin.Value;
  ImgPreview.Repaint;
end;

procedure TFrmPrintPreview.BtnPrintClick(Sender: TObject);
var
  Page, MaxPage: Integer;
begin
  PrintData.PPI_X := PPI_X2;
  PrintData.PPI_Y := PPI_Y2;
  PrintData.SizeX := Printer.PageWidth;
  PrintData.SizeY := Printer.PageHeight;
  PrintData.DrawMargins := False;
  Printer.BeginDoc;
  Printer.Title := 'RadioTaxi Manager v3.1';
  Page := 1; MaxPage := 1;
  repeat
    if Assigned(PrintProc) then
    begin
      MaxPage := Page;
      PrintProc(Printer.Canvas, MaxPage);
    end;
    Inc(Page);
    if Page <= MaxPage then Printer.NewPage;
  until Page > MaxPage;
  Printer.EndDoc;
end;

procedure TFrmPrintPreview.BtnPrinterSetupClick(Sender: TObject);
var
  Dlg: TPrinterSetupDialog;
begin
  Dlg := TPrinterSetupDialog.Create(nil);
  if Dlg.Execute then
  begin
    SetupCanvasWidth;
    ImgPreview.Repaint;
  end;
  Dlg.Free;
end;

procedure TFrmPrintPreview.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Key := 0;
  end;
end;

var
  OldMouseX, OldMouseY: Integer;

procedure TFrmPrintPreview.ImgPreviewDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
  ScbPreview.HorzScrollBar.Position := ScbPreview.HorzScrollBar.Position + (OldMouseX - X);
  ScbPreview.VertScrollBar.Position := ScbPreview.VertScrollBar.Position + (OldMouseY - Y);
end;

procedure TFrmPrintPreview.ImgPreviewStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
  OldMouseX := ImgPreview.ScreenToClient(Mouse.CursorPos).x;
  OldMouseY := ImgPreview.ScreenToClient(Mouse.CursorPos).y;
end;

end.
