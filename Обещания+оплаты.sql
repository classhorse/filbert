declare @d1 as datetime
declare @d2 as datetime
set @d1 = '18-09-2015'
set @d2 = '26-09-2015'

select
	d.id,
	isnull(count(dc.kolvo_oplat),0) as 'Кол-во оплат', 
	isnull(sum(dc.summa_oplat),0) as 'Сумма оплат', 
	isnull(count(dp.kolvo_obeshaniy),0) as 'Кол-во обещаний',
	isnull(sum(dp.summa_obeshaniy),0) as 'Сумма обещаний'
from
	[i_collect].[dbo].[bank] as b
	inner join [i_collect].[dbo].[portfolio] as p on b.id = p.parent_id
	inner join [i_collect].[dbo].[debt] as d on p.id = d.r_portfolio_id
	inner join [i_collect].[dbo].[person] as pers on d.parent_id = pers.id
	
	left join (select --ОПЛАТЫ
					dc.parent_id, 
					count(dc.int_sum) as kolvo_oplat,
					sum(dc.int_sum) as summa_oplat
				from
					[i_collect].[dbo].[debt_calc] as dc
				where
					dc.calc_date between @d1 and @d2
					and dc.is_confirmed = 1
				group by
					dc.parent_id

				) dc on d.id = dc.parent_id

	left join (select --ОБЕЩАНИЯ
					dp.parent_id,
					count(dp.prom_sum) as kolvo_obeshaniy,
					sum(dp.prom_sum)  as summa_obeshaniy
				from
					[i_collect].[dbo].[debt_promise] as dp 
				where
					dp.dt between @d1 and @d2
				group by
					dp.parent_id
				) dp on d.id = dp.parent_id
group by
	d.id