
/*		DataCube 02.08.2016		|		57 column's
		Author: Lestat Kim		|		Version 1.1.28
*/
	

declare @d1 datetime = '01-07-2016 00:00:01'
declare @d2 datetime = '05-07-2016 23:59:59'

SELECT

	d.id 'ID долга'
	,iif(d.status in (6,7,8,10), 0, 1) 'Активность долга'
	,isnull(d_stat.name, '') 'Статус долга'
	,isnull(dsl.name, '') 'Статус на заданную дату'
	,isnull(dsl.act, '') 'Активность долга на заданную дату'
	,isnull(tp.name, 'n/a') 'Тип продукта' -- +{wh}__tops
	,per.id 'ID Должника'
	,per.fio  'Фио должника'
	,b.name 'Банк'
	,p.name 'Портф. тек-й'
	,isnull(dpl.name, '') 'Портф. на дату'
	,isnull(dpl.dt, '') 'Дата смены портф.'
	,iif(p.name like '%EXEC%'
		,'exec'
		,iif(p.name like '%HARD%'
			,'hard'
			,iif(p.name like '%LEGAL'
				,'legal'
				,iif(p.name like '%SOFT%'
					,'soft'
					,'n/a'
				)
			)
		)
	) 'Портфели кратко'
	,replace(isnull(cast(p.sign_date as date), ''), '1900-01-01', '') 'Вход портф-я'
	,replace(isnull(cast(p.end_date as date), ''), '1900-01-01', '') 'Выход портф-я'
	,isnull(d_r.name, '') 'Регион долга'
	,isnull(dfil.name, '') 'Филиал'
	,isnull(d.[contract], '') 'Договор'
	,isnull(d.account, 0) 'Лиц-й счет'
	,isnull(d.agency_rate, 0) '% Вознагр-я'

--Current fix {
	,isnull(wt.fio, '') 'Оператор тек-й'
	,replace(isnull(cast(wt.fd as date), ''), '1900-01-01', '')  'Дата закреп-я тек-го закреп-я'
	,isnull(wt.name,'') 'Отдел тек-й'
	,isnull(wt.depart,'') 'Департамент тек-й'
--}

