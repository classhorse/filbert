--████████████████████████
--█────██──█──█────██───██
--█─██──██───██─██─██─█─██
--█────████─███─██─██─█─██
--█─██──██───██─██─█─────█
--█────██──█──█────█─███─█
--████████████████████████
--████████████
--██───██────█
--██─█─██─██─█
--██─█─██─██─█
--█─────█─██─█
--█─███─█────█
--████████████
--███████████████████████████████
--█────█────███──█────█───█─███─█
--█─██─█─██─██─█─█─██─██─██─███─█
--█─██─█─██─█─██─█────██─██───█─█
--█─██─█─██─█─██─█─██─██─██─█─█─█
--█────█─██─█─██─█─██─██─██───█─█
--███████████████████████████████


select
	d.id,
	convert(varchar, i.data, 104) as 'Дата платежа',
	convert(varchar, wt.dt, 104) as 'Дата посл. лога перед рег.платежа',
	convert(varchar, wt1.dt, 104) as 'Дата посл. лога без учета даты рег.платежа',
	convert(varchar, cl.dt, 104) as 'Дата действия до рег. платежа',
	convert(varchar, cl1.dt, 104) as 'Дата действия'

from
	i_collect.dbo.bank as b
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
	inner join i_collect.dbo.person as per on d.parent_id = per.id
	inner join Journal.dbo.ilmn as i on d.id = i.id


	outer apply--1
			(--последний вход в карточку до оплаты
				select 
					wt.r_debt_id,
					max(a.dt) as dt

				from
					i_collect.dbo.work_task_log as wt
					left join debt ON debt.id = wt.r_debt_id
					left join
							(
								select
									a.r_user_id,
									a.dt, a.r_person_id
								from
									i_collect.dbo.actions as a
								where
									a.typ = 2
									and a.r_user_id in (1564, 1573, 1572, 238)
									and a.dt < i.data
									and a.dt < '01-01-2016'
									

							)a		on a.r_user_id = wt.r_user_id AND a.r_person_id = debt.parent_id

				where
					d.id = wt.r_debt_id
	
				group by
					wt.r_debt_id

			)wt		


			
	outer apply--2
			(--последний вход в карточку
				select 
					wt.r_debt_id,
					max(a.dt) as dt

				from
					i_collect.dbo.work_task_log as wt
					left join debt ON debt.id = wt.r_debt_id
					left join
							(
								select
									a.r_user_id,
									a.dt, a.r_person_id
								from
									i_collect.dbo.actions as a
								where
									a.typ = 2
									and a.r_user_id in (1564, 1573, 1572, 238)
									

							)a		on a.r_user_id = wt.r_user_id AND a.r_person_id = debt.parent_id

				where
					d.id = wt.r_debt_id
	
				group by
					wt.r_debt_id

			)wt1


	outer apply
			(--последнее действие до оплаты
				select
					de.id,
					max(cl.dt) as dt

				from
					i_collect.dbo.contact_log as cl
					left join i_collect.dbo.debt as de on cl.parent_id = de.parent_id
					left join
							(
								select
									code,
									text
								from
									i_collect.dbo.contact_result_set

							)crs		on cl.result = crs.code

				where
					de.id = d.id
					and cl.r_user_id in (1564, 1573, 1572, 238)
					and cl.dt <= i.data
				
				group by
					de.id
		
			)cl
								
								
	outer apply
			(--последнее действие
				select
					de.id,
					max(cl.dt) as dt

				from
					i_collect.dbo.contact_log as cl
					left join i_collect.dbo.debt as de on cl.parent_id = de.parent_id
					left join
							(
								select
									code,
									text
								from
									i_collect.dbo.contact_result_set

							)crs		on cl.result = crs.code

				where
					de.id = d.id
					and cl.r_user_id in (1564, 1573, 1572, 238)
					--and cl.dt <= i.data
				
				group by
					de.id
		
			)cl1

			