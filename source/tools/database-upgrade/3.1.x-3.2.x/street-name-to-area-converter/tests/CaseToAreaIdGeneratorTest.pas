unit CaseToAreaIdGeneratorTest;

interface

uses
  Classes, SysUtils, TestFramework,
  CaseToAreaIdGenerator;

type
  TCaseToAreaIdGeneratorTest = class (TTestCase)
  published
    procedure TestCreate;
    procedure TestCreateUpdateStatement;
  end;

implementation

{ TCaseToAreaIdGeneratorTest }

{ Test cases }

procedure TCaseToAreaIdGeneratorTest.TestCreate;
begin
  TCaseToAreaIdGenerator.Create.Free;
end;

procedure TCaseToAreaIdGeneratorTest.TestCreateUpdateStatement;
begin
  with TCaseToAreaIdGenerator.Create do
    try
      IdForLowercaseStreet := 10001;
      IdForUppercaseStreet := 10002;
      CheckEquals('UPDATE ULICA SET AREAID=10001 WHERE ID=1;', CreateUpdateStatement(1, 'akacjowa'));
      CheckEquals('UPDATE ULICA SET AREAID=10002 WHERE ID=2;', CreateUpdateStatement(2, 'AKADEMICKA'));
    finally
      Free;
    end;
end;

initialization
  RegisterTest(TCaseToAreaIdGeneratorTest.Suite);

end.