--Fix on given date {
	,isnull(fix_wt.fio, '') 'Оператор на зад-ю дату'
	,replace(isnull(cast(fix_wt.fd as date), ''), '1900-01-01', '')  'Дата закреп-я от зад-й даты'
	,isnull(fix_wt.name,'') 'Отдел на зад-ю дату'
	,isnull(fix_wt.depart,'') 'Департамент на зад-ю дату'
--}
	,datediff(day, d.start_date, getdate()-1) 'Факт-я DPD(от даты выхода на проср-ку до тек.даты'
	,(case
		when datediff(day,d.start_date,getdate()-1) !> 90 then '[ 0 - 90 ]'
		when datediff(day,d.start_date,getdate()-1) between 91 and 180 then '[ 91 - 180 ]'
		when datediff(day,d.start_date,getdate()-1) between 181 and 270 then '[ 181 - 270 ]'
		when datediff(day,d.start_date,getdate()-1) between 271 and 360 then '[ 271 - 360 ]'
		when datediff(day,d.start_date,getdate()-1) between 361 and 540 then '[ 361 - 540 ]'
		when datediff(day,d.start_date,getdate()-1) between 541 and 720 then '[ 541 - 720 ]'
		when datediff(day,d.start_date,getdate()-1) between 721 and 900 then '[ 721 - 900 ]'
		when datediff(day,d.start_date,getdate()-1) between 901 and 1080 then '[ 901 - 1080 ]'
		when datediff(day,d.start_date,getdate()-1) between 1081 and 1440 then '[ 1081 - 1440 ]'
		when datediff(day,d.start_date,getdate()-1) between 1441 and 1800 then '[ 1441 - 1800 ]'
		when datediff(day,d.start_date,getdate()-1) !< 1801 then '[ 1801 + ]'
	end)as 'Бакет факт. DPD'
	,datediff(day, d.start_date, p.sign_date) 'Банк-я DPD(от даты выхода на проср-ку до входа портф-я'
	,(case
		when datediff(day, d.start_date, p.sign_date) !> 90 then '[ 0-90 ]'
		when datediff(day, d.start_date, p.sign_date) between 91 and 180 then '[ 91 - 180 ]'
		when datediff(day, d.start_date, p.sign_date) between 181 and 270 then '[ 181 - 270 ]'
		when datediff(day, d.start_date, p.sign_date) between 271 and 360 then '[ 271 - 360 ]'
		when datediff(day, d.start_date, p.sign_date) between 361 and 540 then '[ 361 - 540 ]'
		when datediff(day, d.start_date, p.sign_date) between 541 and 720 then '[ 541 - 720 ]'
		when datediff(day, d.start_date, p.sign_date) between 721 and 900 then '[ 721 - 900 ]'
		when datediff(day, d.start_date, p.sign_date) between 901 and 1080 then '[ 901 - 1080 ]'
		when datediff(day, d.start_date, p.sign_date) between 1081 and 1440 then '[ 1081 - 1440 ]'
		when datediff(day, d.start_date, p.sign_date) between 1441 and 1800 then '[ 1441 - 1800 ]'
		when datediff(day, d.start_date, p.sign_date) !< 1801 then '[ 1801 + ]'
	end) 'Бакет банк. DPD'
	,isnull(d.start_sum, '') as 'Начальная сумма долга'
	,isnull(d.debt_sum, '') as 'Остаток'
	,isnull(dbl.debt_sum, '') as 'Остаток на заданную дату'
	,iif(d.debt_sum !> 1000
		,'0k - 1k'
		,iif(d.debt_sum between 1001 and 5000
			,'1k - 5k'
			,iif(d.debt_sum between 5001 and 30000
				,'5k - 30k'
				,iif(d.debt_sum between 30001 and 50000
					,'30k - 50k'
					,iif(d.debt_sum between 50001 and 100000
						,'50k - 100k'
						,iif(d.debt_sum between 100001 and 300000
							,'100k - 300k'
							,iif(d.debt_sum between 300001 and 500000
								,'300k - 500k'
								,iif(d.debt_sum between 500001 and 1000000
									,'500k - 1kk'
									,iif(d.debt_sum between 1000001 and 3000000
										,'1kk - 3kk'
										,iif(d.debt_sum !< 3000001
											,'3kk+'
											,'0'
										)
									)
								)
							)
						)
					)
				)
			)
		)
	) 'Диапазон остатка'
	,isnull(sum(cc.PP_sum),'') 'E оплат'
	,isnull(sum(cc.PP_kolvo),'') 'V оплат'
	,replace(isnull(cast(c.calc_date as date),''), '1900-01-01', '') 'Посл-я дата оплаты'
	,isnull(sum(dp.kolvo_obeshaniy), '') 'V обещаний'
	,isnull(sum(dp.summa_obeshaniy), '') 'E обещаний'
	,replace(isnull(cast(pr.prom_date as date), ''), '1900-01-01', '') 'Посл-я дата обещания'
	,isnull(sum(s.sms_otrp), '') 'V sms отпр-х'
	,isnull(sum(s.sms_dost), '') 'V sms дост-х'
	,isnull(sum(cl.ivr_vsego), '') 'V ivr отпр-х'
	,isnull(sum(cl.ivr_dost), '') 'V ivr дост-х'
	,isnull(sum(cl.ish_zvon), '') 'V исход-х звон-в'
	,isnull(sum(cl.vhod_zvon), '') 'V вход-х звон-в'
	,isnull(sum(cl.viezdi), '') 'V выездов'
	,isnull(sum(cl.pisma), '') 'V писем'
	,isnull(sum(cl.prochee), '') 'V прочего возд-я'
	,replace(isnull(cast(la.[start_date] as date), ''), '1900-01-01', '') 'Последняя дата ИП'
	,replace(isnull(cast(cl_musor.dt as date), ''), '1900-01-01', '') 'Дата посл-го мусор-го конт-а'
	,replace(isnull(cast(cl_perspective.dt as date), ''), '1900-01-01', '') 'Дата посл.перспек-го конт-а.'
	,isnull(iif(sum(perspect.count_perspecive_contacts) !< 1, 1, 0 ), '') 'Наличие перспек-го конт-а'
	,isnull(sum(perspect.count_perspecive_contacts), '') 'V персп-х конт-в'
	,isnull(sum(perspect.count_contacting_contacts), '') 'V персп-х вызовов'

