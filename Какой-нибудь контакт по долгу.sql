
select

	d.id,
	d.debt_sum,
	convert(varchar, dc.calc_date, 104) as 'Последняя дата оплаты',
	dc.int_sum as 'Последняя сумма оплаты',
	convert(varchar, pr.prom_date, 104) as 'Последняя дата обещания',
	pr.prom_sum as 'Последняя сумма обещания',
	wt.fio as 'Оператор',
	wt.name as 'Отдел',
	p.name as 'Портфель',
	cl_ish_zvon.ish_zvon as 'Исходящие звонки',
	cl_vhod_zvon.vhod_zvon as 'Входящие звонки',
	cl_viezd.Viezd as 'Выезды'


from

	i_collect.dbo.bank as b
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
	inner join i_collect.dbo.person as pers on d.parent_id = pers.id


----CALC
	left join 
			(
				select

					dc.parent_id,
					dc.calc_date,
					dc.int_sum

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
					dc.calc_date,
					dc.int_sum
			
			)dc 	on d.id = dc.parent_id


----PROM
	left join 

			(
				select

					pr.parent_id,
					pr.prom_date,
					pr.prom_sum

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
					pr.prom_date,
					pr.prom_sum

			)pr 	on d.id = pr.parent_id




--users
	left join 

			(
				select

					wt.r_debt_id,
					u.f+' '+u.i+' '+u.o as fio,
					dep.name

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


--исходящие звонки
	outer apply
			(
				select 

					cl.r_debt_id,
					(case
						when (cl.typ = 1 and cl.result in (2, 54, 55, 338, 357, 358, 370, 4, 5, 8, 9, 56, 57, 376, 377, 886, 887, 888, 889, 903, 904, 479, 852))
						then 'С Должником'

						when (cl.typ = 1 and cl.result in (327, 328, 329, 339, 360, 372, 380, 12, 837, 848, 853))
						then 'Кто-то должника знает'

						when (cl.typ = 1 and cl.result in (85, 355, 363, 364, 365, 367, 17, 69, 72, 73, 77, 83, 84, 86, 87, 106, 901, 929, 930, 932))
						then 'Левый номер'

						else 'Прочее'
					end) as ish_zvon
															
				from
					[i_collect].[dbo].[contact_log] as cl

					left join
							(
								select

									cs.code,
									cs.text

								from

									[i_collect].[dbo].[contact_result_set] as cs
									
							) cs on cl.result = cs.code

				where

					d.id = cl.r_debt_id
					and cl.id in
								(
									select
										max(id)
									from
										i_collect.dbo.contact_log
									where
										cl.typ = 1
								)


				group by
					cl.r_debt_id,
					cl.typ,
					cl.result

			)cl_ish_zvon
			


--исходящие звонки
	outer apply
			(
				select 

					cl.r_debt_id,

					(case
						when (cl.typ = 3 and cl.result in (38, 35, 448, 37, 42, 59, 60,  113, 115, 116, 856, 857, 861, 862, 868, 869, 840))
						then 'С Должником'

						when (cl.typ = 3 and cl.result in (40, 454, 462, 470, 121, 864, 871, 841, 842, 843))
						then 'Кто-то должника знает'


						when (cl.typ = 3 and cl.result in (102, 58, 117, 118, 120, 877, 925, 926, 928))
						then 'Левый номер'

						else 'Прочее'
					end) as vhod_zvon
															
				from
					[i_collect].[dbo].[contact_log] as cl

					left join 
							(
								select
									cs.id,
									cs.text
								from
									[i_collect].[dbo].[contact_result_set] as cs
									
							) cs on cl.result = cs.id

				where

					d.id = cl.r_debt_id
					and cl.id in (
									select
										max(id)
									from
										i_collect.dbo.contact_log
									where
										cl.typ = 3
								)

				group by
					cl.r_debt_id,
					cl.typ,
					cl.result

			)cl_vhod_zvon



--исходящие звонки
	outer apply
			(
				select 

					cl.r_debt_id,
					(case
						when (cl.typ = 2 and cl.result in (19, 20, 272, 424, 22, 23, 34, 24, 26, 27, 28, 270, 297, 907, 911, 912, 915, 916, 849, 839))
						then 'С Должником'

						when (cl.typ = 2 and cl.result in (21, 269, 430, 431, 432, 30, 25, 850, 851, 844))
						then 'Кто-то должника знает'


						when (cl.typ = 2 and cl.result in (32, 139, 266, 846))
						then 'Левый номер'

						else 'Прочее'
					end) as Viezd
															
				from
					[i_collect].[dbo].[contact_log] as cl

					left join 
							(
								select
									cs.id,
									cs.text
								from
									[i_collect].[dbo].[contact_result_set] as cs
									
							) cs on cl.result = cs.id

				where

					d.id = cl.r_debt_id
					and cl.id in (
									select	
										max(id)
									from
										i_collect.dbo.contact_log
									where
										cl.typ = 2
								)
				group by
					cl.r_debt_id,
					cl.typ,
					cl.result

			)cl_viezd
