unit DataTypeUtilsTest;

interface

uses
  Classes, SysUtils, TypInfo, TestFramework,
  DatabaseDefinition;

type
  TDataTypeUtilsTest = class (TTestCase)
  protected
    procedure CheckEquals(Expected, Actual: TDataType; Msg: String = '');
  published
    procedure TestStrToDataType;
  end;

implementation

{ TDataTypeUtilsTest }

{ Protected declarations }

procedure TDataTypeUtilsTest.CheckEquals(Expected, Actual: TDataType; Msg: String = '');
begin
  FCheckCalled := True;
  if Expected <> Actual then
    FailNotEquals(GetEnumName(TypeInfo(TDataType), Integer(Expected)), GetEnumName(TypeInfo(TDataType), Integer(Actual)), msg, CallerAddr);
end;

{ Test cases }

procedure TDataTypeUtilsTest.TestStrToDataType;
begin
  CheckEquals(dtInteger, TDataTypeUtils.StrToDataType('INTEGER'));
  CheckEquals(dtWord, TDataTypeUtils.StrToDataType('WORD'));
  CheckEquals(dtChar, TDataTypeUtils.StrToDataType('CHAR'));
  CheckEquals(dtDateTime, TDataTypeUtils.StrToDataType('DATETIME'));
  CheckEquals(dtDouble, TDataTypeUtils.StrToDataType('DOUBLE'));
  CheckEquals(dtUnknown, TDataTypeUtils.StrToDataType('???'));
  CheckEquals(dtUnknown, TDataTypeUtils.StrToDataType('INTEGER1'));
end;

initialization
  RegisterTest(TDataTypeUtilsTest.Suite);

end.

