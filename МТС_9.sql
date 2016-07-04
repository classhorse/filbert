declare @d1 date = '01-02-2016'
declare @d2 date = '07-02-2016'

select
	p.code '№ Реестра',
	'' 'Проект',
	'' 'Продукт',
	d.start_sum 'Сумма просроченной задолженности на начало отчетного периода',
	sum(dp.OP_sum) 'Сумма взятых обещаний об оплате',
	sum(dp.kol_ob) 'Количество взятых обещаний',
	sum(dc.PP_sum) 'Сумма поступивших платежей'

from
	bank as b
	inner join portfolio as p on b.id = p.parent_id	
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id

/*promise*/

	outer apply
			(
				select 
					dp.parent_id, 
					sum(dp2.OP_sum) as OP_sum,
					sum(dp2.kol_ob) as kol_ob
				from 
					i_collect.dbo.debt_promise as dp
					left join
							(
								select
									dp2.id as id,

									(case 
										when (dp2.prom_sum is not null ) 
										then dp2.prom_sum 				
										else 0 
									end) as OP_sum,

									(case 
										when (dp2.prom_sum is not null) 
										then 1 
										else 0 
									end) as kol_ob
								from 								
									i_collect.dbo.debt_promise as dp2
								group by
									dp2.id,
									dp2.prom_sum
							)dp2 	on dp2.id=dp.id
				where
					dp.parent_id = d.id
					and dp.dt between @d1 and @d2
					and dp.prom_date <= @d2
				group by
					dp.parent_id
			)dp

/*Платежи*/
	outer apply
			(
				select
					dc.parent_id,
					sum(dc2.PP_sum) as PP_sum,
					sum(dc2.PP_kolvo) as PP_kolvo
				from
					[i_collect].[dbo].[debt_calc] as dc
					left join 
							(
								select 
										dc2.id as id,

										(case 
											when 
												(
													dc2.int_sum is not null 
													and dc2.is_confirmed = 1 
													and dc2.is_cancel = 0
												)
											then dc2.int_sum
											else 0
										end) as PP_sum,				

										(case 
											when 
												(
													dc2.int_sum is not null 
													and dc2.is_confirmed = 1 
													and dc2.is_cancel = 0
												)
											then 1
											else 0
										end) as PP_kolvo

								from
									[i_collect].[dbo].[debt_calc] as dc2

								group by
									dc2.is_confirmed,
									dc2.int_sum,
									dc2.id,
									dc2.is_cancel
								) dc2 on dc2.id=dc.id
				where
					dc.parent_id = d.id
				group by
					dc.parent_id
				) dc 


--where
	--b.id = @bank --т.к. долгов МТС'а еще нет, сделал пока чтобы можно было его выбрать когда появится