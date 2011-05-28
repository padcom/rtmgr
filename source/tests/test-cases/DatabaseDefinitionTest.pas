unit DatabaseDefinitionTest;

interface

uses
  Classes, SysUtils, TestFramework,
  DatabaseDefinition, MsXml2;

type
  TDatabaseDefinitionTest = class (TTestCase)
  protected
    function CreateDefinitionDescription: IXMLDOMDocument;
  published
    procedure TestLoad;
  end;

implementation

{ TDatabaseDefinitionTest }

{ Protected declarations }

function TDatabaseDefinitionTest.CreateDefinitionDescription: IXMLDOMDocument;
  function CreateTableNode(Document: IXMLDOMDocument): IXMLDOMNode;
  var
    Attr: IXMLDOMAttribute;
  begin
    Result := Document.createElement('table');
    Attr := Document.createAttribute('name');
    Attr.value := 'TEST';
    Result.attributes.setNamedItem(Attr);
    Attr := Document.createAttribute('filename');
    Attr.value := 'TEST.rtm';
    Result.attributes.setNamedItem(Attr);
  end;
  function CreateFieldNode(Document: IXMLDOMDocument; Name, DataType, Size, Offset, IncludedInSQL, IsPrimaryKey: String): IXMLDOMNode;
  var
    Attr: IXMLDOMAttribute;
  begin
    Result := Document.createElement('field');
    Attr := Document.createAttribute('name');
    Attr.value := Name;
    Result.attributes.setNamedItem(Attr);
    Attr := Document.createAttribute('type');
    Attr.value := DataType;
    Result.attributes.setNamedItem(Attr);
    Attr := Document.createAttribute('size');
    Attr.value := Size;
    Result.attributes.setNamedItem(Attr);
    Attr := Document.createAttribute('offset');
    Attr.value := Offset;
    Result.attributes.setNamedItem(Attr);
    Attr := Document.createAttribute('sql');
    Attr.value := IncludedInSQL;
    Result.attributes.setNamedItem(Attr);
    Attr := Document.createAttribute('primarykey');
    Attr.value := IsPrimaryKey;
    Result.attributes.setNamedItem(Attr);
  end;
var
  Node: IXMLDOMNode;
begin
  Result := CoDOMDocument.Create;
  Result.appendChild(Result.createElement('database'));
  Node := Result.createElement('tables');
  Result.selectSingleNode('//database').appendChild(Node);
  Node := CreateTableNode(Result);
  Result.selectSingleNode('//database/tables').appendChild(Node);
  Node := Result.createElement('fields');
  Result.selectSingleNode('//database/tables/table').appendChild(Node);
  Node.appendChild(CreateFieldNode(Result, 'Field1', 'Integer', '4', '1', 'False', 'False'));
  Node.appendChild(CreateFieldNode(Result, 'Field2', 'Double', '8', '10', 'True', 'True'));
end;

{ Test cases }

procedure TDatabaseDefinitionTest.TestLoad;
begin
  with TDatabaseDefinition.Create do
    try
      Load(CreateDefinitionDescription.documentElement);
      CheckEquals(1, Tables.Count, 'Expected one table');
      CheckEquals('TEST', Tables[0].Name);
      CheckEquals('TEST.rtm', Tables[0].FileName);
      CheckEquals(2, Tables[0].Fields.Count, 'Expected two fields');
      CheckEquals('Field1', Tables[0].Fields[0].Name);
      CheckEquals(Integer(dtInteger), Integer(Tables[0].Fields[0].DataType));
      CheckEquals(4, Tables[0].Fields[0].Size);
      CheckEquals(1, Tables[0].Fields[0].Offset);
      CheckEquals(False, Tables[0].Fields[0].IncludedInSQL);
      CheckEquals(False, Tables[0].Fields[0].IsPrimaryKey);
      CheckEquals('Field1', Tables[0].Fields[0].Name);
      CheckEquals(Integer(dtDouble), Integer(Tables[0].Fields[1].DataType));
      CheckEquals(8, Tables[0].Fields[1].Size);
      CheckEquals(10, Tables[0].Fields[1].Offset);
      CheckEquals(True, Tables[0].Fields[1].IncludedInSQL);
      CheckEquals(True, Tables[0].Fields[1].IsPrimaryKey);
    finally
      Free;
    end;
end;

initialization
  RegisterTest(TDatabaseDefinitionTest.Suite);

end.
