--E T E R N V L   2 . 0
use i_collect
go


SELECT
	d.id 'ID долга'

FROM
	bank as b
	inner join portfolio as p on b.id = p.parent_id	
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id
	inner join --отсутствует закрепление
			(
			select
				wt.r_debt_id,
				u.r_department_id,
				u.id
			from
				i_collect.dbo.work_task_log as wt
				left join i_collect.dbo.users as u on wt.r_user_id = u.id
				left join i_collect.dbo.department as dep on u.r_department_id = dep.dep
			where
				wt.id in 
						(
						select max(id)
						from work_task_log
						group by r_debt_id
						)
				and (u.id in (-1) or u.f is null)
			)wt 	on d.id = wt.r_debt_id

	inner join --10 попыток на 1 тел
			(
			select
				cl.r_debt_id
			from
				contact_log cl
				inner join 
						(
						select
							ph.id
						from
							phone ph
							inner join contact_log cl on ph.id = cl.r_phone_id
						where
							ph.typ in (1,2,4)
							and cl.typ = 1
							and cl.dt between dateadd(day, -30, getdate()) and getdate()
						group by
							ph.id
						having
							count(cl.id) >= 10
						)ph
							on ph.id = cl.r_phone_id

			group by
				cl.r_debt_id
			)cl
				on d.id = cl.r_debt_id




WHERE
	d.debt_sum >= 1000
	and d.status not in (6,7,8,9,10)
	and p.status = 2