declare @d1 date
set @d1 = getdate()

select
	d.id,
	per.f+' '+left(per.i,1)+'.'+left(per.o,1)+'! '+'УК Российской Федерации предусмотрена ответственность за уклонение от погашения задолженности. Не усугубляйте ситуацию. Агентство взыскания Филберт. Тел для связи '+isnull(wt.mob_num,'8(812)313-74-33') as text,

	len(per.f+' '+left(per.i,1)+'.'+left(per.o,1)+'! '+'УК Российской Федерации предусмотрена ответственность за уклонение от погашения задолженности. Не усугубляйте ситуацию. Агентство взыскания Филберт. Тел для связи '+isnull(wt.mob_num,'8(812)313-74-33')) as symbols,

--{ count_symbols()
	(case
		when len(per.f+' '+left(per.i,1)+'.'+left(per.o,1)+'! '+'УК Российской Федерации предусмотрена ответственность за уклонение от погашения задолженности. Не усугубляйте ситуацию. Агентство взыскания Филберт. Тел для связи '+isnull(wt.mob_num,'8(812)313-74-33')) <= 67
		then 1

		when len(per.f+' '+left(per.i,1)+'.'+left(per.o,1)+'! '+'УК Российской Федерации предусмотрена ответственность за уклонение от погашения задолженности. Не усугубляйте ситуацию. Агентство взыскания Филберт. Тел для связи '+isnull(wt.mob_num,'8(812)313-74-33')) between 67 and 134
		then 2

		when len(per.f+' '+left(per.i,1)+'.'+left(per.o,1)+'! '+'УК Российской Федерации предусмотрена ответственность за уклонение от погашения задолженности. Не усугубляйте ситуацию. Агентство взыскания Филберт. Тел для связи '+isnull(wt.mob_num,'8(812)313-74-33')) > 134
		then 3
		
		else 4
	end) as 'sms/rub'
--}

from
	[i_collect].[dbo].[bank] as b
	inner join [i_collect].[dbo].[portfolio] as p on b.id = p.parent_id
	inner join [i_collect].[dbo].[debt] as d on p.id = d.r_portfolio_id
	inner join [i_collect].[dbo].[person] as per on d.parent_id = per.id

--USERS	
	left join (select
					wt.r_debt_id,
					dep.name,
					u.i+' '+u.o as fio,
					wt.fd,
					u.r_department_id,
					u.mob_num
				from
					[i_collect].[dbo].[work_task_log] as wt
					left join [i_collect].[dbo].[users] as u on wt.r_user_id = u.id
					left join [i_collect].[dbo].[department] as dep on u.r_department_id = dep.dep
				where
					wt.id in (select
									max(id)
								from
									[i_collect].[dbo].[work_task_log]
								group by
									r_debt_id
								)
					) as wt on d.id = wt.r_debt_id

----CALC
	left join (select
					dc.parent_id,
					dc.calc_date
				from
					[i_collect].[dbo].[debt_calc] as dc
				where
					dc.id in (select
									max(id)
								from
									[i_collect].[dbo].[debt_calc]
								group by
									parent_id
								)

					and dc.is_confirmed = 1
					
				group by
					dc.parent_id,
					dc.calc_date
				) dc on d.id = dc.parent_id


---PROM
	left join (select
					pr.parent_id,
					pr.prom_date
				from
					[i_collect].[dbo].[debt_promise] as pr
				where
					pr.id in (select
									max(id)
								from
									[i_collect].[dbo].[debt_promise]
								group by
									parent_id
								)
				group by
					pr.parent_id,
					pr.prom_date

				) pr on d.id = pr.parent_id

where
	p.name like '%EXEC%'
	--(p.name like '%HARD%' or p.name like '%SOFT%')
	and d.debt_sum >= 1000
	and d.[status] not in (6,7,8,10)
	and dc.calc_date between dateadd(month, -6, @d1) and dateadd(month, -1, @d1)
	and d.status != 9
	and (pr.prom_date < dateadd(day, -2, @d1) or pr.prom_date is null)
	and wt.r_department_id is null--in (8, 47, 48, 60, 66, 100, 101)
	--in (3, 7, 12, 14, 15, 20, 26, 27, 49, 50, 52, 57, 59, 63, 65, 68, 69, 70, 71, 72, 73, 74, 89, 90, 91, 97, 98, 102)