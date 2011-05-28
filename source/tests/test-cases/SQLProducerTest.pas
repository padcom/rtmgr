unit SQLProducerTest;

interface

uses
  Classes, SysUtils, TestFramework,
  DatabaseDefinition, SQLProducer;

type
  TSQLProducerTest = class (TTestCase)
  protected
    function CreateDatabaseDefinition: TDatabaseDefinition;
  published
    procedure TestInsertStatement;
    procedure TestUpdateStatement;
    procedure TestExistsStatement;
    procedure TestDeleteStatement;
    procedure TestLastIdStatement;
  end;

implementation

{ TSQLProducerTest }

{ Protected declarations }

type
  TTestRec = packed record
    Id: Integer;
    Kind: Word;
    Name: array[0..79] of Char;
  end;

function TSQLProducerTest.CreateDatabaseDefinition: TDatabaseDefinition;
begin
  Result := TDatabaseDefinition.Create;
  Result.Tables.Add(TTable.Create);
  Result.Tables[0].Name := 'Test';
  Result.Tables[0].FileName := 'Test.rtm';
  Result.Tables[0].Fields.Add(TField.Create);
  Result.Tables[0].Fields[0].Name := 'Id';
  Result.Tables[0].Fields[0].DataType := dtInteger;
  Result.Tables[0].Fields[0].Size := 4;
  Result.Tables[0].Fields[0].Offset := 0;
  Result.Tables[0].Fields[0].IncludedInSQL := True;
  Result.Tables[0].Fields[0].IsPrimaryKey := True;
  Result.Tables[0].Fields.Add(TField.Create);
  Result.Tables[0].Fields[1].Name := 'Kind';
  Result.Tables[0].Fields[1].DataType := dtInteger;
  Result.Tables[0].Fields[1].Size := 2;
  Result.Tables[0].Fields[1].Offset := 4;
  Result.Tables[0].Fields[1].IncludedInSQL := False;
  Result.Tables[0].Fields[1].IsPrimaryKey := False;
  Result.Tables[0].Fields.Add(TField.Create);
  Result.Tables[0].Fields[2].Name := 'Name';
  Result.Tables[0].Fields[2].DataType := dtChar;
  Result.Tables[0].Fields[2].Size := 80;
  Result.Tables[0].Fields[2].Offset := 6;
  Result.Tables[0].Fields[2].IncludedInSQL := True;
  Result.Tables[0].Fields[2].IsPrimaryKey := False;
end;

{ Published declarations }

procedure TSQLProducerTest.TestInsertStatement;
const
  EXPECTED = 'INSERT INTO TEST (ID, NAME) VALUES (10, ''Hello, world!'');';
  DATA: TTestRec = (Id: 10; Kind: 123; Name: 'Hello, world!');
begin
{$WARNINGS OFF}
  with TSQLProducer.Create do
{$WARNINGS ON}
    try
      with CreateDatabaseDefinition do
        try
          CheckEquals(EXPECTED, Insert(Tables[0], @Data));
        finally
          Free;
        end;
    finally
      Free;
    end;
end;

procedure TSQLProducerTest.TestUpdateStatement;
const
  EXPECTED = 'UPDATE TEST SET NAME = ''Hello, world!'' WHERE ID = 10';
  DATA: TTestRec = (Id: 10; Kind: 123; Name: 'Hello, world!');
begin
{$WARNINGS OFF}
  with TSQLProducer.Create do
{$WARNINGS ON}
    try
      with CreateDatabaseDefinition do
        try
          CheckEquals(EXPECTED, Update(Tables[0], @Data));
        finally
          Free;
        end;
    finally
      Free;
    end;
end;

procedure TSQLProducerTest.TestExistsStatement;
const
  EXPECTED = 'SELECT COUNT(*) FROM TEST WHERE ID = 10;';
  DATA: TTestRec = (Id: 10; Kind: 123; Name: 'Hello, world!');
begin
{$WARNINGS OFF}
  with TSQLProducer.Create do
{$WARNINGS ON}
    try
      with CreateDatabaseDefinition do
        try
          CheckEquals(EXPECTED, Exists(Tables[0], @Data));
        finally
          Free;
        end;
    finally
      Free;
    end;
end;

procedure TSQLProducerTest.TestDeleteStatement;
const
  EXPECTED = 'DELETE FROM TEST WHERE ID = 10;';
  DATA: TTestRec = (Id: 10; Kind: 123; Name: 'Hello, world!');
begin
{$WARNINGS OFF}
  with TSQLProducer.Create do
{$WARNINGS ON}
    try
      with CreateDatabaseDefinition do
        try
          CheckEquals(EXPECTED, Delete(Tables[0], @Data));
        finally
          Free;
        end;
    finally
      Free;
    end;
end;

procedure TSQLProducerTest.TestLastIdStatement;
const
  EXPECTED = 'SELECT MAX(ID) FROM TEST;';
begin
{$WARNINGS OFF}
  with TSQLProducer.Create do
{$WARNINGS ON}
    try
      with CreateDatabaseDefinition do
        try
          CheckEquals(EXPECTED, LastId(Tables[0]));
        finally
          Free;
        end;
    finally
      Free;
    end;
end;

initialization
  RegisterTest(TSQLProducerTest.Suite);

end.

