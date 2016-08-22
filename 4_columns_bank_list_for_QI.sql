/*	пытаюсь замутить банки, а в дальнейшем и портфели в 4 колонки
	дерзко вставить не получается, нужна сцепка
	Сергей предложил по row_number
	как вариант, но стоит еще задуматься..

	пока в стадии разработки
*/

use i_collect;
go

if OBJECT_ID('#count_active_banks') is not null
	drop table #count_active_banks
if OBJECT_ID('#active_banks') is not null
	drop table #active_banks

declare @i int

;with 
	/*	active portfolio
	*/
	portf as (
		select parent_id id
		from portfolio
		where status  = 2
	)
	/*	active banks
	*/
	,b_p as (

		select distinct	b.id, N''+ b.name as Bank
		from bank as b
			 inner join portf p on p.id = b.id
	)

/*	create and instert in temp table list of active banks	
*/
select * into #active_banks from b_p								


;with 
/*	quantity of active banks
*/
	__len as (select count(*) i from #active_banks)

select i into #count_active_banks from __len


;set @i = (select i from #count_active_banks)

--create table #4_column_of_banks (id int, bank varchar(32), id2 int, bank2 varchar(32))
insert into #4_column_of_banks (bank)  (
	

select
	fid.bank
from	
	(
	select id, bank
	from #active_banks
	order by
		id asc
		offset 0 rows
		fetch next cast(round(cast(@i as float) / 2, 0) as int) rows only
	)fid

)

;select * from #4_column_of_banks

