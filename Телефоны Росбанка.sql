select distinct
	d.id 'ID Долга',
	p.name 'Портфель',
	ph.number 'Телефон',
	isnull(cl.text, 'нет данных') as 'Результат звонка',
	isnull(sum(cl.kolvo),0) as 'Кол-во звонков'

from
	[i_collect].[dbo].[bank] as b
	inner join [i_collect].[dbo].[portfolio] as p on b.id = p.parent_id
	inner join [i_collect].[dbo].[debt] as d on p.id = d.r_portfolio_id
	inner join [i_collect].[dbo].[person] as per on d.parent_id=per.id

	left join 
			(
				select
					ph.parent_id,
					ph.number,
					ph.id
				from
					i_collect.dbo.phone as ph
				where
					ph.block_flag = 0

			)ph		on per.id = ph.parent_id

	--исходящие звонки
	left join
			(
				select 

					cs.text,
					cl.r_phone_id,

					sum(case
						when (cl.typ = 1 and cl.result != 0)
						then 1
						else 0
					end) as kolvo
															
				from

					[i_collect].[dbo].[contact_log] as cl

					left join 
							(
								select
									cs.id,
									cs.text
								from
									[i_collect].[dbo].[contact_result_set] as cs
									
							) cs on cl.result = cs.id

				where
					cl.typ = 1
										
				group by
					cl.r_phone_id,
					cs.text

			)cl		on ph.id = cl.r_phone_id

where
	b.id = 69
	and (ph.number like '79%' or ph.number like '89%')
	and len(ph.number) = 11

group by
	d.id,
	p.name,
	ph.number,
	cl.text

