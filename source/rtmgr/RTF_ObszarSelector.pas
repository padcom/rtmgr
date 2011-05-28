unit RTF_ObszarSelector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst,
  RT_Tools;

type
  TFrmObszarSelector = class(TForm)
    LbxObszary: TCheckListBox;
    BtnOk: TButton;
    BtnCancel: TButton;
    LblObszary: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure DisplayObszary;
    procedure SelectIds(Ids: TIdArray);
    procedure GatherSelectedIds(var Ids: TIdArray);
  public
    { Public declarations }
    class function EditIds(var Obszary: TIdArray): Boolean;
  end;

implementation

uses
  RT_SQL;

{$R *.dfm}

{ TFrmObszarSelector }

{ Private declarations }

procedure TFrmObszarSelector.DisplayObszary;
begin
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := 'SELECT NAZWA, SKROT, ID FROM OBSZAR ORDER BY NAZWA';
      Open;
      while not Eof do
      begin
        LbxObszary.Items.AddObject(Format('%s (%s)', [Fields.ByNameAsString['NAZWA'], Fields.ByNameAsString['SKROT']]), Pointer(Fields.ByNameAsInteger['ID']));
        Next;
      end;
    finally
      Free;
    end;
end;

procedure TFrmObszarSelector.SelectIds(Ids: TIdArray);
var
  I, J: Integer;
begin
  for I := 0 to LbxObszary.Items.Count - 1 do
    LbxObszary.Checked[I] := False;

  for I := 0 to LbxObszary.Items.Count - 1 do
    for J := 0 to Length(Ids) - 1 do
      if Integer(LbxObszary.Items.Objects[I]) = Ids[J] then
      begin
        LbxObszary.Checked[I] := True;
        Break;
      end;
end;

procedure TFrmObszarSelector.GatherSelectedIds(var Ids: TIdArray);
var
  I: Integer;
begin
  SetLength(Ids, 0);
  for I := 0 to LbxObszary.Items.Count - 1 do
    if LbxObszary.Checked[I] then
    begin
      SetLength(Ids, Length(Ids) + 1);
      Ids[Length(Ids) - 1] := Integer(LbxObszary.Items.Objects[I]);
    end;
end;

{ Public declarations }

class function TFrmObszarSelector.EditIds(var Obszary: TIdArray): Boolean;
begin
  with TFrmObszarSelector.Create(nil) do
    try
      DisplayObszary;
      SelectIds(Obszary);
      Result := ShowModal = mrOK;
      if Result then
        GatherSelectedIds(Obszary);
    finally
      Free;
    end;
end;

{ Event handlers}

procedure TFrmObszarSelector.FormCreate(Sender: TObject);
begin
//
end;

procedure TFrmObszarSelector.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmObszarSelector.FormShow(Sender: TObject);
begin
//
end;

procedure TFrmObszarSelector.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//
end;

end.
