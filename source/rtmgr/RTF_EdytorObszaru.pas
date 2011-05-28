unit RTF_EdytorObszaru;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvUIB, JvUIBLib, StdCtrls;

type
  TFrmEdytorObszaru = class(TForm)
    GbxDaneObszaru: TGroupBox;
    EdtNazwa: TEdit;
    LblNazwa: TLabel;
    LblSkrot: TLabel;
    EdtSkrot: TEdit;
    BtnOk: TButton;
    BtnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FId: Integer;
  public
    { Public declarations }
    procedure SetData(Fields: TSQLResult);
  end;

implementation

uses
  RT_Tools, RT_SQL;

{$R *.dfm}

{ TFrmEdytorObszaru }

{ Public declarations }

procedure TFrmEdytorObszaru.SetData(Fields: TSQLResult);
begin
  FId := Fields.ByNameAsInteger['Id'];
  EdtNazwa.Text := Fields.ByNameAsString['NAZWA'];
  EdtSkrot.Text := Fields.ByNameAsString['SKROT'];
end;

{ Event handlers }

procedure TFrmEdytorObszaru.FormCreate(Sender: TObject);
begin
//
end;

procedure TFrmEdytorObszaru.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmEdytorObszaru.FormShow(Sender: TObject);
begin
//
end;

procedure TFrmEdytorObszaru.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrCancel then
    Exit;

  CanClose := False;

  if EdtSkrot.Text = '' then
  begin
    ShowError('Nale¿y podaæ skrót obszaru');
    EdtSkrot.SetFocus;
    Exit;
  end;

  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('EXECUTE PROCEDURE UPDATE_OBSZAR %d, %s, %s', [
        FId,
        QuotedStr(EdtNazwa.Text),
        QuotedStr(EdtSkrot.Text)
      ]);
      Execute;
      Transaction.Commit;
      CanClose := True;
    finally
      Free;
    end;
end;

end.

