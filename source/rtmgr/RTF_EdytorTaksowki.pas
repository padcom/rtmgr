unit RTF_EdytorTaksowki;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, JvUIB, JvUIBLib;

type
  TFrmEdytorTaksowki = class(TForm)
    GbxDaneOgolne: TGroupBox;
    LblNazwa: TLabel;
    EdtNazwa: TEdit;
    LblNumerBoczny: TLabel;
    EdtNumerBoczny: TEdit;
    LblNumerWywolawczy: TLabel;
    EdtNumerWywolawczy: TEdit;
    BtnOk: TButton;
    BtnAnuluj: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdtNumerBocznyKeyPress(Sender: TObject; var Key: Char);
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

{$R *.DFM}

{ TFrmEdytorTaksowki }

{ Private declarations }

procedure TFrmEdytorTaksowki.SetData(Fields: TSQLResult);
begin
  FId := Fields.ByNameAsInteger['ID'];
  EdtNazwa.Text := Fields.ByNameAsString['NAZWA'];
  EdtNumerBoczny.Text := Fields.ByNameAsString['NRBOCZNY'];
  EdtNumerWywolawczy.Text := Fields.ByNameAsString['NRWYWOLAWCZY'];
end;

{ Public declarations }

{ Event handlers }

procedure TFrmEdytorTaksowki.FormCreate(Sender: TObject);
begin
//
end;

procedure TFrmEdytorTaksowki.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmEdytorTaksowki.FormShow(Sender: TObject);
begin
//
end;

procedure TFrmEdytorTaksowki.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
//var
//  I: Integer;
begin
  if ModalResult = mrCancel then
    Exit;

  if EdtNazwa.Text = '' then
  begin
    EdtNazwa.SetFocus;
    ShowError('Nale¿y podaæ imiê i nazwisko osoby prowazd¹cej taksówkê');
    CanClose := False;
    Exit;
  end;

  if EdtNumerBoczny.Text = '' then
  begin
    EdtNumerBoczny.SetFocus;
    ShowError('Nale¿y podaæ numer boczny taksówki');
    CanClose := False;
    Exit;
  end;

  if EdtNumerWywolawczy.Text = '' then
  begin
    EdtNumerWywolawczy.SetFocus;
    ShowError('Nale¿y podaæ numer wywo³awczy taksówki');
    CanClose := False;
    Exit;
  end;

  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('EXECUTE PROCEDURE UPDATE_TAKSOWKA %d,%s,%s,%s;', [
        FId,
        QuotedStr(EdtNazwa.Text),
        QuotedStr(EdtNumerBoczny.Text),
        QuotedStr(EdtNumerWywolawczy.Text)
      ]);
      Execute;
    finally
      Free;
    end;
end;

procedure TFrmEdytorTaksowki.EdtNumerBocznyKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then Key := #0;
end;

end.