FROM
	[i_collect].[dbo].[bank] as b

/*	portfolio
*/
	left join 
			(
			select 
				p.id
				,p.parent_id
				,p.name
				,p.sign_date
				,p.end_date
			from 
				[i_collect].[dbo].[portfolio] p

			)p
				on b.id = p.parent_id

/*	debt
*/
	left join
			(
			select
				d.id
				,d.r_portfolio_id
				,d.parent_id
				,d.debt_sum
				,d.start_sum
				,d.agency_rate
				,d.account
				,d.contract
				,d.typ
				,d.status
				,d.filial
				,d.mark1
				,d.filial_new
				,d.start_date
			from 
				[i_collect].[dbo].[debt] as d 

			)d
				on p.id = d.r_portfolio_id

/*	debt balance log
*/
	outer apply 			
			(
			select
				dbl.parent_id
				,dbl.debt_sum
			from 
				i_collect.dbo.debt_balance_log dbl
			where
				dbl.parent_id = d.id
				and dbl.id in 
						(
						select 
							max(d.id)
						from 
							i_collect.dbo.debt_balance_log as d
						where 
							d.dt < @d1
						group by 
							d.parent_id
						)
			)dbl	

/*	person
*/
	left join
			(
			select
				per.id
				,per.f + ' ' + per.i + ' ' + per.o fio
			from
				[i_collect].[dbo].[person] per
			)per
				on d.parent_id = per.id

/*	product type
	+ {wh}
*/
	left join
			(
				select
					d.id
					,di.name
				from
					i_collect.dbo.debt d
					left join
							(
							select
								di.code
								,di.name
							from
								i_collect.dbo.dict di
							where
								di.parent_id = 11
							)di
								on d.typ = di.code
				where
					d.id not in
							(
							select
								id
							from
								wh_data.dbo.type_of_product_special
							)

			UNION
				
				select
					tops.id
					,di.name
				from
					wh_data.dbo.type_of_product_special tops
					left join 
							(
							select
								di.code
								,di.name
							from
								i_collect.dbo.dict di
							where
								di.parent_id = 11
							)di
								on di.code = tops.typ

			)tp
				on tp.id = d.id
			


/*	last calc_date
*/
	left join	 
			(	
			select 
				dc.parent_id
				,dc.calc_date
			from 
				[i_collect].[dbo].[debt_calc] dc
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
				dc.parent_id, dc.calc_date

			)c		on d.id = c.parent_id

/*	last prom_date
*/
	left join 
			(	
			select 
				pr.parent_id, pr.prom_date
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
				pr.parent_id,pr.prom_date			

			)pr
				on d.id = pr.parent_id 

/*	last user
*/
	left join 
			(
			select
				wt.r_debt_id
				,dep.name
				,u.fio
				,u.depart
				,wt.fd
			from 
				[i_collect].[dbo].[work_task_log] as wt
				left join
						(
						select	
							u.id
							,u.r_department_id
							,u.f + ' ' + u.i + ' ' + u.o fio
							,u.depart
						from 
							[i_collect].[dbo].[users] u

						)u
							on wt.r_user_id = u.id

				left join
						(
						select 
							dep.dep
							,dep.name
						from 
							[i_collect].[dbo].[department] dep
						
						)dep
							on u.r_department_id = dep.dep				
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

			)wt
				on d.id = wt.r_debt_id

/*	last law_act
*/
	left join 
			(
			select 
				la.r_debt_id
				,la.[start_date]
			from 
				[i_collect].[dbo].[law_act] la
			where 
				la.id in 
						(
						select 
							max(id)
						from 
							[i_collect].[dbo].[law_act]
						group by 
							r_debt_id
						)
			group by 
				la.r_debt_id,la.[start_date]
			
			)la
				on la.r_debt_id = d.id

/*	debt_status
*/
	left join 
			(
			select 
				d1.name
				,d1.code
			from 
				[i_collect].[dbo].[dict] as d1
			where 
				d1.parent_id = 6

			)d_stat
				on d.status = d_stat.code	
					
