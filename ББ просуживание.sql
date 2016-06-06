--ББ просуживание

select
	d.id as 'ID Долга',
	d.ext_id 'Филиал',
	d.contract as 'Кредитный договор',
	isnull(d.account,'') as 'Лицевой счет',
	p.name as 'Портфель',
	isnull(wt.name,'') as 'Отдел',
	convert(date, p.sign_date) as 'Дата подписания',
	per.f+' '+per.i+' '+per.o as 'ФИО должника',
	di.name as	'Статус долга',
	d.start_sum as 'Начальная сумма долга',
	d.debt_sum as 'Сумма долга',
	isnull(sum(dc.PP_kolvo),'') as 'Кол-во оплат',
	isnull(sum(dc.PP_sum),'') as 'Сумма оплат',
	/*%*/

	--isnull( isnull(sum (dc.PP_sum),'') / (d.debt_sum + sum(dc.PP_sum))*100,'') as '% погашения от начальной суммы долга',

	/*%*/
	isnull(convert(varchar, d.last_pay,104),'') as 'Последняя оплата',
	isnull(convert(varchar, dp.prom_date,104),'') as 'Дата последнего обещания',
	isnull(sum(dc1.PP_sum),'') as 'Оплат за месяц',
	isnull(sum(dc3.PP_sum),'') as 'Оплат 3 за месяцa',
	--(case
	--	when sum(six.PP_sum) is null
	--	then 0
	--	else 1
	--end) as six,

	--(case
	--	when sum(five.PP_sum) is null
	--	then 0
	--	else 1
	--end) as five,

	--(case
	--	when sum(four.PP_sum) is null
	--	then 0
	--	else 1
	--end) as four,

	--(case
	--	when sum(three.PP_sum) is null
	--	then 0
	--	else 1
	--end) as three,


	--(case
	--	when sum(two.PP_sum) is null
	--	then 0
	--	else 1
	--end) as two,

	--(case
	--	when sum(one.PP_sum) is null
	--	then 0
	--	else 1
	--end) as one,
	isnull(sum(one.PP_sum),'') '1',
	isnull(sum(two.PP_sum),'') '2',
	isnull(sum(three.PP_sum),'') '3',
	isnull(sum(four.PP_sum),'') '4',
	isnull(sum(five.PP_sum),'') '5',
	isnull(sum(six.PP_sum),'') '6',
	
	isnull(convert(varchar, clviezd.dt, 104),'') 'Дата последнего выезда',
	isnull(dbl.debt_sum,'') 'Сумма долга 3 мес. назад'

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




/*last viezd*/
	left join
			(
				select	
					cl.r_debt_id,
					cl.dt

				from
					i_collect.dbo.contact_log as cl			

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

/*status*/
	left join
			(
				select
					d.code,
					d.name
				from
					i_collect.dbo.dict as d
				where
					d.parent_id = 6

			)di		on d.status = di.code


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
								dc2.is_cancel,
								dc2.id,
								dc2.calc_date

							) dc2 on dc2.id=dc.id			

			group by
				dc.parent_id

			) dc on dc.parent_id = d.id

/*za mesyac*/
	left join
		( 
			select 
				dc.parent_id,
				sum(dc2.PP_sum) as PP_sum
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
									end) as PP_sum
																		
							from 
								[i_collect].[dbo].[debt_calc] as dc2

							group by
								dc2.is_confirmed,
								dc2.int_sum,
								dc2.is_cancel,
								dc2.id,
								dc2.calc_date

							) dc2 on dc2.id=dc.id			
			where
				dc.calc_date between dateadd(month, -1, getdate()) and getdate()
			group by
				dc.parent_id

			) dc1 on dc1.parent_id = d.id
			

/*za 3 mesyaca*/
	left join
		( 
			select 
				dc.parent_id,
				sum(dc2.PP_sum) as PP_sum
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
									end) as PP_sum
																		
							from 
								[i_collect].[dbo].[debt_calc] as dc2

							group by
								dc2.is_confirmed,
								dc2.int_sum,
								dc2.is_cancel,
								dc2.id,
								dc2.calc_date

							) dc2 on dc2.id=dc.id			
			where
				dc.calc_date between dateadd(month, -3, getdate()) and getdate()
			group by
				dc.parent_id

			) dc3 on dc3.parent_id = d.id

