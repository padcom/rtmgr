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

const
  // sta³e dla flag kursu
  kfZamowiony   = 1 shl 0;
  kfInformacja  = 1 shl 1;
  kfWyslany     = 1 shl 2;
  kfPudlo       = 1 shl 3;
  kfWykozystane = 1 shl 4;

implementation

end.

