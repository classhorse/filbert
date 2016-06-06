select
	getdate() as [DT],
	contr.alias as [Контрагент],
	reg.r_portfolio_id as [ID портфеля],
	reg.alias as [Портфель],
	reg.datebegin as [Дата начала],
	reg.dateend as [Дата выхода],
	reg.KontaktID [ID долга],
	reg.[Contract] [Договор],
	reg.[Account] [Лиц.счет],
	reg.[ExtID] [Клиент ID],
	reg.DPD [DPD],
	reg.amounttorecover [Долг],
	isnull(reg.agency_rate,0) as [% вознагр.],
	isnull((reg.agency_rate/100)*reg.amounttorecover,0) as [Возмож. АВ],
	isnull(reg.dolgi,0) as [Кол-во акт.долгов],
	reg.name as [Продукт],
	reg.kredit as [Размер кредита],
	reg.start as [Перв. сум. д.],
	reg.dstat as [Статус долга],
	reg.fio as [Оператор],
	reg.wtdt as [Дата закрепления],
	reg.fio2 as [Пр. оператор],
	isnull(reg.Sms_vsego,0) as [Отправ.СМС],
	isnull(reg.sms_dostav,0) as [Доставл. СМС],
	isnull(reg.Ivr_vsego,0) as [Отправ.Ivr],
	isnull(reg.ivr_dostav,0) as [Доставл. IVR],
	isnull(reg.s_dolzh,0) as [С должником],
	isnull(reg.s_3m,0) as [С 3-м],
	isnull(reg.vhod_zv,0) as [Входящих],
	isnull(reg.vsego_zv,0) as [Всего попыток дозвона],
	isnull(reg.zv_kontakt,0) as [Контактов],
	reg.dt_zv as [Дата посл. звонка],
	reg.dt_k_d as [Дата контакта с должн.],
	reg.dt_k_3 as [Дата контакта с 3-м],
	reg.dt_sms as [Дата доставки смс],
	reg.dt_ivr as [Дата доставки ivr],
	reg.dcdt as [Дата ПП],
	reg.sumdt as [Посл. ПП],
	reg.dpdt as [Дата ОП],
	reg.dpsum as [Посл. ОП],
	reg.dcdt2 as [Дата НП],
	reg.sumdt2 as [Посл. НП],
	isnull(reg.kol_ob,0) as [Кол-во обещ.],
	isnull(reg.OP_sum,0) as [ОП, руб],
	isnull(reg.NP_sum,0) as [НП, руб],
	isnull(reg.PP_sum,0) as [ПП, руб],
	reg.[Регион] as [Регион],
	reg.[Город] as [Город],
	reg.[Регион в Контакт] as [Регион в Контакт],
	reg.stat as [Статус в контакте],
	isnull(reg.was_hard,0) as [Был в Hard],
	isnull(reg.was_region,0) as [Был в Рег.софт],
	reg.otdel as [Отдел],
	reg.ochered as [Очередь обзвона],
	reg.scor as [Скорбалл],
	reg.idpers as [ID должника],
	prior.Priotity as [Приоритет КА],
	reg.dep as [Название отдела],
	0 as Million
FROM 
	[copy_db_oktell_data].[dbo].[Contragent] as contr
