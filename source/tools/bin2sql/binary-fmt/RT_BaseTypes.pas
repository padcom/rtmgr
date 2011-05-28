unit RT_BaseTypes;

interface

uses
  Windows, Classes, SysUtils, Math,
  RT_Base;

type
  TRT_DataCollection = class;

  TRecHeader = packed record
    Kind       : Integer;
    Size       : Word;
  end;

  TFileHeader = packed record
    FileID  : array[0..4] of Char;
    Created : array[0..7] of Char;
    Modified: array[0..7] of Char;
    Count   : Integer;
    CRC     : Integer;
  end;

  PBuffer = ^TBuffer;
  TBuffer = array[0..65535] of Byte;

  TRT_DataObject = class (TObject)
  private
    function GetID: Integer;
  protected
    Buffer: PBuffer;
    function GetDataSize: Word; virtual;
  public
    constructor Create;
    constructor LoadFromStream(S: TStream; RH: TRecHeader); virtual;
    destructor Destroy; override;
    procedure WriteToStream(S: TStream); virtual;
    property ID: Integer read GetID;
  end;

  TReadRecordResult = (rrrUnknown, rrrTypical);

  TRT_DataCollection = class (TObject)
  protected
    FItems: TList;
    FRecords: TList;
    function GetItems(Index: Integer): TRT_DataObject;
    function GetCount: Integer;
  public
    Header: TFileHeader;
    constructor Create;
    destructor Destroy; override;
{$IFDEF BIN2SQL}
    procedure Load(FileName: String); virtual;
{$ENDIF}
    function ReadRecord(S: TStream; RH: TRecHeader; var R: TRT_DataObject): TReadRecordResult; virtual; abstract;
    procedure Add(Item: TRT_DataObject); virtual;
    procedure Delete(Item: TRT_DataObject);
    procedure Clear;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TRT_DataObject read GetItems; default;
  end;

implementation

{ TRT_DataObject }

constructor TRT_DataObject.Create;
begin
  inherited Create;
  GetMem(Buffer, GetDataSize);
end;

destructor TRT_DataObject.Destroy;
begin
  FreeMem(Buffer);
  inherited Destroy;
end;

function TRT_DataObject.GetDataSize: Word;
begin
  Result := 0;
end;

function TRT_DataObject.GetID: Integer;
begin
  Result := Integer((@Buffer^[SizeOf(TRecHeader)])^);
end;

constructor TRT_DataObject.LoadFromStream(S: TStream; RH: TRecHeader);
var
  L: Word;
begin
  inherited Create;
  L := Max(RH.Size, GetDataSize);
  Buffer := AllocMem(L);
  TRecHeader((@Buffer^[0])^) := RH;
  TRecHeader((@Buffer^[0])^).Size := L;
  S.Read(Buffer^[SizeOf(TRecHeader)], RH.Size - SizeOf(TRecHeader));
end;

procedure TRT_DataObject.WriteToStream(S: TStream);
begin
  TRecHeader((@Buffer^[0])^).Size := GetDataSize;
  S.Write(Buffer^[0], GetDataSize);
end;

{ TRT_DataCollection }

constructor TRT_DataCollection.Create;
begin
  inherited Create;
  FillChar(Header, SizeOf(Header), 0);
  StrPCopy(Header.FileID, 'RT30');
  StrPCopy(Header.Created, FormatDateTime('YYYYMMDD', Now));
  FItems := TList.Create;
  FRecords := TList.Create;
end;

destructor TRT_DataCollection.Destroy;
begin
  Clear;
  FItems.Free;
  FRecords.Free;
  inherited Destroy;
end;

function TRT_DataCollection.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TRT_DataCollection.GetItems(Index: Integer): TRT_DataObject;
begin
  Result := FItems[Index];
end;

procedure TRT_DataCollection.Add(Item: TRT_DataObject);
begin
  if FItems.IndexOf(Item) = -1 then
    FItems.Add(Item);
  if FRecords.IndexOf(Item) = -1 then
    FRecords.Add(Item);
end;

procedure TRT_DataCollection.Delete(Item: TRT_DataObject);
var
  Index: Integer;
begin
  Index := FItems.IndexOf(Item);
  if Index >=0 then
    FItems.Delete(Index);
  Index := FRecords.IndexOf(Item);
  if Index >=0 then
    FRecords.Delete(Index);
end;

procedure TRT_DataCollection.Clear;
var
  I: Integer;
begin
  for I := 0 to FRecords.Count - 1 do
    TObject(FRecords[I]).Free;
  FRecords.Clear;
  FItems.Clear;
end;

{$IFDEF BIN2SQL}
procedure TRT_DataCollection.Load(FileName: String);
var
  Ext: String;
  S: TFileStream;
  RH: TRecHeader;
  R: TRT_DataObject;
  Result: TReadRecordResult;
  Done: Boolean;
  Tmp: String;
  Rescue: Boolean;
  Count, CRC: Integer;
  I: Integer;
  Buffer: array[0..4095] of Byte;
