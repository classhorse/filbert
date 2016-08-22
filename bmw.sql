--BMW
declare @d1 date
declare @d2 date

set @d1 = @SD
set @d2 = @ED

select
	--row_number,
	per.f+' '+per.i+' '+per.o as 'ФИО Должника'
	,d.contract as 'Номер кредитного договора'
	,I_collect.[dbo].FILBERT_DopInfPhone(  per.id,  @d1,  @d2) as 'Уточненная контактная информация'
	,(case
		when p.name like '%HARD%'
		then 'hard'

		when p.name like '%SOFT%'
		then 'soft'

		when p.name like '%LEGAL%'
		then 'legal'

		when p.name like '%EXEC%'
		then 'exec'

	end) as 'Стадия взыскания'
	,I_collect.[dbo].FILBERT_report_87(d.id, @d1, @d2) 'Проведенные мероприятия за период'
	,di_rec.name as 'Рекомендации'	
	,di_status.name as 'Текущая ситуация / Перспективы'
	,isnull(sum(cl.zvonki),'') 'Кол-во звонков за указанный период'
	,isnull(sum(cl.viezdi),'') 'Кол-во выездов за указанный период'
	,replace(isnull(cast(c.calc_date as date),''), '1900-01-01', '') 'Дата последнего платежа'
	,replace(isnull(cast(pr.prom_date as date),''), '1900-01-01', '') 'Дата последнего обещания'
	,isnull(pr.prom_sum,'') 'Сумма последнего обещания'
	,@d1 'Период с'
	,@d2 'Период до'
	

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

	
	outer apply(select 
					cl.r_debt_id
					,sum(case when (cl.typ in (1,3)) then 1 else 0 end) as zvonki
					,sum(case when (cl.typ = 2) then 1 else 0 end) as viezdi
					,sum(case when cl.typ not in (6,2,3,1,19) then 1 else 0 end) as prochee							
				from 
					[i_collect].[dbo].[contact_log] as cl
				where 
					cl.dt between @d1 and @d2	
					and cl.r_debt_id = d.id
				group by 
					cl.r_debt_id
			)cl

	--last calc_date
	left join	 
			(	
			select
				dc.parent_id
				,dc.calc_date
			from 
				[i_collect].[dbo].[debt_calc] as dc
			where 
				dc.id in 
						(
						select 
							max(id)
						from 
							[i_collect].[dbo].[debt_calc]
						group by 
							parent_id
						)
				and dc.is_confirmed = 1
			group by 
				dc.parent_id
				,dc.calc_date
			)c		
				on d.id = c.parent_id
	--last prom_date
	left join 
			(	
			select 
				pr.parent_id
				,pr.prom_date
				,pr.prom_sum
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
				pr.parent_id
				,pr.prom_date
				,pr.prom_sum			
			)pr		
				on d.id = pr.parent_id 




where
	b.id = 73
	and d.id not in (
		select
			parent_id
		from
			debt_status_log
		where
			status in (6,7,8,10)
			and dt !> @d1
	)

group by
	per.f
	,per.i
	,per.o
	,d.contract
	,per.id
	,p.name
	,d.id
	,di_rec.name
	,di_status.name
	,c.calc_date
	,pr.prom_date
	,pr.prom_sum