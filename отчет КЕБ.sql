
select
	per.id 'Должник (идентификационный номер)',
	d.contract 'Номер договора',
	i_collect.[dbo].[FILBERT_work_result_with_debtor](d.id) 'Результат работы с Должником',
	i_collect.[dbo].[FILBERT_ivr+sms](d.id, '01-02-2016', getdate()) 'Действия совершенные Агентством по смс и голосовому информированию, и результат',
	i_collect.[dbo].[FILBERT_zvonok_i_viezd](d.id, '01-02-2016', getdate()) 'Действия совершенные Агентством по дозвону / выезду, и результат',
	i_collect.dbo.[Filbert_dobavlenie_tel_i_adresa](d.id, '01-02-2016', getdate()) 'Найденая в процессе работы информация',
	state.name 'Комментарии',
	datediff(day, p.sign_date, p.end_date) 'Период работы с клиентом'

from
	i_collect.dbo.bank as b
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
	inner join i_collect.dbo.person as per on d.parent_id = per.id

	left join
			(
				select
					code,
					name
				from
					i_collect.dbo.dict
				where
					parent_id = 29
			)state		on d.state = state.code

where
	b.id = 67
	and d.status not in (6,7,8,10)


