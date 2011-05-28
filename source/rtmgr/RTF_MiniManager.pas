unit RTF_MiniManager;

{.$DEFINE SORT_POSTOJE_BY_ILOSC_TAKSOWEK}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, StdCtrls, Menus, IniFiles, JvUIB, JvUIBLib, Contnrs,
  RT_Tools, RT_Updater;

type
  TPostojRec = record
    Id: Integer;
    Nazwa: String;
    IloscTaksowek: Integer;
    Taksowki: array[0..20] of record
      Id: Integer;
      NrWywol: String;
    end;
  end;

  TFrmMiniManager = class(TForm)
    PnlListaUlic: TPanel;
    PnlPostoje: TPanel;
    Splitter1: TSplitter;
    GrdPostoje: TDrawGrid;
    LblPostoje: TLabel;
    MainMenu1: TMainMenu;
    Postawtaks1: TMenuItem;
    ZdejmijtakswkzpostojuF21: TMenuItem;
    Gwnacz1: TMenuItem;
    TmrUpdater: TTimer;
    GrdAktywneTaksowki: TDrawGrid;
    LblAktywneTaksowki: TLabel;
    PnlListaUlicZPostojami: TPanel;
    PnlListaKursowDoWyslania: TPanel;
    LblPostoj1Desc: TLabel;
    LblPostoj1: TLabel;
    LblPostoj2: TLabel;
    LblPostoj2Desc: TLabel;
    LblPostoj3Desc: TLabel;
    LblPostoj3: TLabel;
    LblPostoj4: TLabel;
    LblPostoj4Desc: TLabel;
    LblPostoj5Desc: TLabel;
    LblPostoj5: TLabel;
    LblPostoj6: TLabel;
    LblPostoj6Desc: TLabel;
    LblPostoj7Desc: TLabel;
    LblPostoj7: TLabel;
    LblPostoj8: TLabel;
    LblPostoj8Desc: TLabel;
    LbxUlice: TListBox;
    EdtQuickSearch: TEdit;
    LblQuickSearch: TLabel;
    LbxListaKursowDoWyslania: TListBox;
    LblKursyDoWyslania: TLabel;
    ListaPude1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtQuickSearchChange(Sender: TObject);
    procedure LbxUliceClick(Sender: TObject);
    procedure EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LbxUliceDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure GrdPostojeDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Postawtaks1Click(Sender: TObject);
    procedure ZdejmijtakswkzpostojuF21Click(Sender: TObject);
    procedure Gwnacz1Click(Sender: TObject);
    procedure GrdPostojeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Splitter1Moved(Sender: TObject);
    procedure TmrUpdaterTimer(Sender: TObject);
    procedure GrdPostojeStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure GrdPostojeDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure GrdPostojeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure GrdPostojeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GrdPostojeSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure GrdAktywneTaksowkiDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure LbxListaKursowDoWyslaniaDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ListaPude1Click(Sender: TObject);
  private
    FUpdater: TUpdateListener;
    Postoje: array of TPostojRec;
    Ulice: TJvUIBQuery;
    DisableQuickSearch: Boolean;
    AktywneTaksowki: TJvUIBQuery;
    procedure AssignLanguage;
    procedure GatherPostoje;
{$IFDEF SORT_POSTOJE_BY_ILOSC_TAKSOWEK}
    procedure SortPostojeByIloscTaksowek;
{$ENDIF}
    procedure DisplayPostoje;
    procedure DisplayUlica(Index: Integer);
    procedure DisplayUlice;
    procedure DisplayAktywneTaksowki;
    function GetUlica: String;
    function GetUlicaId: Integer;
  public
    procedure PostawTaksowkeNaPostoju;
    procedure ZdejmijTaksowkeZPostoju(Taksowka: String = ''; ShowError: Boolean = True);
    procedure ZmienStatusTaksowki;
    procedure DisplayKursyDoWyslania;
    property Ulica: String read GetUlica;
    property UlicaId: Integer read GetUlicaId;
  end;

var
  FrmMiniManager: TFrmMiniManager;

implementation

uses
  Math, RTF_Main, RT_SQL, RT_DateProvider, StrUtils, DateUtils,
  RTF_EdytorKursu, RT_Base;

{$R *.DFM}

{ TFrmMiniManager }

{ Private declarations }

