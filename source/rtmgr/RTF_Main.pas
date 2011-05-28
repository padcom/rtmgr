unit RTF_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, IniFiles,
  StdCtrls, ExtCtrls, ToolWin, ComCtrls, Menus, Grids, FileCtrl, JvUIB, JvUIBLib,
  RT_Tools, RT_Updater;

const
  WM_SHOWMINIMANAGER = WM_USER + 1;
  RemindInterval = 5; {minuty o przypomnieniu o kursie}

type
  TFrmMain = class(TForm)
    PnlDaneKursu: TPanel;
    StatusBar: TStatusBar;
    AutoUpdater: TTimer;
    LblPostoj1Desc: TLabel;
    LblPostoj1: TLabel;
    LblPostoj2Desc: TLabel;
    LblPostoj2: TLabel;
    LblPostoj3Desc: TLabel;
    LblPostoj3: TLabel;
    LblPostoj4Desc: TLabel;
    LblPostoj4: TLabel;
    LblPostoj5Desc: TLabel;
    LblPostoj5: TLabel;
    LblPostoj6Desc: TLabel;
    LblPostoj6: TLabel;
    LblPostoj7Desc: TLabel;
    LblPostoj7: TLabel;
    LblPostoj8Desc: TLabel;
    LblPostoj8: TLabel;
    MainMenu: TMainMenu;
    MnuPlik1: TMenuItem;
    N1: TMenuItem;
    MniKoniec: TMenuItem;
    MnuSlowniki: TMenuItem;
    MniPostoje: TMenuItem;
    MniUlice: TMenuItem;
    MniTaksowki: TMenuItem;
    MniKlienci: TMenuItem;
    MnuKursy: TMenuItem;
    MniNowyKurs: TMenuItem;
    MniWyslijKurs: TMenuItem;
    N2: TMenuItem;
    MniUsunKurs: TMenuItem;
    MniPoprawKurs: TMenuItem;
    MnuPomoc: TMenuItem;
    MniIndeksPomocy: TMenuItem;
    MniOProgramie: TMenuItem;
    MnuZestawienia: TMenuItem;
    MniZestawienieZDzisiaj: TMenuItem;
    MnuImportDanych: TMenuItem;
    MniImportUliceIPostoje: TMenuItem;
    MniZestawienieZWczoraj: TMenuItem;
    N4: TMenuItem;
    MniListaKursowWybranejTaksowki: TMenuItem;
    N5: TMenuItem;
    MniZestawienieKoncoweZDzisiaj: TMenuItem;
    MniZestawienieKoncoweZWczoraj: TMenuItem;
    N6: TMenuItem;
    MniZnajdzKlienta: TMenuItem;
    Eksportujdane1: TMenuItem;
    MiniManagerESC1: TMenuItem;
    GrdKursy: TDrawGrid;
    Uliceipostoje1: TMenuItem;
    Kursy1: TMenuItem;
    MniObszary: TMenuItem;
    Wybierzobszar1: TMenuItem;
    MniDrukujWolania: TMenuItem;
    N3: TMenuItem;
    WszystkieDane1: TMenuItem;
    N7: TMenuItem;
    MniZliczKursyZDanegoMiesiaca: TMenuItem;
    N8: TMenuItem;
    MniChangePassword1: TMenuItem;
    MniZmienStatusPudla: TMenuItem;
    N9: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AutoUpdaterTimer(Sender: TObject);
    procedure GrdKursyClick(Sender: TObject);
    procedure MniKoniecClick(Sender: TObject);
    procedure MniPostojeClick(Sender: TObject);
    procedure MniUliceClick(Sender: TObject);
    procedure MniTaksowkiClick(Sender: TObject);
    procedure MniKlienciClick(Sender: TObject);
    procedure MniNowyKursClick(Sender: TObject);
    procedure MniWyslijKursClick(Sender: TObject);
    procedure MniUsunKursClick(Sender: TObject);
    procedure MniPoprawKursClick(Sender: TObject);
    procedure MniZestawienieZDzisiajClick(Sender: TObject);
    procedure MniZestawienieZAktualnegoMiesiacaWszystkieClick(Sender: TObject);
    procedure MniIndeksPomocyClick(Sender: TObject);
    procedure MniOProgramieClick(Sender: TObject);
    procedure MniZestawienieZWczorajClick(Sender: TObject);
    procedure MniImportUliceIPostojeClick(Sender: TObject);
    procedure MniListaKursowWybranejTaksowkiClick(Sender: TObject);
    procedure MniZestawienieKoncoweZDzisiajClick(Sender: TObject);
    procedure MniZestawienieKoncoweZWczorajClick(Sender: TObject);
    procedure MniZnajdzKlientaClick(Sender: TObject);
    procedure Eksportujdane1Click(Sender: TObject);
    procedure MiniManagerESC1Click(Sender: TObject);
    procedure GrdKursyDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Uliceipostoje1Click(Sender: TObject);
    procedure MniObszaryClick(Sender: TObject);
    procedure Wybierzobszar1Click(Sender: TObject);
    procedure MniDrukujWolaniaClick(Sender: TObject);
    procedure WszystkieDane1Click(Sender: TObject);
    procedure MniZliczKursyZDanegoMiesiacaClick(Sender: TObject);
    procedure MniChangePassword1Click(Sender: TObject);
    procedure MniZmienStatusPudlaClick(Sender: TObject);
  private
    { Private declarations }
    FIniFile: TIniFile;
    FCurrentDate: TDateTime;
    FKursyQuery: TJvUIBQuery;
    FKursyTimestamp: TDateTime;
    FUpdater: TUpdateListener;
    FObszary: TIdArray;
    procedure WMShowMiniManager(var Msg: TMsg); message WM_SHOWMINIMANAGER;
    function CheckPassword: Boolean;
    property IniFile: TIniFile read FIniFile;
  public
    { Public declarations }
    procedure DisplayKurs(Index: Integer);
    procedure DisplayKursy;
    procedure EditPostoje;
    procedure EditUlice;
    procedure EditTaksowki;
    procedure EditKlienci;
    procedure EditObszary;
    procedure AddKurs;
    procedure EditKurs;
    procedure DeleteKurs;
    procedure SelectImportFile(Sender: TObject; var ImportFileName: TFileName; var Success: Boolean);
    procedure SelectExportFile(Sender: TObject; var ExportFileName: TFileName; var Success: Boolean);
    procedure BeginImport(Sender: TObject);
    procedure EndImport(Sender: TObject);
    procedure ShowErrorMsg(Sender: TObject; ErrorMsg: String);
    procedure SelectObszary;
    procedure SaveObszary;
    procedure LoadObszary;
    property Obszary: TIdArray read FObszary;
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  Math,
  RTF_ListaPostojow, RTF_EdytorKursu, RTF_ListaUlic, RTF_ListaTaksowek,
  RTF_ListaKlientow, RTF_Zestawienia, RTF_SelectDate,
  RTF_ListaKursowTaksowki, RTF_PleaseWait, RTF_EksportDanych,
  RTF_EksportDanychKursow, RTF_MiniManager, RT_SQL,
  RT_Base, RT_DateProvider, RT_BackupImporter, RT_BackupCreator,
  RTF_ListaObszarow, RTF_ObszarSelector, RT_WolaniaGenerator, ShellAPI, 
  RTF_SelectMonth, RTF_InputPassword, RTF_ChangePassword;

