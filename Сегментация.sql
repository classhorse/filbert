declare @date date
set @date = getdate()

select
	
	(case
		when 
			p.name like '%EXEC%'
			and d.debt_sum < 1000
			and (c.calc_date is null or c.calc_date < dateadd(month, -2, @date))
			and (pr.prom_date is null or pr.prom_date < @date)
		then '1.1'

		when 
			p.name like '%EXEC%'
			and b.id in (49, 14 ,10, 11, 9)
			and d.debt_sum < 1000
			and c.calc_date > dateadd(month, -2, @date)
		then '1.2'

		when 
			p.name like '%EXEC%'
			and b.id in (49, 14 ,10, 11, 9)
			and (d.typ not in (2, 3, 33) or d.typ is null)
			and d.debt_sum between 50000 and 300000
			and (la.[start_date] < dateadd(month, -6, @date) or la.[start_date] is null)
			and c.calc_date is null or c.calc_date < dateadd(month, -6, @date)
			and pr.prom_date is null
		then '2.1'

		when 
			p.name like '%EXEC%'
			and b.id in (49, 14 ,10, 11, 9)
			and (d.typ not in (2, 3, 33) or d.typ is null)
			and d.debt_sum between 1000 and 50000
			and (la.[start_date] < dateadd(month, -6, @date) or la.[start_date] is null)
			and (c.calc_date is null or c.calc_date < dateadd(month, -6, @date))
			and pr.prom_date is null
		then '2.1.1'

		when 
			p.name like '%EXEC%'
			and b.id in (49, 14 ,10, 11, 9)
			and (d.typ not in (2, 3, 33) or d.typ is null)
			and  d.debt_sum >= 300000
			and (la.[start_date] < dateadd(month, -6, @date) or la.[start_date] is null)
			and (c.calc_date is null or c.calc_date < dateadd(month, -6, @date))
			and pr.prom_date is null
		then '2.2'

		when
			p.name like '%EXEC%'
			and b.id in (49, 14 ,10, 11, 9)
			and (d.typ in (2, 3, 33) or d.typ is null)
			and (la.[start_date] < dateadd(month, -6, @date) or la.[start_date] is null)
			and (c.calc_date is null or c.calc_date < dateadd(month, -6, @date))
			and (pr.prom_date is null or pr.prom_date < @date)
		then '2.3'

		when
			p.name like '%EXEC%'
			and b.id not in (49, 14, 10, 11, 9)
			and p.sign_date < dateadd(month, -3, @date)
			and c.calc_date is null
			and pr.prom_date is null
		then '2.4'

		when 
			p.name like '%EXEC%'
			and b.id not in (49, 14, 10, 11, 9)
			and c.calc_date is null
			and pr.prom_date is null
			and p.sign_date < dateadd(month, -6, @date)
		then '3.1'

		when 
			p.name like '%EXEC%'
			and b.id in (49, 14, 10, 11, 9)
			and d.debt_sum >= 1000
			and la.[start_date] > dateadd(month, -6, @date)
			and (c.calc_date < dateadd(month, -6, @date) or c.calc_date is null)
			and (pr.prom_date is null or pr.prom_date < @date)
		then '4.1'

		when
			p.name like '%EXEC%'
			and b.id in (49, 14, 10, 11, 9)
			and d.debt_sum >= 1000
			and c.calc_date > dateadd(month, -6, @date)
			and (pr.prom_date is null or pr.prom_date < @date)
		then '4.2'

		when 
			p.name like '%EXEC%'
			and b.id in (49, 14, 10, 11, 9)
			and  d.debt_sum >= 1000
			and (c.calc_date < dateadd(month, -6, @date) or c.calc_date is null)
			and pr.prom_date between dateadd(month, -2, @date) and dateadd(day, -1, @date)
		then '4.3'

		when
			p.name like '%EXEC%'
			and d.debt_sum >= 1000
			and pr.prom_date >= @date
		then '4.3.1'
		
		when
			p.name like '%EXEC%'
			and b.id not in (49, 14, 10, 11, 9)
			and d.debt_sum >= 1000
			and c.calc_date > dateadd(month, -2, @date)
		then '4.4'
		
		when 
			p.name like '%EXEC%'
			and b.id not in (49, 14, 10, 11, 9)
			and p.sign_date > dateadd(month, -3, @date)
			and  d.debt_sum >= 1000		
			and (pr.prom_date is null or pr.prom_date < @date)
		then '4.5'

		when 
			p.name like '%EXEC%' 
			and b.id not in (49, 14, 10, 11, 9)
			and d.debt_sum >= 1000 
			and pr.prom_date > dateadd(month, -2, @date)
			and c.calc_date is null
		then '4.6'

		when 
			p.name like '%HARD%'  
			and c.calc_date > dateadd(month, -2, @date)
		then '5.1'

		when 
			p.name like '%HARD%'  
			and d.debt_sum >= 1000 
			and pr.prom_date > dateadd(month, -2, @date)
			and c.calc_date < dateadd(month, -2, @date)
		then '5.2'

		when 
			p.name like '%HARD%'
			and d.debt_sum >= 1000
			and pr.prom_date >= getdate()
		then '5.3'

		when 
			p.name like '%HARD%'
			and b.id in (49, 14, 10, 11, 9)
			and (d.typ in (2, 3, 33) or d.typ is null)
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '6.1'

		when 
			p.name like '%HARD%'
			and b.id in (49, 14, 10, 11, 9)
			and (d.typ not in (2, 3, 33) or d.typ is null)
			and d.debt_sum >= 300000
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '6.2'

		when 
			p.name like '%HARD%'
			and b.id in (49, 14, 10, 11, 9)
			and (d.typ not in (2, 3, 33) or d.typ is null)
			and d.debt_sum between 50000 and 300000
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '6.3'

		when 
			p.name like '%HARD%'
			and b.id in (49, 14, 10, 11, 9)
			and (d.typ not in (2, 3, 33) or d.typ is null)
			and d.debt_sum  < 50000
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '6.4'

		when 
			p.name like '%HARD%'
			and b.id in (69, 67)
			and p.end_date > dateadd(day, 7, @date)
			and (d.typ in (2, 3, 33) or d.typ is null)
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '8.1'

		when 
			p.name like '%HARD%'
			and b.id in (69, 67)
			and p.end_date > dateadd(day, 7, @date)
			and (d.typ not in (2, 3, 33) or d.typ is null)
			and d.debt_sum >= 300000
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '8.2'

		when 
			p.name like '%HARD%'
			and b.id in (69, 67)
			and p.end_date > dateadd(day, 7, @date)
			and (d.typ not in (2, 3, 33) or d.typ is null)
			and d.debt_sum between 50000 and 300000
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '8.3'

		when 
			p.name like '%HARD%'
			and b.id in (69, 67)
			and p.end_date > dateadd(day, 7, @date)
			and (d.typ not in (2, 3, 33) or d.typ is null)
			and d.debt_sum < 50000
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '8.4'

		when 
			p.name like '%HARD%'
			and b.id not in (49, 14, 10, 11, 9, 69, 67)
			and (d.typ in (2, 3, 33) or d.typ is null)
			and p.end_date > dateadd(day, 7, @date)
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '9.1'

		when 
			p.name like '%HARD%'
			and b.id not in (49, 14, 10, 11, 9, 69, 67)
			and p.end_date > dateadd(day, 7, @date)
			and (d.typ not in (2, 3, 33) or d.typ is null)
			and d.debt_sum >= 100000
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '9.2'

		when 
			p.name like '%HARD%'
			and b.id not in (49, 14, 10, 11, 9, 69, 67)
			and p.end_date > dateadd(day, 7, @date)
			and (d.typ not in (2, 3, 33) or d.typ is null)
			and d.debt_sum < 100000
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '9.3'

		when 
			p.name like '%HARD%'
			and b.id not in (49, 14, 10, 11, 9)
			and p.end_date <= dateadd(day, 7, @date)
			and pr.prom_date < dateadd(day, -10, @date)
		then '10.1'

		when 
			p.name like '%HARD%'
			and b.id not in (49, 14, 10, 11, 9, 69, 67)
			and d.debt_sum >= 1000
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '10.2'

		when 
			p.name like '%HARD%'
			and b.id in (49, 14, 10, 11, 9, 69, 67)
			and d.debt_sum >= 1000
			and (c.calc_date < dateadd(month, -2, @date) or c.calc_date is null)
			and (pr.prom_date < dateadd(month, -2, @date) or pr.prom_date is null)
		then '10.2.1'

		when 
			p.name like '%HARD%'
			and d.debt_sum < 1000 
		then '10.3'

		when 
			p.name like '%HARD%'
			and b.id not in (49, 14, 10, 11, 9, 69, 67)
		then '10.4'

		else 'н/д'
		
	end) as 'Статус',
	
	(case
		when p.name like '%EXEC%'
		then 'exec'

		when p.name like '%HARD%'
		then 'hard'

		else 'Н/Д'
	end) as 'Текущий этап',

	d.id as 'ID долга',
	b.name as 'Банк',

	(case
		when d.typ = 3
		then 'Ипотека'

		when d.typ in (2, 33)
		then 'Автокред'
		
		when d.typ not in (2, 3, 33)
		then 'Ритейл'

		else 'н/д'
	end) as 'Тип продукта',
	p.name as 'Портфель',
	isnull(wt.fio,'н/д') as 'Оператор',
	isnull(wt.name,'н/д') as 'Отдел',
	isnull(d.debt_sum,0) as 'Остаток',
	isnull(c.calc_date,0) as 'Дата оплаты',
	isnull(pr.prom_date,0) as 'Дата обещания',
	isnull(la.start_date,0) as 'Дата ИП'


	--тип продукта debt.typ (2 - автокредит, 3 - ипотека, 33 - авто экспресс кредит)
	--тип банка 1 -- БалтБанк, ПСБ, Париба, Кит, АТБ b.id in 49, 14, 10, 11, 9
	--тип банка 2 -- Росбанк, КЕБ b.id in 69, 67
	--тип банка 3 --Все Остальное

