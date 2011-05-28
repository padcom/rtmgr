unit RTF_EksportDanych;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, RxToolEdit;

type
  TFrmEksportDanychKursow = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    BtnDodaj: TButton;
    BtnUsun: TButton;
    LbxSource: TListBox;
    LbxDest: TListBox;
    EdtKatalog: TDirectoryEdit;
    BtnPrzerzuc: TButton;
    BtnZamknij: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure BtnDodajClick(Sender: TObject);
    procedure BtnUsunClick(Sender: TObject);
    procedure BtnPrzerzucClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  RT_Tools;

{$R *.DFM}

type
  TPlik = class
    NazwaZrodlowego: String;
  end;

procedure TFrmEksportDanychKursow.FormShow(Sender: TObject);
//var
//  SearchRec: TSearchRec;
//  SearchResult: Integer;
//  P: TPlik;
//  S: String;
begin
//  SearchResult := FindFirst(TOptions.Instance.DataPath + 'Kursy\*.rtm', faAnyfile, SearchRec);
//  while SearchResult = 0 do
//  begin
//    P := TPlik.Create;
//    S := SearchRec.Name;
//    S := Copy(S, 1, Length(S) - Length(ExtractFileExt(S)));
//    try
//      StrToDate(S);
//    except
//      SearchResult := FindNext(SearchRec);
//      Continue;
//    end;
//    P.NazwaZrodlowego := DataPath + 'Kursy\' + SearchRec.Name;
//    LbxSource.Items.AddObject(Copy(SearchRec.Name, 1, Length(SearchRec.Name) - Length(ExtractFileExt(SearchRec.Name))), P);
//    SearchResult := FindNext(SearchRec);
//  end;
end;

procedure TFrmEksportDanychKursow.FormHide(Sender: TObject);
var
  I: Integer;
begin
  I := 0;
  while I < LbxSource.Items.Count do
  begin
    TObject(LbxSource.Items.Objects[I]).Free;
    Inc(I);
  end;
  LbxSource.Items.Clear;
  I := 0;
  while I < LbxDest.Items.Count do
  begin
    TObject(LbxDest.Items.Objects[I]).Free;
    Inc(I);
  end;
  LbxDest.Items.Clear;
end;

procedure TFrmEksportDanychKursow.BtnDodajClick(Sender: TObject);
var
  I: Integer;
  P: TPlik;
  S: String;
begin
  I := 0;
  while I < LbxSource.Items.Count do
  begin
    if LbxSource.Selected[I] then
    begin
      P := LbxSource.Items.Objects[I] as TPlik;
      S := LbxSource.Items[I];
      LbxSource.Items.Delete(I);
      LbxDest.Items.AddObject(S, P);
    end
    else Inc(I);
  end;
end;

procedure TFrmEksportDanychKursow.BtnUsunClick(Sender: TObject);
var
  I: Integer;
  P: TPlik;
  S: String;
begin
  I := 0;
  while I < LbxDest.Items.Count do
  begin
    if LbxDest.Selected[I] then
    begin
      P := LbxDest.Items.Objects[I] as TPlik;
      S := LbxDest.Items[I];
      LbxDest.Items.Delete(I);
      LbxSource.Items.AddObject(S, P);
    end
    else Inc(I);
  end;
end;

procedure TFrmEksportDanychKursow.BtnPrzerzucClick(Sender: TObject);
  function FileSize(FN: String): Integer;
  var
    F: File;
  begin
    AssignFile(F, FN);
    Reset(F);
    Result := System.FileSize(F);
    CloseFile(F);
  end;
var
  I: Integer;
  P: TPlik;
  Dest: String;
  OK: Boolean;
begin
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  OK := True;
  Dest := EdtKatalog.Text;
  if Dest = '' then
  begin
    ShowMessage('Wybierz najpierw katalog docelowy !');
    Exit;
  end;
  if not IsPathDelimiter(Dest, Length(Dest)) then Dest := Dest + '\';

  try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;
    I := 0;
    while I < LbxDest.Items.Count do
    begin
      P := LbxDest.Items.Objects[I] as TPlik;
      try
        if FileExists(Dest + ExtractFileName(P.NazwaZrodlowego)) then DeleteFile(Dest + ExtractFileName(P.NazwaZrodlowego));
        CopyFile(PChar(P.NazwaZrodlowego), PChar(Dest + ExtractFileName(P.NazwaZrodlowego)), True);
        if FileExists(Dest + ExtractFileName(P.NazwaZrodlowego)) and (FileSize(P.NazwaZrodlowego)=FileSize(Dest + ExtractFileName(P.NazwaZrodlowego))) then
        begin
          if ExtractFileName(P.NazwaZrodlowego) <> FormatDateTime('YYYY-MM-DD', Now) + '.rtm' then
            DeleteFile(PChar(P.NazwaZrodlowego));
        end
        else raise Exception.Create('');
      except
        OK := False;
        Break;
      end;
      Inc(I);
    end;
  finally
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
  end;
  Close;
  Screen.Cursor := crDefault;
  if OK then ShowMessage('Dane zosta³y PRZENIESIONE poprawnie')
  else ShowMessage('B³¹d podczas przenoszenia plików !'#13#10#13#10 + 'SprawdŸ, czy dysk nie jest zabezpieczony przed zapisem i czy znajduje siê na nim dostateczna iloœæ miejsca');
end;

end.
