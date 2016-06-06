--задача Никите

select distinct
	pv.parent_id as 'ID долга',
	d.debt_sum 'Сумма долга',
	pv.fio 'Сотрудник',
	convert(varchar, pv.data_vnesen, 104) as 'Дата внесения',

	isnull(convert(varchar ,cl.dt, 104),'') as 'Дата последнего ЗОВИП',
	
	(case
		when datediff(month,cl.dt, pv.data_vnesen/*, cl.dt*/) <= 3
		then 1
		else 0
	end) as '1-е ЗОВИП меньше 3 месяцев назад',
	(case when pv.minus5 > 5 then 1 else 0 end) 'Обещ-е старше на >5 дней от даты оплаты',
	isnull(convert(varchar, pv.prom_date,104),'') 'Последняя дата обещ-я до оплаты',

	(
		case when 
			(case when sum(nov.summa) is not null then 1 else 0 end)
			+
			(case when sum(dec.summa) is not null then 1 else 0 end) 
			= 2 
			then 1 else 0 
		end

	)  'Есть платеж а ноябре и декабре',
	isnull(convert(varchar, last_nov.calc_date,104),'') 'Последний платеж в ноябре',
	isnull(sum(nov.kolvo),'') 'Кол-во платежей в ноябре'


from
	i_collect.dbo.bank as b
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id

	left join
			(
				select
					cl.r_debt_id,
					min(cl.dt) as dt

				from
					i_collect.dbo.contact_log as cl
					left join
							(
								select
									code,
									text

								from
									i_collect.dbo.contact_result_set

							)rs		on rs.code = cl.result

				
				where
					cl.typ = 5
					and rs.text = 'Подано ЗОВИП'
					
				group by
					cl.r_debt_id

			)cl		on d.id = cl.r_debt_id

--payment_v
	inner join
			(select
					pv.parent_id,
					--pv.dt as data_reg,
					pv.calc_date as data_vnesen,
					--pv.sum as summa,
					u.fio,
					DATEDIFF(day, pv.calc_date, pr.dt)/-1 minus5,
					pr.prom_date prom_date

				from
					i_collect.dbo.payment_v as pv
				/*users*/
					left join
							(
								select
									u.id,
									u.f + ' ' + SUBSTRING(u.i,1,1) + '.' + SUBSTRING(u.o,1,1)+'.' as fio
								from
									i_collect.dbo.users as u

							)u		on pv.r_user_id = u.id

				/*prom*/
					outer apply 
							(
								select
									pr.parent_id,
									pr.prom_date,
									pr.dt
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
									and pv.parent_id = pr.parent_id
									and pr.dt < pv.calc_date
				
								group by
									pr.parent_id,
									pr.prom_date,
									pr.dt

							)pr 	--on pv.parent_id = pr.parent_id


				where
					pv.is_cancel = 0
					and pv.r_user_id in (1564, 1572, 1573, 238)
					and pv.calc_date between '01-02-2016 07:00:00' and '29-02-2016 23:59:59'

				group by
					pv.parent_id,
					--pv.dt,
					pv.calc_date,
					--pv.sum,
					u.fio,
					pr.prom_date,
					pr.dt


			)pv		on d.id = pv.parent_id

/*calc_november*/

	left join 
			( 
				select 
					dc.parent_id,
					sum(dc2.PP_sum) as summa,
					sum(dc2.PP_kolvo) as kolvo
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
					dc.calc_date between '01-11-2015 07:59:59' and '30-11-2015 23:59:59'

				group by
					dc.parent_id
				)nov		on nov.parent_id = d.id


/*calc december*/
	left join
			(
				select
					dc.parent_id,
					sum(dc.int_sum) summa
				from
					debt_calc dc
				where
					dc.calc_date between '01-12-2015 07:59:59' and '31-12-2015 23:59:59'
				group by
					dc.parent_id

			)dec		on dec.parent_id = d.id

/*last calc November*/
	left join
			(
				select
					dc.parent_id,
					max(dc.calc_date) calc_date
				from
					debt_calc dc
				where
					dc.calc_date between '01-11-2015 07:59:59' and '30-11-2015 23:59:59'
								
				group by
					dc.parent_id

			)last_nov		on last_nov.parent_id = d.id


group by
	pv.parent_id,
	pv.fio,
	pv.data_vnesen,
	cl.dt,
	pv.minus5,
	pv.prom_date,
	isnull(convert(varchar, last_nov.calc_date, 104),''),
	d.debt_sum