{$R *.DFM}

{ TFrmMain }

{ Private declarations }

procedure TFrmMain.WMShowMiniManager(var Msg: TMsg);
begin
  FrmMiniManager.Show;
  FrmMiniManager.BringToFront;
end;

function GetCurrentPassword: String;
begin
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := 'SELECT HASLO FROM HASLO';
      Open;
      if not Eof then
        Result := Fields.AsString[0]
      else
      begin
        SQL.Text := 'INSERT INTO HASLO (HASLO) VALUES (''qwe123'')';
        Execute;
        Transaction.Commit;
        Result := 'qwe123';
      end;
    finally
      Free;
    end;
end;

function TFrmMain.CheckPassword: Boolean;
var
  Password: String;
begin
  Result := False;
  Password := '';
  if not GetPassword(Password) then
    Exit
  else if Password <> GetCurrentPassword then
    MessageBox(Handle, 'B³êdne has³o!', 'B³¹d', MB_ICONERROR or MB_OK)
  else
    Result := True;
end;

{ Public declarations }

procedure TFrmMain.DisplayKurs(Index: Integer);
var
  I: Integer;
begin
  FKursyQuery.Fields.GetRecord(Index);
  for I := 1 to 8 do
    GetLabelByName(Self, Format('LblPostoj%d', [I])).Caption := FKursyQuery.Fields.ByNameAsString[Format('POSTOJ%d', [I])];
