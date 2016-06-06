
select distinct
	count(cl.r_debt_id)
from
	i_collect.dbo.bank as b
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
	inner join i_collect.dbo.person as per on d.parent_id = per.id

	inner join
			(
				select	distinct
					cl.r_debt_id

				from
					i_collect.dbo.contact_log as cl
					left join
							(
								select
									u.id,
									u.depart
								from
									i_collect.dbo.users as u

							)u		on u.id = cl.r_user_id
								

				where
					cl.dt between '01-12-2015 07:59:59' and '31-12-2015 23:59:59'	
					and cl.typ = 1
					and (u.depart = 'soft' or u.id = 1)
					and cl.id is not null
					and cl.result in
									(
									 --тут всякое говно блоки и т.д.
									)	


				group by					
					cl.r_debt_id

			)cl		on d.id = cl.r_debt_id
	