procedure TFrmMiniManager.AssignLanguage;
begin
  Caption := 'MiniManager postojów (RadioTaxi Manager 3.2)';
  LblQuickSearch.Caption := 'Ulice';
  LblPostoj1Desc.Caption := 'Postój 1: ';
  LblPostoj2Desc.Caption := 'Postój 2: ';
  LblPostoj3Desc.Caption := 'Postój 3: ';
  LblPostoj4Desc.Caption := 'Postój 4: ';
  LblPostoj5Desc.Caption := 'Postój 5: ';
  LblPostoj6Desc.Caption := 'Postój 6: ';
  LblPostoj7Desc.Caption := 'Postój 7: ';
  LblPostoj8Desc.Caption := 'Postój 8: ';
  LblPostoje.Caption := 'Postoje';
end;

procedure TFrmMiniManager.DisplayUlica(Index: Integer);
var
  I: Integer;
begin
  for I := 1 to 8 do
    GetLabelByName(Self, Format('LblPostoj%d', [I])).Caption := '';
  Ulice.Fields.GetRecord(Index);
  with TSQL.Instance.CreatePostojeNaUlicyQuery(Ulice.Fields.ByNameAsInteger['Id']) do
    try
      Open;
      I := 0;
      while (I < 8) and (not Eof) do
      begin
        GetLabelByName(Self, Format('LblPostoj%d', [I + 1])).Caption := Fields.ByNameAsString['NAZWA'];
        Next;
        Inc(I);
      end;
    finally
      Free;
    end;
end;

procedure TFrmMiniManager.DisplayUlice;
begin
  Ulice.Transaction.RollBack;
  Ulice.Open;
  LbxUlice.Items.BeginUpdate;
  try
    LbxUlice.Items.Clear;
    while not Ulice.Eof do
    begin
      LbxUlice.Items.Append(Ulice.Fields.ByNameAsString['NAZWA']);
      Ulice.Next;
    end;
  finally
    LbxUlice.Items.EndUpdate;
  end;
end;

procedure TFrmMiniManager.DisplayAktywneTaksowki;
begin
  GrdAktywneTaksowki.FixedCols := 0;
  GrdAktywneTaksowki.FixedRows := 0;
  AktywneTaksowki.Close(etmRollback);
  AktywneTaksowki.Open;
  AktywneTaksowki.FetchAll;
  AktywneTaksowki.First;
  if AktywneTaksowki.Eof then
  begin
    GrdAktywneTaksowki.ColCount := 1;
    GrdAktywneTaksowki.RowCount := 1;
    GrdAktywneTaksowki.ColWidths[0] := -1;
    GrdAktywneTaksowki.RowHeights[0] := -1;
  end
  else
  begin
    GrdAktywneTaksowki.DefaultRowHeight := 18;
    GrdAktywneTaksowki.DefaultColWidth := 40;
    GrdAktywneTaksowki.RowCount := Min(AktywneTaksowki.Fields.RecordCount, GrdAktywneTaksowki.ClientHeight div 17);
    GrdAktywneTaksowki.ColCount := (AktywneTaksowki.Fields.RecordCount div GrdAktywneTaksowki.VisibleRowCount) + 1;
  end;
end;

procedure TFrmMiniManager.DisplayKursyDoWyslania;
  function GetObszarySelectionClausule: String;
  var
    I: Integer;
  begin
    Result := '';
    for I := 0 to Length(FrmMain.Obszary) - 1 do
    begin
      if Result <> '' then
        Result := Result + ' or ';
      Result := Result + Format('OBSZARID=%d', [FrmMain.Obszary[I]]);
    end;
  end;
var
  ObszarySelectionClausule: String;
