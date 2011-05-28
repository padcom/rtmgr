unit RTF_EdytorKursu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Contnrs,
  Mask, StdCtrls, Buttons, ExtCtrls, RxPickDate, JvUIB, JvUIBLib,
  RT_Tools;

const
  WM_SETFOCUSTOTAKSOWKA = WM_USER + 1;
    
type
  TFrmEdytorKursu = class(TForm)
    BtnOK: TButton;
    BtnAnuluj: TButton;
    GbxDanePodstawowe: TGroupBox;
    LblUlica: TLabel;
    EdtUlica: TEdit;
    BtnSelectUlica: TSpeedButton;
    EdtDom: TEdit;
    EdtMieszkanie: TEdit;
    LblMieszkanie: TLabel;
    LblDom: TLabel;
    EdtTaksowka: TEdit;
    LblTaksowka: TLabel;
    BtnSelectTaksowka: TSpeedButton;
    LblDomMiszkDivider: TLabel;
    GbxPostoje: TGroupBox;
    LblPostoj1Desc: TLabel;
    LblPostoj1: TLabel;
    LblPostoj2Desc: TLabel;
    LblPostoj2: TLabel;
    LblPostoj3Desc: TLabel;
    LblPostoj3: TLabel;
    LblPostoj4Desc: TLabel;
    LblPostoj4: TLabel;
    LblPostoj5Desc: TLabel;
    LblPostoj5: TLabel;
    LblPostoj6Desc: TLabel;
    LblPostoj6: TLabel;
    LblPostoj7Desc: TLabel;
    LblPostoj7: TLabel;
    LblPostoj8Desc: TLabel;
    LblPostoj8: TLabel;
    LblDataPrzyjeciaKursu: TLabel;
    LblDataPrzyjeciaKursuDesc: TLabel;
    PnlPrzyjecieKursu: TPanel;
    LblPostoj: TLabel;
    GbxOpis: TGroupBox;
    EdtOpis: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnSelectUlicaClick(Sender: TObject);
    procedure EdtUlicaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtUlicaChange(Sender: TObject);
    procedure BtnSelectTaksowkaClick(Sender: TObject);
    procedure EdtTaksowkaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtTaksowkaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FId: Integer;
    FFlags: Integer;
    FUlicaId: Integer;
    FObszarId: Integer;
    FPrzyjecie: TDateTime;
    FUpdateMiniManager: Boolean;
    DisableUpdates: Boolean;
    FKursZPudla: Integer;
    function GetTaksowkaId(NrWywol: String): Integer;
    function GetTaksowkaNrWywol(Id: Integer): String;
    function GetObszarId(UlicaId: Integer): Integer;
    function ValidateTaksowka(NrWywol: String): Boolean;
    procedure SetUlicaId(Id: Integer);
    procedure WMSetFocusToTaksowka(var Msg: TMessage); message WM_SETFOCUSTOTAKSOWKA;
  public
    { Public declarations }
    function ServingObszar: Boolean;
    procedure SetData(Fields: TSQLResult);
    procedure DisplayPostoje;
    procedure UpdateTaksowka;
    property UlicaId: Integer read FUlicaId write SetUlicaId;
    property ObszarId: Integer read FObszarId write FObszarId;
    property UpdateMiniManager: Boolean read FUpdateMiniManager write FUpdateMiniManager;
  end;

implementation

uses
  Math, RTF_ListaUlic, RTF_ListaTaksowek, RT_SQL, Variants,
  RTF_MiniManager, RT_Base, RTF_Main, DateUtils;

{$R *.DFM}

{ TFrmEdytorKursu }

{ Private declarations }

function TFrmEdytorKursu.GetTaksowkaId(NrWywol: String): Integer;
begin
  Result := -1;
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT ID FROM TAKSOWKA WHERE NRWYWOLAWCZY=%s', [
        QuotedStr(NrWywol)
      ]);
      Open;
      if not Eof then
        Result := Fields.AsInteger[0];
      Close;
    finally
      Free;
    end;
end;

function TFrmEdytorKursu.GetTaksowkaNrWywol(Id: Integer): String;
begin
  Result := '';
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT NRWYWOLAWCZY FROM TAKSOWKA WHERE ID=%d', [
        Id
      ]);
      Open;
      if not Eof then
        Result := Fields.AsString[0];
      Close;
    finally
      Free;
    end;
end;

function TFrmEdytorKursu.GetObszarId(UlicaId: Integer): Integer;
begin
  Result := 0;
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT OBSZARID FROM ULICA WHERE ID=%d', [
        UlicaId
      ]);
      Open;
      if not Eof then
        Result := Fields.AsInteger[0];
      Close;
    finally
      Free;
    end;