left join 
	(select 
		d.KontaktID as KontaktID
		,d.dstat as dstat
		,d.fio as fio
		,d.fio2
		,d.dt_k_d as dt_k_d,
		d.dt_k_3 as dt_k_3,
		d.dt_ivr as dt_ivr,
		d.dt_sms as dt_sms,
		d.amounttorecover
		,d.DPD
		,d.[Contract]
		,d.[Account]
		,d.[ExtID]
		,d.wtdt as wtdt
		,d.dpdt as dpdt
		,d.dpsum as dpsum
		,d.dcdt as dcdt
		,d.dcdt2 as dcdt2
		,d.dt_zv as dt_zv
		,d.sumdt as sumdt
		,d.sumdt2 as sumdt2,
		reg.alias as alias,
		reg.DateBegin as DateBegin,
		reg.DateEnd as DateEnd,
		reg.Status as Status,
		reg.ContragentID as ContragentID,
		sum(d.Sms_vsego) as Sms_vsego,
		sum(d.Sms_dostav) as Sms_dostav,
		sum(d.Ivr_vsego) as Ivr_vsego,
		sum(d.Ivr_dostav) as Ivr_dostav,
		sum(d.s_dolzh) as s_dolzh,
		sum(d.s_3m) as s_3m,
		sum(d.vhod_zv) as vhod_zv,
		sum(d.vsego_zv) as vsego_zv,
		sum(d.Zv_kontakt) as Zv_kontakt,
		sum(d.OP_sum) as OP_sum,
		sum(d.kol_ob) as kol_ob,
		sum(d.NP_sum) as NP_sum,
		sum(d.PP_sum) as PP_sum
		,d.[Регион] as [Регион]
		,d.[Город] as [Город]
		,d.[Регион в Контакт],
		d.stat as stat
		,d.was_hard as was_hard
		,d.was_region as was_region
		,d.name as name
		,d.kredit as kredit
		,d.start as start
		,d.otdel
		,d.agency_rate
		,d.dolgi
		,d.ochered
		,d.idpers
		,d.dep
		,d.r_portfolio_id
		,d.scor
	from 
		[copy_db_oktell_data].[dbo].[Register] as reg
	left join 
		(select 
			d.id as ID,d.registerid as registerid,
			d.amounttorecover,
			kld.KontaktID as KontaktID
			,dk.r_portfolio_id
			,d.DPD
			,d.[Contract]
			,d.[Account]
			,d.[ExtID]
			,dstat.Description as dstat
			,dk.[agency_rate]
			,us.fio as fio
			,wt.wtdt as wtdt
			,us_2.fio as fio2
			,dpdt.dpdt as dpdt
			,dpdt.dpsum as dpsum
			,dcdt.dcdt as dcdt
			,dcdt2.dcdt2 as dcdt2
			,dcdt.sumdt as sumdt
			,dcdt2.sumdt2 as sumdt2
			,d2_1.dt_k_d as dt_k_d,
			d2_2.dt_k_3 as dt_k_3,
			d2_3.dt_ivr as dt_ivr,
			d2_4.dt_sms as dt_sms,
			d2_5.dt_zv as dt_zv,
			sum(tos.Ivr_vsego) as Ivr_vsego,
			sum(tos.Ivr_dostav) as Ivr_dostav,
			sum(tos.Sms_vsego) as Sms_vsego,
			sum(tos.Sms_dostav) as Sms_dostav,
			sum(tos.s_dolzh) as s_dolzh,
			sum(tos.s_3m) as s_3m,
			sum(tos.vhod_zv) as vhod_zv,
			sum(tos.Zv_kontakt) as Zv_kontakt,
			sum(tos.vsego_zv) as vsego_zv,
			sum(dp.OP_sum) as OP_sum,
			sum(dp.kol_ob) as kol_ob,
			sum(dc.NP_sum) as NP_sum,
			sum(dc.PP_sum) as PP_sum,
			r.[Регион] as [Регион],
			r.[Город] as [Город],
			r.[Регоин в Контакт] as [Регион в Контакт],
			di.name as stat,
			wtl.was_hard as was_hard,
			wtl_2.was_region as was_region,
			dk.name as name,
			dk.total_sum as kredit,
			dk.start_sum as start,
			us.otdel as otdel,
			dolgi.kvo as dolgi,
			pers.decency as ochered,
			pers.id as idpers,
			us.dep,
			rv.value as scor
		from 
			[copy_db_oktell_data].[dbo].[Debt] as d
			left join [copy_db_oktell_data].[dbo].[_DebtStatus] as dstat on dstat.id=d.statusid
			left join [db_oktell_data_log].[dbo].[KontaktLinkDebt] as kld on kld.DebtID=d.id
			left join [copy_db_i_collect_copy].[dbo].[debt] as dk on dk.id=kld.KontaktID
			left join [copy_db_i_collect_copy].[dbo].[dict] as di on di.code=dk.status and di.parent_id=6
			left join

--ДАТА КОНТАКТА С ДОЛЖНИКОМ
	(select 
		d2_1.id, 
		posl_k.dt_k_d as dt_k_d
	from 
		[copy_db_oktell_data].[dbo].[Debt] as d2_1
		cross apply

			(select top 1
				(case 
					when(eventwithdebtor=1 and eventresult <>'История работы') 
					then eventdate 
					else 0 
				end) as dt_k_d
			from 
				[db_report_collection].[report].[temp_oper_statisict] posl_k
			where 
				posl_k.debtid = d2_1.id 
				and (eventwithdebtor=1)
			order by 
				eventdate desc

			)posl_k

	group by d2_1.id, dt_k_d

	)d2_1 on d2_1.id=d.id


--С 3М ЛИЦОМ
left join

	(select 

		d2_2.id, 
		posl_k.dt_k_3 as dt_k_3
	from 
		[copy_db_oktell_data].[dbo].[Debt] as d2_2
		cross apply 

			(select top 1
			(case 
				when(eventwith3=1 and eventresult <>'История работы' 
									and EventResult not like '%Номер%не%прин%') 
				then eventdate 
				else 0 
			end) as dt_k_3

			from
				[db_report_collection].[report].[temp_oper_statisict] posl_k
			where 
				posl_k.debtid=d2_2.id and ( eventwith3=1)
			order by 
				eventdate desc

			)posl_k

	group by d2_2.id, dt_k_3
	)d2_2 on d2_2.id=d.id


--ДАТА ДОСТАВКИ IVR
left join 

	(select 
		d2_3.id, 
		posl_k.dt_ivr as dt_ivr
	from 
		[copy_db_oktell_data].[dbo].[Debt] as d2_3
		cross apply 

			(select top 1
				(case 
					when (eventtype='Ivr' and eventsuccess=1 and eventresult <>'История работы') 
					then eventdate 
					else 0 
				end) as dt_ivr
			from 
				[db_report_collection].[report].[temp_oper_statisict] posl_k
			where 
				posl_k.debtid=d2_3.id 
				and ((eventtype='Ivr' and eventsuccess=1))
			order by 
				eventdate desc

			)posl_k
	group by 
			d2_3.id, 
			dt_ivr

	)d2_3 on d2_3.id=d.id

--ДАТА ДОСТАВКИ СМС
left join 

	(select 
		d2_4.id, 
		posl_k.dt_sms as dt_sms
	from 
		[copy_db_oktell_data].[dbo].[Debt] as d2_4
		cross apply 

			(select top 1
				(case 
					when (eventtype='Sms' and eventresult <>'История работы' and eventsuccess=1) 
					then eventdate 
					else 0 
				end) as dt_sms
			from 
				[db_report_collection].[report].[temp_oper_statisict] posl_k
			where 
				posl_k.debtid=d2_4.id and ( (eventtype='Sms' and eventsuccess=1))
			order by 
				eventdate desc

			)posl_k

	group by 
		d2_4.id, 
		dt_sms

	)d2_4 on d2_4.id=d.id


--ДАТА ПОСЛЕДНЕГО ЗВОНКА
left join 

	(select 
		d2_5.id, 
		posl_k.dt_zv as dt_zv
	from 
		[copy_db_oktell_data].[dbo].[Debt] as d2_5
		cross apply	

			(select top 1
				(case 
					when (eventtype='Звонок' and eventresult <>'История работы') 
					then eventdate 
					else 0 
				end) as dt_zv
			from 
				[db_report_collection].[report].[temp_oper_statisict] posl_k
			where 
				posl_k.debtid=d2_5.id 
				and eventtype='Звонок'
			order by 
				eventdate desc
			) posl_k

	group by 
		d2_5.id,dt_zv

	)d2_5 on d2_5.id=d.id


--Информация по совершенным действиям
left join 

	(select tos.debtid, 
		sum(case 
			when (tos.eventtype ='Ivr') 
			then 1 
			else 0 end) as Ivr_vsego,
		sum(case 
			when (tos.eventtype ='Ivr' 
					and tos.eventsuccess=1) 
			then 1 
			else 0 end) as Ivr_dostav,
		sum(case 
			when (tos.eventtype ='Sms') 
			then 1 
			else 0 end) as Sms_vsego,
		sum(case 
			when (tos.eventtype ='Sms' 
					and tos.eventsuccess=1) 
			then 1 
			else 0 end) as Sms_dostav,
		sum(case 
			when (tos.eventtype ='Звонок' 
					and tos.eventwithdebtor=1 
					and eventresult <>'История работы') 
			then 1 
			else 0 end) as s_dolzh,
		sum(case 
			when (tos.eventtype ='Звонок' 	
					and tos.eventwith3 = 1 
					and eventresult <>'История работы' 
					and EventResult not like '%Номер%не%прин%') 
			then 1 else 0 end) as s_3m,
		sum(case 
			when (tos.eventtype='Звонок' 
					and tos.eventbound=0 
					and eventresult <>'История работы') 
			then 1 
			else 0 end) as vhod_zv,
		sum(case 
			when (tos.eventtype='Звонок' 
					and (tos.eventwithdebtor=1 or tos.eventwith3=1)
					and eventresult <>'История работы' 
					and EventResult not like '%Номер%не%прин%') 
			then 1 
			else 0 end) as Zv_kontakt,
		sum(case 
			when (tos.eventtype='Звонок' 
					and eventbound=1 
					and eventresult <>'История работы') 
			then 1 
			else 0 end) as vsego_zv
		
	from 
		[db_report_collection].[report].[temp_oper_statisict] as tos 
	group by 
		tos.DebtID

	) tos on tos.debtid=d.id


--присоединяем платежи
left join 

	(select 
		dc.parent_id, 
		sum(dc2.PP_sum) as PP_sum,
		sum(dc2.NP_sum) as NP_sum
	from 
		[copy_db_i_collect_copy].[dbo].[debt_calc] as dc
		left join 

			(select dc2.id as id,
				(case 
					when (dc2.int_sum is not null and dc2.is_confirmed='1' and dc2.is_cancel='0' ) 
					then dc2.int_sum 
					else 0 
				end) as PP_sum,
			
				(case 
					when (dc2.int_sum is not null and dc2.is_confirmed='0' and dc2.is_cancel='0' ) 
					then dc2.int_sum 
					else 0 
				end) as NP_sum
			from 
				[copy_db_i_collect_copy].[dbo].[debt_calc] as dc2
			group by 
				dc2.id,
				dc2.is_confirmed,
				dc2.is_cancel,
				dc2.int_sum,dc2.calc_date

			) dc2 on dc2.id=dc.id

		group by dc.parent_id

		) dc on dc.parent_id=kld.KontaktID


--присоединяем обещания
left join 

	(select dp.parent_id, 
		sum(dp2.OP_sum) as OP_sum,
		sum(dp2.kol_ob) as kol_ob
	from 
		[copy_db_i_collect_copy].[dbo].[debt_promise] as dp
		left join 

			(select dp2.id as id,
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
			from [copy_db_i_collect_copy].[dbo].[debt_promise] as dp2
			group by dp2.id,dp2.prom_sum,dp2.dt

			) dp2 on dp2.id=dp.id


	group by dp.parent_id

	) dp on kld.KontaktID=dp.parent_id


--ДАТА ОБЕЩАНИЯ
left join 

	(select 
		dpdt.KontaktID,
		dpdt1.dpdt as dpdt,
		dpdt1.dpsum as dpsum
	from 
		[db_oktell_data_log].[dbo].[KontaktLinkDebt] as dpdt
		cross apply 

			(select top 1
				dpdt1.prom_date as dpdt,
				dpdt1.prom_sum as dpsum
			from 
				[copy_db_i_collect_copy].[dbo].[debt_promise] dpdt1
			where 
				dpdt1.parent_id = dpdt.KontaktID
			order by 
				dpdt1.prom_date desc

			)dpdt1


	group by 
		dpdt.KontaktID,
		dpdt,dpsum

	) dpdt on dpdt.KontaktID=kld.kontaktid



--ДАТА ОПЛАТЫ ПП
left join 

	(select 
		dcdt.KontaktID,
		dcdt1.dcdt as dcdt,
		dcdt1.sumdt as sumdt
	from 
		[db_oktell_data_log].[dbo].[KontaktLinkDebt] as dcdt
		cross apply 

			(select top 1
				dcdt1.calc_date as dcdt,
				dcdt1.int_sum as sumdt
			from 
				[copy_db_i_collect_copy].[dbo].[debt_calc] dcdt1
			where 
				dcdt1.parent_id = dcdt.KontaktID 
				and dcdt1.is_confirmed='1' 
				and dcdt1.is_cancel='0'
			order by 
				dcdt1.calc_date desc

			)dcdt1


	group by 
		dcdt.KontaktID,
		dcdt,sumdt

	)dcdt on dcdt.KontaktID=kld.kontaktid



--ДАТА ОПЛАТЫ НП
left join 

	(select 
		dcdt2.KontaktID,
		dcdt1.dcdt2 as dcdt2,
		dcdt1.sumdt2 as sumdt2
	from 
		[db_oktell_data_log].[dbo].[KontaktLinkDebt] as dcdt2
		cross apply 

			(select top 1
					dcdt1.calc_date as dcdt2,
					dcdt1.int_sum as sumdt2
			from 
				[copy_db_i_collect_copy].[dbo].[debt_calc] dcdt1
			where 
				dcdt1.parent_id = dcdt2.KontaktID 
				and dcdt1.is_confirmed='0' 
				and dcdt1.is_cancel='0'
			order by 
				dcdt1.calc_date desc

			)dcdt1


	group by 
		dcdt2.KontaktID,
		dcdt2,sumdt2

	)dcdt2 on dcdt2.KontaktID=kld.kontaktid



----------------------------------------------------------------------------------------
--Текущий оператор
outer apply 

	(select 
		top 1 wt.r_user_id,wt.r_debt_id,wt.fd as wtdt 
	from 
		[copy_db_i_collect_copy].[dbo].[work_task_log] as wt
	where 
		wt.r_debt_id = kld.kontaktid
	order by 
		wt.fd desc

	) wt



left join

	(select 
		us.f+' '+us.i+' '+us.o as [fio],
		us.id,us.r_department_id as [otdel],
		d.name as dep
	from 
		[copy_db_i_collect_copy].[dbo].[users] as us
	left join 
		[copy_db_i_collect_copy].[dbo].[department] as d on d.dep=us.r_department_id
	group by 
		us.f+' '+us.i+' '+us.o,
		us.id,us.r_department_id,
		d.name

	)us on us.id = wt.r_user_id



---------------------------------------------------------------------------------
--Предыдущий оператор
outer apply 

	(select 
		top 1 wt_2.r_user_id,
		wt_2.r_debt_id,
		wt_2.fd as wtdt 
	from 
		[copy_db_i_collect_copy].[dbo].[work_task_log] as wt_2
	where 
		wt_2.r_debt_id=kld.kontaktid and wt_2.fd<>wt.wtdt
	order by 
		wt_2.fd desc

	)wt_2



left join 

	(select 
		us_2.f+' '+us_2.i+' '+us_2.o as [fio],
		us_2.id
	from 
		[copy_db_i_collect_copy].[dbo].[users] as us_2
	group by 
		us_2.f+' '+us_2.i+' '+us_2.o ,
		us_2.id

	) us_2 on us_2.id=wt_2.r_user_id


	-----------------------------------------------------------------------------------
--Был на хард
left join 

	(select distinct 
		wtl.r_debt_id,
		(case when us.r_department_id in (3,45,46,47,48,49,50) then 1 else 0 end) as was_hard
	from 
		[copy_db_i_collect_copy].[dbo].[work_task_log] as wtl
	left join 
		[copy_db_i_collect_copy].[dbo].[users] as us on us.id=wtl.r_user_id
	where 
		us.r_department_id=3
	group by 
		wtl.r_debt_id,
		wtl.r_user_id,
		us.r_department_id

	)wtl on wtl.r_debt_id=kld.kontaktid



	-------------------------------------------------------------------------------------------
--Был на региональном софте
left join 

	(select distinct 
		wtl.r_debt_id,
		(case when us.r_department_id=19 then 1 else 0 end) as was_region
	from 
		copy_db_i_collect_copy].[dbo].[work_task_log] as wtl
	left join 
		[copy_db_i_collect_copy].[dbo].[users] as us on us.id=wtl.r_user_id
	where 
		us.r_department_id=19
	group by 
		wtl.r_debt_id,
		wtl.r_user_id,
		us.r_department_id

	)wtl_2 on wtl_2.r_debt_id=kld.kontaktid


	-----------------------------------------------------------------------------------------------
--Кол-во активных долгов на должнике
left join 

	(select 
		count(d2.id) as kvo, 
		dolgi.PersonID
	from 
		[db_oktell_data_log].[dbo].[KontaktLinkPerson] as dolgi
	left join 
		[copy_db_i_collect_copy].[dbo].[debt] as d2 on d2.parent_id=dolgi.KontaktID
	where 
		d2.status not in (6,7,8,10,106,110)
	group by 
		dolgi.PersonID
	)dolgi on d.personid=dolgi.PersonID
	-------------------------------------------------------------------------------------------------

	group by 
	d.r_portfolio_id,
	reg.alias,
	reg.DateBegin,
	reg.DateEnd,
	reg.Status,
	d.otdel,
	reg.ContragentID,
	d.kontaktid,
	d.dstat,
	d.fio,
	d.dt_k_d,
	d.dt_k_3,
	d.amounttorecover,
	d.DPD,
	d.[Contract],
	d.[Account],
	d.[ExtID],
	d.dt_ivr,
	d.dt_sms,
	d.[Регион],
	d.[Город],
	d.wtdt,
	d.dpdt,
	d.dcdt,
	d.dt_zv,
	d.sumdt,
	d.[Регион в Контакт],
	d.name,
	d.was_hard,
	d.dcdt2,
	d.dpsum,
	d.sumdt2,
	d.start,
	d.kredit,
	d.stat,
	d.fio2,
	d.agency_rate,
	d.was_region,
	d.dolgi,
	d.ochered,
	d.idpers,
	d.dep,d.scor

	) reg on reg.contragentid=contr.id

where 
	contr.alias not like '%мтс%'
	and contr.alias not like '%test%'
	and reg.Status=1
	order by 
	contr.alias asc


