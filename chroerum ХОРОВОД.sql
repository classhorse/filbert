--------------------------------------------------------------------------------
/*
#5
*/

select * into tmp_campaign_1 from [INFINITY2].[Cx_Work].[public].[Table_5052709673]; --экземпляр # кампании
delete from [INFINITY2].[Cx_Work].[public].[Table_5052709673]; --очищает оригинал # кампании
insert into [INFINITY2].[Cx_Work].[public].[Table_5052709673] --вставляем в оригинал # кампании:
	(
	ID
	,[State]
	,[ID_долга]
	,[Банк]
	,[Фамилия]
	,[Имя]
	,[Отчество]
	,[Остаток_долга]
	,[Часовой_пояс]
	,[Телефон1]
	,[Телефон2]
	,[Телефон3]
	,[Телефон4]
	,[Телефон5]
	,[Телефон6]
	,[Телефон7]
	,[Телефон8]
	,[Телефон9]
	,[Телефон10]
	,[Телефон11]
	,[Телефон12]
	,[Телефон13]
	,[Телефон14]
	,[Телефон15]
	,[Телефон_для_перезвона]
	,[Дата_перезвона]
	,[ПерсональныйОператор]
	)

select --значения из измененной таблицы
	tc1.ID
	,tc1.State
	,tc1.[ID_долга]
	,tc1.[Банк]
	,tc1.[Фамилия]
	,tc1.[Имя]
	,tc1.[Отчество]
	,tc1.[Остаток_долга]
	,tc1.[Часовой_пояс]
	,tc1.[Телефон1]
	,tc1.[Телефон2]
	,tc1.[Телефон3]
	,tc1.[Телефон4]
	,tc1.[Телефон5]
	,tc1.[Телефон6]
	,tc1.[Телефон7]
	,tc1.[Телефон8]
	,tc1.[Телефон9]
	,tc1.[Телефон10]
	,tc1.[Телефон11]
	,tc1.[Телефон12]
	,tc1.[Телефон13]
	,tc1.[Телефон14]
	,tc1.[Телефон15]
	,tc1.[Телефон_для_перезвона]
	,tc1.[Дата_перезвона]
	,tc1.[ПерсональныйОператор]
from 
	tmp_campaign_1 tc1
	left join
			(
			select
				cl.r_debt_id
				,cl.dt
			from
				i_collect.dbo.contact_log cl
			where
				cl.typ = 1
				and cl.id in
						(
						select
							max(id)
						from
							contact_log
						group by
							r_debt_id
						)		
			group by
				cl.r_debt_id
				,cl.dt
			
			)cl on cl.r_debt_id = tc1.[ID_долга]
where
	tc1.[ID_долга] not in
				(
				select
					d.id
				from
					i_collect.dbo.debt d
				where
					d.status in (6,7,8,10)
				group by
					d.id
				)
	or tc1.[ID_долга] not in
				(
				select
					wt.r_debt_id
				from
					i_collect.dbo.work_task_log as wt
					left join i_collect.dbo.users as u on wt.r_user_id = u.id
				where
					u.id not in (1604, -1)										
					and wt.id in 
							(
							select
								max(id)
							from
								i_collect.dbo.work_task_log
							group by
								r_debt_id
							)
				group by
					wt.r_debt_id
				)
	
order by
	cl.dt asc




;

UPDATE [INFINITY2].[Cx_Work].[public].[Table_5052709673]
set [State] = null
where [State] is not null