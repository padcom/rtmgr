unit SQLConverterKurs;

interface

uses
  Classes, SysUtils,
  DatabaseDefinition, SQLConverter, SQLProducer,
  RT_BaseTypes, RT_Kurs;

type
  TSQLConverterKurs = class (TInterfacedObject, ISQLConverter)
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

{ TSQLConverterKurs }

constructor TSQLConverterKurs.Create;
begin
  inherited Create;
  FSQLProducer := TSQLProducer.Create;
end;

destructor TSQLConverterKurs.Destroy;
begin
  FreeAndNil(FSQLProducer);
  inherited Destroy;
end;

function TSQLConverterKurs.GetTable: TTable;
begin
  Result := FTable;
end;

procedure TSQLConverterKurs.SetTable(Value: TTable);
begin
  if FTable <> Value then
    FTable := Value;
end;

procedure TSQLConverterKurs.LoadBinaryData(FileName: String);
begin
  Kursy.Load(FileName);
end;

procedure TSQLConverterKurs.CreateInserts(Output: TStrings);
var
  I: Integer;
begin
  for I := 0 to Kursy.Count - 1 do
    Output.Add(SQLProducer.Insert(FTable, TRT_Kurs(Kursy[I]).D, True));
end;

procedure TSQLConverterKurs.Convert(BinaryFile: TFileName; Output: TStrings);
var
  SRec: TSearchRec;
  SRes: Integer;
begin
  SRes := FindFirst(BinaryFile, faAnyFile, SRec);
  while SRes = 0 do
  begin
    LoadBinaryData(ExtractFilePath(BinaryFile) + SRec.Name);
    CreateInserts(Output);
    SRes := FindNext(SRec);
  end;
end;

end.