end;

function TFrmEdytorKursu.ValidateTaksowka(NrWywol: String): Boolean;
begin
  Result := GetTaksowkaId(NrWywol) <> -1;
end;

function TFrmEdytorKursu.ServingObszar: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Length(FrmMain.Obszary) - 1 do
    if FrmMain.Obszary[I] = FObszarId then
    begin
      Result := True;
      Break;
    end;
end;

procedure TFrmEdytorKursu.SetUlicaId(Id: Integer);
begin
  if FUlicaId <> Id then
  begin
    FUlicaId := Id;
    FObszarId := GetObszarId(Id);
  end;
end;

procedure TFrmEdytorKursu.WMSetFocusToTaksowka(var Msg: TMessage);
begin
  EdtTaksowka.SetFocus;
end;

{ Public declarations }

procedure TFrmEdytorKursu.SetData(Fields: TSQLResult);
begin
  DisableUpdates := True;
  FId := Fields.ByNameAsInteger['ID'];
  FUlicaId := Fields.ByNameAsInteger['ULICAID'];
  FObszarId := GetObszarId(UlicaId);
  FPrzyjecie := Fields.ByNameAsDateTime['PRZYJECIE'];

  EdtUlica.Text := Fields.ByNameAsString['ULICA'];
  EdtDom.Text := Fields.ByNameAsString['DOM'];
  EdtMieszkanie.Text := Fields.ByNameAsString['MIESZKANIE'];
  EdtTaksowka.Text := GetTaksowkaNrWywol(Fields.ByNameAsInteger['TAKSOWKAID']);
  LblDataPrzyjeciaKursu.Caption := FormatDateTime('YYYY-MM-DD, HH:MM', Fields.ByNameAsDateTime['PRZYJECIE']);

  EdtOpis.Text := Fields.ByNameAsString['OPIS'];

  DisableUpdates := False;
end;

procedure TFrmEdytorKursu.DisplayPostoje;
var
  I: Integer;
begin
  for I := 1 to 8 do
    GetLabelByName(Self, Format('LblPostoj%d', [I])).Caption := '';
  if FUlicaId > 0 then
    with TSQL.Instance.CreatePostojeNaUlicyQuery(FUlicaId) do
      try
        Open;
        I := 0;
        while (I < 8) and (not Eof) do
        begin
          GetLabelByName(Self, Format('LblPostoj%d', [I + 1])).Caption := Fields.ByNameAsString['NAZWA'];
          Inc(I);
          Next;
        end;
      finally
        Free;
      end;
end;

type
  TTaksowka = class (TObject)
  private
    FHasPudlo: Boolean;
    function GetHasPudlo: Boolean;
  public
    PudloId: Integer;
    Id: Integer;
    NrWywolawczy: String;
    Postoj: String;
    Index: Integer;
    IndeksPostoju: Integer;
    procedure GatherHasPudlo;
    property HasPudlo: Boolean read GetHasPudlo write FHasPudlo;
  end;

  TTaksowkaList = class (TObjectList)
  private
    function GetItem(Index: Integer): TTaksowka;
  public
    constructor Create;
    property Items[Index: Integer]: TTaksowka read GetItem; default;
  end;

{ TTaksowka }

function TTaksowka.GetHasPudlo: Boolean;
begin
  Result := FHasPudlo and (Index > 0) and (IndeksPostoju <= 4);
end;

procedure TTaksowka.GatherHasPudlo;
var
  Timestamp1, Timestamp2: TDateTime;
begin
  HasPudlo := False;
  Timestamp1 := Now;
  Timestamp2 := IncHour(Timestamp1, -12);
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT Id, FLAGS FROM KURS WHERE TaksowkaId = %d and Przyjecie BETWEEN %s and %s', [
        Id,
        QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN', Timestamp2)),
        QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN', Timestamp1))
      ]);
      Open;
      while not Eof do
      begin
        if (Fields.ByNameAsInteger['Flags'] and (kfPudlo or kfWykozystane) = kfPudlo) then
        begin
          HasPudlo := True;
          PudloId := Fields.ByNameAsInteger['Id'];
          Break;
        end;
        Next;
      end;
      Close;
    finally
      Free;
    end;
end;

{ TTaksowkaList }

{ Private declarations }

function TTaksowkaList.GetItem(Index: Integer): TTaksowka;
begin
  Result := TObject(Get(Index)) as TTaksowka;
end;

{ Public declarations }

constructor TTaksowkaList.Create;
begin
  inherited Create(True);
end;

