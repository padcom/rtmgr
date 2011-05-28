unit RTF_EdytorKlienta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, JvUIB, JvUIBLib;

type
  TFrmEdytorKlienta = class(TForm)
    GbxDaneKlienta: TGroupBox;
    EdtUlica: TEdit;
    LblUlica: TLabel;
    EdtNumerDomu: TEdit;
    LblNumerDomu: TLabel;
    LblPrzez: TLabel;
    EdtNumerMieszk: TEdit;
    LblNumerMieszk: TLabel;
    BtnSelectUlica: TSpeedButton;
    EdtTelefon: TEdit;
    LblTelefon: TLabel;
    BtnOK: TButton;
    BtnAnuluj: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnSelectUlicaClick(Sender: TObject);
    procedure EdtUlicaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FId: Integer;
  public
    { Public declarations }
    procedure SetData(Fields: TSQLResult);
  end;

implementation

uses
  RTF_ListaUlic, RT_Tools, RT_SQL;

{$R *.DFM}

{ TFrmEdytorKlienta }

{ Private declarations }

{ Public declarations }

procedure TFrmEdytorKlienta.SetData(Fields: TSQLResult);
begin
  FId := Fields.ByNameAsInteger['Id'];
  EdtUlica.Text := Fields.ByNameAsString['Ulica'];
  EdtNumerDomu.Text := Fields.ByNameAsString['Dom'];
  EdtNumerMieszk.Text := Fields.ByNameAsString['MIESZKANIE'];
  EdtTelefon.Text := Fields.ByNameAsString['TELEFON'];
end;

{ Event handlers }

procedure TFrmEdytorKlienta.FormCreate(Sender: TObject);
begin
  BtnSelectUlica.Glyph.LoadFromResourceName(hInstance, 'BTNPULLDOWN');
end;

procedure TFrmEdytorKlienta.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmEdytorKlienta.FormShow(Sender: TObject);
begin
//
end;

procedure TFrmEdytorKlienta.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrCancel then
    Exit;

  CanClose := False;

  if EdtUlica.Text = '' then
  begin
    ShowError('Nale¿y podaæ ulicê lub wybraæ jedn¹ z dostêpnych z menu za pomoc¹ klawisza F2');
    EdtUlica.SetFocus;
    Exit;
  end;

  if EdtTelefon.Text = '' then
  begin
    ShowError('Nale¿y podaæ telefon klienta');
    EdtTelefon.SetFocus;
    Exit;
  end;

  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('EXECUTE PROCEDURE UPDATE_KLIENT %d, %s, %s, %s, %s;', [
        FId,
        QuotedStr(EdtUlica.Text),
        QuotedStr(EdtNumerDomu.Text),
        QuotedStr(EdtNumerMieszk.Text),
        QuotedStr(EdtTelefon.Text)
      ]);
      Execute;
      Transaction.Commit;
      CanClose := True;
    finally
      Free;
    end;
end;

procedure TFrmEdytorKlienta.BtnSelectUlicaClick(Sender: TObject);
begin
  with TFrmListaUlic.Create(nil) do
    try
      SetupAsSelector;
      if ShowModal = mrOK then
      begin
//        Street := LbxListaUlic.Items.Objects[LbxListaUlic.ItemIndex] as TStreet;
        EdtUlica.Text := LbxListaUlic.Items[LbxListaUlic.ItemIndex];
        EdtUlica.SelectAll;
      end;
    finally
      Free;
    end;
end;

procedure TFrmEdytorKlienta.EdtUlicaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
  begin
    BtnSelectUlicaClick(Sender);
    Key := 0;
  end;
end;

end.
