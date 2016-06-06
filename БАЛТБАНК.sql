declare @d1 date
declare @d2 date
declare @d1_sms date
declare @d2_sms date
set @d1 = '01-08-2015'
set @d2 = '31-08-2015'
set @d1_sms = '2015-08-01'
set @d2_sms = '2015-08-31'
 
select 
	
	
	
	--'Октябрь' as 'Месяц',
	--wt.fio,
	isnull(sum(dc.PP_kolvo),0) as 'V оплат',
	isnull(sum(dc.PP_sum),0) as 'E оплат',
	isnull(sum(dp.kolvo_obeshaniy),0) as 'V обещаний',
	isnull(sum(dp.summa_obeshaniy),0) as 'E обещаний',
	isnull(sum(dp_kc.kolvo_obeshaniy),0) as 'V обещаний КЦ',
	isnull(sum(dp_kc.summa_obeshaniy),0) as 'E обещаний КЦ',
	isnull(sum(s.sms_otrp),0) as 'СМС отпр.',
	isnull(sum(s.sms_dost),0) as 'СМС дост.',
	isnull(sum(c.ivr_vsego),0) as 'IVR отпр.',
	isnull(sum(c.ivr_dost),0) as 'IVR дост.',
	isnull(sum(c.ish_zvon),0) as 'Исх.звон.',
	isnull(sum(dd.ish_zvon_kc),0) as 'Исх.звон.КЦ',
	isnull(sum(c.vhod_zvon),0) as 'Вх.звонки',
	isnull(sum(c.viezdi),0) as 'Выезды',
	isnull(sum(c.pisma),0) as 'Письма'

