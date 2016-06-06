
declare @d1 date
declare @d2 date

set @d1 = '01-09-2015'
set @d2 = '30-09-2015'
 
select 
	b.name as 'Банк',
	wt.name	as 'Подразделение',
	wt.fio as 'Сотрудник',
	d.debt_sum as 'Сумма долгов',
	sum(dbl.debt_sum) as 'Сумма долга',
	count(dsl.parent_id) as 'Кол-во долгов'

from
	[i_collect].[dbo].[bank] as b
	inner join [i_collect].[dbo].[portfolio] as p on b.id = p.parent_id
	inner join [i_collect].[dbo].[debt] as d on p.id = d.r_portfolio_id

--status
	left join (select
					dsl.parent_id
				from
					[i_collect].[dbo].[debt_status_log] as dsl
				where
					dsl.id in
							(select
								max(d.id)
							from
								[i_collect].[dbo].[debt_status_log] as d
							where
								d.dt < @d1
							group by
								d.parent_id
							)
					and dsl.status not in (6,7,8,10)
				
				group by
					dsl.parent_id					

				) dsl on d.id = dsl.parent_id

--compare
	left join (select
					dbl.parent_id,
					dbl.debt_sum
				from
					[i_collect].[dbo].[debt_balance_log] as dbl
				where
					dbl.id in

							(select
								max(d.id)
							from
								[i_collect].[dbo].[debt_balance_log] as d
							where
								d.dt < @d1
							group by
								d.parent_id
							)
							
				group by
					dbl.parent_id,
					dbl.debt_sum

				) dbl on d.id = dbl.parent_id

--USERS
	left join (select
					wt.r_debt_id,
					dep.name,
					u.f+' '+u.i+' '+u.o as fio

				from
					[i_collect].[dbo].[work_task_log] as wt
					left join [i_collect].[dbo].[users] as u on wt.r_user_id = u.id
					left join [i_collect].[dbo].[department] as dep on u.r_department_id = dep.dep
				where
					wt.id in (select
									max(id)
								from
									[i_collect].[dbo].[work_task_log]
								group by
									r_debt_id
								)

					and wt.fd < @d2

				) as wt on d.id = wt.r_debt_id


--calc
left join (select 
				dc.parent_id,
				dc.id,
				sum(dc2.PP_sum) as PP_sum,
				sum(dc2.PP_kolvo) as PP_kolvo

			from 
				[i_collect].[dbo].[debt_calc] as dc
				left join 

					(select dc2.id as id,
						(case 
							when (dc2.int_sum is not null and dc2.is_confirmed='1')
							then dc2.int_sum
							else 0
						end) as PP_sum,				

						(case 
							when (dc2.int_sum is not null and dc2.is_confirmed='1')
							then 1
							else 0 
						end) as PP_kolvo
							
					from [i_collect].[dbo].[debt_calc] as dc2
					group by 
						dc2.is_confirmed,
						dc2.int_sum,
						dc2.calc_date
					) dc2 on dc2.id=dc.id

			where 
				dc.calc_date between @d1 and @d2
					
			group by
				dc.parent_id
			) dc on dc.parent_id = d.id


--звонки, выезды
	left join (select 
					cl.r_debt_id,
					sum(case
							when (cl.typ = 19)
							then 1
							else 0
						end) as ivr_vsego,
					sum(case
							when (cl.typ = 19 and cl.result = 733)
							then 1
							else 0
						end) as ivr_dost,
					sum(case
							when (cl.typ = 1 and cl.result != 0)
							then 1
							else 0
						end) as ish_zvon,
					sum(case
							when (cl.typ = 3)
							then 1
							else 0
						end) as vhod_zvon,
					sum(case
							when (cl.typ = 2)
							then 1
							else 0
						end) as viezdi,
					sum (case
							when (cl.typ = 6)
							then 1
							else 0
						end) as pisma,
					sum(case
							when cl.typ not in (6,2,3,1,19)
							then 1
							else 0
						end) as prochee
						
				from
					[i_collect].[dbo].[contact_log] as cl
				group by
					cl.r_debt_id

				) as cl on d.id = cl.r_debt_id





group by
	d.id,
	d.debt_sum
