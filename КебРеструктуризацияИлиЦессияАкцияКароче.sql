--отчет КЕБ 15.04
--долгов 40 878

declare @d1 date = '01-04-2016'
declare @d2 date = getdate()


select
	d.ext_id 'ID клиента'
	,per.f+' '+per.i+' '+per.o 'ФИО Должника'
	,d.contract 'Договор'
	,isnull((case when sum(cl.r) >= 1 then 'Обещание "Реструктуризация"' when sum(cl.c) >= 1 then 'Обещание "Цессия"' else '' end), '') 'Обещание'
	,isnull(sum(cl.prom_sum),'') 'Сумма обещания'
	,replace(isnull(cast(cl.dt as date),''), '1900-01-01', '') 'Дата сделки'
	,isnull(cl.number,'') 'конт № телефона'
	,isnull(cl.full_adr,'') 'адрес'
	

from
	bank as b
	inner join portfolio as p on b.id = p.parent_id	
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id
	
	outer apply
			(
			select distinct
				cl.r_debt_id
				,count(case
							when cl.result in (321023,321143,321148,321159,321165,321225,321212,321182)
							then cl.id
						end) r

				,count(case
							when cl.result in (321138,321078,321075,320880,320919,320902,321221,321209,321178)
							then cl.id
						end) c

				,sum(dp.prom_sum) prom_sum
				,dp.dt
				,p.number
				,a.full_adr
					

			from
				contact_log cl
				outer apply --обещание
						(
						select
							dp.id
							,dp.prom_sum
							,dp.dt

						from
							debt_promise dp
						where
							dp.id = cl.r_prom_id
							and dp.dt between @d1 and @d2
							and dp.id in
										(
										select
											max(id)
										from
											debt_promise
										group by
											parent_id
										)
						)dp

				left join --телефон
						(
						select
							p.id,
							p.number
						from
							phone p
						)p		on cl.r_phone_id = p.id

				left join
						(
						select
							a.id,
							a.full_adr
						from
							address a
						)a		on cl.r_adres_id = a.id


								
														


			where
				cl.r_debt_id = d.id
				and cl.dt between @d1 and @d2
				and cl.result in
								(
								321023,321138,321143,321078,321148,321075,320880,321159,321178,
								320919,321165,320902,321225,321221,321212,321209,321182
								)

			group by
				cl.r_debt_id
				,dp.dt
				,p.number
				,a.full_adr
								
			)cl


where
	b.id = 67
	and d.status not in (6,7,8,10)

group by
	d.ext_id,
	per.f,per.i,per.o,
	d.contract,
	cl.dt,
	cl.number,
	cl.full_adr