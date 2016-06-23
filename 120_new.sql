--use i_collect
--go

set nocount on


SELECT
	per.f + ' ' + per.i + ' ' + per.o 'ФИО'
	,cast(d.contract as varchar) + ' / ' + isnull(convert(varchar, d.credit_date, 104),'') 'Договор'
	,b.name 'Банк'
	,round(dbl.debt_sum, 2) 'Сумма_долга'
	,cast(v.fd as date) 'Дата_передачи'
	,v.int_sum 'Платеж'
	,isnull(v.commission, '') / v.int_sum 'Процент'
	,isnull(v.commission,'') 'Вознаграждение'
	,v.fio as 'Агент'
	,'' 'Переплата'
	,v.name 'Отдел'
	,datename(month, getdate()) 'Месяц'


FROM
	bank as b
	inner join portfolio as p on b.id = p.parent_id
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id
	inner join 
			(
			select
				v.parent_id
				,wt.fio
				,sum(v.int_sum) int_sum
				,sum(v.commission) commission
				,wt.name
				,wt.fd
			from
				payment_v v
				inner join
						(
						select
							wt.r_debt_id
							,dep.name
							,wt.fd
							,u.f + ' ' + substring(u.i, 1, 1) + '.' + substring(u.o, 1, 1) + '.' fio
						from
							i_collect.dbo.work_task_log as wt
							left join i_collect.dbo.users as u on wt.r_user_id = u.id
							left join i_collect.dbo.department as dep on u.r_department_id = dep.dep
						where
							u.position like '%агент%'
							and wt.id in
									(
									select
										max(id)
									from
										i_collect.dbo.work_task_log
									group by
										r_debt_id
									)
						)wt
							on v.parent_id = wt.r_debt_id
			where
				v.dt between '01-05-2016 00:00:01' and '31-05-2016 23:59:59'
				and v.is_cancel = 0
				and v.is_confirmed = 1
			group by
				v.parent_id
				,wt.fio
				,wt.name
				,wt.fd
			)v
				on d.id = v.parent_id


	outer apply
			(
			select
				dbl.debt_sum
			from
				debt_balance_log dbl
			where
				dbl.parent_id = d.id
				and dbl.id in 
							(
							select
								max(id)
							from
								debt_balance_log
							where
								dt <= v.fd
							group by
								parent_id
							)
			
			)dbl

WHERE
	b.id != 56

set nocount off;