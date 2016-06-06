--ivr Cession
SELECT
	abs(checksum(newid())),
	cast(debt.id as varchar),
	cast(phone.number as varchar),
	cast(gmt.code-4 as varchar)
FROM
	debt
	JOIN person on debt.parent_id=person.id
	JOIN (SELECT * from dict where parent_id=51) gmt on gmt.code=debt.gmt
	JOIN portfolio on portfolio.id=debt.r_portfolio_id
	JOIN phone on phone.parent_id=person.id

	--users
	inner join 
			(
			select
				wt.r_debt_id
			from
				[i_collect].[dbo].[work_task_log] as wt
				left join [i_collect].[dbo].[users] as u on wt.r_user_id = u.id
				left join [i_collect].[dbo].[department] as dep on u.r_department_id = dep.dep
			where
				(
				dep.r_dep in (8, 57,59, 3, 89)
				or
				dep.name like '%Хард%'
				or
				dep.name = 'Управление колл-центр'
				or 
				u.id in (1618, 1604,-1)
				)

				and wt.id in 
						(
							select
								max(id)
							from
								[i_collect].[dbo].[work_task_log]
							group by
								r_debt_id
						)
			)wt 	on debt.id = wt.r_debt_id

----PROM

	left join 
			(
				select
					pr.parent_id,
					pr.prom_date
				from
					[i_collect].[dbo].[debt_promise] as pr
				where
					pr.id in
							(
							select
								max(id)
							from
								[i_collect].[dbo].[debt_promise]
							group by
								parent_id
							)
				
				group by
					pr.parent_id,
					pr.prom_date

			)pr 	on debt.id = pr.parent_id

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
			
			)dc 	on debt.id = dc.parent_id
		

	WHERE
		debt.status not in (6, 7, 8, 10, 12, 14, 17, 9)
		and (pr.prom_date < dateadd(day, -3, getdate()) or pr.prom_date is null)
		and (dc.calc_date < dateadd(month, -2, getdate()) or dc.calc_date is null)
		and portfolio.status = 2
		and ((debt.currency = 1 and debt.debt_sum > 100) or (debt.currency in (2,3) and debt.debt_sum > 1))
		and portfolio.parent_id in (9,10,11,14,49,70)
		and phone.typ in (1,2,3,4)
		and phone.block_flag = 0
		and debt.id != 677625
		
