unit FormDrzewoPostojow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, JvUIB, JvUIBLib;

type
  TFrmDrzewoPostojow = class(TForm)
    TrvPostoje: TTreeView;
    BtnZamknij: TBitBtn;
    EdtZnajdz: TEdit;
    LblZnajdz: TLabel;
    BtnZnajdz: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnZamknijClick(Sender: TObject);
    procedure BtnZnajdzClick(Sender: TObject);
  private
    { Private declarations }
    procedure AssignLanguage;
    procedure DisplayUlice;
    procedure DisplayPostoje(Root: TTreeNode; UlicaId: Integer);
  public
    { Public declarations }
  end;

implementation

uses
  RT_SQL;

{$R *.DFM}

{ TFrmDrzewoPostojow }

{ Private declarations }

procedure TFrmDrzewoPostojow.AssignLanguage;
begin
  Caption := '';
end;

procedure TFrmDrzewoPostojow.DisplayUlice;
var
  Node: TTreeNode;
  S: String;
begin
  TrvPostoje.Items.BeginUpdate;
  try
    TrvPostoje.Items.Clear;
    with TSQL.Instance.CreateQuery do
      try
        SQL.Text := 'SELECT ID,NAZWA,POCZATEK,KONIEC FROM ULICA ORDER BY NAZWA';
        Open;
        while not Eof do
        begin
          S := Format('%s od %s do %s', [
            Fields.ByNameAsString['NAZWA'],
            Fields.ByNameAsString['POCZATEK'],
            Fields.ByNameAsString['KONIEC']
          ]);
          if Fields.ByNameAsString['KONIEC'] = '' then
            S := S + 'koñca';
          Node := TrvPostoje.Items.Add(nil, S);
          DisplayPostoje(Node, Fields.ByNameAsInteger['ID']);
          Next;
        end;
      finally
        Free;
      end;
  finally
    TrvPostoje.Items.EndUpdate;
  end;
end;

procedure TFrmDrzewoPostojow.DisplayPostoje(Root: TTreeNode; UlicaId: Integer);
begin
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT POSTOJ.NAZWA FROM POSTOJNAULICY INNER JOIN POSTOJ ON (POSTOJNAULICY.POSTOJID = POSTOJ.ID) WHERE POSTOJNAULICY.ULICAID=%d ORDER BY POSTOJNAULICY.INDEKS;', [
        UlicaId
      ]);
      Open;
      while not Eof do
      begin
        TrvPostoje.Items.AddChild(Root, Fields.ByNameAsString['NAZWA']);
        Next;
      end;
    finally
      Free;
    end;
end;

{ Public declarations }

procedure TFrmDrzewoPostojow.FormCreate(Sender: TObject);
begin
  AssignLanguage;
end;

procedure TFrmDrzewoPostojow.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmDrzewoPostojow.FormShow(Sender: TObject);
begin
  DisplayUlice;
  TrvPostoje.Items.EndUpdate;
end;

procedure TFrmDrzewoPostojow.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//
end;

procedure TFrmDrzewoPostojow.BtnZamknijClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmDrzewoPostojow.BtnZnajdzClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to TrvPostoje.Items.Count - 1 do
  begin
    if AnsiCompareText(Copy(TrvPostoje.Items[I].Text, 1, Length(EdtZnajdz.Text)), EdtZnajdz.Text) = 0 then
    begin
      TrvPostoje.Selected := TrvPostoje.Items[I];
      TrvPostoje.SetFocus;
      Break;
    end;
  end;
end;

end.
