unit RTF_SelectMonth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmSelectMonth = class(TForm)
    CbxYear: TComboBox;
    CbxMonth: TComboBox;
    LblYear: TLabel;
    LblMonth: TLabel;
    BtnOK: TButton;
    BtnCancel: TButton;
    TmrUpdater: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure TmrUpdaterTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function SelectYearAndMonth(out Year, Month: Integer): Boolean;

implementation

{$R *.dfm}

procedure TFrmSelectMonth.FormCreate(Sender: TObject);
const
  Months: array[1..12] of String = (
    'Styczeñ', 'Luty', 'Marzec', 'Kwiecieñ', 'Maj', 'Czerwiec', 'Lipiec', 'Sierpieñ', 'Wrzesieñ', 'PaŸdziernik', 'Listopad', 'Grudzieñ'
  );
var
  I: Integer;
  Year, Month, Day: Word;
begin
  DecodeDate(Now, Year, Month, Day);
  for I := Year downto 1976 do
    CbxYear.Items.AddObject(IntToStr(I), Pointer(I));
  for I := 1 to 12 do
    CbxMonth.Items.AddObject(Months[I], Pointer(I));
end;

{ *** }

function SelectYearAndMonth(out Year, Month: Integer): Boolean;
begin
  Year := 0; Month := 0;
  with TFrmSelectMonth.Create(Nil) do
    try
      if ShowModal = mrOk then
      begin
        Year := Integer(CbxYear.Items.Objects[CbxYear.ItemIndex]);
        Month := Integer(CbxMonth.Items.Objects[CbxMonth.ItemIndex]);
        Result := True;
      end
      else
        Result := False;
    finally
      Free;
    end;
end;

procedure TFrmSelectMonth.TmrUpdaterTimer(Sender: TObject);
begin
  BtnOK.Enabled := (CbxYear.ItemIndex <> -1) and (CbxMonth.ItemIndex <> -1);
end;

end.
