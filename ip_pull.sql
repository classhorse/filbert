use i_collect;
go

with 
	
	__le_max as
			(
			select
				max(id) id
			from
				law_exec 
			group by
				r_debt_id
			)

	,le as 
			(
			select
				d.id
				,b.id bank_id
				,d.total_sum 
				,cast(le.load_dt as date) dt
			from
				bank as b
				inner join portfolio as p on b.id = p.parent_id
				inner join debt as d on p.id = d.r_portfolio_id
				inner join law_exec le on le.r_debt_id = d.id
				inner join __le_max lm on lm.id = le.id
			where
				le.load_dt is not null
			)

	,____dbl as 
			(
			select
				max(dbl.id) id
			from
				le 
				left join debt_balance_log dbl on dbl.parent_id = le.id
			where
				dbl.dt !> le.dt
			group by
				dbl.parent_id				
			)

	,dbl as
			(
			select
				dbl.parent_id
				,dbl.debt_sum
			from
				debt_balance_log dbl
				inner join ____dbl d on d.id = dbl.id
			)
	
	,c1 as
			(
			select
				dc.parent_id
				,cast(dc.calc_date as date) dt
				,sum(dc.int_sum) s
			from
				debt_calc dc
				left join le on le.id = dc.parent_id
			where
				dc.is_cancel = 0
				and dc.is_confirmed = 1
				and dc.calc_date between le.dt and dateadd(month, 1, le.dt)
			group by
				dc.parent_id
				,cast(dc.calc_date as date)
			)

	,c2 as
			(
			select
				dc.parent_id
				,cast(dc.calc_date as date) dt
				,sum(dc.int_sum) s
			from
				debt_calc dc
				left join le on le.id = dc.parent_id
			where
				dc.is_cancel = 0
				and dc.is_confirmed = 1
				and dc.calc_date between dateadd(month, 1, le.dt) and dateadd(month, 2, le.dt)
			group by
				dc.parent_id
				,cast(dc.calc_date as date)
			)

	,c3 as
			(
			select
				dc.parent_id
				,cast(dc.calc_date as date) dt
				,sum(dc.int_sum) s
			from
				debt_calc dc
				left join le on le.id = dc.parent_id
			where
				dc.is_cancel = 0
				and dc.is_confirmed = 1
				and dc.calc_date between dateadd(month, 2, le.dt) and dateadd(month, 3, le.dt)
			group by
				dc.parent_id
				,cast(dc.calc_date as date)
			)

	,c4 as
			(
			select
				dc.parent_id
				,cast(dc.calc_date as date) dt
				,sum(dc.int_sum) s
			from
				debt_calc dc
				left join le on le.id = dc.parent_id
			where
				dc.is_cancel = 0
				and dc.is_confirmed = 1
				and dc.calc_date between dateadd(month, 3, le.dt) and dateadd(month, 4, le.dt)
			group by
				dc.parent_id
				,cast(dc.calc_date as date)
			)

	,c5 as
			(
			select
				dc.parent_id
				,cast(dc.calc_date as date) dt
				,sum(dc.int_sum) s
			from
				debt_calc dc
				left join le on le.id = dc.parent_id
			where
				dc.is_cancel = 0
				and dc.is_confirmed = 1
				and dc.calc_date between dateadd(month, 4, le.dt) and dateadd(month, 5, le.dt)
			group by
				dc.parent_id
				,cast(dc.calc_date as date)
			)


	,c6 as
			(
			select
				dc.parent_id
				,cast(dc.calc_date as date) dt
				,sum(dc.int_sum) s
			from
				debt_calc dc
				left join le on le.id = dc.parent_id
			where
				dc.is_cancel = 0
				and dc.is_confirmed = 1
				and dc.calc_date between dateadd(month, 5, le.dt) and dateadd(month, 6, le.dt)
			group by
				dc.parent_id
				,cast(dc.calc_date as date)
			)

	,c7 as
			(
			select
				dc.parent_id
				,cast(dc.calc_date as date) dt
				,sum(dc.int_sum) s
			from
				debt_calc dc
				left join le on le.id = dc.parent_id
			where
				dc.is_cancel = 0
				and dc.is_confirmed = 1
				and dc.calc_date between dateadd(month, 6, le.dt) and dateadd(month, 7, le.dt)
			group by
				dc.parent_id
				,cast(dc.calc_date as date)
			)

	,c8 as
			(
			select
				dc.parent_id
				,cast(dc.calc_date as date) dt
				,sum(dc.int_sum) s
			from
				debt_calc dc
				left join le on le.id = dc.parent_id
			where
				dc.is_cancel = 0
				and dc.is_confirmed = 1
				and dc.calc_date between dateadd(month, 8, le.dt) and dateadd(month, 9, le.dt)
			group by
				dc.parent_id
				,cast(dc.calc_date as date)
			)

	,c9 as
			(
			select
				dc.parent_id
				,cast(dc.calc_date as date) dt
				,sum(dc.int_sum) s
			from
				debt_calc dc
				left join le on le.id = dc.parent_id
			where
				dc.is_cancel = 0
				and dc.is_confirmed = 1
				and dc.calc_date between dateadd(month, 9, le.dt) and dateadd(month, 10, le.dt)
			group by
				dc.parent_id
				,cast(dc.calc_date as date)
			)

	,c10 as
			(
			select
				dc.parent_id
				,cast(dc.calc_date as date) dt
				,sum(dc.int_sum) s
			from
				debt_calc dc
				left join le on le.id = dc.parent_id
			where
				dc.is_cancel = 0
				and dc.is_confirmed = 1
				and dc.calc_date between dateadd(month, 10, le.dt) and dateadd(month, 11, le.dt)
			group by
				dc.parent_id
				,cast(dc.calc_date as date)
			)

	,c11 as
			(
			select
				dc.parent_id
				,cast(dc.calc_date as date) dt
				,sum(dc.int_sum) s
			from
				debt_calc dc
				left join le on le.id = dc.parent_id
			where
				dc.is_cancel = 0
				and dc.is_confirmed = 1
				and dc.calc_date between dateadd(month, 11, le.dt) and dateadd(month, 12, le.dt)
			group by
				dc.parent_id
				,cast(dc.calc_date as date)
			)


