unit RT_GeneratorUpdater;

interface

uses
  Classes, SysUtils,
  RT_SQL;

type
  TRT_GeneratorUpdater = class (TObject)
    class procedure UpdateGenerator(TableName: String);
    class procedure UpdateAllGenerators;
  end;

implementation

uses jvuib;

class procedure TRT_GeneratorUpdater.UpdateGenerator(TableName: String);
var
  CurrentMaxValue: Integer;
  CurrentGenValue: Integer;
begin
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT Max(Id) FROM %s', [TableName]);
      Open;
      if not Eof then
        CurrentMaxValue := Fields.AsInteger[0]
      else
        CurrentMaxValue := -1;
      Close;

      SQL.Text := Format('SELECT GEN_ID(%s_ID, 0) FROM RDB$DATABASE', [TableName]);
      Open;
      CurrentGenValue := Fields.AsInteger[0];
      Close;

      if CurrentGenValue < CurrentMaxValue then
      begin
        SQL.Text := Format('SET GENERATOR %s_ID TO %d', [TableName, CurrentMaxValue + 1]);
        Execute;
        Transaction.Commit;
      end;    finally
      Free;
    end;
end;

class procedure TRT_GeneratorUpdater.UpdateAllGenerators;
begin
  TRT_GeneratorUpdater.UpdateGenerator('KURS');
  TRT_GeneratorUpdater.UpdateGenerator('POSTOJ');
  TRT_GeneratorUpdater.UpdateGenerator('TAKSOWKA');
  TRT_GeneratorUpdater.UpdateGenerator('ULICA');
  TRT_GeneratorUpdater.UpdateGenerator('KLIENT');
end;

end.
