unit RT_DateProviderTest;

interface

uses
  Windows, Classes, SysUtils, TestFramework,
  RT_DateProvider;

type
  TRTDateProviderTest = class (TTestCase, IRTDateProviderConfiguration)
  private
    FFakeDateEnabled: Boolean;
    FFakeDateTime: TDateTime;
    function IsFakeDateEnabled: Boolean;
    function GetFakeDateTime: TDateTime;
  protected
    procedure Setup; override;
    procedure Teardown; override;
  published
    procedure TestCreate;
    procedure TestNow;
    procedure TestDate;
  end;

implementation

{ TRTDateProviderTest }

{ Private declarations }

function TRTDateProviderTest.IsFakeDateEnabled: Boolean;
begin
  Result := FFakeDateEnabled;
end;

function TRTDateProviderTest.GetFakeDateTime: TDateTime;
begin
  Result := FFakeDateTime;
end;

{ Protected declarations }

procedure TRTDateProviderTest.Setup;
begin
  TRTDateProvider.Instance.Configuration := Self;
end;

procedure TRTDateProviderTest.Teardown;
begin
  TRTDateProvider.Instance.Configuration := TRTDateProviderConfiguration.Create;
end;

{ Test cases }

procedure TRTDateProviderTest.TestCreate;
begin
  CheckNotNull(TRTDateProvider.Instance);
end;

procedure TRTDateProviderTest.TestNow;
var
  Settings: TFormatSettings;
begin
  GetLocaleFormatSettings(1045, Settings);
  FFakeDateTime := StrToDateTime('2005-01-02 12:13:14.015', Settings);

  FFakeDateEnabled := False;
  CheckNotEquals(StrToDateTime('2005-01-02 12:13:14.015', Settings), TRTDateProvider.Instance.Now);
  FFakeDateEnabled := True;
  CheckEquals(StrToDateTime('2005-01-02 12:13:14.015', Settings), TRTDateProvider.Instance.Now);
end;

procedure TRTDateProviderTest.TestDate;
var
  Settings: TFormatSettings;
begin
  GetLocaleFormatSettings(1045, Settings);
  FFakeDateTime := StrToDateTime('2005-01-02 12:13:14.015', Settings);

  FFakeDateEnabled := False;
  CheckNotEquals(StrToDateTime('2005-01-02', Settings), TRTDateProvider.Instance.Date);
  FFakeDateEnabled := True;
  CheckEquals(StrToDateTime('2005-01-02', Settings), TRTDateProvider.Instance.Date);
end;

initialization
  RegisterTest(TRTDateProviderTest.Suite)

end.

