unit SQLConverterRegistry;

interface

uses
  Classes, SysUtils, Contnrs,
  SQLConverter;

type
  TSQLConverterRegistryItem = class (TObject)
  private
    FNull: Boolean;
    FTableName: String;
    FConverter: ISQLConverter;
  public
    property Null: Boolean read FNull write FNull;
    property TableName: String read FTableName write FTableName;
    property Converter: ISQLConverter read FConverter write FConverter;
  end;

  TSQLConverterRegistryItemList = class (TObjectList)
  private
    function GetItem(Index: Integer): TSQLConverterRegistryItem;
  public
    property Items[Index: Integer]: TSQLConverterRegistryItem read GetItem; default;
  end;

  TSQLConverterRegistry = class (TObject)
  private
    FItems: TSQLConverterRegistryItemList;
    function GetConverter(TableName: String): ISQLConverter;
  protected
    property Items: TSQLConverterRegistryItemList read FItems;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Register(TableName: String; Converter: ISQLConverter; Null: Boolean = False);
    property Converter[TableName: String]: ISQLConverter read GetConverter; default;
  end;

implementation

uses
  SQLConverterNull;

{ TSQLConverterRegistryItem }

{ TSQLConverterRegistryItemList }

{ Private declarations }

function TSQLConverterRegistryItemList.GetItem(Index: Integer): TSQLConverterRegistryItem;
begin
  Result := TObject(Get(Index)) as TSQLConverterRegistryItem;
end;

{ TSQLConverterRegistry }

{ Private declarations }

function TSQLConverterRegistry.GetConverter(TableName: String): ISQLConverter;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Items.Count - 1 do
    if AnsiSameText(TableName, Items[I].TableName) then
    begin
      Result := Items[I].Converter;
      Break;
    end
    else if Items[I].Null then
      Result := Items[I].Converter;
end;

{ Public declarations }

constructor TSQLConverterRegistry.Create;
begin
  inherited Create;
  FItems := TSQLConverterRegistryItemList.Create(True);
  Register('', TSQLConverterNull.Create, True);
end;

destructor TSQLConverterRegistry.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

procedure TSQLConverterRegistry.Register(TableName: String; Converter: ISQLConverter; Null: Boolean = False);
var
  Item: TSQLConverterRegistryItem;
begin
  Item := TSQLConverterRegistryItem.Create;
  Item.TableName := TableName;
  Item.Converter := Converter;
  Item.Null := Null;
  Items.Add(Item);
end;

end.
