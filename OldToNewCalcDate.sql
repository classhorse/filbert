select
	d.id
	,isnull(cast(cl.dt as date),'01-01-1900') dt
	,ROW_NUMBER()  over (order by isnull(cast(cl.dt as datetime),'01-01-1900') desc) dt
from
	debt d
	left join
			(
			select
				cl.r_debt_id
				,cl.dt
			from
				contact_log cl
			where
				cl.typ = 1 
				and cl.id in
							(
							select
								max(id)
							from
								contact_log
							group by
								r_debt_id
							)

			)cl
				on cl.r_debt_id = d.id

where
	d.status not in (6,7,8,10)

order by
	cl.dt desc