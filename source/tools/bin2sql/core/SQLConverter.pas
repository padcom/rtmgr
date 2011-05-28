unit SQLConverter;

interface

uses
  Classes, SysUtils,
  DatabaseDefinition;

type
  ISQLConverter = interface
    ['{D394C463-DA74-4714-8AD8-4225EAFAB967}']
    function GetTable: TTable;
    procedure SetTable(Value: TTable);
    procedure LoadBinaryData(FileName: String);
    procedure CreateInserts(Output: TStrings);
    procedure Convert(BinaryFile: TFileName; Output: TStrings);
    property Table: TTable read GetTable write SetTable;
  end;

implementation

end.

