program Pods;

uses
  Forms,
  FormMain in 'FormMain.pas' {FrmMain1},
  RT_Print in '..\..\rtmgr\RT_Print.pas',
  RT_DateProvider in '..\..\rtmgr\RT_DateProvider.pas',
  RT_BackupCreator in '..\..\rtmgr\RT_BackupCreator.pas',
  RT_BackupImporter in '..\..\rtmgr\RT_BackupImporter.pas',
  RT_Updater in '..\..\rtmgr\RT_Updater.pas',
  RT_SQL in '..\..\common\RT_SQL.pas',
  RTF_PrintPreview in '..\..\rtmgr\RTF_PrintPreview.pas' {FrmPrintPreview},
  RTF_SelectDate in '..\..\rtmgr\RTF_SelectDate.pas' {FrmSelectDate},
  RTF_ListaKursowTaksowki in '..\..\rtmgr\RTF_ListaKursowTaksowki.pas' {FrmListaKursowTaksowki},
  RTF_EdytorKursu in '..\..\rtmgr\RTF_EdytorKursu.pas' {FrmEdytorKursu},
  RTF_PleaseWait in '..\..\rtmgr\RTF_PleaseWait.pas' {FrmPleaseWait},
  RTF_EksportDanych in '..\..\rtmgr\RTF_EksportDanych.pas' {FrmEksportDanych},
  RTF_EksportDanychKursow in '..\..\rtmgr\RTF_EksportDanychKursow.pas' {FrmEksportDanychKursow},
  RTF_ListaUlic in '..\..\rtmgr\RTF_ListaUlic.pas' {FrmListaUlic},
  RTF_EdytorUlicy in '..\..\rtmgr\RTF_EdytorUlicy.pas' {FrmEdytorUlicy},
  RTF_ListaPostojow in '..\..\rtmgr\RTF_ListaPostojow.pas' {FrmListaPostojow},
  RTF_ListaTaksowek in '..\..\rtmgr\RTF_ListaTaksowek.pas' {FrmListaTaksowek},
  RTF_EdytorTaksowki in '..\..\rtmgr\RTF_EdytorTaksowki.pas' {FrmEdytorTaksowki},
  RTF_ListaKlientow in '..\..\rtmgr\RTF_ListaKlientow.pas' {FrmListaKlientow},
  RTF_ListaObszarow in '..\..\rtmgr\RTF_ListaObszarow.pas' {FrmListaObszarow},
  RTF_EdytorKlienta in '..\..\rtmgr\RTF_EdytorKlienta.pas' {FrmEdytorKlienta},
  RTF_EdytorObszaru in '..\..\rtmgr\RTF_EdytorObszaru.pas' {FrmEdytorObszaru},
  RTF_ObszarSelector in '..\..\rtmgr\RTF_ObszarSelector.pas' {FrmObszarSelector},
  RTF_MiniManager in '..\..\rtmgr\RTF_MiniManager.pas' {FrmMiniManager},
  RTF_Main in '..\..\rtmgr\RTF_Main.pas' {FrmMain},
  RTF_SelectMonth in '..\..\rtmgr\RTF_SelectMonth.pas' {RTF_SelectMonth},
  RTF_InputPassword in '..\..\rtmgr\RTF_InputPassword.pas' {RTF_InputPassword},
  RTF_ChangePassword in '..\..\rtmgr\RTF_ChangePassword.pas' {RTF_ChangePassword},
  RTF_Zestawienia in '..\..\rtmgr\RTF_Zestawienia.pas' {FrmZestawienia},
  RT_WolaniaGenerator in '..\..\rtmgr\RT_WolaniaGenerator.pas';

{.$R *.RES}
{$R ..\..\rtmgr\ButtonGlyphs.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain1, FrmMain1);
  Application.Run;
end.
