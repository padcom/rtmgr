unit SQLConverterKlient;

interface

uses
  Classes, SysUtils,
  DatabaseDefinition, SQLConverter, SQLProducer,
  RT_BaseTypes, RT_Klient;

type
  TSQLConverterKlient = class (TInterfacedObject, ISQLConverter)
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

{ TSQLConverterKlient }

constructor TSQLConverterKlient.Create;
begin
  inherited Create;
  FSQLProducer := TSQLProducer.Create;
end;

destructor TSQLConverterKlient.Destroy;
begin
  FreeAndNil(FSQLProducer);
  inherited Destroy;
end;

function TSQLConverterKlient.GetTable: TTable;
begin
  Result := FTable;
end;

procedure TSQLConverterKlient.SetTable(Value: TTable);
begin
  if FTable <> Value then
    FTable := Value;
end;

procedure TSQLConverterKlient.LoadBinaryData(FileName: String);
begin
  Klienci.Load(FileName);
end;

procedure TSQLConverterKlient.CreateInserts(Output: TStrings);
var
  I: Integer;
begin
  for I := 0 to Klienci.Count - 1 do
    Output.Add(SQLProducer.Insert(FTable, TRT_Klient(Klienci[I]).D));
end;

procedure TSQLConverterKlient.Convert(BinaryFile: TFileName; Output: TStrings);
begin
  LoadBinaryData(BinaryFile);
  CreateInserts(Output);
end;

end.


