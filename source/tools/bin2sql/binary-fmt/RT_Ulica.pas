unit RT_Ulica;

interface

uses
  Classes, SysUtils,
  RT_Base, RT_BaseTypes;

type
  TRT_Ulica = class (TRT_DataObject)
  private
    function GetData: PRTUlicaRec;
  protected
    function GetDataSize: Word; override;
  public
    constructor Create;
    property D: PRTUlicaRec read GetData;
  end;

  TRT_Ulice = class (TRT_DataCollection)
    procedure Resort;
{$IFDEF BIN2SQL}
    procedure Load(FileName: String); override;
{$ENDIF}    
    function ReadRecord(S: TStream; RH: TRecHeader; var R: TRT_DataObject): TReadRecordResult; override;
  end;

var
  Ulice: TRT_Ulice = nil;

implementation

{ TRT_Ulica }

constructor TRT_Ulica.Create;
begin
  inherited Create;
  D.Kind := ridUlica;
  D.Size := GetDataSize;
  D.ID := 0;
  D.Flags := 0;
  D.Postoje[1] := -1;
  D.Postoje[2] := -1;
  D.Postoje[3] := -1;
  D.Postoje[4] := -1;
  D.Postoje[5] := -1;
  D.Postoje[6] := -1;
end;

function TRT_Ulica.GetDataSize: Word;
begin
  Result := SizeOf(TRTUlicaRec);
end;

function TRT_Ulica.GetData: PRTUlicaRec;
begin
  Result := PRTUlicaRec(@Buffer^[0]);
end;

{ TRT_Ulice }

function CompareUlice(Item1, Item2: Pointer): Integer; 
var
  Ulica1, Ulica2: TRT_Ulica;
  S1, S2: String;
  P1, P2: Integer;
begin
  Ulica1 := Item1;
  Ulica2 := Item2;
  S1 := AnsiUpperCase(Ulica1.D^.Nazwa);
  S2 := AnsiUpperCase(Ulica2.D^.Nazwa);
  Result := AnsiCompareStr(S1, S2);
  if Result = 0 then
  begin
    P1 := StrToInt(Ulica1.D^.Poczatek);
    P2 := StrToInt(Ulica2.D^.Poczatek);
    if P1 < P2 then
      Result := 1
    else if P1 > P2 then
      Result := -1
    else
      Result := 0;
  end;
end;

procedure TRT_Ulice.Resort;
begin
  FItems.Sort(CompareUlice);
end;

{$IFDEF BIN2SQL}
procedure TRT_Ulice.Load(FileName: String);
begin
  inherited Load(FileName);
  Resort;
end;
{$ENDIF}

function TRT_Ulice.ReadRecord(S: TStream; RH: TRecHeader; var R: TRT_DataObject): TReadRecordResult;
begin
  Result := rrrUnknown;
  case RH.Kind of
    ridUlica:
    begin
      R := TRT_Ulica.LoadFromStream(S, RH);
      Result := rrrTypical;
    end;
  end;
end;

initialization
  Ulice := TRT_Ulice.Create;

finalization
  Ulice.Free;

end.