SELECT 
	
	cast(datename(month, le.dt) as varchar(16)) + ' ' +cast(datename(year, le.dt) as varchar) 'Месяц возбуждения ИП'
	,sum(le.total_sum) 'Сумма требования'
	,sum(dbl.debt_sum) 'Остаток на дату возбуждения ИП'
	,sum(c1.s) 'Платежи в течение 1 кал мес с даты ИП'
	,sum(c2.s) 'Платежи в течение 2 кал мес с даты ИП'
	,sum(c3.s) 'Платежи в течение 3 кал мес с даты ИП'
	,sum(c4.s) 'Платежи в течение 4 кал мес с даты ИП'
	,sum(c5.s) 'Платежи в течение 5 кал мес с даты ИП'
	,sum(c6.s) 'Платежи в течение 6 кал мес с даты ИП'
	,sum(c7.s) 'Платежи в течение 7 кал мес с даты ИП'
	,sum(c8.s) 'Платежи в течение 8 кал мес с даты ИП'
	,sum(c9.s) 'Платежи в течение 9 кал мес с даты ИП'
	,sum(c10.s) 'Платежи в течение 10 кал мес с даты ИП'
	,sum(c11.s) 'Платежи в течение 11 кал мес с даты ИП'

FROM
	le 
	left join dbl on dbl.parent_id = le.id
	left join c1 on c1.parent_id = le.id
	left join c2 on c2.parent_id = le.id
	left join c3 on c3.parent_id = le.id
	left join c4 on c4.parent_id = le.id
	left join c5 on c5.parent_id = le.id
	left join c6 on c6.parent_id = le.id
	left join c7 on c7.parent_id = le.id
	left join c8 on c8.parent_id = le.id
	left join c9 on c9.parent_id = le.id
	left join c10 on c10.parent_id = le.id
	left join c11 on c11.parent_id = le.id





	
WHERE
	le.bank_id = 10

GROUP BY
	cast(datename(month, le.dt) as varchar(16)) + ' ' +cast(datename(year, le.dt) as varchar)
	,datepart(month, le.dt)
	,datepart(year, le.dt) 

order by
	datepart(year, le.dt) asc
	,datepart(month, le.dt) asc

