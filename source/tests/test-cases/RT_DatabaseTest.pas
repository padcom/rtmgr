unit RT_DatabaseTest;

interface

uses
  Classes, SysUtils, TestFramework,
  RT_Database;

type
  TDatabaseTest = class (TTestCase)
  private
    function CreateTestDatabase: TDatabase;
  published
    procedure TestObserver;
  end;

implementation

{ TDatabaseTest }

{ Private declarations }

function TDatabaseTest.CreateTestDatabase: TDatabase;
var
  TaxiStop: TTaxiStop;
  Street: TStreet;
begin
  Result := TDatabase.Create;

  TaxiStop := TTaxiStop.Create;
  TaxiStop.Id := 1;
  TaxiStop.Name := 'Wieczorka';
  Result.TaxiStops.Add(TaxiStop);

  TaxiStop := TTaxiStop.Create;
  TaxiStop.Id := 2;
  TaxiStop.Name := 'Dworzec';
  Result.TaxiStops.Add(TaxiStop);

  Street := TStreet.Create;
  Street.Id := 1;
  Street.Name := 'Plebañska';
  Street.Start := '1';
  Street.Stop := '';
  Street.TaxiStops.Add(Result.TaxiStops[0]);
  Street.TaxiStops.Add(Result.TaxiStops[1]);
  Result.Streets.Add(Street);

end;

{ Test cases }

procedure TDatabaseTest.TestObserver;
var
  Database: TDatabase;
begin
  Database := CreateTestDatabase;
  Database.Free;
end;

initialization
  RegisterTest(TDatabaseTest.Suite);

end.