begin
  ObszarySelectionClausule := GetObszarySelectionClausule;
  if ObszarySelectionClausule <> '' then
    with TSQL.Instance.CreateQuery do
      try
        SQL.Text := Format('SELECT ID, ULICA, DOM, MIESZKANIE FROM KURSYZOBSZARID WHERE TAKSOWKAID=-1 AND (%s) AND (PRZYJECIE > %s)', [
          ObszarySelectionClausule,
          QuotedStr(FormatDateTime('YYYY-MM-DD', TRTDateProvider.Instance.Now))
        ]);
        Open;
        FetchAll;
        if Fields.RecordCount = 0 then
          PnlListaKursowDoWyslania.Visible := False
        else
        begin
          PnlListaKursowDoWyslania.Visible := True;
          LbxListaKursowDoWyslania.Clear;
          First;
          while not Eof do
          begin
            if Fields.AsString[3] = '' then
              LbxListaKursowDoWyslania.Items.AddObject(Format('%s %s', [
                Fields.AsString[1],
                Fields.AsString[2]
              ]), Pointer(Fields.AsInteger[0]))
            else
              LbxListaKursowDoWyslania.Items.AddObject(Format('%s %s/%s', [
                Fields.AsString[1],
                Fields.AsString[2],
                Fields.AsString[3]
              ]), Pointer(Fields.AsInteger[0]));
            Next;
          end;
          PnlListaKursowDoWyslania.Height := Min(LbxListaKursowDoWyslania.Items.Count * LbxListaKursowDoWyslania.ItemHeight + 28, 160);
        end;
      finally
        Free;
      end
  else
    PnlListaKursowDoWyslania.Visible := False;
  if IsWindowVisible(EdtQuickSearch.Handle) and Active then
    EdtQuickSearch.SetFocus;
end;

procedure TFrmMiniManager.GatherPostoje;
begin
  SetLength(Postoje, 0);
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := 'SELECT TAKSOWKANAPOSTOJU.INDEKS, POSTOJ.NAZWA, POSTOJ.ID, TAKSOWKA.NRWYWOLAWCZY, TAKSOWKA.ID as TAXI FROM POSTOJ LEFT OUTER JOIN TAKSOWKANAPOSTOJU ON '+'(POSTOJ.ID = TAKSOWKANAPOSTOJU.POSTOJID) LEFT OUTER JOIN TAKSOWKA ON (TAKSOWKANAPOSTOJU.TAKSOWKAID = TAKSOWKA.ID) ORDER BY POSTOJ.NAZWA, TAKSOWKANAPOSTOJU.INDEKS';
      Open;
      while not Eof do
      begin
        if (Length(Postoje) = 0) or (Postoje[Length(Postoje) - 1].Nazwa <> Fields.ByNameAsString['NAZWA']) then
        begin
          SetLength(Postoje, Length(Postoje) + 1);
          Postoje[Length(Postoje) - 1].Nazwa := Fields.ByNameAsString['NAZWA'];
          Postoje[Length(Postoje) - 1].Id := Fields.ByNameAsInteger['ID'];
          Postoje[Length(Postoje) - 1].IloscTaksowek := 0;
        end;
        Postoje[Length(Postoje) - 1].Taksowki[Postoje[Length(Postoje) - 1].IloscTaksowek].ID := Fields.ByNameAsInteger['TAXI'];
        Postoje[Length(Postoje) - 1].Taksowki[Postoje[Length(Postoje) - 1].IloscTaksowek].NrWywol := Fields.ByNameAsString['NRWYWOLAWCZY'];
        if Fields.ByNameAsString['NRWYWOLAWCZY'] <> '' then
          Inc(Postoje[Length(Postoje) - 1].IloscTaksowek);
        Next;
      end;
    finally
      Free;
    end;
end;

{$IFDEF SORT_POSTOJE_BY_ILOSC_TAKSOWEK}
procedure TFrmMiniManager.SortPostojeByIloscTaksowek;
var
  I: Integer;
  Done: Boolean;
  Temp: TPostojRec;
begin
  repeat
    Done := True;
    for I := 0 to Length(Postoje) - 2 do
      if Postoje[I].IloscTaksowek < Postoje[I + 1].IloscTaksowek then
      begin
        Done := False;
        Temp := Postoje[I];
        Postoje[I] := Postoje[I + 1];
        Postoje[I + 1] := Temp;
      end;
  until Done;
end;
{$ENDIF}

procedure TFrmMiniManager.DisplayPostoje;
var
  I: Integer;
begin
  GatherPostoje;
{$IFDEF SORT_POSTOJE_BY_ILOSC_TAKSOWEK}
  SortPostojeByIloscTaksowek;
{$ENDIF}

  with GrdPostoje do
  begin
    if Length(Postoje) = 0 then
    begin
      ColCount := 1;
      RowCount := 1;
      ColWidths[0] := -1;
      RowHeights[0] := -1;
    end
    else
    begin
      ColCount := 21;
      RowCount := Length(Postoje) + 1;
      FixedCols := 0;
      ColWidths[0] := 98;
      ColWidths[1] := 25;
      for I := 2 to 20 do
        ColWidths[I] := 40;
      for I := 0 to RowCount - 1 do
        RowHeights[I] := 18;
    end;
  end;
  GrdPostoje.TopRow := 1;
  GrdPostoje.Invalidate;