end;

procedure TFrmMain.DisplayKursy;
begin
  FKursyQuery.Close(etmRollback);
  FKursyQuery.SQL.Text := Format('SELECT * FROM GRDKURSY WHERE PRZYJECIE BETWEEN %S AND %S;', [
    QuotedStr(FormatDateTime('YYYY-MM-DD', TRTDateProvider.Instance.Now)),
    QuotedStr(FormatDateTime('YYYY-MM-DD', TRTDateProvider.Instance.Now + 1))
  ]);

  FKursyTimestamp := TRTDateProvider.Instance.Now;
  FKursyQuery.Open;
  FKursyQuery.FetchAll;

  if FKursyQuery.Fields.RecordCount = 0 then
  begin
    GrdKursy.ColCount := 1;
    GrdKursy.RowCount := 1;
    GrdKursy.ColWidths[0] := 0;
    GrdKursy.RowHeights[0] := 0;
  end
  else
  begin
    GrdKursy.ColCount := 6;
    GrdKursy.RowCount := FKursyQuery.Fields.RecordCount + 1;
    GrdKursy.ColWidths[0] := 32;
    GrdKursy.ColWidths[1] := 347;
    GrdKursy.ColWidths[2] := 48;
    GrdKursy.ColWidths[3] := 48;
    GrdKursy.ColWidths[4] := 48;
    GrdKursy.ColWidths[5] := 96;
    GrdKursy.DefaultRowHeight := 18;
    GrdKursy.FixedCols := 0;
    GrdKursy.FixedRows := 1;
  end;

  GrdKursy.Row := GrdKursy.RowCount - 1;
  GrdKursy.TopRow := GrdKursy.RowCount - GrdKursy.VisibleRowCount;
  GrdKursyClick(nil);
end;

procedure TFrmMain.EditPostoje;
begin
  AutoUpdater.Enabled := False;
  try
    if not CheckPassword then Exit;
    with TFrmListaPostojow.Create(nil) do
      try
        SetupAsEditor;
        ShowModal;
      finally
        Free;
      end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

procedure TFrmMain.EditUlice;
begin
  AutoUpdater.Enabled := False;
  try
    if not CheckPassword then Exit;
    with TFrmListaUlic.Create(nil) do
      try
        SetupAsEditor;
        ShowModal;
      finally
        Free;
      end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

procedure TFrmMain.EditTaksowki;
begin
  AutoUpdater.Enabled := False;
  try
    if not CheckPassword then Exit;
    with TFrmListaTaksowek.Create(nil) do
      try
        SetupAsEditor;
        ShowModal;
      finally
        Free;
      end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

procedure TFrmMain.EditKlienci;
begin
  AutoUpdater.Enabled := False;
  try
    if not CheckPassword then Exit;
    with TFrmListaKlientow.Create(nil) do
      try
        SetupAsEditor;
        ShowModal;
      finally
        Free;
      end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

procedure TFrmMain.EditObszary;
begin
  AutoUpdater.Enabled := False;
  try
    if not CheckPassword then Exit;
    with TFrmListaObszarow.Create(nil) do
      try
        SetupAsEditor;
        ShowModal;
      finally
        Free;
      end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

