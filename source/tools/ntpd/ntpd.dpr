program ntpd;

uses
  Windows, Classes, SysUtils, IdTimeServer;

begin
  CreateMutex(nil, False, 'TaxiManagerNTPD');
  if GetLastError = ERROR_ALREADY_EXISTS then
    Exit;
  repeat
    try
      with TIdTimeServer.Create(nil) do
        try
          Active := True;
          repeat
            CheckSynchronize(1000);
          until False;
        finally
          Free;
        end;
    except
      Sleep(1000);
    end;
  until False;
end.
