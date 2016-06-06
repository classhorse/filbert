--Brain

ivrCessionPostgreSQL --таблица с ID varchar
CellForCessionIvrTrigger --job для ячейки
ivrCession --trigger


--ПОЧИТАть!!!! 
https://msdn.microsoft.com/ru-ru/library/ms191300(v=sql.120).aspx


create trigger ivrCession ON ivrCessionPostgreSQL

for INSERT
AS 
BEGIN

 if 
  exists(select * from inserted where ID is null)
 
 begin
  insert openquery(INFINITY, 'select * from "table"')
  select
   *
  from
   table1;

  exec xp_cmdshell 'start http://yandex.ru'; --тут будет HTTP запрос который запускает дайлер
  
  waitfor delay '00:00:07.000';

  exec xp_cmdshell 'tskill iexplore';

  exec xp_cmdshell 'exit'