from
	[i_collect].[dbo].[bank] as b
	inner join [i_collect].[dbo].[portfolio] as p on b.id = p.parent_id
	inner join [i_collect].[dbo].[debt] as d on p.id = d.r_portfolio_id

----CALC
	left join (select
					dc.parent_id,
					dc.calc_date
				from
					[i_collect].[dbo].[debt_calc] as dc
				where
					dc.id in (select
									max(id)
								from
									[i_collect].[dbo].[debt_calc]
								group by
									parent_id
								)
				group by
					dc.parent_id,
					dc.calc_date
				) c on d.id = c.parent_id


----PROM
	left join (select
					pr.parent_id,
					pr.prom_date
				from
					[i_collect].[dbo].[debt_promise] as pr
				where
					pr.id in (select
									max(id)
								from
									[i_collect].[dbo].[debt_promise]
								group by
									parent_id
								)
				group by
					pr.parent_id,
					pr.prom_date
				) pr on d.id = pr.parent_id
 
--USERS	
	left join (select
					wt.r_debt_id,
					dep.name,
					u.f+' '+u.i+' '+u.o as fio,
					u.r_department_id
				from
					[i_collect].[dbo].[work_task_log] as wt
					left join [i_collect].[dbo].[users] as u on wt.r_user_id = u.id
					left join [i_collect].[dbo].[department] as dep on u.r_department_id = dep.dep
				where
					wt.id in (select
									max(id)
								from
									[i_collect].[dbo].[work_task_log]
								group by
									r_debt_id
								)
					) as wt on d.id = wt.r_debt_id


--LAW ACT
	left join (select
					la.r_debt_id,
					la.[start_date]
				from
					[i_collect].[dbo].[law_act] as la
				where 
					la.id in (select
									max(id)
								from
									[i_collect].[dbo].[law_act]
								group by
									r_debt_id
								)
				group by
					la.r_debt_id,
					la.[start_date]
				) as la on la.r_debt_id = d.id
where
	d.debt_sum > 0
	and wt.r_department_id in (3, 7, 12, 14, 15, 20, 26, 27, 49, 50, 52, 57, 59, 63, 65, 68, 69, 
												70, 71, 72, 73, 74, 89, 90, 91, 97, 98, 102)
	and p.name not like '%LEGAL%'
	and p.name not like '%SOFT%'
	and d.[status] not in (6,7,8,10)
