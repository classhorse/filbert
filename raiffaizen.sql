
/************Raifaizen************/
/*	Это говногод, у меня рак глаз когда смотрю на такое
	создавать табилчку для него стало впадлу, сделал копипастом
	Если ты добрался до правок этого кода, прости..
	так захотели менеджеры и заказчики
	Regards, Лестат Ким

*/

declare @sd datetime = '01-07-2016 00:00:01'
declare @ed datetime = '31-07-2016 23:59:59'

SELECT 


	row_number() over (order by d.contract asc, cl.dt asc) '№ п/п' 
	,replace(isnull(convert(varchar, cl.dt, 104),''), '1900-01-01', '') 'Дата действия'
	,d.contract 'Рутер'

	,isnull(isnull(convert(varchar, cl.dt, 104),'') + ' / ' + isnull((case
		when cl.result in (535,534,773,772,788)
			then 'Постановление об отказе в возбуждении ИП'
		when cl.result in (523,762)
			then 'Предъявление испол. Листа'
		when cl.result in (320820,320821,781)
			then 'Поиск данных о Клиенте'
		when cl.result in (550,796)
			then 'Постановление об обращении взыскания на заработную плату/пенсию/иные доходы должника'
		when cl.result in (542,541,540,539)
			then 'Телефонные переговоры с Приставом'
		when cl.result in (548,568,778,776)
			then 'Постановление об окончании ИП'
		when cl.result in (537,536,777,775)
			then 'Акт о невозможности взыскания'
		when cl.result in (556,321566,321569)
			then 'Постановление об отказе в заведении розыскного дела'
		when cl.result in (321565,321568)
			then 'Постановление о заведении розыскного дела'
		when cl.result in (549,795)
			then 'Получен ответ о ходе ИП'
		when cl.result in (553,792)
			then 'Постановление о запрете на выезд'
		when cl.result in (552,793)
			then 'Постановление о запрете на рег. Действий'
		when cl.result in (533,771)
			then 'Постановление о возбуждении ИП'
		when cl.result in (525,764)
			then 'Жалоба на действие/бездействие СПИ'
		when cl.result in (528,767)
			then 'Заявление о розыске имущества клиента'
		when cl.result in (557,763,1001011101011101110011)
			then 'Направлен запрос о ходе ИП'
		when cl.result in (530)
			then 'Заявление о запрете выезда за гр. РФ'
		when cl.result in (551,786,799,794)
			then 'Акт о наложении ареста на имущ. Клиента'
		when cl.result in (30,325,8,730,731,16,13,327,5,321,
							313,314,315,318,707,209,713,712,
							220,708,709,710,711,206)
			then 'Контакт не состоялся'
		when cl.result in (15,4,706,204,205)
			then 'Контакт состоялся'
		when cl.result in (714,1,715,11,717,201,718,207)
			then 'Контакт. Обещание платежа'
		when cl.result in (3, 203)
			then 'Контакт. Отказ платежа'
		when cl.result = 7
			then 'Не отвечает'
		when cl.result in (106,105,119,111,115,113,109,116,117,101,118,108,110)
			then 'Выезд'
		when cl.result in (733,734,735,320730,320731,320732)
			then 'IVR'
		when cl.result in (124,125,128,320634,320857,9373770000000)
			then 'Письмо отправлено'
		when cl.result in (53553500001)
			then 'СМС Доставлена'
		when cl.result in (53553500000)
			then 'СМС Не доставлена'
		when cl.result in (701,320435,320702,321056,321262)
			then 'Письмо @ отправлено'
		--else cast(cl.result as varchar)

	end),'') + ' / ' + cl.detal,'') 'Детальное описание Результата'

	,isnull((case
		when cl.result in (535,534,773,772,788)
			then 'A55'
		when cl.result in (523,762)
			then 'A53'
		when cl.result in (320820,320821,781)
			then 'A37'
		when cl.result in (550,796)
			then 'A25'
		when cl.result in (542,541,540,539)
			then 'A19'
		when cl.result in (548,568,778,776)
			then 'A17'
		when cl.result in (537,536,777,775)
			then 'A16'
		when cl.result in (556,321566,321569)
			then 'A15'
		when cl.result in (321565,321568)
			then 'A14'
		when cl.result in (549,795)
			then 'A13'
		when cl.result in (553,792)
			then 'A12'
		when cl.result in (552,793)
			then 'A11'
		when cl.result in (533,771)
			then 'A10'
		when cl.result in (525,764)
			then 'A09'
		when cl.result in (528,767)
			then 'A08'
		when cl.result in (557,763,1001011101011101110011)
			then 'A07'
		when cl.result in (530)
			then 'A06'
		when cl.result in (551,786,799,794)
			then 'A05'
		when cl.result in (30,325,8,730,731,16,13,327,5,321,
							313,314,315,318,707,209,713,712,
							220,708,709,710,711,206)
			then 'A28'
		when cl.result in (15,4,706,204,205)
			then 'A29'
		when cl.result in (714,1,715,11,717,201,718,207)
			then 'A30'
		when cl.result in (3, 203)
			then 'A31'
		when cl.result = 7
			then 'A32'
		when cl.result in (106,105,119,111,115,113,109,116,117,101,118,108,110)
			then 'A35'
		when cl.result in (733,734,735,320730,320731,320732)
			then 'A39'
		when cl.result in (124,125,128,320634,320857,9373770000000)
			then 'A36'
		when cl.result in (53553500001)
			then 'A33'
		when cl.result in (53553500000)
			then 'A34'
		when cl.result in (701,320435,320702,321056,321262)
			then 'A40'
		--else cast(cl.result as varchar)

	end),'') 'Код действия'

	,isnull((case
		when cl.result in (535,534,773,772,788)
			then 'Постановление об отказе в возбуждении ИП'
		when cl.result in (523,762)
			then 'Предъявление испол. Листа'
		when cl.result in (320820,320821,781)
			then 'Поиск данных о Клиенте'
		when cl.result in (550,796)
			then 'Постановление об обращении взыскания на заработную плату/пенсию/иные доходы должника'
		when cl.result in (542,541,540,539)
			then 'Телефонные переговоры с Приставом'
		when cl.result in (548,568,778,776)
			then 'Постановление об окончании ИП'
		when cl.result in (537,536,777,775)
			then 'Акт о невозможности взыскания'
		when cl.result in (556,321566,321569)
			then 'Постановление об отказе в заведении розыскного дела'
		when cl.result in (321565,321568)
			then 'Постановление о заведении розыскного дела'
		when cl.result in (549,795)
			then 'Получен ответ о ходе ИП'
		when cl.result in (553,792)
			then 'Постановление о запрете на выезд'
		when cl.result in (552,793)
			then 'Постановление о запрете на рег. Действий'
		when cl.result in (533,771)
			then 'Постановление о возбуждении ИП'
		when cl.result in (525,764)
			then 'Жалоба на действие/бездействие СПИ'
		when cl.result in (528,767)
			then 'Заявление о розыске имущества клиента'
		when cl.result in (557,763)
			then 'Направлен запрос о ходе ИП'
		when cl.result = 1001011101011101110011
			then 'Направлен запрос о ходе ИП__test__'
		when cl.result in (530)
			then 'Заявление о запрете выезда за гр. РФ'
		when cl.result in (551,786,799,794)
			then 'Акт о наложении ареста на имущ. Клиента'
		when cl.result in (30,325,8,730,731,16,13,327,5,321,
							313,314,315,318,707,209,713,712,
							220,708,709,710,711,206)
			then 'Контакт не состоялся'
		when cl.result in (15,4,706,204,205)
			then 'Контакт состоялся'
		when cl.result in (714,1,715,11,717,201,718,207)
			then 'Контакт. Обещание платежа'
		when cl.result in (3, 203)
			then 'Контакт. Отказ платежа'
		when cl.result = 7
			then 'Не отвечает'
		when cl.result in (106,105,119,111,115,113,109,116,117,101,118,108,110)
			then 'Выезд'
		when cl.result in (733,734,735,320730,320731,320732)
			then 'IVR'
		when cl.result in (124,125,128,320634,320857,9373770000000)
			then 'Письмо отправлено'
		when cl.result in (53553500001)
			then 'СМС Доставлена'
		when cl.result in (53553500000)
			then 'СМС Не доставлена'
		when cl.result in (701,320435,320702,321056,321262)
			then 'Письмо @ отправлено'
		--else cast(cl.result as varchar)

	end),'') 'Результат'

	,replace(replace(isnull(cl.dsc,''), 'Импортировано из Infinity (Автоинформатор)','Автоинформатор'),'Импортировано из Infinity', '') 'Комментарий'


