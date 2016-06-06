
declare @d1 date = '01-02-2016'
declare @d2 date = '29-02-2016'

select distinct
	left(p1.name, charindex('_', p1.name) + 2) as pname, 
	p1.sign_date,
	stat.start_sum,
	stat.srok,
	stat.cnt,
	paid.psum,
	paid.yearly,
	paid.monthly,
	prom.pc

from 
	portfolio p1

/*dpd*/
	left join
		( 
			select 
				left(portfolio.name, charindex('_', portfolio.name) + 2) pid,
				count(debt.id) cnt,
				sum(debt.start_sum) start_sum,
				avg(datediff(day, debt.start_date, portfolio.sign_date)) srok
			from 
				debt
				inner join portfolio on debt.r_portfolio_id=portfolio.id
			group by 
				left(portfolio.name, charindex('_', portfolio.name) + 2)
		) stat on stat.pid = left(p1.name, charindex('_', p1.name) + 2)

/*debt_calc*/
	outer apply
		(
			select 
				left(dcp.name, charindex('_', dcp.name) + 2) pid,
				sum(dc.int_sum) psum,
				datepart(month,dc.calc_date) monthly, 
				datepart(year, dc.calc_date) yearly

			from 
				debt_calc dc
				join debt dcd on dc.parent_id = dcd.id
				join portfolio dcp on dcp.id = dcd.r_portfolio_id

			where 
				dc.is_cancel = 0
				and dc.calc_date between @d1 and @d2
				and left(dcp.name, charindex('_', dcp.name) + 2) = left(p1.name, charindex('_', p1.name) + 2)

			group by 
				left(dcp.name, charindex('_', dcp.name) + 2),
				datepart(month,dc.calc_date), 
				datepart(year, dc.calc_date)

		) paid 
	
/*prom*/
	outer apply
		(
			select 
				left(pp.name, charindex('_', pp.name) + 2) pid,
				sum(dpp.prom_sum) pc
			from 
				debt_promise dpp
				join debt dp on dpp.parent_id = dp.id
				join portfolio pp on pp.id = dp.r_portfolio_id
			where 
				left(pp.name, charindex('_', pp.name) + 2) = left(p1.name, charindex('_', p1.name) + 2)
				and dpp.prom_date > dateadd(day, -10, getdate() )				
			group by 
				left(pp.name, charindex('_', pp.name) + 2)

		) prom
	
	join bank on bank.id = p1.parent_id 

--where 
--	bank.id in (@bank) 
--	and portfolio.code in (@portf)

order by 
	p1.sign_date asc