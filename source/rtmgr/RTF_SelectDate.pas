unit RTF_SelectDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, RxToolEdit;

type
  TFrmSelectDate = class(TForm)
    EdtDataKursow: TDateEdit;
    BtnAnuluj: TButton;
    BtnOK: TButton;
    LblDataKursow: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TFrmSelectDate.FormShow(Sender: TObject);
begin
  EdtDataKursow.DoClick;
end;

end.