/* region
*/
	left join
			(
			select 
				d.name
				,d.code
			from 
				[i_collect].[dbo].[dict] as d
			where 
				d.parent_id = 39

			)d_r
				on d_r.code = d.filial

/*	sms
*/
	outer apply  
			(
			select 
				s.parent_id
				,sum(iif(s.status in (1,2,3,4,5,6,7,8,9), 1, 0)) sms_otrp
				,sum(iif(s.status in (1,2), 1, 0)) sms_dost
			from 
				[i_collect].[dbo].[debt_sms] as s				
			where 
				s.parent_id = d.id
				and s.send_date between @d1 and @d2
			group by 
				s.parent_id

			)s

/*	IO_calls, ivr, mail, departure, other
*/
	outer apply
			(
			select 
				cl.r_debt_id
				,sum(iif(  (cl.typ = 19 and cl.dsc = 'Импортировано из Infinity (Автоинформатор)')
					,1
					,0
				))ivr_vsego

				,sum(iif((cl.typ = 19 and cl.result = 733 and cl.dsc = 'Импортировано из Infinity (Автоинформатор)')
					,1
					,0
				))ivr_dost

				,sum(iif((cl.typ = 1 and cl.result != 0), 1, 0)) ish_zvon
				,sum(iif(cl.typ = 3, 1, 0)) vhod_zvon
				,sum(iif(cl.typ = 2, 1, 0)) viezdi
				,sum(iif(cl.typ = 6, 1, 0)) pisma
				,sum(iif(cl.typ not in (6,2,3,1,19), 1, 0)) prochee						
			from 
				[i_collect].[dbo].[contact_log] cl
			where
				cl.r_debt_id = d.id
				and cl.dt between @d1 and @d2
			group by 
				cl.r_debt_id

			)cl

/*	debt_calc 
	quantity and sum
*/
	outer apply
			(
			select 
				dc.parent_id
				,sum(dc2.PP_sum) PP_sum
				,sum(dc2.PP_kolvo) PP_kolvo
			from 
				[i_collect].[dbo].[debt_calc] dc
				left join 
						(
						select 
							dc2.id as id
							,iif( (dc2.int_sum is not null and dc2.is_confirmed = 1 and dc2.is_cancel = 0)
								,dc2.int_sum
								,0
							)PP_sum
							,iif( (dc2.int_sum is not null and dc2.is_confirmed = 1 and dc2.is_cancel = 0)
								,1
								,0
							)PP_kolvo
							
						from 
							[i_collect].[dbo].[debt_calc] dc2
						group by
							dc2.id,dc2.is_confirmed,dc2.int_sum,dc2.is_cancel

						)dc2		on dc2.id=dc.id
					
			where 
				dc.parent_id = d.id	
				and dc.calc_date between @d1 and @d2									
			group by 
				dc.parent_id

			)cc
	
/*	promises
	quantity and sum
*/
	outer apply 
			(
			select 
				dp.parent_id
				,sum(dp2.summa_obeshaniy) as summa_obeshaniy
				,sum(dp2.kolvo_obeshaniy) as kolvo_obeshaniy
			from 
				[i_collect].[dbo].[debt_promise] as dp
				left join 
						(
						select 
							dp2.id id
							,iif(dp2.prom_sum is not null, dp2.prom_sum, 0) summa_obeshaniy
							,iif(dp2.prom_sum is not null, 1, 0) kolvo_obeshaniy
						from 
							[i_collect].[dbo].[debt_promise] dp2
						group by 
							dp2.id,dp2.prom_sum,dp2.dt

						)dp2
							on dp2.id=dp.id

			where 
				d.id = dp.parent_id 
				and dp.dt between @d1 and @d2
			group by 
				dp.parent_id

			) dp

/*	debt filial
*/
	left join	
			(	
			select 
				d.code
				,d.name
			from 
				i_collect.dbo.dict as d
			where 
				d.parent_id = 61
			)dfil		on d.filial_new = dfil.code

