unit SQLConverterUlica;

interface

uses
  Classes, SysUtils,
  DatabaseDefinition, SQLConverter, SQLProducer,
  RT_BaseTypes, RT_Ulica;

type
  TSQLConverterUlica = class (TInterfacedObject, ISQLConverter)
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

{ TSQLConverterUlica }

constructor TSQLConverterUlica.Create;
begin
  inherited Create;
  FSQLProducer := TSQLProducer.Create;
end;

destructor TSQLConverterUlica.Destroy;
begin
  FreeAndNil(FSQLProducer);
  inherited Destroy;
end;

function TSQLConverterUlica.GetTable: TTable;
begin
  Result := FTable;
end;

procedure TSQLConverterUlica.SetTable(Value: TTable);
begin
  if FTable <> Value then
    FTable := Value;
end;

procedure TSQLConverterUlica.LoadBinaryData(FileName: String);
begin
  Ulice.Load(FileName);
end;

procedure TSQLConverterUlica.CreateInserts(Output: TStrings);
var
  I, J: Integer;
begin
  for I := 0 to Ulice.Count - 1 do
  begin
    Output.Add(SQLProducer.Insert(FTable, TRT_Ulica(Ulice[I]).D));
    for J := 1 to 8 do
      if TRT_Ulica(Ulice[I]).D^.Postoje[J] <> 0 then
        Output.Add(Format('INSERT INTO POSTOJNAULICY (ID, ULICAID, POSTOJID, INDEKS) VALUES (0, %d, %d, %d);', [
          TRT_Ulica(Ulice[I]).D^.ID,
          TRT_Ulica(Ulice[I]).D^.Postoje[J],
          J
        ]));
  end;
end;

procedure TSQLConverterUlica.Convert(BinaryFile: TFileName; Output: TStrings);
begin
  LoadBinaryData(BinaryFile);
  CreateInserts(Output);
end;

end.