end;

function TFrmMiniManager.GetUlica: String;
begin
  if EdtQuickSearch.Text <> '' then
    Result := Ulice.Fields.ByNameAsString['NAZWA']
  else
    Result := '';
end;

function TFrmMiniManager.GetUlicaId: Integer;
begin
  if EdtQuickSearch.Text <> '' then
    Result := Ulice.Fields.ByNameAsInteger['Id']
  else
    Result := 0;
end;

{ Public declarations }

procedure TFrmMiniManager.PostawTaksowkeNaPostoju;
var
  Taksowka, Postoj: String;
begin
  Postoj := '';
  if not InputQuery('WprowadŸ identyfikator postoju', 'Postój', Postoj) then
    Exit;
  Taksowka := '';
  if not InputQuery('WprowadŸ numer taksówki', 'Taksówka', Taksowka) then
    Exit;
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('EXECUTE PROCEDURE POSTAW_TAKSOWKE_NA_POSTOJU %s, %s', [
        QuotedStr(Taksowka),
        Postoj
      ]);
      try
        ExecSQL;
      except
        ShowError('Niepoprawny postój lub numer wywo³awczy taksówki');
      end;
    finally
      Free;
    end;
  DisplayPostoje;
  DisplayAktywneTaksowki;
end;

procedure TFrmMiniManager.ZdejmijTaksowkeZPostoju(Taksowka: String = ''; ShowError: Boolean = True);
begin
  if Taksowka = '' then
    if not InputQuery('WprowadŸ numer taksówki', 'Taksówka', Taksowka) then
      Exit;
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('EXECUTE PROCEDURE ZDEJMIJ_TAKSOWKE_Z_POSTOJU %s', [
        QuotedStr(Taksowka)
      ]);
      try
        ExecSQL;
      except
        if ShowError then
          RT_Tools.ShowError(Format('Nie znaleziono taksówki %s na ¿adnym postoju', [Taksowka]));
      end;
    finally
      Free;
    end;
  DisplayPostoje;
  DisplayAktywneTaksowki;
end;

procedure TFrmMiniManager.ZmienStatusTaksowki;
var
  Taksowka: String;
  Stan: Integer;
begin
  if not InputQuery('WprowadŸ numer taksówki', 'Taksówka', Taksowka) then
    Exit;
  with TSQL.Instance.CreateQuery do
    try
      SQL.Text := Format('SELECT AKTYWNA FROM TAKSOWKA WHERE NRWYWOLAWCZY=%s', [
        QuotedStr(Taksowka)
      ]);
      try
        Open;
        if Eof then
        begin
          Close(etmRollback);
          raise Exception.Create('Taksówka nie istnieje!');
        end;
        if Fields.ByNameAsInteger['AKTYWNA'] = 0 then
          Stan := 1
        else
          Stan := 0;
        Close(etmRollback);
        SQL.Text := Format('UPDATE TAKSOWKA SET AKTYWNA=%d WHERE NRWYWOLAWCZY=%s', [
          Stan,
          QuotedStr(Taksowka)
        ]);
        try
          ExecSQL;
          Close(etmCommit);
          DisplayAktywneTaksowki;
        except
          Close(etmRollback);
          raise;
        end;
      except
        RT_Tools.ShowError(Format('Taksówki %s nie znaleziona', [Taksowka]));
      end;
    finally
      Free;
    end;
end;

{ Event handlers }

procedure TFrmMiniManager.FormCreate(Sender: TObject);
begin
  AssignLanguage;
  FUpdater := TUpdateListener.Create(['POSTOJ', 'ULICA', 'TAKSOWKA', 'TAKSOWKANAPOSTOJU', 'POSTOJNAULICY', 'KURS']);
  TRTUpdater.Instance.RegisterListener(FUpdater);
  Ulice := TSQL.Instance.CreateQuery;
  Ulice.SQL.Text := 'SELECT ULICA.ID,lower(ULICA.NAZWA) AS NAZWA,POCZATEK,KONIEC,SKROT FROM ULICA INNER JOIN OBSZAR ON (ULICA.OBSZARID=OBSZAR.ID) ORDER BY NAZWA, POCZATEK';
  AktywneTaksowki := TSQL.Instance.CreateQuery;
  AktywneTaksowki.SQL.Text := 'SELECT * FROM GRDAKTYWNETAKSOWKI';
  DisplayUlice;
  DisplayPostoje;
  DisplayAktywneTaksowki;
  Application.ProcessMessages;
  DisplayAktywneTaksowki;
  DisplayKursyDoWyslania;