/*six*/
left join 
		( --платежи
			select 
				dc.parent_id,
				sum(dc2.PP_sum) as PP_sum
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
									end) as PP_sum

							from 
								[i_collect].[dbo].[debt_calc] as dc2

							group by							 
								dc2.is_confirmed,
								dc2.int_sum,
								dc2.id,
								dc2.is_cancel
							) dc2 on dc2.id=dc.id			
			where
				dc.calc_date between dateadd(month, -6, getdate()) and dateadd(month, -5, getdate())
			group by
				dc.parent_id
			)six on six.parent_id = d.id




/*five*/
left join 
		( --платежи
			select 
				dc.parent_id,
				sum(dc2.PP_sum) as PP_sum
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
									end) as PP_sum

							from 
								[i_collect].[dbo].[debt_calc] as dc2

							group by							 
								dc2.is_confirmed,
								dc2.int_sum,
								dc2.id,
								dc2.is_cancel
							) dc2 on dc2.id=dc.id			
			where
				dc.calc_date between dateadd(month, -5, getdate()) and dateadd(month, -4, getdate())
			group by
				dc.parent_id
			)five on five.parent_id = d.id



/*four*/
left join 
		( --платежи
			select 
				dc.parent_id,
				sum(dc2.PP_sum) as PP_sum
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
									end) as PP_sum

							from 
								[i_collect].[dbo].[debt_calc] as dc2

							group by							 
								dc2.is_confirmed,
								dc2.int_sum,
								dc2.id,
								dc2.is_cancel
							) dc2 on dc2.id=dc.id			
			where
				dc.calc_date between dateadd(month, -4, getdate()) and dateadd(month, -3, getdate())
			group by
				dc.parent_id
			)four on four.parent_id = d.id


/*three*/
left join 
		( --платежи
			select 
				dc.parent_id,
				sum(dc2.PP_sum) as PP_sum
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
									end) as PP_sum

							from 
								[i_collect].[dbo].[debt_calc] as dc2

							group by							 
								dc2.is_confirmed,
								dc2.int_sum,
								dc2.id,
								dc2.is_cancel
							) dc2 on dc2.id=dc.id			
			where
				dc.calc_date between dateadd(month, -3, getdate()) and dateadd(month, -2, getdate())
			group by
				dc.parent_id
			)three on three.parent_id = d.id


/*two*/
left join 
		( --платежи
			select 
				dc.parent_id,
				sum(dc2.PP_sum) as PP_sum
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
									end) as PP_sum

							from 
								[i_collect].[dbo].[debt_calc] as dc2

							group by							 
								dc2.is_confirmed,
								dc2.int_sum,
								dc2.id,
								dc2.is_cancel
							) dc2 on dc2.id=dc.id			
			where
				dc.calc_date between dateadd(month, -2, getdate()) and dateadd(month, -1, getdate())
			group by
				dc.parent_id
			)two on two.parent_id = d.id


/*one*/
	left join 
			( --платежи
				select 
					dc.parent_id,
					sum(dc2.PP_sum) as PP_sum
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
										end) as PP_sum

								from 
									[i_collect].[dbo].[debt_calc] as dc2

								group by							 
									dc2.is_confirmed,
									dc2.int_sum,
									dc2.id,
									dc2.is_cancel
								) dc2 on dc2.id=dc.id			
				where
					dc.calc_date between dateadd(month, -1, getdate()) and getdate()
				group by
					dc.parent_id
				)one on one.parent_id = d.id

/*Дата последнего выезда*/

	left join
			(
				select
					cl.r_debt_id,
					cl.dt
				from
					i_collect.dbo.contact_log as cl
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

				group by
					cl.r_debt_id,
					cl.dt

			)clviezd		on clviezd.r_debt_id = d.id

/*3 mes nazad summa*/
	left join
			(
				select
					dbl.parent_id,
					dbl.debt_sum
				from
					i_collect.dbo.debt_balance_log as dbl
				where
					dbl.id in
							(
								select
									max(id)
								from
									i_collect.dbo.debt_balance_log
								where
									dt < dateadd(month, -3, getdate() )
								group by
									parent_id
							)

				group by
					dbl.parent_id,
					dbl.debt_sum

			)dbl		on dbl.parent_id = d.id

	


where
	b.id = 63


group by
	d.id,
	d.contract,
	d.account,
	p.name,
	wt.name,
	p.sign_date,
	per.f,
	per.i,
	per.o,
	di.name,
	d.start_sum,
	d.debt_sum,
	d.last_pay,
	dp.prom_date,
	clviezd.dt,
	d.ext_id,
	dbl.debt_sum

