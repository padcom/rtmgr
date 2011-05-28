unit RT_Kurs;

interface

uses
  Classes, SysUtils,
  RT_Base, RT_BaseTypes;

type
  TRT_Kurs = class (TRT_DataObject)
  private
    function GetData: PRTKursRec;
  protected
    function GetDataSize: Word; override;
  public
    constructor Create;
    property D: PRTKursRec read GetData;
  end;

  TRT_Kursy = class (TRT_DataCollection)
    function ReadRecord(S: TStream; RH: TRecHeader; var R: TRT_DataObject): TReadRecordResult; override;
    procedure Add(Item: TRT_DataObject); override;
    function FiltrujKursy(Date: TDateTime): Boolean;
  end;

var
  Kursy: TRT_Kursy = nil;

implementation

{ TRT_Kurs }

constructor TRT_Kurs.Create;
begin
  inherited Create;
  D.Kind := ridKurs;
  D.Size := GetDataSize;
  D.ID := 0;
  D.Flags := 0;
end;

function TRT_Kurs.GetDataSize: Word;
begin
  Result := SizeOf(TRTKursRec);
end;

function TRT_Kurs.GetData: PRTKursRec;
begin
  Result := PRTKursRec(@Buffer^[0]);
end;

{ TRT_Kursy }

function TRT_Kursy.ReadRecord(S: TStream; RH: TRecHeader; var R: TRT_DataObject): TReadRecordResult;
begin
  Result := rrrUnknown;
  case RH.Kind of
    ridKurs:
    begin
      R := TRT_Kurs.LoadFromStream(S, RH);
      Result := rrrTypical;
    end;
  end;
end;

procedure TRT_Kursy.Add(Item: TRT_DataObject);
var
  I: Integer;
  Kurs: TRT_Kurs;
begin
  I := 0;
  while I < FItems.Count do
  begin
    Kurs := TRT_Kurs(Items[I]);
    if Kurs.D^.Realizacja > TRT_Kurs(Item).D^.Realizacja then
    begin
      FItems.Insert(I, Item);
      Break
    end;
    Inc(I);
  end;

  inherited Add(Item);
end;

function TRT_Kursy.FiltrujKursy(Date: TDateTime): Boolean;
var
  I: Integer;
  Kurs: TRT_Kurs;
begin
  Result := False;

  I := 0;
  while I < Count do
  begin
    Kurs := TRT_Kurs(Items[I]);
    try
      if Trunc(Date) <> Trunc(Kurs.D^.Realizacja) then
      begin
        Delete(Kurs);
        Dec(Header.Count);
        Kurs.Free;
        Result := True;
      end
      else Inc(I);
    except
      Inc(I);
    end;
  end;
end;

initialization
  Kursy := TRT_Kursy.Create;

finalization
  Kursy.Free;

end.
