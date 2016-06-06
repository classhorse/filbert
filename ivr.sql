--╦ ╗╔ ╔╗
--║ ║║ ╠╝
--╩ ╚╝ ╠╗
--git_test

declare @d date
set @d = getdate()

select distinct

	d.id as 'ID_долга',
	per.f as 'Фамилия',
	per.i as 'Имя',
	per.o as 'Отчество',
	d.debt_sum as 'Остаток_долга',
	isnull(d.gmt-4,0) as 'Часовой_пояс',
	p.name as 'Банк',
	ph.number as 'Телефон1'

from
	[i_collect].[dbo].[bank] as b
	inner join [i_collect].[dbo].[portfolio] as p on b.id = p.parent_id
	inner join [i_collect].[dbo].[debt] as d on p.id = d.r_portfolio_id
	inner join [i_collect].[dbo].[person] as per on d.parent_id=per.id
--Phone
	left join
			(
				select
					ph.parent_id,
					ph.number
				from 
					[i_collect].[dbo].[phone] as ph 
				where
					ph.typ in (1,2)
					and ph.block_flag = 0
		
			)ph 	on ph.parent_id = per.id


--users
	left join 
			(
				select
					wt.r_debt_id,
					u.r_department_id,
					u.id
				from
					[i_collect].[dbo].[work_task_log] as wt
					left join [i_collect].[dbo].[users] as u on wt.r_user_id = u.id
					left join [i_collect].[dbo].[department] as dep on u.r_department_id = dep.dep
				where
					wt.id in 

							(
								select
									max(id)
								from
									[i_collect].[dbo].[work_task_log]
								group by
									r_debt_id
							)

			)wt 	on d.id = wt.r_debt_id
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

			)pr 	on d.id = pr.parent_id

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
			
			)dc 	on d.id = dc.parent_id

where
	d.status not in (6,7,8,10)
	and ph.number is not null
	and len(ph.number) = 11
	and wt.id != 1551
	and (p.end_date >= dateadd(day, 5, @d) or p.end_date is null)