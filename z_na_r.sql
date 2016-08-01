--З_НА_Р

SELECT distinct
	d.id 'ID долга'
	,per.f + ' ' + per.i + ' ' + per.o 'ФИО должника'
	,d.debt_sum 'Остаток'

FROM
	bank as b
	inner join portfolio as p on b.id = p.parent_id
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id
	
	/*users*/
	inner join 
			(
			select
				wt.r_debt_id,
				u.id
			from
				i_collect.dbo.work_task_log as wt
				left join i_collect.dbo.users as u on wt.r_user_id = u.id
				left join i_collect.dbo.department as dep on u.r_department_id = dep.dep
			where
				u.f like 'Турпет%'
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
				on d.id = wt.r_debt_id

----CALC
	left join 
			(
				select
					dc.parent_id,
					dc.calc_date
				from
					[i_collect].[dbo].[debt_calc] as dc
				where
					dc.is_confirmed = 1
					and dc.is_cancel = 0
					and dc.id in 
								(
									select
										max(id)
									from 
										[i_collect].[dbo].[debt_calc]
									group by
										parent_id
								)
				group by
					dc.parent_id,
					dc.calc_date
			
			)dc 	on d.id = dc.parent_id

			
WHERE
	d.debt_sum !< 10000
	and d.int_color not in (11, 10, 2, 3, 12)
	and (dc.calc_date < '01-01-2016' or dc.calc_date is null)
	and d.id not in 
					(
					select
						cl.r_debt_id
					from
						contact_log cl
					where
						cl.dsc like '%заяв%розы%'
					)
	
	and d.id not in
					(
					select
						cl.r_debt_id
					from
						contact_log cl
					where
						cl.dsc like '%З на Р%'
					)