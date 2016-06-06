--{
declare @d1 date
declare @d2 date
--};

set @d1 = '01-10-2015'
set @d2 = '30-10-2015'
 
select
	b.name as 'Банк',
	isnull(wt.name, 'н/д') as 'Подразделение',
	isnull(di.name, 'н/д') as 'Филиал',
	isnull(wt.fio, 'н/д') as 'Сотрудник',
	count(dsl.parent_id) as 'Портфель, шт.',
	sum(dbl.debt_sum) as 'Портфель, руб',
	isnull(sum(dc.PP_kolvo),0) as 'Платежи, шт',
	isnull(sum(dc.PP_sum),0) as 'Платежи, руб',
	isnull(sum(dc.PP_sum),0)/sum(dbl.debt_sum) as 'Эффективность',
	isnull(sum(cl.ish_zvon),0) as 'Звонки, шт',
	isnull(sum(cl.ish_zvon),0)/count(dsl.parent_id) as '% охвата звонком',
	isnull(sum(cl.viezdi),0) as 'Выезды, шт',
	isnull(sum(cl.viezdi),0)/count(dsl.parent_id) as '% охвата выездом'

from
	[i_collect].[dbo].[bank] as b
	inner join [i_collect].[dbo].[portfolio] as p on b.id = p.parent_id
	inner join [i_collect].[dbo].[debt] as d on p.id = d.r_portfolio_id

--status
	inner join 
			(
				select
					dsl.parent_id
				from
					[i_collect].[dbo].[debt_status_log] as dsl
				where
					dsl.id in
							(
								select
									max(d.id)
								from
									[i_collect].[dbo].[debt_status_log] as d
								where
									d.dt < @d1
								group by
									d.parent_id
							)

					and dsl.status not in (6,7,8,10)
					and dsl.mark1 in (2, 4)
				
				group by
					dsl.parent_id					

			)dsl	on d.id = dsl.parent_id

--balance
	left join 
			(
				select
					dbl.parent_id,
					dbl.debt_sum
				from
					[i_collect].[dbo].[debt_balance_log] as dbl
				where
					dbl.id in
							(
								select
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

			)dbl	on d.id = dbl.parent_id

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
					and (wt.id in
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
									
								or wt.fd between @d1 and @d2
						) 

				


			)wt		on d.id = wt.r_debt_id


--calc
	left join 
			(
				select 
					dc.parent_id,
					dc.id,
					sum(dc2.PP_sum) as PP_sum,
					sum(dc2.PP_kolvo) as PP_kolvo

				from
					[i_collect].[dbo].[debt_calc] as dc

					left join
							(
								select
									dc2.id as id,

								--{
									(case
										when (dc2.int_sum is not null and dc2.is_confirmed = 1 and dc2.is_cancel = 0)
										then dc2.int_sum
										else 0
									end) as PP_sum,

									(case
										when (dc2.int_sum is not null and dc2.is_confirmed = 1 and dc2.is_cancel = 0)
										then 1
										else 0
									end) as PP_kolvo
								--};
							
								from 
									[i_collect].[dbo].[debt_calc] as dc2

								group by 
									dc2.id,
									dc2.is_confirmed,
									dc2.int_sum,
									dc2.calc_date,
									dc2.is_cancel

							)	dc2 on dc2.id=dc.id

				where
					dc.calc_date between @d1 and @d2
				group by
					dc.id,
					dc.parent_id

			)dc		on dc.parent_id = d.id


--звонки, выезды
	left join 
			(
				select
					cl.r_debt_id,
				--{
					sum(case
							when (cl.typ = 1 and cl.result != 0)
							then 1
							else 0
						end) as ish_zvon,
					sum(case
							when (cl.typ = 2)
							then 1
							else 0
						end) as viezdi
				--};
						
				from
					[i_collect].[dbo].[contact_log] as cl
				where
					cl.dt between @d1 and @d2
				group by
					cl.r_debt_id

			)cl		on cl.r_debt_id = d.id

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
	wt.fio is not null
	and wt.name is not null

group by
	b.name,
	wt.name,
	wt.fio,
	di.name