unit SQLConverterNull;

interface

uses
  Classes, SysUtils,
  SQLConverter, DatabaseDefinition;

type
  TSQLConverterNull = class (TInterfacedObject, ISQLConverter)
  public
    function GetTable: TTable;
    procedure SetTable(Value: TTable);
    procedure LoadBinaryData(FileName: String);
    procedure CreateTable(Output: TStrings);
    procedure CreateTriggers(Output: TStrings);
    procedure CreateInserts(Output: TStrings);
    procedure Convert(BinaryFile: TFileName; Output: TStrings);
  end;

implementation

{ TSQLConverterNull }

function TSQLConverterNull.GetTable: TTable;
begin
  Result := nil;
end;

procedure TSQLConverterNull.SetTable(Value: TTable);
begin
end;

procedure TSQLConverterNull.LoadBinaryData(FileName: String);
begin
end;

procedure TSQLConverterNull.CreateTable(Output: TStrings);
begin
end;

procedure TSQLConverterNull.CreateTriggers(Output: TStrings);
begin
end;

procedure TSQLConverterNull.CreateInserts(Output: TStrings);
begin
end;

procedure TSQLConverterNull.Convert(BinaryFile: TFileName; Output: TStrings);
begin
end;

end.

