select

	d.id as 'ID долга',
	per.id as 'ID должника',
	per.fio as 'ФИО должника',
	b.name as 'Банк',
	p.name as 'Портфель',
	d.debt_sum as 'Остаток',
	isnull(wt.fio,'н/д') as 'Оператор',
	isnull(wt.name,'н/д') as 'Отдел'


from

	i_collect.dbo.bank as b

	left join 
			
			(
				select	
					
					p.id,
					p.parent_id,
					p.name

				from
					
					i_collect.dbo.portfolio as p 

			)p		on b.id = p.parent_id




	left join 
		
			(
				select
					
					d.id,
					d.r_portfolio_id,
					d.parent_id,
					d.status,
					d.debt_sum
					
				from
					
					i_collect.dbo.debt as d 

			)d		on p.id = d.r_portfolio_id



	left join 
	
			(
				select
					
					per.id,
					per.f+' '+per.i+' '+per.o as fio

				from

					i_collect.dbo.person as per

			)per		on d.parent_id = per.id


--users
	left join 

			(
				select

					wt.r_debt_id,
					u.fio,
					dep.name

				from

					[i_collect].[dbo].[work_task_log] as wt

					left join 
						
							(
								select
									
									u.r_department_id,
									u.f+' '+u.i+' '+u.o as fio,
									u.id
									
								from
									
									[i_collect].[dbo].[users] as u


							)u		on wt.r_user_id = u.id

					left join 
							
							(
								select
									
									dep.name,
									dep.dep
								
								from
									
									[i_collect].[dbo].[department] as dep

							)dep on u.r_department_id = dep.dep

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
	inner join
			(
				select 

					cl.r_debt_id
															
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
					
					cs.code in (1, 2, 3, 4, 5, 11, 12, 13, 14, 15, 16, 310, 714, 715, 716, 720, 723, 58, 803, 805, 806, 807, 808, 809, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 839, 840, 841, 842, 20044, 120044, 120045, 120048, 120153, 120154, 120156)

					and cl.dt > dateadd(month, -6, cl.dt)
					


				group by
					cl.r_debt_id

			)cl	on d.id = cl.r_debt_id

where
	
	d.status not in (6,7,8,10)