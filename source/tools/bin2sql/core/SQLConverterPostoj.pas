unit SQLConverterPostoj;

interface

uses
  Classes, SysUtils,
  DatabaseDefinition, SQLConverter, SQLProducer,
  RT_BaseTypes, RT_Postoj;

type
  TSQLConverterPostoj = class (TInterfacedObject, ISQLConverter)
  private
    FTable: TTable;
    FSQLProducer: TSQLProducer;
  property
    SQLProducer: TSQLProducer read FSQLProducer;
  public
    constructor Create;
    destructor Destroy; override;
    function GetTable: TTable;
    procedure SetTable(Value: TTable);
    procedure LoadBinaryData(FileName: String);
    procedure CreateInserts(Output: TStrings);
    procedure Convert(BinaryFile: TFileName; Output: TStrings);
  end;

implementation

{ TSQLConverterPostoj }

constructor TSQLConverterPostoj.Create;
begin
  inherited Create;
  FSQLProducer := TSQLProducer.Create;
end;

destructor TSQLConverterPostoj.Destroy;
begin
  FreeAndNil(FSQLProducer);
  inherited Destroy;
end;

function TSQLConverterPostoj.GetTable: TTable;
begin
  Result := FTable;
end;

procedure TSQLConverterPostoj.SetTable(Value: TTable);
begin
  if FTable <> Value then
    FTable := Value;
end;

procedure TSQLConverterPostoj.LoadBinaryData(FileName: String);
begin
  Postoje.Load(FileName);
end;

procedure TSQLConverterPostoj.CreateInserts(Output: TStrings);
var
  I: Integer;
begin
  for I := 0 to Postoje.Count - 1 do
    Output.Add(SQLProducer.Insert(FTable, TRT_Postoj(Postoje[I]).D));
end;

procedure TSQLConverterPostoj.Convert(BinaryFile: TFileName; Output: TStrings);
begin
  LoadBinaryData(BinaryFile);
  CreateInserts(Output);
end;

end.


