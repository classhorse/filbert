--BMW
declare @d1 date
declare @d2 date

set @d1 = @SD
set @d2 = @ED

select
	--row_number,
	per.f+' '+per.i+' '+per.o as 'ФИО Должника',
	d.contract as 'Номер кредитного договора',

	I_collect.[dbo].FILBERT_DopInfPhone(  per.id,  @d1,  @d2) as 'Уточненная контактная информация',

	(case
		when p.name like '%HARD%'
		then 'hard'

		when p.name like '%SOFT%'
		then 'soft'

	end) as 'Стадия взыскания',
	I_collect.[dbo].FILBERT_report_87(d.id, @d1, @d2) 'Проведенные мероприятия за период',

	di_rec.name as 'Рекомендации',
	
	di_status.name as 'Текущая ситуация / Перспективы'

from
	i_collect.dbo.bank as b
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
	inner join i_collect.dbo.person as per on d.parent_id = per.id

	left join
			(--recomended
				select
					d.code,
					d.name

				from
					i_collect.dbo.dict as d

				where
					d.parent_id = 29

			)di_rec		on d.state = di_rec.code

	left join
			(--status
				select
					code,
					name
				from
					i_collect.dbo.dict
				where
					parent_id = 6

			)di_status		on d.status = di_status.code

where
	b.id = 73