unit RT_WolaniaGenerator;

interface

uses
  Classes, SysUtils, jvuiblib;

type
  TRT_WolaniaGenerator = class (TObject)
  private
    FData: TSQLResult;
  protected
    property Data: TSQLResult read FData;
  public
    constructor Create(AData: TSQLResult);
    procedure GenerateHTML(Output: TStrings);
  end;

implementation

{ TRT_WolaniaGenerator }

constructor TRT_WolaniaGenerator.Create(AData: TSQLResult);
begin
  inherited Create;
  FData := AData;
end;

procedure TRT_WolaniaGenerator.GenerateHTML(Output: TStrings);
begin
  Output.Add('<html>');
  Output.Add('  <head>');
  Output.Add('    <META HTTP-EQUIV="Content-Type" content="text/html; charset=windows-1250">');
  Output.Add('  </head>');
  Output.Add('  <body bgcolor=white>');
  Output.Add('    <table bgcolor=black cellspacing=1 cellpadding=3 border=0>');
  Output.Add('    <tr><td nowrap><font color=white><b>OBSZAR</b></font></td><td nowrap><font color=white><b>NAZWA</b></font></td><td nowrap><font color=white><b>POCZATEK</b></font></td><td nowrap><font color=white>' + '<b>KONIEC</b></font></td><td nowrap><font color=white><b>POSTOJ1</b></font></td><td nowrap><font color=white><b>POSTOJ2</b></font></td><td nowrap><font color=white><b>POSTOJ3</b></font></td><td nowrap><font color=white><b>POSTOJ4</b></font></td><' + 'td nowrap><font color=white><b>POSTOJ5</b></font></td><td nowrap><font color=white><b>POSTOJ6</b></font></td></tr>');
  while not Data.Eof do
  begin
    Output.Add(Format('<tr bgcolor=white><td nowrap>%s</td><td nowrap>%s</td><td nowrap>%s</td><td nowrap>%s</td><td nowrap>%s</td><td nowrap>%s</td><td nowrap>%s</td><td nowrap>%s</td><td nowrap>%s</td><td nowrap>%s</td></tr>', [
      Data.ByNameAsString['OBSZAR'],
      Data.ByNameAsString['NAZWA'],
      Data.ByNameAsString['POCZATEK'],
      Data.ByNameAsString['KONIEC'],
      Data.ByNameAsString['POSTOJ1'],
      Data.ByNameAsString['POSTOJ2'],
      Data.ByNameAsString['POSTOJ3'],
      Data.ByNameAsString['POSTOJ4'],
      Data.ByNameAsString['POSTOJ5'],
      Data.ByNameAsString['POSTOJ6']
    ]));
    Data.Next;
  end;
  Output.Add('    </table>');
  Output.Add('  </body>');
  Output.Add('</html>');
end;

end.

