declare @d1 datetime = '01-04-2016 07:00:00'
declare @d2 datetime = '30-04-2016 23:59:59'


select distinct
	d.id 'ID долга'
	,f.fio 'Оператор'
	,f.name 'Отдел'
	,cast(f.dt as date) 'Дата регистрации обещания'
	,cast(f.prom_date as date) 'Дата обещанного платежа'
	,cast(f.prom_sum as money) 'Сумма обещанного платежа'
	--,replace(isnull(cast(f.calc_date as date),''), '1900-01-01', '') 'Дата оплаты'
	,isnull(cast(sum(f.int_sum) as money),'') 'Сумма оплаты'

from
	bank as b
	inner join portfolio as p on b.id = p.parent_id	
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id

	outer apply
			(
			select
				dp.parent_id,
				dp.r_user_id,
				u.f+' '+u.i+' '+u.o fio,
				dep.name
				--dc.calc_date,
				,sum(dc.int_sum) int_sum
				,dp.dt
				,dp.prom_date
				,dp.prom_sum
			from
				debt_promise dp 
				left join users u on u.id = dp.r_user_id
				left join i_collect.dbo.department as dep on u.r_department_id = dep.dep
				left join debt_calc dc on dp.parent_id = dc.parent_id

			where
				dp.parent_id = d.id
				and dp.dt between @d1 and @d2
				and (dc.calc_date > dp.dt or dc.calc_date is null)
				and (dc.calc_date < dateadd(day, 5, dp.prom_date) or dc.calc_date is null)
				and dep.name like 'Колл%'		
			group by
				dp.parent_id
				,dp.r_user_id
				,u.f
				,u.i
				,u.o
				,dep.name
				,dp.dt
				,dp.prom_date
				,dp.prom_sum		

			)f		--on f.parent_id = d.id

where
	f.dt is not null
	and d.id = 678696

group by
	d.id
	,f.fio
	,f.name
	,f.dt
	,f.prom_date
	,f.prom_sum
	--,f.calc_date


