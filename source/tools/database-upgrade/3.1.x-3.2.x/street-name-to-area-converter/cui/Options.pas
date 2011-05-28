unit Options;

interface

uses
  Classes, SysUtils, PxCommandLine, PxSettings;

type
  TOptions = class (TPxCommandLineParser)
  private
    function GetHelp: Boolean;
    function GetQuiet: Boolean;
    function GetDatabase: String;
    function GetIdForUpperCase: Integer;
    function GetIdForLowerCase: Integer;
  protected
    class procedure Initialize;
    class procedure Shutdown;
    procedure CreateOptions; override;
    procedure AfterParseOptions; override;
  public
    class function Instance: TOptions;
    property Help: Boolean read GetHelp;
    property Quiet: Boolean read GetQuiet;
    property Database: String read GetDatabase;
    property IdForUpperCase: Integer read GetIdForUpperCase;
    property IdForLowerCase: Integer read GetIdForLowerCase;
  end;

implementation

{ TOptions }

var
  _Instance: TOptions = nil;

{ Private declarations }

function TOptions.GetHelp: Boolean;
begin
  Result := ByName['help'].Value;
end;

function TOptions.GetQuiet: Boolean;
begin
  Result := ByName['quiet'].Value;
end;

function TOptions.GetDatabase: String;
begin
  Result := ByName['database'].Value;
end;

function TOptions.GetIdForUpperCase: Integer;
begin
  Result := ByName['uppercase-id'].Value;
end;

function TOptions.GetIdForLowerCase: Integer;
begin
  Result := ByName['lowercase-id'].Value;
end;

{ Protected declarations }

class procedure TOptions.Initialize;
begin
  _Instance := TOptions.Create;
  _Instance.ParseOptions;
end;

class procedure TOptions.Shutdown;
begin
  FreeAndNil(_Instance);
end;

procedure TOptions.CreateOptions; 
begin
  with AddOption(TPxBoolOption.Create('h', 'help')) do
    Explanation := 'Show help';
  with AddOption(TPxBoolOption.Create('q', 'quiet')) do
    Explanation := 'Be quiet';
  with AddOption(TPxStringOption.Create('d', 'database')) do
  begin
    Value := IniFile.ReadString('settings', LongForm, '127.0.0.1:RTMGR');
    Explanation := Format('Database to connect to (default: %s)', [Value]);
  end;
  with AddOption(TPxIntegerOption.Create('l', 'lowercase-id')) do
  begin
    Value := IniFile.ReadInteger('settings', LongForm, 10001);
    Explanation := Format('Area id for lowercase street names (default: %s)', [Value]);
  end;
  with AddOption(TPxIntegerOption.Create('u', 'uppercase-id')) do
  begin
    Value := IniFile.ReadInteger('settings', LongForm, 10002);
    Explanation := Format('Area id for uppercase street names (default: %s)', [Value]);
  end;
end;

procedure TOptions.AfterParseOptions; 
begin
  if not Quiet then
  begin
    Writeln(Format('%s - assign street names according to name character case', [ExtractFileName(ParamStr(0))]));
    Writeln;
  end;
  if Help then
  begin
    WriteExplanations;
    Halt(0);
  end;
end;

{ Public declarations }

class function TOptions.Instance: TOptions;
begin
  Result := _Instance;
end;

initialization
  TOptions.Initialize;

end.
