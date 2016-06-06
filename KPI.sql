--kpi

declare @d1 date = '01-10-2015'
declare @d2 date = '31-03-2016'


SELECT
	

	d.id 'ID долга'
	,dp1.otdel 'Отдел'
	,dp1.fio 'Оператор взявший обещание'
	
	,cast(dp1.prom_date as date) 'Дата обещанного платежа'
	,dp1.prom_sum 'Сумма первого обещания'
	,isnull(sum(oDp.kolvo),0) 'Кол-во обещаний за период'
	,dp1.zzzzzz 'Сумма на дату рег. 1-го обещания'
	,d.debt_sum 'Сумма долга текущая'
	,isnull(sum(cc.PP_sum),0) 'Сумма оплат за период'
	,cast(dp1.reg1 as date) 'Дата рег. 1-го обещания'
	,(
	case
		when dp1.Status4erez30DneiPosleReg1 not in (6,7,8) --если активен:
			then cast(dateadd(month, 1, dp1.reg1) as date)

		when dp1.Status4erez30DneiPosleReg1 in (6,7,8)
			then cast(dp1.Data4erez30DneiPosleReg1 as date) --cast(dp1.Data4erez30DneiPosleReg1 as date)
	end
	) 'Контрольная дата'
	
	,(
		select
			debt_sum
		from
			debt_balance_log
		where
			id = (select max(id) from debt_balance_log where parent_id = d.id
																			
																			and

																			dt <= 
																					(
																					case
																						when dp1.Status4erez30DneiPosleReg1 not in (6,7,8)
																							then cast(dateadd(month, 1, dp1.reg1) as date)

																						when dp1.Status4erez30DneiPosleReg1 in (6,7,8) 
																							then cast(dp1.Data4erez30DneiPosleReg1 as date)--cast(dp1.Data4erez30DneiPosleReg1 as date)
																					end
																					)
				)
	) 'Сумма остатка на контрольную дату'


	,(
	case
		when dp1.Status4erez30DneiPosleReg1 not in (6,7,8)
			then dp1.Status4erez30DneiPosleReg1Text

		when dp1.Status4erez30DneiPosleReg1 in (6,7,8)
			then dp1.Status4erez30DneiPosleReg1Text
	end
	) 'Статус на контрольную дату'

	,isnull((
	select 
		sum(dc2.PP_sum)
	from 
		debt_calc as dc
		left join (select 
						dc2.id as id,
						(case 
							when (dc2.int_sum is not null and dc2.is_confirmed = 1 and dc2.is_cancel = 0)
							then dc2.int_sum 
							else 0
						end) as PP_sum
					from 
						debt_calc as dc2
					group by 
						dc2.id
						,dc2.is_confirmed
						,dc2.int_sum
						,dc2.is_cancel
				)dc2
					on dc2.id = dc.id
					
			where
				dc.parent_id = d.id
				and dc.calc_date between dp1.reg1 and (
														case
															when dp1.Status4erez30DneiPosleReg1 not in (6,7,8) --если активен:
																then cast(dateadd(month, 1, dp1.reg1) as date)

															when dp1.Status4erez30DneiPosleReg1 in (6,7,8)
																then cast(dp1.Data4erez30DneiPosleReg1 as date) --cast(dp1.Data4erez30DneiPosleReg1 as date)
														end
														)
			group by 
				dc.parent_id
	),0) 'Оплат за период'
	
	/*users*/
	,isnull((
	select
		dep.name
	from
		work_task_log as wt
		left join users as u on wt.r_user_id = u.id
		left join department as dep on u.r_department_id = dep.dep
	where
		d.id = wt.r_debt_id
		and wt.id in 
				(
				select
					max(id)
				from
					work_task_log
				where
					dt < dp1.reg1
				group by
					r_debt_id
				)
	),'') 'Закрепление'

