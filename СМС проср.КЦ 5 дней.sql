select distinct
	d.id
	--dp.number
from
	debt d

--prom
	inner join
		(
			select
				dp.parent_id
				,dp.dt
				,dp.id

			from
				debt_promise dp

			where
				datediff(day, dp.prom_date, getdate()) = 5
				and dp.id in
					(
						select
							max(id)
						from
							debt_promise
						where
							(cover_sum < dp.prom_sum or cover_sum is null)
						group by
							parent_id
					)

		)dp		on d.id = dp.parent_id

--call center
	inner join
		(
			select
				wt.r_debt_id
			from
				work_task_log as wt
				left join users as u on wt.r_user_id = u.id
				left join department as dep on u.r_department_id = dep.dep
			where
				dep.name like '%колл%'
				and wt.id in
					(
						select
							max(id)
						from
							i_collect.dbo.work_task_log
						group by
							r_debt_id
					)

		)wt		on wt.r_debt_id = d.id






where
	d.status not in (6,7,8,9,10,12,14,17)
	and d.id not in
		(
			select 
				cl.r_debt_id
			from
				debt d
				inner join 
					(
						select
							dp.parent_id,
							dp.id,
							dp.dt
						from
							debt_promise dp 
						where
							dp.id in
								(
									select
										max(id)
									from
										debt_promise
									group by
										parent_id

								)
							and DATEDIFF(day, dp.prom_date, GETDATE()) = 5

					)dp		on d.id = dp.parent_id

				outer apply 
					(
						select
							cl.r_debt_id
						from
							contact_log cl
							inner join contact_result_set rs on cl.result = rs.code
						where
							cl.r_debt_id = d.id
							and cl.dt between dp.dt and GETDATE()
							and rs.text = 'Подтверждение обещания'
				
					)cl

			where
				cl.r_debt_id is not null
		)