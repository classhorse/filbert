Просуживание


select
	d.id as 'ID Долга',
	d.contract as 'Кредитный договор',
	d.account as 'Лицевой счет',
	p.name as 'Портфель',
	wt.name as 'Отдел',
	p.sign_date as 'Дата подписания',
	per.f+' '+per.i+' '+per.o as 'ФИО должника',
	d.status as	'Статус долга',
	d.start_sum as 'Начальная сумма долга',
	d.debt_sum as 'Сумма долга',
	isnull(sum(dc.PP_kolvo),'') as 'Кол-во оплат',
	isnull(sum(dc.PP_sum),'') as 'Сумма оплат',
	(isnull(sum (dc.PP_sum),'')/d.start_sum)*100 as '% погашения',
	isnull(d.last_pay,'') as 'Последняя оплата',
	isnull(convert(varchar, dp.prom_date, 104),'') as 'Дата последнего обещания',
	sum(dc3.int_sum) as 'Сумма за посл. 3 мес.',
	cl.text as 'Результат последнего вызда'

from
	i_collect.dbo.bank as b
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
	inner join i_collect.dbo.person as per on d.parent_id = per.id

/*prom*/
	left join 
			(
				select
					dp.parent_id,
					dp.prom_date
				from
					[i_collect].[dbo].[debt_promise] as dp
				where
					dp.id in
							(
								select
									max(id)
								from
									[i_collect].[dbo].[debt_promise]
								group by
									parent_id
							)
				
				group by
					dp.parent_id,
					dp.prom_date

			)dp 	on d.id = dp.parent_id


/*users*/
	left join 
			(
				select
					wt.r_debt_id,
					dep.name
				from
					i_collect.dbo.work_task_log as wt
					left join i_collect.dbo.users as u on wt.r_user_id = u.id
					left join i_collect.dbo.department as dep on u.r_department_id = dep.dep
				where
					wt.id in 
							(
								select
									max(id)
								from
									i_collect.dbo.work_task_log
								group by
									r_debt_id
							)
			)wt 	on d.id = wt.r_debt_id

/*calc*/
	left join 
		( 
			select 
				dc.parent_id,
				sum(dc2.PP_sum) as PP_sum,
				sum(dc2.PP_kolvo) as PP_kolvo
			from 
				[i_collect].[dbo].[debt_calc] as dc
				left join 
						(
							select 
									dc2.id as id,

									(case 
										when 
											(
												dc2.int_sum is not null 
												and dc2.is_confirmed = 1 
												and dc2.is_cancel = 0
											)
										then dc2.int_sum
										else 0
									end) as PP_sum,				

									(case 
										when 
											(
												dc2.int_sum is not null 
												and dc2.is_confirmed = 1 
												and dc2.is_cancel = 0
											)
										then 1
										else 0 
									end) as PP_kolvo	

							from 
								[i_collect].[dbo].[debt_calc] as dc2

							group by							 
								dc2.is_confirmed,
								dc2.int_sum,
								dc2.is_cancel

							) dc2 on dc2.id=dc.id			

			group by
				dc.parent_id
			) dc on dc.parent_id = d.id

/*calc 3 month*/
	left join
			(
				select
					dc.parent_id,
					sum(dc.int_sum) as int_sum

				from
					i_collect.dbo.debt_calc as dc

				where
					dc.calc_date between dateadd(month, -3, getdate()) and getdate()

				group by
					dc.parent_id

			)dc3		on dc3.parent_id = d.id

/*last viezd*/
	left join
			(
				select	
					cl.r_debt_id,
					rs.text
				from
					i_collect.dbo.contact_log as cl
					left join
							(
								select
									code,
									text

								from
									i_collect.dbo.contact_result_set

							)rs		on rs.code = cl.result					

				where
					cl.typ = 2
					and cl.id in
								(
									select
										max(id)
									from
										i_collect.dbo.contact_log
									group by
										r_debt_id
								)


			)cl		on cl.r_debt_id = d.id


where
	d.debt_sum >= 6500
	and d.status not in (6,7,8,9,10)
