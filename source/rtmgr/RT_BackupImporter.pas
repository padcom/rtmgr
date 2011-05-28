unit RT_BackupImporter;

interface

uses
  Classes, SysUtils, JvUIB, JvUIBLib;

type
  TQueryFileNameEvent = procedure (Sender: TObject; var FileName: TFileName; var Success: Boolean) of object;
  TErrorEvent = procedure (Sender: TObject; ErrorMsg: String) of object;

  TRTBackupImporter = class (TObject)
  private
    FTables: TStrings;
    FQuery: TJvUIBQuery;
    FOnQueryFileName: TQueryFileNameEvent;
    FOnBeginImport: TNotifyEvent;
    FOnEndImport: TNotifyEvent;
    FOnError: TErrorEvent;
    procedure ReadTables(Tables: array of String);
  protected
    function DoGetFileName(var FileName: TFileName): Boolean;
    procedure DoBeginImport;
    procedure DoEndImport;
    procedure DoError(ErrorMsg: String);
    procedure DeleteContentOfTables;
    procedure DeleteContentOfTable(TableName: String);
    procedure ExecuteImportScript(Script: TStrings);
    property Tables: TStrings read FTables;
    property Query: TJvUIBQuery read FQuery write FQuery;
  public
    constructor Create(Tables: array of String);
    destructor Destroy; override;
    procedure Execute;
    property OnQueryFileName: TQueryFileNameEvent read FOnQueryFileName write FOnQueryFileName;
    property OnBeginImport: TNotifyEvent read FOnBeginImport write FOnBeginImport;
    property OnEndImport: TNotifyEvent read FOnEndImport write FOnEndImport;
    property OnError: TErrorEvent read FOnError write FOnError;
  end;

implementation

uses
  RT_SQL;

{ TRTBackupImporter }

{ Private declarations }

procedure TRTBackupImporter.ReadTables(Tables: array of String);
var
  I: Integer;
begin
  Self.Tables.Clear;
  for I := 0 to Length(Tables) - 1 do
    Self.Tables.Add(UpperCase(Tables[I]));
end;

{ Protected declarations }

function TRTBackupImporter.DoGetFileName(var FileName: TFileName): Boolean;
begin
  Result := False;
  FileName := '';
  if Assigned(OnQueryFileName) then
    OnQueryFileName(Self, FileName, Result);
end;

procedure TRTBackupImporter.DoBeginImport;
begin
  if Assigned(OnBeginImport) then
    OnBeginImport(Self);
end;

procedure TRTBackupImporter.DoEndImport;
begin
  if Assigned(OnEndImport) then
    OnEndImport(Self);
end;

procedure TRTBackupImporter.DoError(ErrorMsg: String);
begin
  if Assigned(OnError) then
    OnError(Self, ErrorMsg);
end;

procedure TRTBackupImporter.DeleteContentOfTables;
var
  I: Integer;
begin
  for I := 0 to Tables.Count - 1 do
    DeleteContentOfTable(Tables[I]);
end;

procedure TRTBackupImporter.DeleteContentOfTable(TableName: String);
begin
  Query.SQL.Text := Format('DELETE FROM %s', [TableName]);
  Query.ExecSQL;
end;

procedure TRTBackupImporter.ExecuteImportScript(Script: TStrings);
  function StatementIsForSelectedTables(Line: String): Boolean;
  var
    I: Integer;
  begin
    Result := Tables.Count = 0;
    for I := 0 to Tables.Count - 1 do
      if Pos(Format('INSERT INTO %s', [Tables[I]]), UpperCase(Line)) > 0 then
      begin
        Result := True;
        Break;
      end;
  end;
var
  I: Integer;
begin
  for I := 0 to Script.Count - 1 do
    if StatementIsForSelectedTables(Script.Strings[I]) then
    begin
      Query.SQL.Text := Script.Strings[I];
      Query.ExecSQL;
    end;
end;

{ Public declarations }

constructor TRTBackupImporter.Create(Tables: array of String);
begin
  inherited Create;
  FTables := TStringList.Create;
  ReadTables(Tables);
  FQuery := TSQL.Instance.CreateQuery;
end;

destructor TRTBackupImporter.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FTables);
  inherited Destroy;
end;

procedure TRTBackupImporter.Execute;
var
  ScriptFileName: TFileName;
  Script: TStrings;
begin
  if DoGetFileName(ScriptFileName) then
  begin
    Query.Transaction.StartTransaction;
    try
      Script := TStringList.Create;
      DoBeginImport;
      try
        Script.LoadFromFile(ScriptFileName);
        DeleteContentOfTables;
        ExecuteImportScript(Script);
        Query.Transaction.Commit;
      finally
        Script.Free;
        DoEndImport;
      end;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        DoError(E.Message);
      end;
    end;
  end;
end;

end.

