unit RT_Base;

interface

type
  TZestawienieKind = (zkDzien, zkOkres);

const
  ridPostoj = 1001;
  ridUlica = 1002;
  ridTaksowka = 1003;
  ridKurs = 1004;
  ridKlient = 1005;

type
  TRTBaseRec = packed object
    Kind       : Integer;
    Size       : Word;
    ID         : Integer;
    Flags      : Word;
  end;

  PRTPostojRec = ^TRTPostojRec;
  TRTPostojRec = packed object (TRTBaseRec)
    Nazwa      : array[0..79] of Char;
  end;

  PRTUlicaRec = ^TRTUlicaRec;
  TRTUlicaRec = packed object (TRTBaseRec)
    Nazwa      : array[0..79] of Char;
    Poczatek   : array[0..5] of Char;
    Koniec     : array[0..5] of Char;
    Postoje    : array[1..8] of Integer;
  end;

  PRTTaksowkaRec = ^TRTTaksowkaRec;
  TRTTaksowkaRec = packed object (TRTBaseRec)
    NrBoczny   : array[0..9] of Char;
    NrWywol    : array[0..9] of Char;
    Nazwa      : array[0..79] of Char;
  end;

const
  // sta³e dla flag kursu
  kfZamowiony  = 1 shl 0;
  kfInformacja = 1 shl 1;
  kfWyslany    = 1 shl 2;

type
  PRTKursRec = ^TRTKursRec;
  TRTKursRec = packed object (TRTBaseRec)
    UlicaID    : Integer;
    Ulica      : array[0..79] of Char;
    Dom        : array[0..5] of Char;
    Mieszk     : array[0..5] of Char;
    TaksowkaID : Integer;
    Przyjecie  : TDateTime;
    Realizacja : TDateTime;
    Shift      : Double;
  end;

  PRTKlientRec = ^TRTKlientRec;
  TRTKlientRec = packed object (TRTBaseRec)
    Nazwa      : array[0..79] of Char;
    UlicaID    : Integer;
    Ulica      : array[0..79] of Char;
    Dom        : array[0..5] of Char;
    Mieszk     : array[0..5] of Char;
    Telefon    : array[0..14] of Char;
  end;
  
implementation

end.

