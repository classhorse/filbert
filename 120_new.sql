----------------------------------------
/**************120 Report**************/
----------------------------------------

use i_collect
go

--set nocount on

SELECT
	per.f + ' ' + per.i + ' ' + per.o 'ФИО'
	,cast(d.contract as varchar) + ' / ' + isnull(convert(varchar, d.credit_date, 104),'') 'Договор'
	,b.name 'Банк'
	,round(dbl.debt_sum, 2) 'Сумма_долга'
	,cast(v.fd as date) 'Дата_передачи'
	,sum(v.int_sum) 'Платеж'
	,isnull(sum(v.commission), '') / sum(v.int_sum) 'Процент'
	,isnull(sum(v.commission),'') 'Вознаграждение'
	,v.fio as 'Агент'
	,'' 'Переплата'
	,v.otdel 'Отдел'
	,datename(month, getdate()) 'Месяц'

FROM
	bank as b
	inner join portfolio as p on b.id = p.parent_id
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id

--смотрим закрепление за агентом {1}
--период оплат {2}
	inner join 
			(
			select
				v.parent_id
				,u.f + ' ' + substring(u.i, 1, 1) + '.' + substring(u.o, 1, 1) + '.' fio
				,sum(v.int_sum) int_sum
				,sum(v.commission) commission
				,d.name otdel
				,wt.fd
			from
				payment_v v
				inner join users u on v.r_user_id = u.id
				left join department d on u.r_department_id = d.dep
				--{1}
				left join
						(
						select
							wt.r_user_id
							,wt.fd
						from
							work_task_log wt
							inner join users u on wt.r_user_id = u.id
						where
							u.position like '%агент%'
							and wt.id in
									(
									select
										max(id) --{1}
									from
										work_task_log
									group by
										r_user_id
									)
						)wt
							on wt.r_user_id = v.r_user_id
				
			where
				v.dt between '01-05-2016 00:00:01' and '31-05-2016 23:59:59' --{2}
				and v.is_cancel = 0
				and v.is_confirmed = 1
				and u.position like '%агент%'
			group by
				v.parent_id
				,u.f + ' ' + substring(u.i, 1, 1) + '.' + substring(u.o, 1, 1) + '.'
				,d.name
				,wt.fd
			)v
				on d.id = v.parent_id
				
--смотрим баланс на дату закрепления за оператором {0}
	outer apply
			(
			select
				dbl.parent_id
				,dbl.debt_sum
			from
				debt_balance_log dbl
			where
				dbl.parent_id = v.parent_id
				and dbl.id in
							(
							select
								max(dbl.id)
							from
								debt_balance_log dbl
							where
								dbl.dt < v.fd 
								and dbl.debt_sum != 0
							group by
								dbl.parent_id
							)
			group by
				dbl.parent_id
				,dbl.debt_sum

			)dbl
			
WHERE
	b.id != 56

GROUP BY
	per.f
	,per.i
	,per.o
	,d.contract
	,d.credit_date
	,b.name
	,dbl.debt_sum
	,v.fd
	,v.fio
	,v.otdel

--set nocount off;

