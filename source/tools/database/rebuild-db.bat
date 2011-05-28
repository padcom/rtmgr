@echo off
rem bin2sql.exe 
call isql -u SYSDBA -p masterkey RTMGR < rtmgr-database-drop.sql
call isql < rtmgr-database.sql
call isql -u SYSDBA -p masterkey RTMGR -i rtmgr-tables.sql
rem call isql -u SYSDBA -p masterkey RTMGR -i rtmgr.sql

call isql -u SYSDBA -p masterkey RTMGR -i rtmgr-data-ulica.sql
call isql -u SYSDBA -p masterkey RTMGR -i rtmgr-data-obszar.sql
call isql -u SYSDBA -p masterkey RTMGR -i rtmgr-data-taksowka.sql
call isql -u SYSDBA -p masterkey RTMGR -i rtmgr-data-postoj.sql
call isql -u SYSDBA -p masterkey RTMGR -i rtmgr-data-postojnaulicy.sql
call isql -u SYSDBA -p masterkey RTMGR -i rtmgr-data-taksowkanapostoju.sql
call isql -u SYSDBA -p masterkey RTMGR -i rtmgr-data-kurs.sql

updtegens.exe ULICA
updtegens.exe POSTOJ
updtegens.exe OBSZAR
updtegens.exe TAKSOWKA
updtegens.exe KLIENT
updtegens.exe KURS
updtegens.exe POSTOJNAULICY
updtegens.exe TAKSOWKANAPOSTOJU

