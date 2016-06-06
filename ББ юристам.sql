select

--{
	isnull(d.ext_id,'') as 'Филиал',
	isnull(d.contract,'') as '№ Договора',
	isnull(convert(varchar, d.credit_date, 104),'') as 'Дата договора',
	per.f+' '+per.i+' '+per.o as 'ФИО Должника',
	convert(date, p.sign_date) as 'Дата передачи Реестра',
	isnull(cl1.text,'') as 'Статус контакта',
	isnull(sum(cl.ish_zvon),0) as 'Количество звонков',
	isnull(sum(cl.viezdi),0) as 'Количество выездов',
	isnull(sum(s.sms),0) as 'Количество СМС',
	isnull(sum(cl.pisma),0) as 'Количество писем',
--}
	--(case --1
	--	when la.status = 1
	--	then '0'
	--	else convert(varchar, la.data_gos_poshlini,104)
	--end) as 'Дата оплаты государственной пошлины',
	
	isnull((case --2 
		when la.status = 1
		then '' 
		else isnull(convert(varchar, la.data_otp_zayav_v_sud, 104),'')
	end),'') as			'Дата отправки заявления в суд',

	isnull((case --3
		when la.status = 1
		then '0'
		else isnull(la.name,'')
	end),'') as			'Наименование судебного участка',

	isnull((case --4
		when la.status = 1
		then ''
		else isnull(la.user_result,'')
	end),'') as			'Вид документа вынесеного судом',

	isnull((case --10
		when la.status = 1
		then ''
		else isnull(convert(varchar, la.exec_date, 104),'')
	end),'') as			'Дата вынесения документа',

	isnull((case --5
		when la.status = 1
		then '1'
		else isnull(la.exec_number,'')
	end),'') as			'Номер документа',

--{ 
	isnull((case
		when la.contract is not null
		then la.total_sum + isnull(la.due_sum,0)

		when la.contract is null 
		then la.total_sum
	end),'') as			'Сумма требования по СП', --6
--}
	isnull(
			(case
				when la.dsc like '%*%' or la.dsc like '*%' or la.dsc like '%*'
				then
					(replace --7

								(
									SUBSTRING
											(
												la.dsc,
												CHARINDEX('**', la.dsc),
												1000
											),
									'*',

									''

								)
					)
			end)

		,'')as		'Причина отказа',

			
				

	isnull(convert(varchar, la.load_dt, 104),'') as 'Дата получения оригинала документа Агентом',

	isnull
		(
			replace --9
					(
						SUBSTRING
								(
									la.dsc, 
									CHARINDEX('*', la.dsc), 
									CHARINDEX('**', la.dsc) 
								),

						'*',

						''
					),''
		) as		'Рекомендации Агента'


from
	i_collect.dbo.bank as b	
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
	inner join i_collect.dbo.person as per on d.parent_id = per.id

	--гс, смс, письма, выезды
	left join

			(

				select 
					cl.r_debt_id,

					sum(case
							when (cl.typ in (1,3) and cl.result != 0)
							then 1
							else 0
						end) as ish_zvon,

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
					cl.dt > '01-01-2016'

				group by
					cl.r_debt_id


			)cl		on d.id = cl.r_debt_id


	--sms
	left join

			(
				select 
					s.parent_id,
				--{
					sum(case
							when (s.status in (1,2,3,4,5,6,7,8,9))
							then 1
							else 0
						end) as sms
				--};

				from
					[i_collect].[dbo].[debt_sms] as s
				where
					s.dt > '01-01-2016'

				group by 
					s.parent_id


			)s		on d.id = s.parent_id


	--law_act
	left join
			(
				select
					la.r_debt_id,
					la.due_pay_date as data_gos_poshlini,
					la.start_date as data_otp_zayav_v_sud,
					lc.name,
					la.exec_date,
					la.exec_number,
					la.total_sum,
					la.dsc,
					la.load_dt,
					la.status,
					la.contract,
					la.due_sum,
					di.user_result
					

				from
					i_collect.dbo.law_act as la
					left join
							(
								select
									lc.id,
									lc.name
								from
									i_collect.dbo.law_court as lc
							)lc		on la.r_court_id = lc.id

					left join
							(
								select
									code,
									name as user_result
								from
									dict
								where
									parent_id = 135
							)di		on la.user_result = di.code

				group by
					la.r_debt_id,					
					la.due_pay_date,
					la.start_date,
					lc.name,
					la.exec_date,
					la.exec_number,
					la.total_sum,
					la.dsc,
					la.receipt_dt,
					la.status,
					la.contract,
					la.due_sum,
					di.user_result,
					la.load_dt


			)la		on d.id = la.r_debt_id


	left join
			(
				select
					cl.r_debt_id,
					rs.text
				from
					i_collect.dbo.contact_log as cl
					left join
							(
								select
									rs.code,
									rs.text

								from
									i_collect.dbo.contact_result_set as rs


							)rs		on rs.code = cl.result
					
				where
					cl.id in
							(
								select
									max(id)

								from
									i_collect.dbo.contact_log

								group by
									r_debt_id

							)

				group by
					cl.r_debt_id,
					rs.text



			)cl1		on d.id = cl1.r_debt_id





where
	b.id = 74



group by
	d.ext_id,
	d.contract,
	d.credit_date,
	per.f+' '+per.i+' '+per.o,
	p.sign_date,
	la.data_otp_zayav_v_sud,
	la.name,
	la.user_result,
	la.exec_date,
	la.exec_number,
	la.total_sum,
	la.dsc,
	la.load_dt,
	la.status,
	la.due_sum,
	la.contract,
	cl1.text