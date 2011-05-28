program bin2sql;

{$APPTYPE CONSOLE}

uses
  Classes,
  SysUtils,
  ActiveX,
  Options in 'core\Options.pas',
  RT_Base in 'binary-fmt\RT_Base.pas',
  RT_BaseTypes in 'binary-fmt\RT_BaseTypes.pas',
  RT_Klient in 'binary-fmt\RT_Klient.pas',
  RT_Kurs in 'binary-fmt\RT_Kurs.pas',
  RT_Postoj in 'binary-fmt\RT_Postoj.pas',
  RT_Taksowka in 'binary-fmt\RT_Taksowka.pas',
  RT_Ulica in 'binary-fmt\RT_Ulica.pas',
  DatabaseDefinition in 'core\DatabaseDefinition.pas',
  SQLProducer in 'core\SQLProducer.pas',
  SQLConverter in 'core\SQLConverter.pas',
  SQLConverterRegistry in 'core\SQLConverterRegistry.pas',
  SQLConverterNull in 'core\SQLConverterNull.pas',
  SQLConverterPostoj in 'core\SQLConverterPostoj.pas',
  SQLConverterUlica in 'core\SQLConverterUlica.pas',
  SQLConverterTaksowka in 'core\SQLConverterTaksowka.pas',
  SQLConverterKurs in 'core\SQLConverterKurs.pas',
  SQLConverterKlient in 'core\SQLConverterKlient.pas';

procedure WriteLog(Log: String);
begin
  if not TOptions.Instance.Quiet then
    Write(Log);
end;

procedure WritelnLog(Log: String);
begin
  if not TOptions.Instance.Quiet then
    Writeln(Log);
end;

var
  I: Integer;
  Defs: TDatabaseDefinition;
  Registry: TSQLConverterRegistry;
  Converter: ISQLConverter;
  Output: TStrings;

begin
  OleInitialize(nil);

  Output := TStringList.Create;
  try
    Registry := TSQLConverterRegistry.Create;
    try
      Registry.Register('POSTOJ', TSQLConverterPostoj.Create);
      Registry.Register('ULICA', TSQLConverterUlica.Create);
      Registry.Register('TAKSOWKA', TSQLConverterTaksowka.Create);
      Registry.Register('KURS', TSQLConverterKurs.Create);
      Registry.Register('KLIENT', TSQLConverterKlient.Create);
      Defs := TDatabaseDefinition.Create;
      try
        Defs.Load(TOptions.Instance.DataFolder + 'rtmgr.xml');
        for I := 0 to Defs.Tables.Count - 1 do
        begin
          WriteLog('Processing ' + Defs.Tables[I].Name + ' (file: ' + Defs.Tables[I].FileName + ')...');
          Converter := Registry[Defs.Tables[I].Name];
          Converter.Table := Defs.Tables[I];
          Converter.Convert(Defs.Tables[I].FileName, Output);
          WritelnLog('OK');
        end;
        WriteLog('Saving SQL script to ' + TOptions.Instance.OutputFile + '...');
        Output.SaveToFile(TOptions.Instance.OutputFile);
        WritelnLog('OK');
      finally
        Defs.Free;
      end;
    finally
      Registry.Free;
    end;
  finally
    Output.Free;
  end;
end.

