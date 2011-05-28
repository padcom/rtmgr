unit RTF_EksportDanychKursow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, RxToolEdit, DateUtils;

type
  TFrmEksportDanychKursowSimple = class(TForm)
    CbxRok: TComboBox;
    CbxMiesiac: TComboBox;
    BtnPrzerzuc: TButton;
    BtnZamknij: TButton;
    LblRok: TLabel;
    LblMiesiac: TLabel;
    EdtKatalogDocelowy: TDirectoryEdit;
    LblKatalogDocelowy: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure BtnPrzerzucClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelectExportFile(Sender: TObject; var ExportFileName: TFileName; var Success: Boolean);
  end;

implementation

uses
  RT_Tools, RT_SQL, jvuib, RT_BackupCreator, RTF_Main;

{$R *.DFM}

procedure TFrmEksportDanychKursowSimple.FormCreate(Sender: TObject);
begin
//
end;

procedure TFrmEksportDanychKursowSimple.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmEksportDanychKursowSimple.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//
end;

procedure TFrmEksportDanychKursowSimple.FormShow(Sender: TObject);
  procedure AddDzien(Date: TDateTime);
  const
    Miesiace: array [1..12] of String =
      ('Styczeñ', 'Luty', 'Marzec', 'Kwiecieñ', 'Maj', 'Czerwiec',
       'Lipiec', 'Sierpieñ', 'Wrzesieñ', 'PaŸdziernik', 'Listopad', 'Grudzieñ');
  var
    SRok: String;
    Miesiac: integer;
    SMiesiac: String;
  begin
    SRok := FormatDateTime('YYYY', Date);
    SMiesiac := FormatDateTime('MM', Date);
    Miesiac := StrToInt(SMiesiac);
    SMiesiac := Format('%.2d', [Miesiac]) + '. ' + Miesiace[Miesiac];
    if CbxRok.Items.IndexOf(SRok) = -1 then
      CbxRok.Items.Add(SRok);
    if CbxMiesiac.Items.IndexOf(SMiesiac) = -1 then
      CbxMiesiac.Items.AddObject(SMiesiac, Pointer(Miesiac));
  end;
var
  S: String;
  I: Integer;
begin
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := 'SELECT DISTINCT CAST(REALIZACJA AS DATE) AS REALIZACJA FROM KURS';
      Open;
      while not Eof do
      begin
        AddDzien(Fields.ByNameAsDateTime['REALIZACJA']);
        Next;
      end;
    finally
      Free;
    end;
  for I := 0 to CbxMiesiac.Items.Count - 1 do
  begin
    S := CbxMiesiac.Items[I];
    S := Copy(S, 5, MaxInt);
    CbxMiesiac.Items[I] := S;
  end;
  if CbxRok.Items.Count > 0 then
    CbxRok.ItemIndex := 0;
  if CbxMiesiac.Items.Count > 0 then
    CbxMiesiac.ItemIndex := 0;
end;

procedure TFrmEksportDanychKursowSimple.SelectExportFile(Sender: TObject; var ExportFileName: TFileName; var Success: Boolean);
var
  Rok, Miesiac: Integer;
begin
  Rok := StrToInt(CbxRok.Items[CbxRok.ItemIndex]);
  Miesiac := Integer(CbxMiesiac.Items.Objects[CbxMiesiac.ItemIndex]);

  ExportFileName := '';
  with TSaveDialog.Create(nil) do
    try
      Title := 'Wska¿ plik danych do eksportu...';
      DefaultExt := '.backup';
      Filter := 'Pliki kopii zapasowej kursów (*.backup)|*.backup|Wszystkie pliki (*.*)|*.*';
      Options := [ofOverwritePrompt, ofPathMustExist, ofEnableSizing];
      FileName := Format('kursy-%s.backup', [FormatDateTime('YYYY-MM', EncodeDateTime(Rok, Miesiac, 1, 0, 0, 0, 0))]);
      Success := Execute;
      if Success then
        ExportFileName := FileName;
    finally
      Free;
    end;
end;

procedure TFrmEksportDanychKursowSimple.BtnPrzerzucClick(Sender: TObject);
var
  Rok, Miesiac: Integer;
  FromDate, ToDate: TDateTime;
begin
  Rok := StrToInt(CbxRok.Items[CbxRok.ItemIndex]);
  Miesiac := Integer(CbxMiesiac.Items.Objects[CbxMiesiac.ItemIndex]);

  FromDate := EncodeDateTime(Rok, Miesiac, 1, 0, 0, 0, 0);
  ToDate :=  IncMonth(FromDate);

  with TRTBackupCreator.Create(['KURS']) do
    try
      OnQueryFileName := SelectExportFile;
      OnBeginImport := FrmMain.BeginImport;
      OnEndImport := FrmMain.EndImport;
      OnError := FrmMain.ShowErrorMsg;
      Execute('KURS', Format('SELECT * FROM KURS WHERE REALIZACJA BETWEEN %s AND %s', [
        QuotedStr(FormatDateTime('YYYY-MM-DD', FromDate)),
        QuotedStr(FormatDateTime('YYYY-MM-DD', ToDate))
      ]));
    finally
      Free;
    end;
end;

end.

