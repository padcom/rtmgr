unit RT_Klient;

interface

uses
  Classes, SysUtils,
  RT_Base, RT_BaseTypes;

type
  TRT_Klient = class (TRT_DataObject)
  private
    function GetData: PRTKlientRec;
  protected
    function GetDataSize: Word; override;
  public
    constructor Create;
    property D: PRTKlientRec read GetData;
  end;

  TRT_Klienci = class (TRT_DataCollection)
    function ReadRecord(S: TStream; RH: TRecHeader; var R: TRT_DataObject): TReadRecordResult; override;
    procedure Add(Item: TRT_DataObject); override;
  end;

var
  Klienci: TRT_Klienci = nil;

implementation

{ TRT_Klient }

constructor TRT_Klient.Create;
begin
  inherited Create;
  D.Kind := ridKlient;
  D.Size := GetDataSize;
  D.ID := 0;
  D.Flags := 0;
end;

function TRT_Klient.GetDataSize: Word;
begin
  Result := SizeOf(TRTKlientRec);
end;

function TRT_Klient.GetData: PRTKlientRec;
begin
  Result := PRTKlientRec(@Buffer^[0]);
end;

{ TRT_Klienci }

function TRT_Klienci.ReadRecord(S: TStream; RH: TRecHeader; var R: TRT_DataObject): TReadRecordResult;
begin
  Result := rrrUnknown;
  case RH.Kind of
    ridKlient:
    begin
      R := TRT_Klient.LoadFromStream(S, RH);
      Result := rrrTypical;
    end;
  end;
end;

procedure TRT_Klienci.Add(Item: TRT_DataObject);
var
  I: Integer;
  Klient: TRT_Klient;
begin
  I := 0;
  while I < FItems.Count do
  begin
    Klient := TRT_Klient(Items[I]);
    if Klient.D^.Nazwa < TRT_Klient(Item).D^.Nazwa then
    begin
      FItems.Insert(I, Item);
      Break
    end;
    Inc(I);
  end;

  inherited Add(Item);
end;

initialization
  Klienci := TRT_Klienci.Create;

finalization
  Klienci.Free;

end.
