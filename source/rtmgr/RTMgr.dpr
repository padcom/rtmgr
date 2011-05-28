program RadioTaxi;

uses
  Windows,
  SysUtils,
  ActiveX,
  Forms,
  Dialogs,
  RT_SQL in '..\common\RT_SQL.pas',
  RT_Base in '..\common\RT_Base.pas',
  RT_Tools in '..\common\RT_Tools.pas',
  RT_DateProvider in 'RT_DateProvider.pas',
  RT_BackupCreator in 'RT_BackupCreator.pas',
  RT_BackupImporter in 'RT_BackupImporter.pas',
  RT_Updater in 'RT_Updater.pas',
  RTF_Main in 'RTF_Main.pas' {FrmMain},
  RTF_EdytorKursu in 'RTF_EdytorKursu.pas' {FrmEdytorKursu},
  RTF_ListaPostojow in 'RTF_ListaPostojow.pas' {FrmListaPostojow},
  RTF_ListaUlic in 'RTF_ListaUlic.pas' {FrmListaUlic},
  RTF_ListaTaksowek in 'RTF_ListaTaksowek.pas' {FrmListaTaksowek},
  RTF_EdytorUlicy in 'RTF_EdytorUlicy.pas' {FrmEdytorUlicy},
  RTF_EdytorTaksowki in 'RTF_EdytorTaksowki.pas' {FrmEdytorTaksowki},
  RTF_ListaKlientow in 'RTF_ListaKlientow.pas' {FrmListaKlientow},
  RTF_EdytorKlienta in 'RTF_EdytorKlienta.pas' {FrmEdytorKlienta},
  RTF_Zestawienia in 'RTF_Zestawienia.pas' {FrmZestawienia},
  RT_Print in 'RT_Print.pas',
  RTF_PrintPreview in 'RTF_PrintPreview.pas' {FrmPrintPreview},
  RTF_ListaKursowTaksowki in 'RTF_ListaKursowTaksowki.pas' {FrmListaKursowTaksowki},
  RTF_SelectDate in 'RTF_SelectDate.pas' {FrmSelectDate},
  RTF_PleaseWait in 'RTF_PleaseWait.pas' {FrmPleaseWait},
  RTF_EksportDanych in 'RTF_EksportDanych.pas' {FrmEksportDanychKursow},
  RTF_EksportDanychKursow in 'RTF_EksportDanychKursow.pas' {FrmEksportDanychKursowSimple},
  RTF_MiniManager in 'RTF_MiniManager.pas' {FrmMiniManager},
  RTF_ListaObszarow in 'RTF_ListaObszarow.pas' {FrmListaObszarow},
  RTF_EdytorObszaru in 'RTF_EdytorObszaru.pas' {FrmEdytorObszaru},
  RTF_ObszarSelector in 'RTF_ObszarSelector.pas' {FrmObszarSelector},
  RT_WolaniaGenerator in 'RT_WolaniaGenerator.pas',
  RT_GeneratorUpdater in 'RT_GeneratorUpdater.pas',
  RTF_SelectMonth in 'RTF_SelectMonth.pas' {FrmSelectMonth},
  RTF_InputPassword in 'RTF_InputPassword.pas' {FrmInputPassword},
  RTF_ChangePassword in 'RTF_ChangePassword.pas' {FrmChangePassword};

{$R ButtonGlyphs.res}

var
  Mutex: THandle;
  Wnd: THandle;

begin
  Mutex := CreateMutex(nil, False, 'TaxiManager');
  if GetLastError = error_already_exists then
  begin
    Wnd := FindWindow('TFrmMain', 'TaxiManager v3.1');
    SetForegroundWindow(Wnd);
    ShowWindow(Wnd, SW_MAXIMIZE);
    Exit;
  end;

  TRT_GeneratorUpdater.UpdateAllGenerators;
  Application.Initialize;
  Application.Title := 'TaxiManager 3.1 alpha';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmMiniManager, FrmMiniManager);
  Application.Run;
  ReleaseMutex(Mutex);
end.

