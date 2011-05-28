unit CaseToAreaIdGenerator;

interface

uses
  Classes, SysUtils;

type
  TCaseToAreaIdGenerator = class (TObject)
  private
    FIdForLowercaseStreet: Integer;
    FIdForUppercaseStreet: Integer;
  protected
    function IsUpperCase(S: String): Boolean;
    function GetIdForName(Name: String): Integer;
  public
    function CreateUpdateStatement(Id: Integer; Name: String): String;
    property IdForLowercaseStreet: Integer read FIdForLowercaseStreet write FIdForLowercaseStreet;
    property IdForUppercaseStreet: Integer read FIdForUppercaseStreet write FIdForUppercaseStreet;
  end;

implementation

{ TCaseToAreaIdGenerator }

{ Protected declarations }

function TCaseToAreaIdGenerator.IsUpperCase(S: String): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 1 to Length(S) do
    if S[I] in ['A'..'Z', '•','∆',' ','£','”','—','å','è','Ø'] then
    begin
      Result := True;
      Break;
    end;
end;

function TCaseToAreaIdGenerator.GetIdForName(Name: String): Integer;
begin
  if IsUpperCase(Name) then
    Result := IdForUppercaseStreet
  else
    Result := FIdForLowercaseStreet;
end;

{ Public declarations }

function TCaseToAreaIdGenerator.CreateUpdateStatement(Id: Integer; Name: String): String;
begin
  Result := Format('UPDATE ULICA SET AREAID=%d WHERE ID=%d;', [
    GetIdForName(Name),
    Id
  ]);
end;

end.

