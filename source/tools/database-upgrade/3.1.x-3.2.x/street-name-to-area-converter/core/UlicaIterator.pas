unit UlicaIterator;

interface

uses
  Classes, SysUtils, jvuib, jvuiblib;

type
  TUlicaIteratorCallback = procedure (Sender: TObject; Ulica: TSQLResult) of object;

  TUlicaIterator = class (TObject)
  private
    FDatabase: TJvUIBDataBase;
    FTransaction: TJvUIBTransaction;
    FOnProcess: TUlicaIteratorCallback;
    procedure DoProcess(Ulica: TSQLResult);
  protected
    function CreateQuery: TJvUIBQuery;
  public
    procedure Iterate(Query: String = '');
    property Database: TJvUIBDataBase read FDatabase write FDatabase;
    property Transaction: TJvUIBTransaction read FTransaction write FTransaction;
    property OnProcess: TUlicaIteratorCallback read FOnProcess write FOnProcess;
  end;

implementation

{ TUlicaIterator }

{ Private declarations }

procedure TUlicaIterator.DoProcess(Ulica: TSQLResult);
begin
  if Assigned(OnProcess) then
    OnProcess(Self, Ulica);
end;

{ Protected declarations }

function TUlicaIterator.CreateQuery: TJvUIBQuery;
begin
  Result := TJvUIBQuery.Create(nil);
  Result.Transaction := Transaction;
  Result.DataBase := Database;
end;

{ Public declarations }

procedure TUlicaIterator.Iterate(Query: String = '');
begin
  if Query = '' then
    Query := 'SELECT * FROM UlICA ORDER BY ID';
  with CreateQuery do
    try
      SQL.Text := Query;
      Open;
      while not Eof do
      begin
        DoProcess(Fields);
        Next;
      end;
    finally
      Free;
    end;
end;

end.