end;

procedure TFrmMiniManager.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Ulice);
end;

procedure TFrmMiniManager.FormShow(Sender: TObject);
var
  R: TRect;
begin
  EdtQuickSearch.Text := '';
//  Exit;
  SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
  if R.Right > 640 then
  begin
    Top := (R.Bottom - 488) div 2;
    Left := (R.Right - 648) div 2;
    Width := 648;
    Height := 488;
  end
  else
  begin
    Top := -4;
    Left := -4;
    Width := 648;
    Height := R.Bottom + 8;
  end;
end;

procedure TFrmMiniManager.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//
end;

procedure TFrmMiniManager.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then
  begin
    FrmMain.BringToFront;
    Key := 0;
  end;
  if Key = VK_F1 then
  begin
    PostawTaksowkeNaPostoju;
    Key := 0;
  end;
  if Key = VK_F2 then
  begin
    ZdejmijTaksowkeZPostoju;
    Key := 0;
  end;
  if Key = VK_F9 then
  begin
    ZmienStatusTaksowki;
    Key := 0;
  end;
end;

procedure TFrmMiniManager.EdtQuickSearchChange(Sender: TObject);
var
  I: Integer;
  S1, S2: String;
begin
  if DisableQuickSearch then
    Exit;
  S1 := EdtQuickSearch.Text;
  for I := 0 to LbxUlice.Items.Count - 1 do
  begin
    S2 := Copy(LbxUlice.Items[I], 1, Length(S1));
    if AnsiSameText(S1, S2) then
    begin
      LbxUlice.ItemIndex := I;
      Ulice.Fields.GetRecord(I);
      DisplayUlica(LbxUlice.ItemIndex);
      Break;
    end;
  end;
end;

procedure TFrmMiniManager.LbxUliceClick(Sender: TObject);
begin
  DisableQuickSearch := True;
  if LbxUlice.ItemIndex <> -1 then
    EdtQuickSearch.Text := LbxUlice.Items[LbxUlice.ItemIndex]
  else
    EdtQuickSearch.Text := '';
  EdtQuickSearch.SelectAll;
  DisplayUlica(LbxUlice.ItemIndex);
  EdtQuickSearch.SetFocus;
  DisableQuickSearch := False;
end;

procedure TFrmMiniManager.EdtQuickSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and ((Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_LEFT) or (Key = VK_RIGHT)) then
  begin
    PostMessage(GrdPostoje.Handle, WM_KEYDOWN, Key, 0);
    Key := 0;
  end;

  if (Key = VK_PRIOR) or (Key = VK_NEXT) or (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_END) or (Key = VK_HOME) then
  begin
    PostMessage(LbxUlice.Handle, WM_KEYDOWN, Key, 0);
    LbxUliceClick(nil);
    Key := 0;
  end;
end;

procedure TFrmMiniManager.LbxUliceDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  S: String;
  OldIndex: Integer;
begin
  OldIndex := Ulice.Fields.CurrentRecord;
  try
    Ulice.Fields.GetRecord(Index);
    LbxUlice.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 1, Ulice.Fields.ByNameAsString['SKROT']);
    Inc(Rect.Left, 30);
    Dec(Rect.Right, 100);
    LbxUlice.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, Ulice.Fields.ByNameAsString['NAZWA']);

    Rect.Left := Rect.Right;
    Inc(Rect.Right, 45);
    LbxUlice.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, 'Od ' + Ulice.Fields.ByNameAsString['POCZATEK']);
    Rect.Left := Rect.Right;
    Inc(Rect.Right, 55);
    if Ulice.Fields.ByNameAsString['KONIEC'] = '' then
      S := 'koñca'
    else
      S := Ulice.Fields.ByNameAsString['KONIEC'];
    LbxUlice.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 1, 'Do ' + S);
  finally
    Ulice.Fields.GetRecord(OldIndex);
  end;
end;

