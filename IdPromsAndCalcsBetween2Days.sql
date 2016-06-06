select
	d.id
from
	debt d
where
	d.id in
			(
			select
				parent_id
			from
				debt_promise 
			where
				dt >= dateadd(day, -2, getdate())
			group by
				parent_id
			)

or
	d.id in
			(
			select
				parent_id
			from
				debt_calc
			where
				calc_date >= dateadd(day, -2, getdate())

			)