unit SQLProducer;

interface

uses
  Windows, Classes, SysUtils, StrUtils, 
  DatabaseDefinition;

type
  TSQLProducer = class (TObject)
  protected
    function GetFieldValue(Field: TField; Buffer: Pointer): String;
  public
    function Insert(Table: TTable; Buffer: Pointer; ZeroId: Boolean = False): String;
    function Update(Table: TTable; Buffer: Pointer): String;
    function Exists(Table: TTable; Buffer: Pointer): String;
    function Delete(Table: TTable; Buffer: Pointer): String;
    function LastId(Table: TTable): String;
  end;

implementation

{ TSQLProducer }

{ Protected declarations }

function TSQLProducer.GetFieldValue(Field: TField; Buffer: Pointer): String;
var
  DataPtr: PByte;
  FormatSettings: TFormatSettings;
begin
  DataPtr := Buffer;
  Inc(DataPtr, Field.Offset);
  case Field.DataType of
    dtInteger:
      Result := IntToStr(PInteger(DataPtr)^);
    dtWord:
      Result := IntToStr(PWord(DataPtr)^);
    dtChar:
    begin
      SetLength(Result, Field.Size);
      Move(DataPtr^, Result[1], Field.Size);
      SetLength(Result, StrLen(PChar(Result)));
      Result := QuotedStr(Result);
    end;
    dtDateTime:
      Result := QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn', PDateTime(DataPtr)^));
    dtDouble:
    begin
      GetLocaleFormatSettings(GetUserDefaultLCID, FormatSettings);
      FormatSettings.DecimalSeparator := '.';
      Result := Format('%.8f', [PDouble(DataPtr)^], FormatSettings);
    end;
  end;
end;

{ Public declarations }

function TSQLProducer.Insert(Table: TTable; Buffer: Pointer; ZeroId: Boolean = False): String;
var
  I: Integer;
  Names, Values: String;
begin
  for I := 0 to Table.Fields.Count - 1 do
    if Table.Fields[I].IncludedInSQL then
    begin
      if Names <> '' then
        Names := Names + ', ';
      Names := Names + UpperCase(Table.Fields[I].Name);
      if Values <> '' then
        Values := Values + ', ';
      if Table.Fields[I].IsPrimaryKey and ZeroId then
        Values := Values + '0'
      else
        Values := Values + GetFieldValue(Table.Fields[I], Buffer);
    end;
  Result := Format('INSERT INTO %s (%s) VALUES (%s);', [UpperCase(Table.Name), Names, Values]);
end;

function TSQLProducer.Update(Table: TTable; Buffer: Pointer): String;
var
  I: Integer;
  Values: String;
begin
  Values := '';
  for I := 0 to Table.Fields.Count - 1 do
    if Table.Fields[I].IncludedInSQL and (not Table.Fields[I].IsPrimaryKey) then
    begin
      if Values <> '' then
        Values := Values + ', ';
      Values := Values + Format('%s = %s', [UpperCase(Table.Fields[I].Name), GetFieldValue(Table.Fields[I], Buffer)]);
    end;
  Result := Format('UPDATE %s SET %s WHERE %s = %s', [UpperCase(Table.Name), Values, UpperCase(Table.PrimaryKeyField.Name), GetFieldValue(Table.PrimaryKeyField, Buffer)]);
end;

function TSQLProducer.Exists(Table: TTable; Buffer: Pointer): String;
begin
  Result := Format('SELECT COUNT(*) FROM %s WHERE %s = %s;', [UpperCase(Table.Name), UpperCase(Table.PrimaryKeyField.Name), GetFieldValue(Table.PrimaryKeyField, Buffer)]);
end;

function TSQLProducer.Delete(Table: TTable; Buffer: Pointer): String;
begin
  Result := Format('DELETE FROM %s WHERE %s = %s;', [UpperCase(Table.Name), UpperCase(Table.PrimaryKeyField.Name), GetFieldValue(Table.PrimaryKeyField, Buffer)]);
end;

function TSQLProducer.LastId(Table: TTable): String;
begin
  Result := Format('SELECT MAX(%s) FROM %s;', [UpperCase(Table.PrimaryKeyField.Name), UpperCase(Table.Name)]);
end;

end.