/*	last trash contact
*/
	left join
			( 
			select 
				cl.r_debt_id
				,cl.dt
			from 
				i_collect.dbo.contact_log as cl
				inner join wh_data.dbo.results r on cl.result = r.cl_result_id
			where 
				r.contact_or_not = 0
				and cl.id in (
					select 
						max(id)
					from 
						i_collect.dbo.contact_log
					group by 
						r_debt_id
				)

			)cl_musor
				on cl_musor.r_debt_id = d.id


/*	last perspective contact
*/
	left join(
			select 
				cl.r_debt_id
				,cl.dt
			from 
				i_collect.dbo.contact_log as cl
				inner join wh_data.dbo.results r on cl.result = r.cl_result_id
			where 		
				r.perspective = 1

				and cl.id in(	
					select 
						max(id)
					from 
						i_collect.dbo.contact_log
					group by
						r_debt_id
				)

			)cl_perspective
				on cl_perspective.r_debt_id = d.id

/*	perspective contacts
*/
	outer apply
			(
			select 
				perspect.r_debt_id
				,count(perspect.id) as count_contacting_contacts
				,count(case when r.perspective = 1 then perspect.id end) as	count_perspecive_contacts
			from 
				contact_log as perspect
				inner join wh_data.dbo.results r on perspect.result = r.cl_result_id
			where
				d.id = perspect.r_debt_id
				and r.contact_or_not = 1
				and perspect.dt between @d1 and @d2	
			group by
				perspect.r_debt_id	
						
			)perspect

/*	debt status on a given date
*/
	outer apply
			(
			select
				di.name
				,iif(dsl.status in (6,7,8,10), 0, 1) act
			from
				i_collect.dbo.debt_status_log dsl
				left join
						(
						select
							code,
							name
						from
							i_collect.dbo.dict 
						where
							parent_id = 6
						)di
							on di.code = dsl.status
			where
				dsl.parent_id = d.id
				and dsl.id in	
						(
						select
							max(id)
						from
							i_collect.dbo.debt_status_log
						where
							dt < @d1
						group by
							parent_id
						)
			)dsl

/*	Fix on given date
*/
	outer apply
			(
			select
				wt.r_debt_id
				,dep.name
				,u.fio
				,u.depart
				,wt.fd
			from 
				[i_collect].[dbo].[work_task_log] as wt
				left join
						(
						select	
							u.id
							,u.r_department_id
							,u.f + ' ' + u.i + ' ' + u.o fio
							,u.depart
						from 
							[i_collect].[dbo].[users] u

						)u
							on wt.r_user_id = u.id

				left join
						(
						select 
							dep.dep
							,dep.name
						from 
							[i_collect].[dbo].[department] dep
						
						)dep
							on u.r_department_id = dep.dep		
									
			where
				wt.r_debt_id = d.id
				and wt.id in 
						(
						select 
							max(id)
						from 
							[i_collect].[dbo].[work_task_log]
						where
							fd < @d1
						group by 
							r_debt_id						
						)

			)fix_wt

/*	portfolio on given date
*/
	outer apply
			(
			select
				p.name
				,replace(isnull(cast(dpl.dt as date), ''), '1900-01-01', '') dt
			from
				i_collect.dbo.debt_portfolio_log dpl
				left join i_collect.dbo.portfolio p on dpl.r_portfolio_id = p.id
			where
				dpl.parent_id = d.id
				and dpl.id in
						(
						select
							max(id)
						from
							i_collect.dbo.debt_portfolio_log
						where
							dt < @d1
						group by
							parent_id
						)
			)dpl


GROUP BY
	p.name,	d.debt_sum,c.calc_date,pr.prom_date
	,b.id,d.typ,la.start_date,p.sign_date,p.end_date
	,d.id,p.id,b.name,d_r.name,d.status,d.contract
	,d.account,d.agency_rate,wt.fio,wt.name,d_stat.name
	,d.start_sum,wt.fd,per.fio, per.id,dbl.debt_sum
	,dfil.name,cl_musor.dt,cl_perspective.dt,wt.depart
	,d.start_date,tp.name,dsl.name, dsl.act,fix_wt.fio
	, fix_wt.fd, fix_wt.name, fix_wt.depart,dpl.dt,dpl.name