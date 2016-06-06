
select
	d.id, 
	u.f,
	dbl.summa

from
	[i_collect].[dbo].[bank] as b
	inner join [i_collect].[dbo].[portfolio] as p on b.id = p.parent_id
	inner join [i_collect].[dbo].[debt] as d on p.id = d.r_portfolio_id
	inner join [i_collect].[dbo].[person] as per on d.parent_id=per.id
	left join [i_collect].[dbo].[work_task_log] as wt on d.id = wt.r_debt_id
	left join [i_collect].[dbo].[users] as u on wt.r_user_id = u.id
	left join [i_collect].[dbo].[address] as a on per.id = a.parent_id

	left join (select
					dbl.parent_id,
					dbl.debt_sum
				from
					[i_collect].[dbo].[debt_balance_log] as dbl
				where
					dbl.id in	
							(select
								max(d.id)
							from
								[i_collect].[dbo].[debt_balance_log] as d
							where 
								d.dt < @d1
							group by       
								d.parent_id
							)
				) dbl on d.id = dbl.parent_id


where
	u.id in (1469, 1488)
	and b.id in (10, 49, 67, 69)
	and a.city like 'Магнит%'

group by
	d.id, u.f, dbl.summa