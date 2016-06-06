--░█░░░█▀█░█░█░█▀▀░
--░█░░░█░█░█░█░█▀▀
--░▀▀▀░▀▀▀░░▀░░▀▀▀░


select distinct
	
	--ROW_NUMBER() over (order by sum(dp.op_sum) desc) as '№п/п',
	'Филберт' as 'Агентство',
	d.contract as 'Номер договора',
	d.id as 'ID долга',
	per.f+' '+per.i+' '+per.o as 'ФИО Клиента',
	'Rur' as 'Валюта',
	dd.write_off_sum as 'Сумма к прощению',
	dd.pay_sum as 'Сумма к оплате',
	dd.write_off_sum/(dd.pay_sum+dd.write_off_sum)*100 as '% Дисконта',


--из journal {

	do.data as 'Предложить до', --дропни потом как СКМ закончишь <3

--из journal };
	
	
	isnull(cl.skem,'-') as 'С кем контакт',
	isnull (convert(varchar, cl.dt, 104), '-') as 'Дата контакта с клиентом',
	isnull(cl.sogl, '-') as 'Результат',

	isnull((case
				when cl.sogl = 'Отказ от дисконта'
				then isnull(	replace(r.name, 'СКМ -', '')	, 'Иное')
			end)	,	'-')  
	as 'Причина отказа',


	isnull(convert(varchar, dp.prom_date, 104),'-') as 'Дата планируемой оплаты ',

	
	isnull( sum(dp.summa),0) as 'Сумма планируемой оплаты'



	




from

	i_collect.dbo.bank as b
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
	inner join i_collect.dbo.person as per on d.parent_id = per.id
	inner join Journal.dbo.do_31_01 as do on d.id = do.id

--акция
	inner join
			(
				select
					dd.r_debt_id,
					dd.pay_sum,
					dd.write_off_sum,
					dd.pay_date

				from
					i_collect.dbo.debt_discount as dd

				where
					
					dd.r_discount_id in (25, 26)

			
			)dd on d.id = dd.r_debt_id

--причина отказа
	left join
			(
				select

					ds.parent_id,
					di.name,
					ds.reason

				from
					
					i_collect.dbo.debt_dsc_log as ds

					left join
							
							(
								select
									code,
									name
								from
									i_collect.dbo.dict
								where
									parent_id = 13
									and code between 919 and 926

							)di		on ds.reason = di.code


			)r		on d.id = r.parent_id


--присоединяем обещания

	outer apply

		(
			select 

				dp.parent_id, 
				dp.prom_date

			from 

				i_collect.dbo.debt_promise as dp

			where

				dp.dt > '18-12-2015 07:59:59'
				and d.id = dp.parent_id

			group by 

				dp.parent_id,
				dp.prom_date,
				dp.dt	



		)dp1 --on d.id = dp.parent_id