FROM
	bank as b
	inner join portfolio as p on b.id = p.parent_id
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id 

	inner join  --1 prom
			(
			select
				dp.parent_id
				,dp.dt reg1
				,u.f+' '+u.i+' '+u.o fio
				,dep.name otdel
				,dp.prom_date 
				,dp.prom_sum
			    ,(
					select 
						debt_sum 
					from 
						debt_balance_log 
					where 
						id = (select max(id) from debt_balance_log where parent_id = dp.parent_id and dt <= dp.dt)
				)
				 zzzzzz

				 ,(
					select 
						debt_sum 
					from 
						debt_balance_log 
					where 
						id = (select max(id) from debt_balance_log where parent_id = dp.parent_id and dt <= dateadd(month, 1, dp.dt))
				)
				 zzzzzz1

				,(
					select
						status
					from
						debt_status_log
					where
						id = (select max(id) from debt_status_log where parent_id = dp.parent_id and dt <= dateadd(month, 1, dp.dt))
				)
				 Status4erez30DneiPosleReg1


				,(
					select
						di.name
					from
						debt_status_log
						left join (select dict.code, dict.name from dict where parent_id = 6)di on debt_status_log.status = di.code
					where
						id = (select max(id) from debt_status_log where parent_id = dp.parent_id and dt <= dateadd(month, 1, dp.dt))
				)
				 Status4erez30DneiPosleReg1Text
				
						
				,(
					select
						dt
					from
						debt_status_log
					where
						id = (select max(id) from debt_status_log where parent_id = dp.parent_id and dt between dp.dt and  dateadd(month, 1, dp.dt))
				)
				 Data4erez30DneiPosleReg1

				
				



			from
				debt_promise dp
				left join users u on dp.r_user_id = u.id
				left join department dep on u.r_department_id = dep.dep
			where
				dp.id in (select min(id) from debt_promise group by parent_id)
				and dep.r_dep = 8
				and dp.dt >= '01-10-2015'
				
			)dp1
				on dp1.parent_id = d.id


	outer apply --количество обещаний за период
			(
			select
				oDp.parent_id
				,count(oDp.id) kolvo
			from
				debt_promise oDp
			where
				oDp.parent_id = d.id
				and oDp.dt between @d1 and @d2
			group by
				oDp.parent_id
				
			)oDp
			

	--calc summ
	outer apply
			(
			select 
				dc.parent_id
				,sum(dc2.PP_sum) as PP_sum
			from
				[i_collect].[dbo].[debt_calc] as dc
				left join 
						(
						select
							dc2.id as id
							,(case
								when (dc2.int_sum is not null and dc2.is_confirmed = 1 and dc2.is_cancel = 0)
								then dc2.int_sum else 0
							end) as PP_sum
						from
							[i_collect].[dbo].[debt_calc] as dc2
						group by
							dc2.id
							,dc2.is_confirmed
							,dc2.int_sum
							,dc2.is_cancel
						)dc2
							on dc2.id=dc.id
					
			where
				dc.parent_id = d.id
				and dc.calc_date between @d1 and @d2
								
			group by 
				dc.parent_id
			)cc

--status
	left join
			(
			select
				dsl.parent_id
				,dsl.dt
				,dsl.status
			from
				debt_status_log dsl
			where
				dsl.id in (select max(id) from debt_status_log group by parent_id)
			group by
				dsl.parent_id
				,dsl.dt
				,dsl.status
			)dsl
				on dsl.parent_id = d.id

group by
	 d.id
	,dp1.otdel
	,dp1.fio
	,dp1.reg1
	,dp1.prom_date
	,dp1.prom_sum
	,dp1.zzzzzz
	,d.debt_sum
	--,d.status
	,dsl.dt
	,dp1.Status4erez30DneiPosleReg1
	,dp1.Data4erez30DneiPosleReg1
	,dp1.Status4erez30DneiPosleReg1Text


	--select * from debt_status_log where parent_id = 518915 order by dt desc