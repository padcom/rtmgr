unit RT_Tools;

interface

uses
  Windows, Forms, Controls, Dialogs, SysUtils, JvUIB, StdCtrls;

type
  TDialogKind = (dkEditor, dkSelector);
  TIdArray = array of Integer;

function SelectDate: TDateTime;
function SelectTaxi: String;
function GetTaksowkaId(NrWywol: String): Integer;
function GetLabelByName(Form: TForm; Name: String): TLabel;
procedure LoadDatabase;
procedure ShowError(ErrorStr: String);
function CompareTextPL(S1, S2: String): Integer;

var
  DataPath: String = 'data';

implementation

uses
  Math, RTF_SelectDate, RTF_ListaTaksowek, RT_SQL, jvuiblib, RT_DateProvider;

function SelectDate: TDateTime;
begin
  Result := 0;
  with TFrmSelectDate.Create(nil) do
    try
      EdtDataKursow.Date := TRTDateProvider.Instance.Date;
      if ShowModal = mrOK then
        Result := EdtDataKursow.Date
      else
        Exit;
    finally
      Free;
    end;
end;

function SelectTaxi: String;
begin
  Result := '';
  with TFrmListaTaksowek.Create(nil) do
    try
      SetupAsSelector;
      if ShowModal = mrOK then
        Result := LbxListaTaksowek.Items[LbxListaTaksowek.ItemIndex]
      else
        Exit;
    finally
      Free;
    end;
end;

function GetTaksowkaId(NrWywol: String): Integer;
begin
  Result := 0;
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT ID FROM TAKSOWKA WHERE NRWYWOLAWCZY=%s', [
        QuotedStr(NrWywol)
      ]);
      Open;
      if not Eof then
        Result := Fields.ByNameAsInteger['ID'];
      Close;
    finally
      Free;
    end;
end;

function GetLabelByName(Form: TForm; Name: String): TLabel;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Form.ComponentCount - 1 do
    if Form.Components[I].Name = Name then
    begin
      Result := Form.Components[I] as TLabel;
      Break;
    end;
end;

procedure LoadDatabase;
begin
end;

procedure ShowError(ErrorStr: String);
begin
  Application.MessageBox(PChar(ErrorStr), 'B³¹d', MB_ICONERROR or MB_OK);
end;

function CompareTextPL(S1, S2: String): Integer;
const
  CHARS = 'abcdefghijklmnopqrstuvwxyz¹æê³ñóœŸ¿';
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Min(Length(S1), Length(S2)) do
    if Pos(S1[I], CHARS) < Pos(S2[I], CHARS) then
    begin
      Result := -1;
      Break
    end
    else if Pos(S1[I], CHARS) > Pos(S2[I], CHARS) then
    begin
      Result := 1;
      Break;
    end;
end;

end.