procedure TFrmMain.AddKurs;
begin
  AutoUpdater.Enabled := False;
  try
    with TFrmEdytorKursu.Create(nil) do
      try
        if FrmMiniManager.Active then
        begin
          EdtUlica.Text := FrmMiniManager.Ulica;
          UlicaId := FrmMiniManager.UlicaId;
          if ServingObszar then
            UpdateTaksowka;
          FrmMiniManager.EdtQuickSearch.Text := '';
        end;
        if ShowModal = mrOK then
          DisplayKursy;
      finally
        Free;
      end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

procedure TFrmMain.EditKurs;
begin
  if GrdKursy.Row < 1 then
    Exit;

  AutoUpdater.Enabled := False;
  try
    with TFrmEdytorKursu.Create(nil) do
      try
        FKursyQuery.Fields.GetRecord(GrdKursy.Row - 1);
        SetData(FKursyQuery.Fields);
        if ShowModal = mrOK then
          DisplayKursy;
      finally
        Free;
      end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

procedure TFrmMain.DeleteKurs;
begin
  if GrdKursy.Row < 1 then
    Exit;

  AutoUpdater.Enabled := False;
  try
    if MessageDlg('Czy na pewno chcesz usun¹æ ten kurs ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      FKursyQuery.Fields.GetRecord(GrdKursy.Row - 1);
      with TSQL.Instance.CreateQuery do
        try
          SQL.Text := Format('EXECUTE PROCEDURE DELETE_KURS %d', [
            FKursyQuery.Fields.ByNameAsInteger['ID']
          ]);
          Execute;
          Transaction.Commit;
        finally
          Free;
        end;
      DisplayKursy;
    end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

procedure TFrmMain.SaveObszary;
var
  I: Integer;
  Keys: TStrings;
begin
  Keys := TStringList.Create;
  try
    IniFile.ReadSection('areas', Keys);
    for I := 0 to Keys.Count - 1 do
      IniFile.DeleteKey('areas', Keys[I]);
  finally
    Keys.Free;
  end;
  for I := 0 to Length(Obszary) - 1 do
    IniFile.WriteInteger('areas', IntToStr(I), Obszary[I]);
end;

procedure TFrmMain.LoadObszary;
var
  I: Integer;
  Keys: TStrings;
begin
  SetLength(FObszary, 0);
  Keys := TStringList.Create;
  try
    IniFile.ReadSection('areas', Keys);
    SetLength(FObszary, Keys.Count);
    for I := 0 to Keys.Count - 1 do
      Obszary[I] := IniFile.ReadInteger('areas', Keys[I], 0);
  finally
    Keys.Free;
  end;
end;

{ Event handlers }

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  AutoUpdater.Enabled := False;
  FIniFile := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  FUpdater := TUpdateListener.Create(['KURS', 'POSTOJ', 'ULICA', 'POSTOJNAULICY']);
  TRTUpdater.Instance.RegisterListener(FUpdater);
  FCurrentDate := TRTDateProvider.Instance.Date;
  FKursyQuery := TSQL.Instance.CreateQuery;
  AutoUpdater.Enabled := True;
  DisplayKursy;
  LoadObszary;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  SaveObszary;
  FreeAndNil(FKursyQuery);
end;

procedure TFrmMain.FormShow(Sender: TObject);
var
  R: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
  if R.Right > 640 then
  begin
    Top := (R.Bottom - 488) div 2;
    Left := (R.Right - 648) div 2;
    Width := 648;
    Height := 488;
  end
  else
  begin
    Top := -4;
    Left := -4;
    Width := 648;
    Height := R.Bottom + 8;
  end;
  SelectObszary;
  PostMessage(Handle, WM_SHOWMINIMANAGER, 0, 0);
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
{$IFDEF FINALVERSION}
  if MessageBox(Handle, 'Czy na pewno chcesz zakoñczyæ program ?', 'PotwierdŸ', MB_ICONQUESTION or MB_YESNO or MB_APPLMODAL) = ID_NO then
    CanClose := False;
{$ENDIF}
end;

procedure TFrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then
  begin
    FrmMiniManager.Show;
    FrmMiniManager.BringToFront;
  end;
end;

procedure TFrmMain.AutoUpdaterTimer(Sender: TObject);
var
  PerformUpdate: Boolean;
begin
  if FCurrentDate <> TRTDateProvider.Instance.Date then
  begin
    FCurrentDate := TRTDateProvider.Instance.Date;
    DisplayKursy;
  end
  else
  begin
    FUpdater.Lock;
    try
      PerformUpdate := not FUpdater.UpdatedTables.Empty;
      while not FUpdater.UpdatedTables.Empty do
        FUpdater.UpdatedTables.Pop;
    finally
      FUpdater.Unlock;
    end;
    if PerformUpdate then
      DisplayKursy;
  end;
end;

procedure TFrmMain.GrdKursyClick(Sender: TObject);
begin
  DisplayKurs(GrdKursy.Row - 1);
end;

procedure TFrmMain.MniKoniecClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.MniPostojeClick(Sender: TObject);
begin
  EditPostoje;
end;

procedure TFrmMain.MniUliceClick(Sender: TObject);
begin
  EditUlice;
end;

procedure TFrmMain.MniTaksowkiClick(Sender: TObject);
begin
  EditTaksowki;
end;

procedure TFrmMain.MniKlienciClick(Sender: TObject);
begin
  EditKlienci;
end;

procedure TFrmMain.MniNowyKursClick(Sender: TObject);
begin
  AddKurs;
  GrdKursy.Row := GrdKursy.RowCount - 1;
end;

procedure TFrmMain.MniWyslijKursClick(Sender: TObject);
begin
//
end;

procedure TFrmMain.MniUsunKursClick(Sender: TObject);
begin
  DeleteKurs;
end;

procedure TFrmMain.MniPoprawKursClick(Sender: TObject);
begin
  EditKurs;
end;

procedure TFrmMain.MniZestawienieZDzisiajClick(Sender: TObject);
begin
  with TFrmZestawienia.Create(nil) do
    try
      SetupAsZestawienieZDnia(TRTDateProvider.Instance.Date);
      ShowModal;
    finally
      Free;
    end;
end;

procedure TFrmMain.MniZestawienieZAktualnegoMiesiacaWszystkieClick(Sender: TObject);
begin
  with TFrmZestawienia.Create(nil) do
    try
      SetupAsZestawienieWszystkichTaksowekZMiesiaca(TRTDateProvider.Instance.Now);
      ShowModal;
    finally
      Free;
    end;
end;

procedure TFrmMain.MniIndeksPomocyClick(Sender: TObject);
begin
//
end;

procedure TFrmMain.MniOProgramieClick(Sender: TObject);
begin
  MessageBox(Handle, 'RadioTaxi Manager 3.6'#13#10#13#10'Autor: Maciej Hryniszak'#13#10'Wszelkie prawa zastrze¿one'#13#10#13#10'Program do u¿ytku wy³¹cznie w firmie Radio Taxi Dragon sp. z o.o.', 'O programie ...', MB_ICONINFORMATION or MB_OK or MB_APPLMODAL);
end;

procedure TFrmMain.MniZestawienieZWczorajClick(Sender: TObject);
begin
  with TFrmZestawienia.Create(nil) do
    try
      SetupAsZestawienieZDnia(TRTDateProvider.Instance.Date - 1);
      ShowModal;
    finally
      Free;
    end;
end;

procedure TFrmMain.SelectImportFile(Sender: TObject; var ImportFileName: TFileName; var Success: Boolean);
begin
  ImportFileName := '';
  with TOpenDialog.Create(nil) do
    try
      Title := 'Wska¿ plik danych do importu...';
      DefaultExt := '.backup';
      Filter := 'Pliki kopii zapasowej (*.backup)|*.backup|Wszystkie pliki (*.*)|*.*';
      Options := [ofPathMustExist, ofFileMustExist, ofEnableSizing];
      Success := Execute;
      if Success then
        ImportFileName := FileName;
    finally
      Free;
    end;
end;

procedure TFrmMain.BeginImport(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
end;

procedure TFrmMain.EndImport(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TFrmMain.ShowErrorMsg(Sender: TObject; ErrorMsg: String);
begin
  Application.MessageBox(PChar(ErrorMsg), 'B³¹d', MB_ICONERROR or MB_OK);
end;

procedure TFrmMain.SelectObszary;
begin
  if TFrmObszarSelector.EditIds(FObszary) then
    FrmMiniManager.DisplayKursyDoWyslania;
end;

procedure TFrmMain.MniImportUliceIPostojeClick(Sender: TObject);
begin
  AutoUpdater.Enabled := False;
  try
    with TRTBackupImporter.Create(['ULICA', 'POSTOJ', 'TAKSOWKANAPOSTOJU', 'POSTOJNAULICY']) do
      try
        OnQueryFileName := SelectImportFile;
        OnBeginImport := BeginImport;
        OnEndImport := EndImport;
        OnError := ShowErrorMsg;
        Execute;
        ShowMessage('Import danych zakoñczony pomyœlnie');
      finally
        Free;
      end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

procedure TFrmMain.MniListaKursowWybranejTaksowkiClick(Sender: TObject);
begin
  with TFrmListaKursowTaksowki.Create(nil) do
    try
      Date := SelectDate;
      if Date = 0 then
        Exit;
      Taxi := SelectTaxi;
      if Taxi <> '' then
        ShowModal;
    finally
      Free;
    end;
end;

procedure TFrmMain.MniZestawienieKoncoweZDzisiajClick(Sender: TObject);
begin
  with TFrmZestawienia.Create(nil) do
    try
      SetupAsZestawienieKoncoweZDnia(TRTDateProvider.Instance.Now);
      ShowModal;
    finally
      Free;
    end;
end;

procedure TFrmMain.MniZestawienieKoncoweZWczorajClick(Sender: TObject);
begin
  with TFrmZestawienia.Create(nil) do
    try
      SetupAsZestawienieKoncoweZDnia(TRTDateProvider.Instance.Now - 1);
      ShowModal;
    finally
      Free;
    end;
end;

procedure TFrmMain.MniZnajdzKlientaClick(Sender: TObject);
var
  S: String;
begin
  FKursyQuery.Fields.GetRecord(GrdKursy.Row - 1);
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT TELEFON FROM KLIENT WHERE ULICA LIKE %s AND DOM LIKE %s AND MIESZKANIE LIKE %s;', [
        QuotedStr(FKursyQuery.Fields.ByNameAsString['ULICA']),
        QuotedStr(FKursyQuery.Fields.ByNameAsString['DOM']),
        QuotedStr(FKursyQuery.Fields.ByNameAsString['MIESZKANIE'])
      ]);
      Open;
      if not Eof then
      begin
        S := Format('Klient zamawiaj¹cy kurs:'#13#10'%s %s', [
          FKursyQuery.Fields.ByNameAsString['ULICA'],
          FKursyQuery.Fields.ByNameAsString['DOM']
        ]);
        if FKursyQuery.Fields.ByNameAsString['DOM'] <> '' then
          S := S + Format('/%s', [FKursyQuery.Fields.ByNameAsString['DOM']]);
        S := S + Format(#13#10'Telefon: %s', [Fields.ByNameAsString['TELEFON']]);
        Application.MessageBox(PChar(S), 'Znaleziony klient', MB_ICONINFORMATION or MB_OK);
      end
      else
      begin
        S := 'Nie znaleziono klienta do danego kursu w bazie danych !';
        Application.MessageBox(PChar(S), 'Klienci', MB_ICONERROR or MB_OK);
      end;
      Close;
    finally
      Free;
    end;
end;

procedure TFrmMain.Eksportujdane1Click(Sender: TObject);
begin
  with TFrmEksportDanychKursowSimple.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TFrmMain.MiniManagerESC1Click(Sender: TObject);
begin
  PostMessage(Handle, WM_SHOWMINIMANAGER, 0, 0);
end;

procedure TFrmMain.GrdKursyDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  function GetRodzajKursu(Flags: Integer): String;
  begin
    Result := 'Normalny';
    if (Flags and kfZamowiony <> 0) and (Flags and kfWyslany = 0) then
      Result := 'Zamówiony'
    else if (Flags and kfZamowiony <> 0) and (Flags and kfWyslany <> 0) then
      Result := 'Wys³any'
    else if Flags and kfInformacja <> 0 then
      Result := 'Informacja';
  end;
  function IsPudlo(Flags: Integer): Boolean;
  begin
    Result := Flags and kfPudlo <> 0;
  end;
  function IsWykozystany(Flags: Integer): Boolean;
  begin
    Result := Flags and kfWykozystane <> 0;
  end;
const
  HEADERS: array[0..5] of String = (
    'L.p.', 'Ulica', 'Dom', 'Miesz.', 'Taxi', 'Godzina nadania'
  );
var
  S: String;
  DrawTextFormat: Word;
begin
  DrawTextFormat := 0;
  if ARow = 0 then
  begin
    S := HEADERS[ACol];
    if ACol = 5 then
      DrawTextFormat := DT_CENTER;
  end
  else
  begin
    FKursyQuery.Fields.GetRecord(ARow - 1);

    if IsPudlo(FKursyQuery.Fields.ByNameAsInteger['Flags']) then
    begin
      GrdKursy.Canvas.Font.Style := [fsBold];
      if IsWykozystany(FKursyQuery.Fields.ByNameAsInteger['Flags']) then
        GrdKursy.Canvas.Font.Style := GrdKursy.Canvas.Font.Style + [fsStrikeOut];
    end
    else
      GrdKursy.Canvas.Font.Style := [];

    case ACol of
      0: S := IntToStr(ARow);
      1: S := FKursyQuery.Fields.ByNameAsString['ULICA'];
      2: S := FKursyQuery.Fields.ByNameAsString['DOM'];
      3: S := FKursyQuery.Fields.ByNameAsString['MIESZKANIE'];
      4: S := FKursyQuery.Fields.ByNameAsString['TAKSOWKA'];
      5:
      begin
        S := FormatDateTime('HH:NN', FKursyQuery.Fields.ByNameAsDateTime['PRZYJECIE']);
        DrawTextFormat := DT_CENTER;
      end;
    end;
  end;
  Inc(Rect.Left, 2);
  Inc(Rect.Top, 2);
  DrawText(GrdKursy.Canvas.Handle, PChar(S), Length(S), Rect, DT_SINGLELINE or DT_END_ELLIPSIS or DrawTextFormat);
end;

procedure TFrmMain.SelectExportFile(Sender: TObject; var ExportFileName: TFileName; var Success: Boolean);
begin
  ExportFileName := '';
  with TSaveDialog.Create(nil) do
    try
      Title := 'Wska¿ plik danych do eksportu...';
      DefaultExt := '.backup';
      Filter := 'Pliki kopii zapasowej (*.backup)|*.backup|Wszystkie pliki (*.*)|*.*';
      Options := [ofOverwritePrompt, ofPathMustExist, ofEnableSizing];
      FileName := 'rtmgr.backup';
      Success := Execute;
      if Success then
        ExportFileName := FileName;
    finally
      Free;
    end;
end;

procedure TFrmMain.Uliceipostoje1Click(Sender: TObject);
begin
  AutoUpdater.Enabled := False;
  try
    with TRTBackupCreator.Create(['ULICA', 'POSTOJ', 'TAKSOWKANAPOSTOJU', 'POSTOJNAULICY']) do
      try
        OnQueryFileName := SelectExportFile;
        OnBeginImport := BeginImport;
        OnEndImport := EndImport;
        OnError := ShowErrorMsg;
        Execute;
        ShowMessage('Eksport danych zakoñczony pomyœlnie');
      finally
        Free;
      end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

procedure TFrmMain.MniObszaryClick(Sender: TObject);
begin
  EditObszary;
end;

procedure TFrmMain.Wybierzobszar1Click(Sender: TObject);
begin
  SelectObszary;
end;

procedure TFrmMain.MniDrukujWolaniaClick(Sender: TObject);
var
  HTML: TStrings;
begin
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := 'SELECT * FROM WOLANIA';
      Open;
      FetchAll;
      First;
      HTML := TStringList.Create;
      try
        with TRT_WolaniaGenerator.Create(Fields) do
          try
            GenerateHTML(HTML);
          finally
            Free;
          end;
        HTML.SaveToFile('C:\wolania.html');
        ShellExecute(Handle, 'open', 'C:\wolania.html', '', 'C:\', SW_MAXIMIZE);
      finally
        HTML.Free;
      end;
    finally
      Free;
    end;
end;

procedure TFrmMain.WszystkieDane1Click(Sender: TObject);
begin
  AutoUpdater.Enabled := False;
  try
    with TRTBackupCreator.Create(['ULICA', 'POSTOJ', 'TAKSOWKANAPOSTOJU', 'POSTOJNAULICY', 'OBSZAR', 'KURS', 'KLIENT']) do
      try
        OnQueryFileName := SelectExportFile;
        OnBeginImport := BeginImport;
        OnEndImport := EndImport;
        OnError := ShowErrorMsg;
        Execute;
        ShowMessage('Eksport danych zakoñczony pomyœlnie');
      finally
        Free;
      end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

procedure TFrmMain.MniZliczKursyZDanegoMiesiacaClick(Sender: TObject);
var
  Year, Month: Integer;
  StartDate, EndDate: TDateTime;
begin
  if not SelectYearAndMonth(Year, Month) then
    Exit;

  StartDate := EncodeDate(Year, Month, 1);
  EndDate := IncMonth(StartDate);

  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT COUNT(*) FROM KURS WHERE KURS.PRZYJECIE BETWEEN %s AND %s', [
        QuotedStr(FormatDateTime('YYYY-MM-DD', StartDate)),
        QuotedStr(FormatDateTime('YYYY-MM-DD', EndDate))
      ]);
      Open;
      MessageBox(Handle, PChar(Format('Iloœæ kursów: %d', [Fields.AsInteger[0]])), 'Zliczanie kursów', MB_ICONINFORMATION or MB_OK);
      Close;
    finally
      Free;
    end;
end;

procedure TFrmMain.MniChangePassword1Click(Sender: TObject);
var
  Password: String;
begin
  if not CheckPassword then Exit;
  if not GetNewPassword(Password) then Exit;
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('UPDATE HASLO SET HASLO = %s', [QuotedStr(Password)]);
      Execute;
      Transaction.Commit;
      MessageBox(Handle, 'Has³o zosta³o zmienione.', 'Informacja', MB_ICONINFORMATION or MB_OK);
    finally
      Free;
    end;
end;

procedure TFrmMain.MniZmienStatusPudlaClick(Sender: TObject);
var
  Flags, RowIndex: Integer;
begin
  if GrdKursy.Row < 1 then
    Exit;

  AutoUpdater.Enabled := False;
  try
    with TFrmEdytorKursu.Create(nil) do
      try
        FKursyQuery.Fields.GetRecord(GrdKursy.Row - 1);
        Flags := FKursyQuery.Fields.ByNameAsInteger['Flags'];
        Flags := Flags xor kfPudlo;
        Flags := Flags and (not kfWykozystane);
        with TSQL.Instance.CreateQuery do
          try
            SQL.Text := Format('UPDATE KURS SET FLAGS = %d where ID=%d', [
              Flags,
              FKursyQuery.Fields.ByNameAsInteger['Id']
            ]);
            Execute;
            Transaction.Commit;
            RowIndex := GrdKursy.Row;
            DisplayKursy;
            GrdKursy.Row := RowIndex;
            if Flags and kfPudlo <> 0 then
              MessageBox(Handle, 'Kurs zosta³ oznaczony jako pud³o', 'Informacja', MB_ICONINFORMATION or MB_OK)
            else
              MessageBox(Handle, 'Kurs zosta³ oznaczony jako nie-pud³o', 'Informacja', MB_ICONINFORMATION or MB_OK);
          finally
            Free;
          end;
      finally
        Free;
      end;
  finally
    AutoUpdater.Enabled := True;
  end;
end;

end.

