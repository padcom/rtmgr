unit RT_Taksowka;

interface

uses
  Classes, SysUtils,
  RT_Base, RT_BaseTypes;

type
  TRT_Taksowka = class (TRT_DataObject)
  private
    function GetData: PRTTaksowkaRec;
  protected
    function GetDataSize: Word; override;
  public
    IloscKursow: Integer;
    IloscInformacji: Integer;
    IloscKursowDziennie: array[1..31] of record
      Informacje: Integer;
      Normalne: Integer;
    end;
    constructor Create;
    property D: PRTTaksowkaRec read GetData;
  end;

  TRT_Taksowki = class (TRT_DataCollection)
    function ReadRecord(S: TStream; RH: TRecHeader; var R: TRT_DataObject): TReadRecordResult; override;
    procedure Add(Item: TRT_DataObject); override;
  end;

var
  Taksowki: TRT_Taksowki = nil;

implementation

{ TRT_Taksowka }

constructor TRT_Taksowka.Create;
begin
  inherited Create;
  D.Kind := ridTaksowka;
  D.Size := GetDataSize;
  D.ID := 0;
  D.Flags := 0;
end;

function TRT_Taksowka.GetDataSize: Word;
begin
  Result := SizeOf(TRTTaksowkaRec);
end;

function TRT_Taksowka.GetData: PRTTaksowkaRec;
begin
  Result := PRTTaksowkaRec(@Buffer^[0]);
end;

{ TRT_Taksowki }

function TRT_Taksowki.ReadRecord(S: TStream; RH: TRecHeader; var R: TRT_DataObject): TReadRecordResult;
begin
  Result := rrrUnknown;
  case RH.Kind of
    ridTaksowka:
    begin
      R := TRT_Taksowka.LoadFromStream(S, RH);
      Result := rrrTypical;
    end;
  end;
end;

procedure TRT_Taksowki.Add(Item: TRT_DataObject);
var
  I: Integer;
  Taksowka: TRT_Taksowka;
begin
  I := 0;
  while I < FItems.Count do
  begin
    Taksowka := TRT_Taksowka(Items[I]);
    if StrToInt(Taksowka.D^.NrWywol) > StrToInt(TRT_Taksowka(Item).D^.NrWywol) then
    begin
      FItems.Insert(I, Item);
      Break;
    end;
    Inc(I);
  end;

  inherited Add(Item);
end;

initialization
  Taksowki := TRT_Taksowki.Create;

finalization
  Taksowki.Free;

end.