procedure TFrmMiniManager.GrdPostojeDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
const
  HEADER: array[0..20] of String = ('Postój', 'Ile', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19');
var
  S: String;
  Bc, Fc: TColor;
begin
  if ARow = 0 then
    S := HEADER[ACol]
  else
    case ACol of
      0: S := Postoje[ARow - 1].Nazwa;
      1: S := IntToStr(Postoje[ARow - 1].IloscTaksowek);
      else S := Postoje[ARow - 1].Taksowki[ACol - 2].NrWywol;
    end;

  with GrdPostoje.Canvas do
  begin
    if ARow = 0 then
    begin
      Rect.Left := Rect.Left + (Rect.Right - Rect.Left - Canvas.TextWidth(S)) div 2 - 1;
      TextRect(Rect, Rect.Left, Rect.Top + 2, S);
    end
    else
    begin
      Bc := Brush.Color;
      Fc := Font.Color;
      Brush.Color := clWindow;
      Font.Color := clWindowText;
      if ACol = 0 then
        GrdPostoje.Canvas.Brush.Color := $EEEEEE
//      else if (GrdPostoje.Col = ACol) and (GrdPostoje.Row = ARow) and (Dragging) then
//        GrdPostoje.Canvas.Brush.Color := $AAAAAA
      else
        GrdPostoje.Canvas.Brush.Color := clWindow;

      GrdPostoje.Canvas.FillRect(Rect);

      if ACol = 0 then
      begin
        Font.Style := [fsBold];
        TextRect(Rect, Rect.Left + 1, Rect.Top + 2, IntToStr(Postoje[ARow - 1].Id));
        Font.Style := [];
        Rect.Left := Rect.Left + 20;
        TextRect(Rect, Rect.Left + 1, Rect.Top + 2, S);
      end
      else
      begin
        Font.Style := [fsBold];
        Rect.Left := Rect.Left + (Rect.Right - Rect.Left - Canvas.TextWidth(S)) div 2 - 5;
        GrdPostoje.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 2, S);
        Font.Style := [];
      end;
      Brush.Color := Bc;
      Font.Color := Fc;
    end;
  end;
end;

procedure TFrmMiniManager.Postawtaks1Click(Sender: TObject);
begin
  PostawTaksowkeNaPostoju;
end;

procedure TFrmMiniManager.ZdejmijtakswkzpostojuF21Click(Sender: TObject);
begin
  ZdejmijTaksowkeZPostoju;
end;

procedure TFrmMiniManager.Gwnacz1Click(Sender: TObject);
begin
  FrmMain.BringToFront;
end;

procedure TFrmMiniManager.GrdPostojeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  EdtQuickSearch.SetFocus;
end;

procedure TFrmMiniManager.Splitter1Moved(Sender: TObject);
begin
  LbxUlice.Invalidate;
end;

procedure TFrmMiniManager.TmrUpdaterTimer(Sender: TObject);
var
  S: String;
  UpdatePostoje: Boolean;
  UpdateUlice: Boolean;
  UpdateTaksowki: Boolean;
  UpdateKursy: Boolean;
begin
  UpdatePostoje := False;
  UpdateUlice := False;
  UpdateTaksowki := False;
  UpdateKursy := False;
  FUpdater.Lock;
  try
    while not FUpdater.UpdatedTables.Empty do
    begin
      S := FUpdater.UpdatedTables.Pop;
      UpdateUlice := UpdateUlice or AnsiSameText('ULICA', S);
      UpdateUlice := UpdateUlice or AnsiSameText('POSTOJNAULICY', S);
      UpdateUlice := UpdateUlice or AnsiSameText('POSTOJ', S);
      UpdatePostoje := UpdatePostoje or AnsiSameText('POSTOJ', S);
      UpdatePostoje := UpdatePostoje or AnsiSameText('TAKSOWKANAPOSTOJU', S);
      UpdateTaksowki := UpdateTaksowki or AnsiSameText('TAKSOWKA', S);
      UpdateTaksowki := UpdateTaksowki or AnsiSameText('TAKSOWKANAPOSTOJU', S);
      UpdateKursy := UpdateKursy or AnsiSameText('KURS', S);
    end;
  finally
    FUpdater.Unlock;
  end;

  if UpdateUlice then
    DisplayUlice;
  if UpdatePostoje then
  begin
    DisplayPostoje;
    GrdPostoje.Invalidate;
  end;
  if UpdateTaksowki then
  begin
    DisplayAktywneTaksowki;
    GrdAktywneTaksowki.Invalidate;
  end;
  if UpdateKursy then
    DisplayKursyDoWyslania;
