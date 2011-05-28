unit DatabaseDefinition;

interface

uses
  ActiveX, Classes, SysUtils, StrUtils, Contnrs, MsXml2;

type
  TDataType = (dtUnknown, dtInteger, dtWord, dtChar, dtDateTime, dtDouble);

  TDataTypeUtils = class (TObject)
    class function StrToDataType(S: String): TDataType;
  end;

  TField = class (TObject)
  private
    FName: String;
    FDataType: TDataType;
    FSize: Integer;
    FOffset: Integer;
    FIncludedInSQL: Boolean;
    FIsPrimaryKey: Boolean;
  protected
    procedure Load(XmlNode: IXMLDOMNode);
  public
    property Name: String read FName write FName;
    property DataType: TDataType read FDataType write FDataType;
    property Size: Integer read FSize write FSize;
    property Offset: Integer read FOffset write FOffset;
    property IncludedInSQL: Boolean read FIncludedInSQL write FIncludedInSQL;
    property IsPrimaryKey: Boolean read FIsPrimaryKey write FIsPrimaryKey;
  end;

  TFieldList = class (TObjectList)
  private
    function GetItem(Index: Integer): TField;
  protected
    procedure Load(XmlNode: IXMLDOMNode);
  public
    property Items[Index: Integer]: TField read GetItem; default;
  end;

  TTable = class (TObject)
  private
    FName: String;
    FFileName: TFileName;
    FFields: TFieldList;
    function GetPrimaryKeyField: TField;
  protected
    procedure Load(XmlNode: IXMLDOMNode);
  public
    constructor Create;
    destructor Destroy; override;
    property Name: String read FName write FName;
    property FileName: TFileName read FFileName write FFileName;
    property PrimaryKeyField: TField read GetPrimaryKeyField;
    property Fields: TFieldList read FFields;
  end;

  TTableList = class (TObjectList)
  private
    function GetItem(Index: Integer): TTable;
    function GetByName(Name: String): TTable;
  protected
    procedure Load(XmlNode: IXMLDOMNode);
  public
    property Items[Index: Integer]: TTable read GetItem; default;
    property ByName[Name: String]: TTable read GetByName;
  end;

  TDatabaseDefinition = class (TObject)
  private
    FTables: TTableList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Load(FileName: TFileName); overload;
    procedure Load(XmlNode: IXMLDOMNode); overload;
    property Tables: TTableList read FTables;
  end;

implementation

{ TDataTypeUtils }

class function TDataTypeUtils.StrToDataType(S: String): TDataType;
const
  CONVERSION_TABLE: array[0..4] of record Text: String; DataType: TDataType; end = (
    (Text: 'Integer';  DataType: dtInteger),
    (Text: 'Word';     DataType: dtWord),
    (Text: 'Char';     DataType: dtChar),
    (Text: 'DateTime'; DataType: dtDateTime),
    (Text: 'Double';   DataType: dtDouble)
  );
var
  I: Integer;
begin
  Result := dtUnknown;
  for I := 0 to Length(CONVERSION_TABLE) - 1 do
    if AnsiSameText(CONVERSION_TABLE[I].Text, S) then
    begin
      Result := CONVERSION_TABLE[I].DataType;
      Break;
    end;
end;

{ TField }

{ Protected declarations }

procedure TField.Load(XmlNode: IXMLDOMNode);
begin
  Name := XmlNode.attributes.getNamedItem('name').text;
  DataType := TDataTypeUtils.StrToDataType(XmlNode.attributes.getNamedItem('type').text);
  Assert(DataType <> dtUnknown, Format('Error: unknown datatype %s', [XmlNode.attributes.getNamedItem('type').text]));
  Offset := StrToInt(XmlNode.attributes.getNamedItem('offset').text);
  Size := StrToInt(XmlNode.attributes.getNamedItem('size').text);
  if Assigned(XmlNode.attributes.getNamedItem('sql')) then
    IncludedInSQL := StrToBoolDef(XmlNode.attributes.getNamedItem('sql').text, false);
  if Assigned(XmlNode.attributes.getNamedItem('primarykey')) then
    IsPrimaryKey := StrToBoolDef(XmlNode.attributes.getNamedItem('primarykey').text, false);
end;

{ TFieldList }

{ Private declarations }

function TFieldList.GetItem(Index: Integer): TField;
begin
  Result := TObject(Get(Index)) as TField;
end;

{ Protected declarations }

procedure TFieldList.Load(XmlNode: IXMLDOMNode);
var
  I: Integer;
  Field: TField;
  Nodes: IXMLDOMNodeList;
begin
  Nodes := XmlNode.selectNodes('field');
  for I := 0 to Nodes.length - 1 do
  begin
    Field := TField.Create;
    try
      Field.Load(Nodes[I]);
      Add(Field);
    except
      Field.Free;
    end;
  end;
end;

{ TTable }

{ Private declarations }

function TTable.GetPrimaryKeyField: TField;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Fields.Count - 1 do
    if Fields[I].IsPrimaryKey then
    begin
      Result := Fields[I];
      Break;
    end;
end;

{ Protected declarations }

procedure TTable.Load(XmlNode: IXMLDOMNode);
begin
  FName := XmlNode.attributes.getNamedItem('name').text;
  FFileName := XmlNode.attributes.getNamedItem('filename').text;
  Fields.Load(XmlNode.selectSingleNode('fields'));
end;

{ Public declarations }

constructor TTable.Create;
begin
  inherited Create;
  FFields := TFieldList.Create(True);
end;

destructor TTable.Destroy;
begin
  FreeAndNil(FFields);
  inherited Destroy;
end;

{ TTableList }

{ Private declarations }

function TTableList.GetItem(Index: Integer): TTable;
begin
  Result := TObject(Get(Index)) as TTable;
end;

function TTableList.GetByName(Name: String): TTable;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if AnsiSameText(Items[I].Name, Name) then
    begin
      Result := Items[I];
      Break;
    end;
end;

{ Protected declarations }

procedure TTableList.Load(XmlNode: IXMLDOMNode);
var
  I: Integer;
  Table: TTable;
  Nodes: IXMLDOMNodeList;
begin
  if not Assigned(XmlNode) then
    raise Exception.Create('ERROR: XMLNODE is not supposed to be nil!');
  Nodes := XmlNode.selectNodes('table');
  for I := 0 to Nodes.length - 1 do
  begin
    Table := TTable.Create;
    try
      Table.Load(Nodes[I]);
      Add(Table);
    except
      Table.Free;
    end;
  end;
end;

{ TDatabaseDef }

{ Private declarations }

{ Public declarations }

constructor TDatabaseDefinition.Create;
begin
  inherited Create;
  FTables := TTableList.Create(True);
end;

destructor TDatabaseDefinition.Destroy;
begin
  FreeAndNil(FTables);
  inherited Destroy;
end;

procedure TDatabaseDefinition.Load(FileName: TFileName);
var
  XmlDoc: IXMLDOMDocument;
begin
  XmlDoc := CoDOMDocument.Create;
  XmlDoc.Load(FileName);
  Load(XmlDoc.selectSingleNode('//database'));
end;

procedure TDatabaseDefinition.Load(XmlNode: IXMLDOMNode);
begin
  try
    Tables.Load(XmlNode.selectSingleNode('tables'));
  except
    Tables.Clear;
    raise;
  end;
end;

initialization
  OleInitialize(nil);

finalization
  OleUninitialize;

end.

