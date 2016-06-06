--███████████████████████████████
--█───█────█────█─────█─██─█─██─█
--█─███─██─█─██─█─█─█─█─██─█─█─██
--█─███────█────█─█─█─█─█──█──███
--█─███─████─██─█─────█──█─█─█─██
--█─███─████─██─███─███─██─█─██─█
--███████████████████████████████
--███████████████████████████████████──██
--█────███──█────█───█───█─█─█─█───█─██─█
--█─██─██─█─█─██─██─██─███─────█─███─██─█
--█─██─█─██─█────██─██───██───██───█─█──█
--█─██─█─██─█─██─██─██─███─────█─███──█─█
--█─██─█─██─█─██─██─██───█─█─█─█───█─██─█
--███████████████████████████████████████


select
		
		d.id as 'ID долга',
		d.debt_sum as 'Сумма долга',
		isnull(convert(varchar, dps.dt, 104),'-') as 'Дата составления графика',
		isnull(convert(varchar, dps.start_dt,104),'-') as 'Дата начала оплаты',
		isnull(convert(varchar, dps.end_dt, 104),'-') as 'Дата окончания оплаты',
		isnull(dps.dsc, '-') as 'Комментарий'


		--count(d.id) as kolvo_id,
		--sum(d.debt_sum) as summa


from

	i_collect.dbo.bank as b
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
	inner join i_collect.dbo.person as per on d.parent_id = per.id
	inner join Journal.dbo.one as t on d.id = t.id
	

	inner join
			(
				select					
					cl.r_debt_id


				from			
						
					i_collect.dbo.contact_log as cl
					left join 
							(
								select
									cs.code,
									cs.text
								from
									i_collect.dbo.contact_result_set as cs
								where
									cs.typ = 1

							)cs		on cl.result = cs.code

				where

					cl.typ = 1
					and cl.dt between '19-12-2015 07:59:59' and '20-12-2015 23:59:59'
					and cs.text like '%граф%'

				group by
					
					cl.r_debt_id

			)cl		on d.id = cl.r_debt_id


	left join
			(
				select
					dps.r_debt_id,
					dps.dt,
					dps.start_dt,
					dps.end_dt,
					dps.dsc

				from 
					i_collect.dbo.debt_payment_schedule as dps

			)dps		on d.id = dps.r_debt_id