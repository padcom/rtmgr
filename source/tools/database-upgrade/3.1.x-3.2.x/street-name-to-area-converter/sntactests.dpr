library sntactests;

uses
  ShareMem, TestFramework,
  CaseToAreaIdGenerator in 'core\CaseToAreaIdGenerator.pas',
  CaseToAreaIdGeneratorTest in 'tests\CaseToAreaIdGeneratorTest.pas';

exports
  RegisteredTests name 'Test';

end.
