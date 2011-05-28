unit RTF_InputPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmInputPassword = class(TForm)
    EdtPassword: TEdit;
    LblPassword: TLabel;
    BtnOK: TButton;
    BtnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetPassword(out Password: String): Boolean;

implementation

{$R *.dfm}

function GetPassword(out Password: String): Boolean;
begin
  with TFrmInputPassword.Create(Nil) do
    try
      if ShowModal = mrOK then
      begin
        Password := EdtPassword.Text;
        Result := True;
      end
      else
        Result := False;
    finally
      Free;
    end;
end;

end.

