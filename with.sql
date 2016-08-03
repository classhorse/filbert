




declare @d1 datetime
declare @d2 datetime
declare @d int

declare @bilo int
declare @stalo int


;with 
	__closed_mx as 
			(
			select
				max(id) id
			from
				i_collect.dbo.debt_status_log
			where
				dt !< dateadd(week, -1, getdate())
				and status in (6,7,8,10)
			group by
				parent_id
			)

	,_closed as
			(
			select
				parent_id
			from
				i_collect.dbo.debt_status_log dbl
				inner join __closed_mx on __closed_mx.id = dbl.id
			)

	
	
	
	select * into #closed from _closed

					
set @d1 = getdate()
set @bilo = (select count(*) from [INFINITY2].[Cx_Work].[public].[Table_5000081023])

	delete from [INFINITY2].[Cx_Work].[public].[Table_5000081023]
	where [ID] in (select parent_id from #closed)

set @d2 = getdate()

set @d = datediff(second, @d1, @d2)
set @stalo = (select count(*) from [INFINITY2].[Cx_Work].[public].[Table_5000081023])

select 
	'Ожидание= ' + cast(@d as varchar(16)) + ' секунд'
	,'Было: ' + cast(@bilo as varchar(16)) 
	,'Стало: ' + cast(@stalo as varchar(16))

drop table #closed