function CompareTaksowkaZPudlami(P1, P2: Pointer): Integer;
var
  T1: TTaksowka absolute P1;
  T2: TTaksowka absolute P2;
begin
  if T1.HasPudlo and (not T2.HasPudlo) then
    Result := -1
  else if T2.HasPudlo and (not T1.HasPudlo) then
    Result := 1
  else if T1.Index < T2.Index then
    Result := -1
  else if T1.Index > T2.Index then
    Result := 1
  else
    Result := 0;
end;

procedure TFrmEdytorKursu.UpdateTaksowka;
var
  Taksowka: TTaksowka;
  Taksowki: TTaksowkaList;
  I, Index: Integer;
begin
  Taksowki := TTaksowkaList.Create;
  try
    // 123 -> 124 -> 125 -> 123 -> ...
    with TSQL.Instance.CreateQuery do
      try
        SQL.Text := Format('SELECT TAKSOWKA, NRWYWOLAWCZY, NAZWA, INDEKSPOSTOJU FROM TAKSOWKANAULICY WHERE ID=%d', [FUlicaId]);
        Open;
        while not Eof do
        begin
          Taksowka := TTaksowka.Create;
          Taksowka.Id := Fields.ByNameAsInteger['TAKSOWKA'];
          Taksowka.NrWywolawczy := Fields.ByNameAsString['NRWYWOLAWCZY'];
          Taksowka.Postoj := Fields.ByNameAsString['NAZWA'];
          Taksowka.IndeksPostoju := Fields.ByNameAsInteger['INDEKSPOSTOJU'];
          Taksowka.GatherHasPudlo;
          Taksowka.Index := Taksowki.Count;
          Taksowki.Add(Taksowka);
          Next;
        end;
        Close;
        Taksowki.Sort(@CompareTaksowkaZPudlami);
        if Taksowki.Count > 0 then
        begin
          Index := -1;
          for I := 0 to Taksowki.Count - 1 do
            if Taksowki[I].NrWywolawczy = EdtTaksowka.Text then
            begin
              Index := I;
              Break;
            end;
          if (Index <> -1) and (Index < Taksowki.Count - 1) then
            Index := Index + 1
          else
            Index := 0;
          EdtTaksowka.Text := Taksowki[Index].NrWywolawczy;
          LblPostoj.Caption := Taksowki[Index].Postoj;
          if Taksowki[Index].HasPudlo then
          begin
            FKursZPudla := Taksowki[Index].PudloId;
            EdtTaksowka.Color := clGreen;
            EdtTaksowka.Font.Color := clWhite;
          end
          else
          begin
            FKursZPudla := -1;
            EdtTaksowka.Color := clWindow;
            EdtTaksowka.Font.Color := clWindowText;
          end;
        end;
      finally
        Free;
      end;
  finally
    Taksowki.Free;
  end;
end;

{ Event handlers }

procedure TFrmEdytorKursu.FormCreate(Sender: TObject);
begin
  BtnSelectUlica.Glyph.LoadFromResourceName(hInstance, 'BTNPULLDOWN');
  BtnSelectTaksowka.Glyph.LoadFromResourceName(hInstance, 'BTNPULLDOWN');
  EdtUlica.MaxLength := 80;
  EdtDom.MaxLength := 10;
  EdtMieszkanie.MaxLength := 10;
  EdtTaksowka.MaxLength := 3;
  EdtOpis.MaxLength := 16384;
  LblDataPrzyjeciaKursu.Caption := '';
  FUpdateMiniManager := True;
  if Assigned(FrmMiniManager) and FrmMiniManager.Active then
    Position := poDesigned;
end;

procedure TFrmEdytorKursu.FormDestroy(Sender: TObject);
begin
//
end;

procedure TFrmEdytorKursu.FormShow(Sender: TObject);
begin
  DisableUpdates := True;
  try
    if FPrzyjecie = 0 then
    begin
      FPrzyjecie := Now;
      LblDataPrzyjeciaKursu.Caption := FormatDateTime('YYYY-MM-DD, HH:MM', FPrzyjecie);
    end;

    DisplayPostoje;
    ActiveControl := EdtUlica;

    if Assigned(FrmMiniManager) and FrmMiniManager.Active then
    begin
      Left := FrmMiniManager.Left;
      Top := FrmMiniManager.Top + 81;
    end;
  finally
    DisableUpdates := False;
  end;
end;

procedure TFrmEdytorKursu.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  S: String;
  Flags: Integer;
