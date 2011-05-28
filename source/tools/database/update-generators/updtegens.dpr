program updtgens;

{$APPTYPE CONSOLE}

uses
  Classes, SysUtils, jvuib;

var
  Database: TJvUIBDatabase;
  Transaction: TJvUIBTransaction;
  Query: TJvUIBQuery;
  ID: Integer;

begin
  Database := TJvUIBDataBase.Create(nil);
  try
    Database.UserName := 'SYSDBA';
    Database.PassWord := 'masterkey';
    Database.DatabaseName := ':RTMGR';
    Database.Connected := True;
    Transaction := TJvUIBTransaction.Create(nil);
    try
      Transaction.Database := Database;
      Query := TJvUIBQuery.Create(nil);
      try
        Query.DataBase := Database;
        Query.Transaction := Transaction;
        Query.SQL.Text := Format('SELECT MAX(ID) FROM %s', [ParamStr(1)]);
        Query.Open;
        ID := Query.Fields.AsInteger[0];
        Writeln(ID);
        Query.Close(etmCommit);
        Query.SQL.Text := Format('SET GENERATOR %s_ID TO %d', [ParamStr(1), ID]);
        Query.ExecSQL;
        Transaction.Commit;
      finally
        Query.Free;
      end;
    finally
      Transaction.Free;
    end;
  finally
    Database.Free;
  end;
end.
