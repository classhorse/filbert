--{
declare @d1 date
declare @d2 date
--};

set @d1 = '13-11-2015'
set @d2 = '30-10-2015'
 
select

	d.id as 'ID Долга',
	per.id as 'ID Должника',
	isnull(d.[contract],'н/д') as 'Договор',
	isnull(d.account,0) as 'Лиц.счет',
	per.f+' '+per.i+' '+per.o as 'Фио должника',
	isnull(wt.name, 'н/д') as 'Подразделение',
	isnull(di.name, 'н/д') as 'Филиал',
	isnull(wt.fio, 'н/д') as 'Сотрудник'
	

from

	[i_collect].[dbo].[bank] as b
	inner join [i_collect].[dbo].[portfolio] as p on b.id = p.parent_id
	inner join [i_collect].[dbo].[debt] as d on p.id = d.r_portfolio_id
	inner join [i_collect].[dbo].[person] as per on d.parent_id=per.id


--USERS
	inner join 
			(
				select distinct

					u.id,
					wt.r_debt_id,
					dep.name,
					u.f+' '+u.i+' '+u.o as fio

				from

					[i_collect].[dbo].[work_task_log] as wt
					left join [i_collect].[dbo].[users] as u on wt.r_user_id = u.id
					left join [i_collect].[dbo].[department] as dep on u.r_department_id = dep.dep

				where

					u.depart = 'hard'
					and wt.id in
									(
										select

											max(id)

										from

											[i_collect].[dbo].[work_task_log]

										where

											fd < @d1

										group by

											r_debt_id

									)	

				


			)wt		on d.id = wt.r_debt_id


	left join
			(
				select

					d.parent_id,
					d.dt,
					d.status

				from

					i_collect.dbo.debt_status_log as d

				group by

					d.parent_id,
					d.dt,
					d.status


		)ds		on d.id = ds.parent_id
			


--Fillial
	left join
			(
				select

					d.code,
					d.name

				from

					i_collect.dbo.dict as d

				where

					d.parent_id = 39

			)di		on di.code = d.filial

where

	b.id = 67
	and p.id in (1803, 1804, 1814, 1815, 1825, 1838)
	and ds.status = 8
	and ds.dt >= '13-11-2015'
