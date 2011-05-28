unit Options;

interface

uses
  Classes, SysUtils, 
  PxCommandLine, PxSettings;

type
  TOptions = class (TPxCommandLineParser)
  private
    function GetHelp: Boolean;
    function GetQuiet: Boolean;
    function GetDataFolder: String;
    function GetOutputFile: String;
  protected
    class procedure Initialize;
    class procedure Shutdown;
    procedure CreateOptions; override;
    procedure AfterParseOptions; override;
  public
    class function Instance: TOptions;
    property Help: Boolean read GetHelp;
    property Quiet: Boolean read GetQuiet;
    property DataFolder: String read GetDataFolder;
    property OutputFile: String read GetOutputFile;
  end;

implementation

{ TOptions }

{ Private declarations }

function TOptions.GetHelp: Boolean;
begin
  Result := ByName['help'].Value;
end;

function TOptions.GetQuiet: Boolean;
begin
  Result := ByName['quiet'].Value;
end;

function TOptions.GetDataFolder: String;
begin
  Result := ByName['data-folder'].Value;
  if Result <> '' then
    Result := IncludeTrailingPathDelimiter(Result);
end;

function TOptions.GetOutputFile: String;
begin
  Result := ByName['output-file'].Value;
end;

{ Protected declarations }

var
  _Instance: TOptions = nil;

class procedure TOptions.Initialize;
begin
  _Instance := TOptions.Create;
  _Instance.Parse;
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
  with AddOption(TPxStringOption.Create('i', 'data-folder')) do
  begin
    Explanation := 'Data folder to read data from';
    Value := IniFile.ReadString('settings', LongForm, 'data');
  end;
  with AddOption(TPxStringOption.Create('o', 'output-file')) do
  begin
    Explanation := 'Output file to store produced SQL statements';
    Value := IniFile.ReadString('settings', LongForm, 'rtmgr.sql');
  end;
end;

procedure TOptions.AfterParseOptions; 
begin
  if not Quiet then
  begin
    Writeln(Format('%s - binary data from version 3.x to SQL converter', [
      ExtractFileName(ParamStr(0))
    ]));
    Writeln;
  end;
  if DataFolder = '' then
  begin
    Writeln('Error: no data folder specified!');
    Writeln;
    Halt(1);
  end;
  if OutputFile = '' then
  begin
    Writeln('Error: no output file specified!');
    Writeln;
    Halt(2);
  end;
end;

{ Public declarations }

class function TOptions.Instance: TOptions;
begin
  Result := _Instance;
end;

initialization
  TOptions.Initialize;

finalization
  TOptions.Shutdown;

end.
