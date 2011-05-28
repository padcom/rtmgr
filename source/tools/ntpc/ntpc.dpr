program ntpc;

uses
  Windows, SysUtils, IdTime, PxSettings;

begin
  CreateMutex(nil, False, 'TaxiManagerNTPC');
  if GetLastError = ERROR_ALREADY_EXISTS then
    Exit;
  repeat
    Sleep(10000);
    try
      with TIdTime.Create(nil) do
        try
          Host := IniFile.ReadString('settings', 'host', '127.0.0.1');
          SyncTime;
        finally
          Free;
        end;
    except
    end;
  until False;
end.
