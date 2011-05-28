unit RTF_ChangePassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmChangePassword = class(TForm)
    EdtPassword1: TEdit;
    EdtPassword2: TEdit;
    LblPassword1: TLabel;
    LblPassword2: TLabel;
    BtnOK: TButton;
    BtnCancel: TButton;
    TmrUpdate: TTimer;
    procedure TmrUpdateTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetNewPassword(out NewPassword: String): Boolean;

implementation

{$R *.dfm}

procedure TFrmChangePassword.TmrUpdateTimer(Sender: TObject);
begin
  BtnOK.Enabled :=
    (EdtPassword1.Text <> '') and
    (EdtPassword1.Text = EdtPassword2.Text);
end;

{ *** }

function GetNewPassword(out NewPassword: String): Boolean;
begin
  Result := False;
  NewPassword := Unassigned;
  with TFrmChangePassword.Create(nil) do
    try
      if ShowModal = mrOK then
      begin
        NewPassword := EdtPassword1.Text;
        Result := True;
      end;
    finally
      Free;
    end;
end;

end.
