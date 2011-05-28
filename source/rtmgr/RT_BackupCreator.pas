unit RT_BackupCreator;

interface

uses
  Classes, SysUtils, JvUIB, JvUIBLib;

type
  TQueryFileNameEvent = procedure (Sender: TObject; var FileName: TFileName; var Success: Boolean) of object;
  TErrorEvent = procedure (Sender: TObject; ErrorMsg: String) of object;

type
  TRTBackupCreator = class (TObject)
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
    function GetFields: String;
    function GetValues: String;
    procedure ExportRow(TableName: String; Script: TStrings);
    procedure ExportQuery(TableName, SQL: String; Script: TStrings);
    procedure ExportTable(TableName: String; Script: TStrings);
    procedure ExportTables(Script: TStrings);
    property Tables: TStrings read FTables;
    property Query: TJvUIBQuery read FQuery write FQuery;
  public
    constructor Create(Tables: array of String);
    destructor Destroy; override;
    procedure Execute; overload;
    procedure Execute(TableName, SQL: String); overload;
    property OnQueryFileName: TQueryFileNameEvent read FOnQueryFileName write FOnQueryFileName;
    property OnBeginImport: TNotifyEvent read FOnBeginImport write FOnBeginImport;
    property OnEndImport: TNotifyEvent read FOnEndImport write FOnEndImport;
    property OnError: TErrorEvent read FOnError write FOnError;
  end;

implementation

uses
  RT_SQL;

{ TRTBackupCreator }

{ Private declarations }

procedure TRTBackupCreator.ReadTables(Tables: array of String);
var
  I: Integer;
begin
  Self.Tables.Clear;
  for I := 0 to Length(Tables) - 1 do
    Self.Tables.Add(UpperCase(Tables[I]));
end;

{ Protected declarations }

function TRTBackupCreator.DoGetFileName(var FileName: TFileName): Boolean;
begin
  Result := False;
  FileName := '';
  if Assigned(OnQueryFileName) then
    OnQueryFileName(Self, FileName, Result);
end;

procedure TRTBackupCreator.DoBeginImport;
begin
  if Assigned(OnBeginImport) then
    OnBeginImport(Self);
end;

procedure TRTBackupCreator.DoEndImport;
begin
  if Assigned(OnEndImport) then
    OnEndImport(Self);
end;

procedure TRTBackupCreator.DoError(ErrorMsg: String);
begin
  if Assigned(OnError) then
    OnError(Self, ErrorMsg);
end;

function TRTBackupCreator.GetFields: String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Query.Fields.FieldCount - 1 do
  begin
    if Result <> '' then
      Result := Result + ', ';
    Result := Result + Query.Fields.SqlName[I];
  end;
end;

function TRTBackupCreator.GetValues: String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Query.Fields.FieldCount - 1 do
  begin
    if Result <> '' then
      Result := Result + ', ';
    if Query.Fields.FieldType[I] in [uftChar, uftVarchar, uftCstring, uftTimestamp, uftDate, uftTime] then
      Result := Result + QuotedStr(Query.Fields.AsString[I])
    else
      Result := Result + Query.Fields.AsString[I];
  end;
end;

procedure TRTBackupCreator.ExportRow(TableName: String; Script: TStrings);
begin
  Script.Add(Format('INSERT INTO %s (%s) VALUES (%s);', [TableName, GetFields, GetValues]));
end;

procedure TRTBackupCreator.ExportQuery(TableName, SQL: String; Script: TStrings);
begin
  Query.SQL.Text := SQL;
  Query.Open;
  while not Query.Eof do
  begin
    ExportRow(TableName, Script);
    Query.Next;
  end;
  Query.Close(etmRollback);
end;

procedure TRTBackupCreator.ExportTable(TableName: String; Script: TStrings);
begin
  ExportQuery(TableName, Format('SELECT * FROM %s', [TableName]), Script);
end;

procedure TRTBackupCreator.ExportTables(Script: TStrings);
var
  I: Integer;
begin
  for I := 0 to Tables.Count - 1 do
    ExportTable(Tables[I], Script);
end;

{ Public declarations }

constructor TRTBackupCreator.Create(Tables: array of String);
begin
  inherited Create;
  FTables := TStringList.Create;
  ReadTables(Tables);
  FQuery := TSQL.Instance.CreateQuery;
end;

destructor TRTBackupCreator.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FTables);
  inherited Destroy;
end;

procedure TRTBackupCreator.Execute;
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
        ExportTables(Script);
        Script.SaveToFile(ScriptFileName);
        Query.Transaction.RollBack;
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

procedure TRTBackupCreator.Execute(TableName, SQL: String);
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
        ExportQuery(TableName, SQL, Script);
        Script.SaveToFile(ScriptFileName);
        Query.Transaction.RollBack;
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

