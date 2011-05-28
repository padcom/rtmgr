unit RT_Updater;

interface

uses
  Windows, Classes, SysUtils, Contnrs, JvUIB, JvUIBLib, PxThread;

const
  SLEEP_INTERVAL = 2000;

type
  TStringsQueue = class (TObject)
  private
    FStrings: TStrings;
    FLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    function Empty: Boolean;
    function Pop: String;
    procedure Push(Value: String);
  end;

  TUpdateListener = class (TObject)
  private
    FTables: TStrings;
    FUpdatedTables: TStringsQueue;
    FLock: TRTLCriticalSection;
    function GetTables: TStrings;
    procedure GatherTables(TablesArray: array of String);
  public
    constructor Create(Tables: array of String);
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    property Tables: TStrings read GetTables;
    property UpdatedTables: TStringsQueue read FUpdatedTables;
  end;

  TUpdateListenerList = class (TObjectList)
  private
    function GetItem(Index: Integer): TUpdateListener;
  public
    property Items[Index: Integer]: TUpdateListener read GetItem; default;
  end;

  TRTUpdaterTable = class (TObject)
  private
    FName: String;
    FLastUpdate: TDateTime;
  public
    constructor Create(AName: String);
    property Name: String read FName;
    property LastUpdate: TDateTime read FLastUpdate write FLastUpdate;
  end;

  TRTUpdaterTableList = class (TObjectList)
  private
    function GetItem(Index: Integer): TRTUpdaterTable;
    function GetByName(Name: String): TRTUpdaterTable;
  public
    property Items[Index: Integer]: TRTUpdaterTable read GetItem; default;
    property ByName[Name: String]: TRTUpdaterTable read GetByName;
  end;

  TRTUpdater = class (TPxThread)
  private
    FRegisterCS: TRTLCriticalSection;
    FListeners: TUpdateListenerList;
    FQuery: TJvUIBQuery;
    FUpdates: TRTUpdaterTableList;
    class procedure Initialize;
    class procedure Shutdown;
  protected
    procedure GatherTables(Tables: TStrings);
    procedure NotifyTablechanges(TableName: String);
    procedure CheckForModifications;
    procedure Execute; override;
    property Listeners: TUpdateListenerList read FListeners;
    property Query: TJvUIBQuery read FQuery;
    property Updates: TRTUpdaterTableList read FUpdates;
  public
    class function Instance: TRTUpdater;
    constructor Create;
    destructor Destroy; override;
    procedure RegisterListener(Listener: TUpdateListener);
    procedure UnregisterListener(Listener: TUpdateListener);
  end;

implementation

uses
  RT_SQL;

{ TStringsQueue }

{ Private declarations }

{ Public declarations }

constructor TStringsQueue.Create;
begin
  inherited Create;
  FStrings := TStringList.Create;
  InitializeCriticalSection(FLock);
end;

destructor TStringsQueue.Destroy;
begin
  FreeAndNil(FStrings);
  DeleteCriticalSection(FLock);
  inherited Destroy;
end;

function TStringsQueue.Empty: Boolean;
begin
  Result := FStrings.Count = 0;
end;

function TStringsQueue.Pop: String;
begin
  EnterCriticalSection(FLock);
  try
    Result := FStrings[0];
    FStrings.Delete(0);
  finally
    LeaveCriticalSection(FLock);
  end;
end;

procedure TStringsQueue.Push(Value: String);
begin
  EnterCriticalSection(FLock);
  try
    if FStrings.IndexOf(Value) = -1 then
      FStrings.Append(Value);
  finally
    LeaveCriticalSection(FLock);
  end;
end;

{ TUpdateListenerList }

{ Private declarations }

function TUpdateListenerList.GetItem(Index: Integer): TUpdateListener;
begin
  Result := TObject(Get(Index)) as TUpdateListener;
end;

{ TUpdateListener }

{ Private declarations }

function TUpdateListener.GetTables: TStrings;
begin
  Result := FTables;
end;

procedure TUpdateListener.GatherTables(TablesArray: array of String);
var
  I: Integer;
begin
  for I := Low(TablesArray) to High(TablesArray) do
  begin
    TablesArray[I] := UpperCase(TablesArray[I]);
    if Tables.IndexOf(TablesArray[I]) = -1 then
      Tables.Add(TablesArray[I]);
  end;
end;

{ Public declarations }

constructor TUpdateListener.Create(Tables: array of String);
begin
  inherited Create;
  InitializeCriticalSection(FLock);
  FTables := TStringList.Create;
  GatherTables(Tables);
  FUpdatedTables := TStringsQueue.Create;
end;

destructor TUpdateListener.Destroy;
begin
  FreeAndNil(FUpdatedTables);
  FreeAndNil(FTables);
  DeleteCriticalSection(FLock);
  inherited Destroy;
end;