begin
  if ModalResult = mrCancel then Exit;

  CanClose := False;

  // Sprawdzenie, czy podana zosta³a wprowadzona ulica
  if EdtUlica.Text = '' then
  begin
    CanClose := False;
    ShowError('Nale¿y podaæ nazwê ulicy lub wybraæ j¹ z menu za pomoc¹ klawisza F2');
    EdtUlica.SetFocus;
    Exit;
  end;

  // Sprawdzenie, czy mia³a zostaæ podana i czy zosta³a podana poprawna taksówka
  if (EdtTaksowka.Text = '') and ServingObszar then
    CanClose := False
  else if (EdtTaksowka.Text <> '') and (not ValidateTaksowka(EdtTaksowka.Text)) then
  begin
    ShowError('Nale¿y podaæ numer taksówki lub wybraæ jedn¹ z dostêpnych taksówek z menu za pomoc¹ klawisza F2');
    EdtTaksowka.SetFocus;
    EdtTaksowka.SelectAll;
    Exit;
  end
  else if (FFlags and kfWyslany = 0) and UpdateMiniManager and (EdtTaksowka.Text <> '') then
  begin
    FFlags := FFlags or kfWyslany;
    try
      FrmMiniManager.ZdejmijTaksowkeZPostoju(EdtTaksowka.Text, False);
    except
    end;
  end;

  if FKursZPudla <> -1 then
    with TSQL.Instance.CreateQuery do
      try
        SQL.Text := Format('SELECT FLAGS FROM KURS WHERE Id = %d', [FKursZPudla]);
        Open;
        Flags := Fields.ByNameAsInteger['FLAGS'] or kfWykozystane;
        Close;
        SQL.Text := Format('UPDATE KURS SET FLAGS = %d WHERE Id=%d', [Flags, FKursZPudla]);
        Execute;
        Transaction.Commit;
      finally
        Free;
      end;

  with TSQL.Instance.CreateQuery do
    try
      S := Format('EXECUTE PROCEDURE UPDATE_KURS %d, %d, %d, %s, %s, %s, %d, %s, %s', [
        FId,
        0,
        FUlicaId,
        QuotedStr(EdtUlica.Text),
        QuotedStr(EdtDom.Text),
        QuotedStr(EdtMieszkanie.Text),
        GetTaksowkaId(EdtTaksowka.Text),
        QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN', FPrzyjecie)),
        QuotedStr(EdtOpis.Text)
      ]);
      SQL.Text := S;
      Execute;
      Transaction.Commit;
      CanClose := True;
    finally
      Free;
    end;
end;

procedure TFrmEdytorKursu.BtnSelectUlicaClick(Sender: TObject);
begin
  with TFrmListaUlic.Create(nil) do
  try
    SetupAsSelector;
    if ShowModal = mrOK then
    begin
      EdtUlica.Text := LbxListaUlic.Items[LbxListaUlic.ItemIndex];
      EdtUlica.SelectAll;
      FUlicaId := SelectedUlica.ByNameAsInteger['ID'];
      DisplayPostoje;
      if ServingObszar then
        UpdateTaksowka;
    end;
  finally
    Free;
  end;
end;

procedure TFrmEdytorKursu.EdtUlicaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
  begin
    BtnSelectUlicaClick(Sender);
    Key := 0;
  end;
end;

procedure TFrmEdytorKursu.EdtUlicaChange(Sender: TObject);
begin
  if not DisableUpdates then
  begin
    FUlicaId := 0;
    LblPostoj1.Caption := '';
    LblPostoj2.Caption := '';
    LblPostoj3.Caption := '';
    LblPostoj4.Caption := '';
    LblPostoj5.Caption := '';
    LblPostoj6.Caption := '';
    LblPostoj7.Caption := '';
    LblPostoj8.Caption := '';
  end;
end;

procedure TFrmEdytorKursu.BtnSelectTaksowkaClick(Sender: TObject);
begin
  with TFrmListaTaksowek.Create(nil) do
    try
      SetupAsSelector;
      if ShowModal = mrOK then
      begin
        EdtTaksowka.Text := LbxListaTaksowek.Items[LbxListaTaksowek.ItemIndex];
        EdtTaksowka.SelectAll;
      end;
    finally
      Free;
    end;
end;

procedure TFrmEdytorKursu.EdtTaksowkaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
  begin
    BtnSelectTaksowkaClick(Sender);
    Key := 0;
  end;

  if Key = VK_F1 then
    UpdateTaksowka;
end;

procedure TFrmEdytorKursu.EdtTaksowkaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then Key := #0;
end;

procedure TFrmEdytorKursu.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F5: FrmMiniManager.PostawTaksowkeNaPostoju;
    Vk_F6: FrmMiniManager.ZdejmijtaksowkeZPostoju;
  end;
end;

end.