end;

type
  TTaksowkaNaPostojuDragObject = class (TDragObject)
    Column, Row: Integer;
  end;

procedure TFrmMiniManager.GrdPostojeStartDrag(Sender: TObject; var DragObject: TDragObject);
var
  P: TPoint;
begin
  DragObject := TTaksowkaNaPostojuDragObject.Create;
  P := GrdPostoje.ScreenToClient(Mouse.CursorPos);
  with DragObject as TTaksowkaNaPostojuDragObject do
    GrdPostoje.MouseToCell(P.X, P.Y, Column, Row);
end;

procedure TFrmMiniManager.GrdPostojeDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
  function CanDropAt(X, Y, Column, Row: Integer): Boolean;
  var
    C, R: Integer;
  begin
    GrdPostoje.MouseToCell(X, Y, C, R);
    Result := (R > 0) and (C > 1) and (C - 2 < Postoje[R - 1].IloscTaksowek) and (C <> Column) and (R = Row);
  end;
begin
  with Source as TTaksowkaNaPostojuDragObject do
    Accept := CanDropAt(X, Y, Column, Row)
end;

procedure TFrmMiniManager.GrdPostojeDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  P: TPoint;
  C, R, I: Integer;
begin
  TmrUpdater.Enabled := False;
  try
    P := GrdPostoje.ScreenToClient(Mouse.CursorPos);
    GrdPostoje.MouseToCell(X, Y, C, R);
    with Source as TTaksowkaNaPostojuDragObject do
    begin
      with TStringList.Create do
        try
          for I := Low(Postoje[Row - 1].Taksowki) to Postoje[Row - 1].IloscTaksowek - 1 do
            AddObject(Postoje[Row - 1].Taksowki[I].NrWywol, Pointer(Postoje[Row - 1].Taksowki[I].Id));
          Move(Column - 2, C - 2);
          for I := Low(Postoje[Row - 1].Taksowki) to Postoje[Row - 1].IloscTaksowek - 1 do
          begin
            Postoje[Row - 1].Taksowki[I].Id := Integer(Objects[I]);
            Postoje[Row - 1].Taksowki[I].NrWywol := Strings[I];
          end;

          // update the database
          with TSQL.Instance.CreateQuery do
            try
              try
                for I := 0 to Count - 1 do
                begin
                  SQL.Text := Format('UPDATE TAKSOWKANAPOSTOJU SET INDEKS=%d WHERE POSTOJID=%d AND TAKSOWKAID=%d', [
                    I,
                    Postoje[Row - 1].Id,
                    Integer(Objects[I])
                  ]);
                  ExecSQL;
                end;
                Transaction.Commit;
              except
                Transaction.RollBack;
              end;
            finally
              Free;
            end;
        finally
          Free;
        end;
      GrdPostoje.Invalidate;
    end;
  finally
    TmrUpdater.Enabled := True;
  end;
end;

procedure TFrmMiniManager.GrdPostojeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  function CanDragAt(X, Y: Integer; var C, R: Integer): Boolean;
  begin
    GrdPostoje.MouseToCell(X, Y, C, R);
    Result := (R > 0) and (C > 1) and (C - 2 < Postoje[R - 1].IloscTaksowek);
  end;
var
  C, R: Integer;
begin
  if (ssLeft in Shift) and CanDragAt(X, Y, C, R) then
  begin
    GrdPostoje.BeginDrag(False);
    Invalidate;
  end
  else if (ssRight in Shift) and CanDragAt(X, Y, C, R) then
  begin
    ZdejmijTaksowkeZPostoju(Postoje[R - 1].Taksowki[C-2].NrWywol);
    GrdPostoje.BeginDrag(False);
    Invalidate;
  end;
end;

procedure TFrmMiniManager.GrdPostojeSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect := (ARow > 0) and (ACol > 1) and (ACol - 2 < Postoje[ARow - 1].IloscTaksowek);
end;

procedure TFrmMiniManager.GrdAktywneTaksowkiDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Index: Integer;
  S: String;
