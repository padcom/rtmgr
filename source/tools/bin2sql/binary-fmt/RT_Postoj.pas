unit RT_Postoj;

interface

uses
  Classes, SysUtils,
  RT_Base, RT_BaseTypes;

type
  TRT_Postoj = class (TRT_DataObject)
  private
    function GetData: PRTPostojRec;
  protected
    function GetDataSize: Word; override;
  public
    Taksowki: TList;
    constructor Create;
    constructor LoadFromStream(S: TStream; RH: TRecHeader); override;
    destructor Destroy; override;
    property D: PRTPostojRec read GetData;
  end;

  TRT_Postoje = class (TRT_DataCollection)
    function ReadRecord(S: TStream; RH: TRecHeader; var R: TRT_DataObject): TReadRecordResult; override;
    procedure Add(Item: TRT_DataObject); override;
  end;

var
  Postoje: TRT_Postoje = nil;

implementation

{ TRT_Postoj }

constructor TRT_Postoj.Create;
begin
  inherited Create;
  D.Kind := ridPostoj;
  D.Size := GetDataSize;
  D.ID := 0;
  D.Flags := 0;
  Taksowki := TList.Create;
end;

constructor TRT_Postoj.LoadFromStream(S: TStream; RH: TRecHeader);
begin
  inherited LoadFromStream(S, RH);
  Taksowki := TList.Create;
end;

destructor TRT_Postoj.Destroy;
begin
  Taksowki.Free;
  inherited Destroy;
end;

function TRT_Postoj.GetDataSize: Word;
begin
  Result := SizeOf(TRTPostojRec);
end;

function TRT_Postoj.GetData: PRTPostojRec;
begin
  Result := PRTPostojRec(@Buffer^[0]);
end;

{ TRT_Postoje }

function TRT_Postoje.ReadRecord(S: TStream; RH: TRecHeader; var R: TRT_DataObject): TReadRecordResult;
begin
  Result := rrrUnknown;
  case RH.Kind of
    ridPostoj:
    begin
      R := TRT_Postoj.LoadFromStream(S, RH);
      Result := rrrTypical;
    end;
  end;
end;

procedure TRT_Postoje.Add(Item: TRT_DataObject);
var
  I: Integer;
  Postoj: TRT_Postoj;
begin
  I := 0;
  while I < FItems.Count do
  begin
    Postoj := TRT_Postoj(Items[I]);
    if Postoj.D^.Nazwa < TRT_Postoj(Item).D^.Nazwa then
    begin
      FItems.Insert(I, Item);
      Break
    end;
    Inc(I);
  end;

  inherited Add(Item);
end;

initialization
  Postoje := TRT_Postoje.Create;

finalization
  Postoje.Free;

end.
