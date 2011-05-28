unit RT_SQL;

interface

uses
  Windows, Classes, SysUtils, JvUIB, JvUIBLib, PxSettings;

type  
  TSQL = class (TObject)
  private
    FDatabase: TJvUIBDataBase;
    class procedure Initialize;
    class procedure Shutdown;
  public
    class function Instance: TSQL;
    constructor Create;
    destructor Destroy; override;
    function CreateQuery: TJvUIBQuery;
    function CreatePostojeNaUlicyQuery(UlicaId: Integer): TJvUIBQuery;
  end;

implementation

{ TSQL }

var
  _Instance: TSQL = nil;

{ Private declarations }

class procedure TSQL.Initialize;
begin
  _Instance := TSQL.Create;
end;

class procedure TSQL.Shutdown;
begin
  FreeAndNil(_Instance);
end;

{ Public declarations }

class function TSQL.Instance: TSQL;
begin
  Result := _Instance;
end;

constructor TSQL.Create;
begin
  inherited Create;
  FDatabase := TJvUIBDataBase.Create(nil);
  FDatabase.UserName := 'SYSDBA';
  FDatabase.PassWord := 'masterkey';
  FDatabase.DatabaseName := IniFile.ReadString('settings', 'database', 'RTMGR');
  FDatabase.SQLDialect := 3;
  try
    FDatabase.Connected := True;
  except
    on E: Exception do
    begin
      MessageBox(0, 'B£¥D PODCZAS PO£ACZENIA DO BAZY DANYCH! prawdopodobnie brak pliku rtmgr.ini z poprawnym wpisem [settings] database=adres:rtmgr', 'KRYTYCZNY B£¥D', MB_ICONERROR or MB_OK);
      Halt(1);
    end;
  end;
end;

destructor TSQL.Destroy;
begin
  FreeAndNil(FDatabase);
  inherited Destroy;
end;

function TSQL.CreateQuery: TJvUIBQuery;
begin
  Result := TJvUIBQuery.Create(nil);
  Result.DataBase := FDatabase;
  Result.Transaction := TJvUIBTransaction.Create(Result);
  Result.Transaction.Database := FDatabase;
end;

function TSQL.CreatePostojeNaUlicyQuery(UlicaId: Integer): TJvUIBQuery;
begin
  Result := TSQL.Instance.CreateQuery;
  Result.SQL.Text := Format('SELECT POSTOJ.NAZWA FROM POSTOJNAULICY INNER JOIN POSTOJ ON (POSTOJNAULICY.POSTOJID = POSTOJ.ID) WHERE POSTOJNAULICY.ULICAID = %d ORDER BY POSTOJNAULICY.INDEKS', [
   UlicaId
  ]);
end;

initialization
  TSQL.Initialize;

finalization
  TSQL.Shutdown;

end.