begin
  GrdAktywneTaksowki.Canvas.Brush.Color := clWindow;
  GrdAktywneTaksowki.Canvas.FillRect(Rect);
  GrdAktywneTaksowki.Canvas.Font.Color := clWindowText;
  Index := ACol * GrdAktywneTaksowki.RowCount + ARow;
  if Index < AktywneTaksowki.Fields.RecordCount then
  begin
    AktywneTaksowki.Fields.GetRecord(Index);
    S := AktywneTaksowki.Fields.ByNameAsString['NRWYWOLAWCZY'];
    GrdAktywneTaksowki.Canvas.Font.Style := [fsBold];
    Rect.Left := Rect.Left + (Rect.Right - Rect.Left - Canvas.TextWidth(S)) div 2 - 5;
    GrdAktywneTaksowki.Canvas.TextRect(Rect, Rect.Left + 1, Rect.Top + 2, S);
    GrdAktywneTaksowki.Canvas.Font.Style := [];
  end;
end;

procedure TFrmMiniManager.LbxListaKursowDoWyslaniaDblClick(Sender: TObject);
var
  ItemIndex: Integer;
begin
  ItemIndex := LbxListaKursowDoWyslania.ItemAtPos(LbxListaKursowDoWyslania.ScreenToClient(Mouse.CursorPos), True);
  if ItemIndex <> -1 then
  begin
    FrmMain.AutoUpdater.Enabled := False;
    try
      with TSQL.Instance.CreateQuery do
        try
          SQL.Text := Format('SELECT * FROM KURS WHERE ID=%d', [Integer(LbxListaKursowDoWyslania.Items.Objects[ItemIndex])]);
          Open;
          if not Eof then
            with TFrmEdytorKursu.Create(nil) do
              try
                SetData(Fields);
                UpdateTaksowka;
                PostMessage(Handle, WM_SETFOCUSTOTAKSOWKA, 0, 0);
                if ShowModal = mrOK then
                begin
                  DisplayKursyDoWyslania;
                  FrmMain.DisplayKursy;
                end;
              finally
                Free;
              end;
        finally
          Free;
        end;
    finally
      FrmMain.AutoUpdater.Enabled := True;
    end;
  end;
  EdtQuickSearch.SetFocus;
end;

procedure TFrmMiniManager.FormActivate(Sender: TObject);
begin
  EdtQuickSearch.SetFocus;
end;

function GetTaksowkaById(Id: Integer): String;
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

procedure TFrmMiniManager.ListaPude1Click(Sender: TObject);
var
  Timestamp1, Timestamp2: TDateTime;
  TaksowkiZPudlami: TStringList;
  Dom, Mieszkanie: String;
begin
  TaksowkiZPudlami := TStringList.Create;
  try
    TaksowkiZPudlami.Duplicates := dupIgnore;
    Timestamp1 := Now;
    Timestamp2 := IncHour(Timestamp1, -12);
    with TSQL.Instance.CreateQuery do
      try
        SQL.Text := Format('SELECT TAKSOWKAID, FLAGS, ULICA, DOM, Mieszkanie, PRZYJECIE FROM KURS WHERE Przyjecie BETWEEN %s and %s', [
          QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN', Timestamp2)),
          QuotedStr(FormatDateTime('YYYY-MM-DD HH:NN', Timestamp1))
        ]);
        Open;
        while not Eof do
        begin
          if Fields.ByNameAsString['DOM'] <> '' then
            Dom := ', ' + Fields.ByNameAsString['DOM'];
          if Fields.ByNameAsString['Mieszkanie'] <> '' then
            Mieszkanie := ', ' + Fields.ByNameAsString['Mieszkanie'];
          if (Fields.ByNameAsInteger['Flags'] and (kfPudlo or kfWykozystane) = kfPudlo) then
          begin
            TaksowkiZPudlami.Add(Format('%s (%s, %s)', [
              GetTaksowkaById(Fields.ByNameAsInteger['TAKSOWKAID']),
              Fields.ByNameAsString['ULICA'] + Dom + Mieszkanie,
              FormatDateTime('YYYY-MM-DD HH:NN', Fields.ByNameAsDateTime['PRZYJECIE'])
            ]));
          end;
          Next;
        end;
        Close;
      finally
        Free;
      end;
    if TaksowkiZPudlami.Count = 0 then
      TaksowkiZPudlami.Add('Brak');
    MessageBox(Handle, PChar(TaksowkiZPudlami.Text), 'Taksówki z pud³ami', MB_ICONINFORMATION or MB_OK);
  finally
    TaksowkiZPudlami.Free;
  end;
end;

end.