begin
  Clear;
  Ext := ExtractFileExt(FileName);
  if not FileExists(FileName) then
  begin
    FileName := Copy(FileName, 1, Length(FileName) - Length(Ext));
    if not FileExists(FileName + '.bak') then
      Exit;
    Tmp := 'Nie znalaz³em pliku danych ' + ExtractFileName(FileName) + '.rtm'#13#10'Nast¹pi próba odtworzenia z kopii zapasowej.';
    MessageBox(0, PChar(Tmp), 'Ostrze¿enie', MB_ICONWARNING or MB_OK or MB_APPLMODAL);
    FileName := FileName + '.bak';
  end;
  Rescue := LowerCase(Ext) = '.bak';
  Count := 0;
  S := TFileStream.Create(FileName, fmOpenRead);
  try
    if S.Read(Header, SizeOf(Header)) < SizeOf(Header) then
      raise Exception.CreateFmt('B³¹d odczytu nag³ówka pliku %s !', [FileName]);
    repeat
      if S.Size <> S.Position then
      begin
        S.Read(RH, SizeOf(RH));
        if S.Size = S.Position then
          raise Exception.CreateFmt('B³¹d podczas odczytu danych z pliku &s !', [FileName]);
        Done := S.Size - (S.Position + RH.Size - SizeOf(RH)) <= 0;
        Result := ReadRecord(S, RH, R);
        Inc(Count);
        case Result of
          rrrTypical:
          begin
            Add(R);
            FillChar(RH, SizeOf(RH), 0);
          end;
          rrrUnknown:
          begin
            R := TRT_DataObject.Create;
            GetMem(R.Buffer, RH.Size);
            TRecHeader((@R.Buffer^[0])^) := RH;
            S.Read(R.Buffer^[SizeOf(TRecHeader)], RH.Size - SizeOf(TRecHeader));
            FRecords.Add(R);
            FillChar(RH, SizeOf(RH), 0);
          end;
        end;
      end
      else Done := True;
    until Done;
    // sprawdzenie, czy iloœæ wczytanych danych jest zgodna z iloœci¹ przewidywan¹
    if Header.Count <> Count then
      raise Exception.Create('Wyst¹pi³ b³¹d podczas odczytu danych z pliku: iloœæ rekordów jest niezgodna z zapisem w nag³ówku');
    // sprawdzenie CRC pliku
    S.Seek(SizeOf(Header), soFromBeginning);
    CRC := 0;
    while S.Position <> S.Size do
    begin
      Count := S.Read(Buffer, SizeOf(Buffer));
      if Count > 0 then for I := 0 to Count - 1 do
        CRC := CRC + Buffer[I];
    end;
    if CRC <> Header.CRC then
      raise Exception.Create('Wyst¹pi³ b³¹d podczas odczytu danych z pliku: suma kontrolna jest niezgodna z zapisem w nag³ówku');
  except
    if Rescue then
    begin
      Tmp := 'Wyst¹pi³ b³¹d podczas odzysku danych z pliku ' + FileName + #13#10 + 'Nie istnieje mo¿liwoœæ przywrócenia danych z kopii zapasowej.';
      MessageBox(0, PChar(Tmp), 'B³¹d', MB_ICONERROR or MB_OK or MB_APPLMODAL);
      Rescue := False;
    end
    else
    begin
      Ext := LowerCase(ExtractFileExt(FileName));
      FileName := Copy(FileName, 1, Length(FileName) - Length(ExtractFileExt(FileName))) + '.bak';
      if not FileExists(FileName) then
      begin
        Tmp := 'Wyst¹pi³ b³¹d podczas odczytu danych z pliku ' + ExtractFileName(FileName) + #13#10 + 'Nie istnieje kopia zapasowa tego pliku';
        MessageBox(0, PChar(Tmp), 'B³¹d', MB_ICONERROR or MB_OK or MB_APPLMODAL);
        Rescue := False;
      end
      else
      begin
        Tmp := 'Wyst¹pi³ b³¹d podczas odczytu danych z pliku ' + ExtractFileName(FileName) + #13#10 + 'Nast¹pi próba odzysku danych z kopi zapasowej.';
        MessageBox(0, PChar(Tmp), 'Ostrze¿enie', MB_ICONWARNING or MB_OK or MB_APPLMODAL);
        Load(FileName);
      end;
    end;
  end;
  S.Free;

  if Rescue then
  begin
    Tmp := 'Przywracanie danych z pliku ' + ExtractFileName(FileName) + ' zakoñczone pomyœlnie';
    MessageBox(0, PChar(Tmp), 'Informacja', MB_ICONINFORMATION or MB_OK or MB_APPLMODAL);
  end;
end;
{$ENDIF}

end.