--cl
	outer apply
			(
				select

					cl.r_debt_id,

					(case	
						
						when cl.result in 
										(
											120239,120189,120190,120191,120202,120200,
											120198,120196,120194,120201,120199,120197,
											120195,120193,320271,320272,320273,320274,
											320321,320319,320317,320315,320322,320320,
											320318,320316,320314,320313
										)
						then 'С должником'

						when cl.result in 
										(
											120237,120228,120218,120240,120236,120227,
											120217,120213,120210,120207,120204,120234,
											120225,120216,120212,120209,120206,120203,
											320312,320311,320310,320309,320308,320307,
											320306,320305,320304,320303,320302,320301,
											320300,320299,320298,320297,320296
										)
						then 'С родственником'

						when cl.result in 
										(
											120232,120224,120215,120241,120231,120222,
											120214,120211,120208,120205,120192,120188,
											120187,120186,120185,120184,120183,120182,
											120181,120180,120179,120178,320295,320294,
											320293,320292,320291,320290,320289,320288,
											320287,320286,320285,320284,320283,320282,
											320281,320280,320279,320278,320277,320276,
											320275,120158,120159,120161,120162,120163,
											120164
										)
						then 'С третьим лицом'

						else '-'

					end) as skem,




		--resultat {
					(case
						
						when cl.result in 
										(--согл
										120239,120189,120190,120191,120237,120228,
										120218,120240,120232,120224,120215,120241
										)
						then 'Согласен на дисконт'

						when  cl.result in 
										(--сообщено
										120202,120200,120198,120194,120236,120227,
										120217,120210,120207,120204,120231,120222,
										120214,120208,120205,120192
										) 
											and	
												cl.result not in
																( --согл
																	120239,120189,120190,120191,120237,120228,
																	120218,120240,120232,120224,120215,120241
																)
						then 'О дисконте сообщено'

						when  cl.result in 
										(--не предлагался
										120201,120199,120197,120195,120193,120234,
										120225,120216,120212,120209,120206,120203,
										120188,120187,120186,120185,120184,120183,
										120182,120181,120180,120179,120178
												
										)
											and
												cl.result not in
																( --согл & сообщено
																	120239,120189,120190,120191,120237,120228,
																	120218,120240,120232,120224,120215,120241,
																	120202,120200,120198,120194,120236,120227,
																	120217,120210,120207,120204,120231,120222,
																	120214,120208,120205,120192
																)
						then 'Дисконт не предлагался'

						

						when  cl.result in 
										(--отказ
											120158,120159,120161,120162,120163,120164
										)
											and	
												cl.result not in
																(--согл, сообщено, не предлагался
																	120239,120189,120190,120191,120237,120228,
																	120218,120240,120232,120224,120215,120241,
																	120202,120200,120198,120194,120236,120227,
																	120217,120210,120207,120204,120231,120222,
																	120214,120208,120205,120192,
																	120201,120199,120197,120195,120193,120234,
																	120225,120216,120212,120209,120206,120203,
																	120188,120187,120186,120185,120184,120183,
																	120182,120181,120180,120179,120178
																)
						then 'Отказ от дисконта'

						
						else (
								case
									when cl.result not in
														(--согл, сообщено, не предлагался, отказ
															120239,120189,120190,120191,120237,120228,
															120218,120240,120232,120224,120215,120241,
															120202,120200,120198,120194,120236,120227,
															120217,120210,120207,120204,120231,120222,
															120214,120208,120205,120192,
															120201,120199,120197,120195,120193,120234,
															120225,120216,120212,120209,120206,120203,
															120188,120187,120186,120185,120184,120183,
															120182,120181,120180,120179,120178,
															120158,120159,120161,120162,120163,120164
														)
									then 'Контакт не состоялся'
								end
							)						


					end) as sogl,



		--resultat };


				--ДАТА {
					(case						
						when cl.result in
										(
											120239,120189,120190,120191,120237,120228,120218,
											120240,120232,120224,120215,120241,120201,120199,
											120197,120195,120193,120234,120225,120216,120212,
											120209,120206,120203,120188,120187,120186,120185,
											120183,120182,120181,120180,120179,120178,120202,
											120200,120198,120194,120236,120227,120217,120210,
											120204,120231,120222,120214,120208,120205,120192,
											120159,120161,120162,120163,120164,120184,120207,
											120158
										)
						then cl.dt

					end) as dt
				--ДАТА };					
						
															
				from
					[i_collect].[dbo].[contact_log] as cl
					left join
							(
								select
									cs.code,
									cs.text,
									cs.TREE_TYP
								from
									i_collect.dbo.contact_result_set as cs

							)cs		on cl.result = cs.code
				where
					cl.typ in (1,3)
					and cl.dt > '18-12-2015 07:59:59'			
					and d.id = cl.r_debt_id
				group by
					cl.r_debt_id,
					cl.result,
					cl.dt

			)cl		--on d.id = cl.r_debt_id


--присоединяем обещания

	outer apply

		(
			select 

				dp.parent_id,
				--sum(dp2.OP_sum) as OP_sum,
				sum(isnull(dp.prom_sum,0)) as summa,
				dp.prom_date,
				dp.dt

			from 

				i_collect.dbo.debt_promise as dp

				left join

							(
								select

									dp2.id as id,

									(case 
										when (dp2.prom_sum is not null)
										then dp2.prom_sum 				
										else 0
									end) as OP_sum

								from
								
									i_collect.dbo.debt_promise as dp2

							)dp2 	on dp2.id = dp.id

			where

				dp.dt > '18-12-2015 07:59:59'
				and d.id = dp.parent_id
				and ((dp.prom_date <= '01-01-2016' and dp.prom_date >= '18-12-2015 07:59:59') or dp.prom_date is null)
				and convert(varchar, cl.dt, 104) = convert(varchar, dp.dt, 104)

			group by

				dp.parent_id,
				dp.prom_date,
				dp.dt

		)dp --on d.id = dp.parent_id


where
	
	d.status not in (8)
	and cl.dt > dateadd ( day, -7, getdate() )


group by
	
	d.contract,
	d.id,
	per.f,
	per.i,
	per.o,
	cl.dt,
	dp.prom_date,
	cl.skem,
	dd.write_off_sum,
	dd.pay_sum,
	r.name,
	do.data,
	cl.sogl