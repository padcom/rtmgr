unit RT_DateProvider;

interface

uses
  Windows, Classes, SysUtils;

type
  IRTDateProviderConfiguration = interface
    ['{AAB43AD1-4706-41C0-BCD0-4A344B44F6FA}']
    function IsFakeDateEnabled: Boolean;
    function GetFakeDateTime: TDateTime;
  end;

  TRTDateProviderConfiguration = class (TInterfacedObject, IRTDateProviderConfiguration)
  private
    FormatSettings: TFormatSettings;
    function IsFakeDateEnabled: Boolean;
    function GetFakeDateTime: TDateTime;
  public
    constructor Create;
  end;

  TRTDateProvider = class (TObject)
  private
    FConfiguration: IRTDateProviderConfiguration;
  protected
    class procedure Initialize;
    class procedure Shutdown;
  public
    class function Instance: TRTDateProvider;
    constructor Create;
    destructor Destroy; override;
    function Now: TDateTime;
    function Date: TDateTime;
    property Configuration: IRTDateProviderConfiguration read FConfiguration write FConfiguration;
  end;

implementation

{ TRTDateProviderConfiguration }

{ Private declarations }

function TRTDateProviderConfiguration.IsFakeDateEnabled: Boolean;
begin
  Result := FileExists('FakeDate.txt');
end;

function TRTDateProviderConfiguration.GetFakeDateTime: TDateTime;
begin
  with TStringList.Create do
    try
      LoadFromFile('FakeDate.txt');
      if Count > 0 then
        Result := StrToDateTime(Strings[0], FormatSettings)
      else
        Result := SysUtils.Now;
    finally
      Free;
    end;
end;

{ Public declarations }

constructor TRTDateProviderConfiguration.Create;
begin
  inherited Create;
  GetLocaleFormatSettings(1045, FormatSettings);
  if IsFakeDateEnabled then
    MessageBox(0, PChar(Format('Using fake date "%s" from file "FakeDate.txt"', [DateTimeToStr(GetFakeDateTime, FormatSettings)])), 'Information', MB_ICONASTERISK or MB_OK);
end;

{ TRTDateProvider }

var
  _Instance: TRTDateProvider = nil;

{ Protected declarations }

class procedure TRTDateProvider.Initialize;
begin
  _Instance := TRTDateProvider.Create;
end;

class procedure TRTDateProvider.Shutdown;
begin
  FreeAndNil(_Instance);
end;

{ Public declarations }

class function TRTDateProvider.Instance: TRTDateProvider;
begin
  Result := _Instance;
end;

constructor TRTDateProvider.Create;
begin
  inherited Create;
  Configuration := TRTDateProviderConfiguration.Create;
end;

destructor TRTDateProvider.Destroy;
begin
  Configuration := nil;
  inherited Destroy;
end;

function TRTDateProvider.Now: TDateTime;
begin
  if Configuration.IsFakeDateEnabled then
    Result := Configuration.GetFakeDateTime
  else
    Result := SysUtils.Now;
end;

function TRTDateProvider.Date: TDateTime;
begin
  if Configuration.IsFakeDateEnabled then
    Result := Trunc(Configuration.GetFakeDateTime)
  else
    Result := SysUtils.Date;
end;

initialization
  TRTDateProvider.Initialize;

finalization
  TRTDateProvider.Shutdown;

end.

