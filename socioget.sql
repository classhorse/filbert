SELECT 
	d.id 'ID'
	,per.f + ' ' + per.i + ' ' +per.o as 'ФИО'
	,convert(varchar, per.birth_date, 104) 'Дата рождения'
	,isnull(a1.city, '') 'Адрес регистрации'
	,isnull(a2.city, '') 'Адрес фактический'


FROM
	bank as b
	inner join portfolio as p on b.id = p.parent_id
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id

	left join --reg
			(
			select 
				a.parent_id
				,a.city
			from
				address a 
			where
				a.typ = 1
				
			)a1
				on per.id = a1.parent_id

	left join --reg
			(
			select 
				a.parent_id
				,a.city
			from
				address a 
			where
				a.typ = 2
				
			)a2
				on per.id = a2.parent_id

	inner join
			(
			select
				ph.parent_id
			from
				phone ph
			where
				ph.dsc not like '%socio%'
				and ph.dsc not like '%hea%'
				and ph.dsc not like '%hh%'
				and ph.dsc not like '%sup%'
			)phone
				on phone.parent_id = per.id

where
	d.status not in (6,7,8,10)
	and (p.end_date > dateadd(month, 1, getdate()) or p.end_date is null)
	and per.birth_date is not null
	and per.birth_date > dateadd(year, -50, getdate())
	and d.debt_sum > 5000

order by
	d.id asc
	offset 5000 rows
	fetch next 5000 rows only