FROM
	i_collect.dbo.bank as b
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
	inner join i_collect.dbo.person as per on d.parent_id = per.id

	left join 
			(
			select	
				cl.r_debt_id
				,cl.result
				,cl.dt
				,rs.text
				,cl.dsc

				,(case
					when cl.r_phone_id is not null and cl.typ in (1,3,19)
						then p.number
					when cl.r_adres_id is not null and cl.typ = 2
						then a.full_adr
					end
				) detal

			from	
				i_collect.dbo.contact_log cl
				left join i_collect.dbo.phone p on cl.r_phone_id = p.id
				left join i_collect.dbo.address a on cl.r_adres_id = a.id
				left join
						(
						select
							rs.code
							,rs.text
						from
							i_collect.dbo.contact_result_set rs
						)rs
							on rs.code = cl.result

			where
				cl.dt between @sd and @ed

		UNION

			select
				l.parent_id r_debt_id
				,iif(l.id is not null, 9373770000000, null)  result
				,l.start_date dt
				,dl.name text
				,'' dsc				
				,a.full_adr detal

			from
				i_collect.dbo.debt_letter l
				left join i_collect.dbo.address a on l.r_address_id = a.id
				left join(select code, name from i_collect.dbo.dict where parent_id = 35)dl on dl.code = l.status
			where
				l.start_date between @sd and @ed
				
		UNION
			/*	исправляем косяки операторов
				добавил левый код запрос о ходе ИП райфа
			*/
			select
				dl.parent_id r_debt_id
				,iif(dl.id is not null, 1001011101011101110011, null) result
				,dl.dt dt
				,'' text
				,'' dsc
				,''
			from
				i_collect.dbo.debt_letter dl
				left join i_collect.dbo.debt_letter_history dlh on dl.id = dlh.parent_id
				
		UNION
			
			select
				s.parent_id r_debt_id
				,iif(s.status in (1,2), 53553500001, 53553500000) result
				,s.send_date dt
				,ds.name text
				,'' dsc				
				,p.number detal
			from
				i_collect.dbo.debt_sms s
				left join i_collect.dbo.phone p on s.r_phone_id = p.id
				left join(select code, name from i_collect.dbo.dict where parent_id = 50)ds on s.status = ds.code
			where
				s.send_date between @sd and @ed

			)cl
				on cl.r_debt_id = d.id

WHERE
	b.id = 77