from
	[i_collect].[dbo].[bank] as b
	inner join [i_collect].[dbo].[portfolio] as p on b.id = p.parent_id
	inner join [i_collect].[dbo].[debt] as d on p.id = d.r_portfolio_id

	inner join (select  -- НАШ ДЕПАРТАМЕНТ
                    wt.r_debt_id, 
                    u.r_department_id,
                    u.depart
				from
                    (SELECT 
						wt.r_user_id, 
						wt.r_debt_id
					FROM
						[i_collect].[dbo].[work_task_log] as wt
					WHERE 
						(wt.fd BETWEEN @d1 AND @d2
						--OR  wt.id IN 
						--			(SELECT
						--				MAX(wt.id) 
						--			FROM 
						--				[i_collect].[dbo].[work_task_log] as wt
						--			WHERE
						--				wt.fd < @d1
						--			GROUP BY 
						--				r_debt_id
						--			)
						) 
					) as wt 
					left join [i_collect].[dbo].[users] as u on wt.r_user_id = u.id
				where
                    u.r_department_id in (3, 7, 12, 14, 15, 20, 26, 27, 49, 50, 52, 57, 59, 63, 65, 68,
                                                69, 70, 71, 72, 73, 74, 89, 90, 91, 97, 98, 102)
                    or u.depart = 'hard'
				group by
                    wt.r_user_id,
                    wt.r_debt_id,
					u.r_department_id,
					u.depart

			  ) as wt on d.id = wt.r_debt_id

	

	--outer apply (select  
	--				count(ddd.id) as kolvo,
	--				sum(dbl.debt_sum) as summa
				
	--				from [i_collect].[dbo].[debt] as ddd
	--					inner JOIN [i_collect].[dbo].[portfolio] as p on d.r_portfolio_id = p.id
	--					inner JOIN [i_collect].[dbo].[debt_status_log] as dsl on dsl.parent_id = ddd.id

	--					inner JOIN (select
	--									MAX(id) mid 
	--								from 
	--									[i_collect].[dbo].[debt_status_log]
	--								where 
	--									dt < @d1
	--								group by
	--									parent_id
	--								) s on s.mid = dsl.id

	--					inner join (select * 
	--								from 
	--									[i_collect].[dbo].[dict] as dict
	--								where parent_id=6
	--								) stts on stts.code = dsl.status

	--					inner join [i_collect].[dbo].[debt_balance_log] as dbl on dbl.parent_id = ddd.id

	--					inner join(select 
	--									MAX(id) mid 
	--								from 
	--									debt_balance_log
	--								where 
	--									dt < @d1	
	--								group by parent_id
	--								) dbl1 on dbl1.mid = dbl.id
	--				where 
	--					dsl.status not in (6,7,8,10) and dbl.debt_sum<>0
	--					and p.name like 'БАЛТБАНК%'
	--					and d.id = ddd.id
	--					) dbldsl



	outer apply (select --Cчитаем ivr, звонки, выезды и письма
					cl.r_debt_id,
					sum(case
							when (cl.typ = 19)
							then 1
							else 0
						end) as ivr_vsego,
					sum(case
							when (cl.typ = 19 and cl.result = 733)
							then 1
							else 0
						end) as ivr_dost,
					sum(case
							when (cl.typ = 1 and cl.result != 0)
							then 1
							else 0
						end) as ish_zvon,
					sum(case
							when (cl.typ = 3)
							then 1
							else 0
						end) as vhod_zvon,
					sum(case
							when (cl.typ = 2)
							then 1
							else 0
						end) as viezdi,
					sum (case
							when (cl.typ = 6)
							then 1
							else 0
						end) as pisma
						
				from
					[i_collect].[dbo].[contact_log] as cl
				where 
					cl.reg_dt between @d1 and @d2
					and cl.r_debt_id = d.id
				group by
					cl.r_debt_id
				) as c --on d.id = c.r_debt_id



	outer apply (select --Cчитаем звонки КЦ 
					cl_kc.r_debt_id,
					sum(case
							when (cl_kc.typ = 1 and cl_kc.result != 0)
							then 1
							else 0
						end) as ish_zvon_kc											
				from
					[i_collect].[dbo].[contact_log] as cl_kc
				where 
					cl_kc.reg_dt between @d1 and @d2
					and	wt.r_department_id in (8, 47, 48, 60, 66, 100, 101)
					or wt.depart = 'soft'
					and cl_kc.r_debt_id = d.id
				group by
					cl_kc.r_debt_id
							
				) dd 


	--outer apply (select --Cчитаем звонки ДВВ и ИП 
	--				cl_dvv.r_debt_id,
	--				sum(case
	--						when (cl_dvv.typ = 1 and cl_dvv.result != 0)
	--						then 1
	--						else 0
	--					end) as ish_zvon_dvv											
	--			from
	--				[i_collect].[dbo].[contact_log] as cl_dvv
	--			where 
	--				cl_dvv.reg_dt between @d1 and @d2
	--				and	wt.r_department_id not in (3, 7, 12, 14, 15, 20, 26, 27, 49, 50, 52, 57, 59, 63, 65, 68, 
	--												69, 70, 71, 72, 73, 74, 89, 90, 91, 97, 98, 102)
	--				or wt.depart = 'hard'
	--				and cl_dvv.r_debt_id = d.id
	--			group by
	--				cl_dvv.r_debt_id
							
	--			) ddd 



	outer apply  (select --СМС'ки отправленные / доставленные//
					s.parent_id,
					sum(case
							when (s.status in (1,2,3,4,5,6,7,8,9))
							then 1
							else 0
						end) as sms_otrp,
					sum(case
							when (s.status in (1,2))
							then 1
							else 0
						end) as sms_dost
				from
					[i_collect].[dbo].[debt_sms] as s
				where
					s.dt between @d1_sms and @d2_sms
					and d.id = s.parent_id
				group by 
					s.parent_id
				) s --on d.id = s.parent_id



	--left join (select	-----------ОТДЕЛЫ-----------
	--				u.r_department_id, 
	--				wt.r_debt_id, 
	--				dep.dep_name
	--			from
	--				[i_collect].[dbo].[work_task] as wt
	--				inner join [i_collect].[dbo].[users] as u on wt.r_user_id = u.id

	--				left join (select
	--								dep.dep,
	--								(case 
	--								when dep.dep in (3, 7, 12, 14, 15, 20, 26, 27, 49, 50, 52, 57, 59, 63, 65, 68, 
	--												69, 70, 71, 72, 73, 74, 89, 90, 91, 97, 98, 102)
	--								then 'ДВВ и ИП'

	--								when dep.dep in (8, 47, 48, 60, 66, 100, 101)				
	--								then 'КЦ'

	--								when dep.dep = 88 --Отдел сопровождения судебного производства
	--								then 'Отдел суд. производства'

	--								when dep.dep = 11 --Управление судебного взыскания долгов
	--								then 'списание'

	--								when dep.dep = 56 --Юридическое управление
	--								then 'Таланова А.'

	--								else dep.name

	--								END) as dep_name
	--							from
	--								[i_collect].[dbo].[department] as dep 

	--							) dep on u.r_department_id = dep.dep

	--			) wt1 on d.id = wt1.r_debt_id


	left join (select dc.parent_id, --присоединяем платежи
				dc.id,
				sum(dc2.PP_sum) as PP_sum,
				sum(dc2.PP_kolvo) as PP_kolvo
				from 
					[i_collect].[dbo].[debt_calc] as dc
					left join 

						(select dc2.id as id,
							(case 
								when (dc2.int_sum is not null and dc2.is_confirmed='1')
								then dc2.int_sum
								else 0
							end) as PP_sum,				

							(case 
								when (dc2.int_sum is not null and dc2.is_confirmed='1')
								then 1
								else 0 
							end) as PP_kolvo
							
						from [i_collect].[dbo].[debt_calc] as dc2
						group by 
							dc2.id,
							dc2.is_confirmed,
							dc2.int_sum,
							dc2.calc_date
						) dc2 on dc2.id=dc.id

				where 
					dc.calc_date between @d1 and @d2 				
					
				group by dc.parent_id, dc.id
				) dc on dc.parent_id = d.id



	outer apply (select dp.parent_id, --присоединяем обещания

					sum(dp2.summa_obeshaniy) as summa_obeshaniy,
					sum(dp2.kolvo_obeshaniy) as kolvo_obeshaniy

				from 
					[i_collect].[dbo].[debt_promise] as dp
					left join 

						(select dp2.id as id,

							(case 
								when (dp2.prom_sum is not null ) 
								then dp2.prom_sum 
								else 0 
							end) as summa_obeshaniy,

							(case 
								when (dp2.prom_sum is not null) 
								then 1 
								else 0 
							end) as kolvo_obeshaniy

						from [i_collect].[dbo].[debt_promise] as dp2
						group by 
							dp2.id,
							dp2.prom_sum,
							dp2.dt
						) dp2 on dp2.id=dp.id

				where 
					dp.dt between @d1 and @d2
					and d.id = dp.parent_id
					
				group by dp.parent_id
				) dp --on 


	outer apply (select dp.parent_id, -- ОБЕЩАНИЯ КЦ !!!!!

					sum(dp2.summa_obeshaniy) as summa_obeshaniy,
					sum(dp2.kolvo_obeshaniy) as kolvo_obeshaniy
				from 
					[i_collect].[dbo].[debt_promise] as dp
					left join 

						(select dp2.id as id,
							(case
								when (dp2.prom_sum is not null)
								then dp2.prom_sum
								else 0
							end) as summa_obeshaniy,

							(case 
								when (dp2.prom_sum is not null) 
								then 1 
								else 0 
							end) as kolvo_obeshaniy

						from [i_collect].[dbo].[debt_promise] as dp2
						group by dp2.id,dp2.prom_sum,dp2.dt
						) dp2 on dp2.id=dp.id

				where 
					dp.dt between @d1 and @d2
					and d.id = dp.parent_id
					and wt.r_department_id in (8, 47, 48, 60, 66, 100, 101)
					or wt.depart = 'soft'
				group by dp.parent_id
				) dp_kc --on d.id = dp.parent_id


where
	p.name like 'БАЛТБАНК%'