procedure TUpdateListener.Lock;
begin
  EnterCriticalSection(FLock);
end;

procedure TUpdateListener.Unlock;
begin
  LeaveCriticalSection(FLock);
end;

{ TRTUpdaterTable }

{ Private declarations }

{ Public declarations }

constructor TRTUpdaterTable.Create(AName: String);
begin
  inherited Create;
  FName := AName;
  FLastUpdate := Now;
end;

{ TRTUpdaterTableList }

{ Private declarations }

function TRTUpdaterTableList.GetItem(Index: Integer): TRTUpdaterTable;
begin
  Result := TObject(Get(Index)) as TRTUpdaterTable;
end;

function TRTUpdaterTableList.GetByName(Name: String): TRTUpdaterTable;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if AnsiSameText(Items[I].Name, Name) then
    begin
      Result := Items[I];
      Break;
    end;
end;

{ TRTUpdater }

var
  _Instance: TRTUpdater = nil;

{ Private declarations }

class procedure TRTUpdater.Initialize;
begin
  _Instance := TRTUpdater.Create;
end;

class procedure TRTUpdater.Shutdown;
begin
  _Instance.Terminate;
  FreeAndNil(_Instance);
end;

{ Protected declarations }

procedure TRTUpdater.GatherTables(Tables: TStrings);
var
  I, J: Integer;
begin
  Tables.Clear;
  for I := 0 to Listeners.Count - 1 do
    for J := 0 to Listeners[I].Tables.Count - 1 do
      if Tables.IndexOf(Listeners[I].Tables[J]) = -1 then
        Tables.Add(Listeners[I].Tables[J]);
end;

procedure TRTUpdater.NotifyTablechanges(TableName: String);
var
  I: Integer;
begin
  for I := 0 to Listeners.Count - 1 do
    if Listeners[I].Tables.IndexOf(TableName) <> -1 then
    begin
      Listeners[I].Lock;
      try
        Listeners[I].UpdatedTables.Push(TableName);
      finally
        Listeners[I].Unlock;
      end;
    end;
end;

procedure TRTUpdater.CheckForModifications;
var
  I: Integer;
  Tables: TStrings;
  Table: TRTUpdaterTable;
begin
  Tables := TStringList.Create;
  try
    GatherTables(Tables);
    for I := 0 to Tables.Count - 1 do
    begin
      Table := Updates.ByName[Tables[I]];
      if not Assigned(Table) then
      begin
        Table := TRTUpdaterTable.Create(Tables[I]);
        Updates.Add(Table);
      end;
      Query.Transaction.RollBack;
      Query.SQL.Text := Format('SELECT DATA FROM UPDATES WHERE TABLENAME=%s AND DATA>%s', [
        QuotedStr(Tables[I]),
        QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN:SS.ZZZ', Table.LastUpdate))
      ]);
      Query.Open;
      if not Query.Eof then
      begin
        Query.Last;
        Table.LastUpdate := Query.Fields.AsDateTime[0];
        NotifyTablechanges(Table.Name);
      end;
      Query.Close(etmRollback);
    end
  finally
    Tables.Free;
  end;
end;

procedure TRTUpdater.Execute;
begin
  while not Terminated do
  begin
    Sleep(SLEEP_INTERVAL);
    if not Terminated then
      CheckForModifications;
  end;
end;

{ Public declarations }

class function TRTUpdater.Instance: TRTUpdater;
begin
  Result := _Instance;
end;

constructor TRTUpdater.Create;
begin
  inherited Create(True);
  InitializeCriticalSection(FRegisterCS);
  FListeners := TUpdateListenerList.Create(True);
  FQuery := TSQL.Instance.CreateQuery;
  FUpdates := TRTUpdaterTableList.Create(True);
  Resume;
end;

destructor TRTUpdater.Destroy;
begin
  FreeAndNil(FUpdates);
  FreeAndNil(FQuery);
  FreeAndNil(FListeners);
  DeleteCriticalSection(FRegisterCS);
  inherited Destroy;
end;

procedure TRTUpdater.RegisterListener(Listener: TUpdateListener);
begin
  EnterCriticalSection(FRegisterCS);
  try
    Assert(Listeners.IndexOf(Listener) = -1, 'Error: this listener has already been registered');
    Listeners.Add(Listener);
  finally
    LeaveCriticalSection(FRegisterCS);
  end;
end;

procedure TRTUpdater.UnregisterListener(Listener: TUpdateListener);
begin
  EnterCriticalSection(FRegisterCS);
  try
    Assert(Listeners.IndexOf(Listener) <> -1, 'Error: this listener has not been registered');
    Listeners.Remove(Listener);
  finally
    LeaveCriticalSection(FRegisterCS);
  end;
end;

initialization
  TRTUpdater.Initialize;

finalization
  TRTUpdater.Shutdown;

end.

