library rtmgrtest;

uses
  ShareMem,
  TestFramework,
  DataTypeUtilsTest in 'test-cases\DataTypeUtilsTest.pas',
  DatabaseDefinition in '..\tools\bin2sql\core\DatabaseDefinition.pas',
  DatabaseDefinitionTest in 'test-cases\DatabaseDefinitionTest.pas',
  SQLProducer in '..\tools\bin2sql\core\SQLProducer.pas',
  SQLProducerTest in 'test-cases\SQLProducerTest.pas',
  RT_Database in '..\common\RT_Database.pas',
  RT_DatabaseTest in 'test-cases\RT_DatabaseTest.pas',
  RT_DateProvider in '..\rtmgr\RT_DateProvider.pas',
  RT_DateProviderTest in 'test-cases\RT_DateProviderTest.pas';

exports
  RegisteredTests name 'Test';

end.
