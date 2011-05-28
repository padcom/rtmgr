unit SQLConverterTaksowka;

interface

uses
  Classes, SysUtils,
  DatabaseDefinition, SQLConverter, SQLProducer,
  RT_BaseTypes, RT_Taksowka;

type
  TSQLConverterTaksowka = class (TInterfacedObject, ISQLConverter)
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

{ TSQLConverterTaksowka }

constructor TSQLConverterTaksowka.Create;
begin
  inherited Create;
  FSQLProducer := TSQLProducer.Create;
end;

destructor TSQLConverterTaksowka.Destroy;
begin
  FreeAndNil(FSQLProducer);
  inherited Destroy;
end;

function TSQLConverterTaksowka.GetTable: TTable;
begin
  Result := FTable;
end;

procedure TSQLConverterTaksowka.SetTable(Value: TTable);
begin
  if FTable <> Value then
    FTable := Value;
end;

procedure TSQLConverterTaksowka.LoadBinaryData(FileName: String);
begin
  Taksowki.Load(FileName);
end;

procedure TSQLConverterTaksowka.CreateInserts(Output: TStrings);
var
  I: Integer;
begin
  for I := 0 to Taksowki.Count - 1 do
    Output.Add(SQLProducer.Insert(FTable, TRT_Taksowka(Taksowki[I]).D));
end;

procedure TSQLConverterTaksowka.Convert(BinaryFile: TFileName; Output: TStrings);
begin
  LoadBinaryData(BinaryFile);
  CreateInserts(Output);
end;

end.


