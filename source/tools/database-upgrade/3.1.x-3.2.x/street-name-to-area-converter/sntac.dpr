program sntac;

{$APPTYPE CONSOLE}

uses
  Classes, SysUtils, jvuib, jvuiblib,
  Options in 'cui\Options.pas',
  CaseToAreaIdGenerator in 'core\CaseToAreaIdGenerator.pas',
  UlicaIterator in 'core\UlicaIterator.pas';

type
  TCallback = class (TObject)
    class procedure Process(Sender: TObject; Ulica: TSQLResult);
  end;

{ TCallback }

class procedure TCallback.Process(Sender: TObject; Ulica: TSQLResult);
begin
  with TCaseToAreaIdGenerator.Create do
    try
      IdForLowercaseStreet := TOptions.Instance.IdForLowerCase;
      IdForUppercaseStreet := TOptions.Instance.IdForUpperCase;
      Writeln(CreateUpdateStatement(Ulica.Values['Id'], Ulica.Values['Nazwa']));
    finally
      Free;
    end;
end;

var
  Database: TJvUIBDataBase;
  Transaction: TJvUIBTransaction;
  Iterator: TUlicaIterator;

begin
  Database := TJvUIBDataBase.Create(nil);
  try
    Database.UserName := 'SYSDBA';
    Database.PassWord := 'masterkey';
    Database.DatabaseName := TOptions.Instance.Database;
    Database.Connected := True;
    Transaction := TJvUIBTransaction.Create(nil);
    try
      Transaction.Database := Database;
      Iterator := TUlicaIterator.Create;
      try
        Iterator.Database := Database;
        Iterator.Transaction := Transaction;
        Iterator.OnProcess := TCallback.Process;
        Iterator.Iterate('SELECT ID, NAZWA FROM ULICA');
      finally
        Iterator.Free;
      end;
    finally
      Transaction.Free;
    end;
  finally
    Database.Free;
  end
end.

