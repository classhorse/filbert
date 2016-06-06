/*
ivr
Информация ББ 2.
*/

use i_collect;

if (select * from openquery(INFINITY, 'select count(*) from "Table_5459752341"')) = 0

BEGIN
----------------------------
	
	delete openquery (INFINITY, 'select * from "Table_5459752341"');

	insert openquery (INFINITY, 'select "ID", "ID_долга" from "Table_5459752341"')
	values (1000, 'Вас приветствует система E T E R N A L');

	insert openquery (INFINITY, 'select "ID", "ID_долга" from "Table_5459752341"')
	values (1001, 'Кампания {ИнформированиеББ_2} обновлена: ');

	insert openquery (INFINITY, 'select "ID", "ID_долга" from "Table_5459752341"')
	values (1002, convert(varchar, getdate(), 113));

	insert openquery (INFINITY, 'select "ID", "ID_долга" from "Table_5459752341"')
	values (1003, 'Желаю Вам хорошего дня!');

----------------------------

	insert openquery(INFINITY, 'select "ID", "ID_долга", "Телефон", "Часовой_пояс" from "Table_5459752341"')


	select distinct		
		row_number() over (order by d.id) + 100000,
		cast(d.id as varchar),	
		cast(ph.number as varchar),
		cast(d.gmt-4 as varchar)

	from
		[i_collect].[dbo].[bank] as b
		inner join [i_collect].[dbo].[portfolio] as p on b.id = p.parent_id
		inner join [i_collect].[dbo].[debt] as d on p.id = d.r_portfolio_id
		inner join [i_collect].[dbo].[person] as per on d.parent_id=per.id
	--Phone
		left join
				(
					select
						ph.parent_id,
						ph.number
					from 
						[i_collect].[dbo].[phone] as ph 
					where
						ph.typ in (1,2)
						and ph.block_flag = 0
		
				)ph 	on ph.parent_id = per.id


	--users
		left join 
				(
					select
						wt.r_debt_id,
						u.r_department_id,
						u.id
					from
						[i_collect].[dbo].[work_task_log] as wt
						left join [i_collect].[dbo].[users] as u on wt.r_user_id = u.id
						left join [i_collect].[dbo].[department] as dep on u.r_department_id = dep.dep
					where
						wt.id in 

								(
									select
										max(id)
									from
										[i_collect].[dbo].[work_task_log]
									group by
										r_debt_id
								)

				)wt 	on d.id = wt.r_debt_id

	----PROM
		left join 
				(
					select
						pr.parent_id,
						pr.prom_date
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
						pr.parent_id,
						pr.prom_date

				)pr 	on d.id = pr.parent_id

	----CALC
		left join 
				(
					select
						dc.parent_id,
						dc.calc_date
					from
						[i_collect].[dbo].[debt_calc] as dc
					where
						dc.is_confirmed = 1
						and dc.id in 
									(
										select
											max(id)
										from 
											[i_collect].[dbo].[debt_calc]
										group by
											parent_id
									)
					group by
						dc.parent_id,
						dc.calc_date
			
				)dc 	on d.id = dc.parent_id

	where
		d.status not in (6,7,8,9,10,12,14,17)
		and ph.number is not null
		and len(ph.number) = 11
		and b.id in (49, 70)
		and wt.id != 1551
		and p.status = 2
		and (pr.prom_date < dateadd(day, -3, getdate()) or pr.prom_date is null)
		and (dc.calc_date < dateadd(month, -1, getdate()) or dc.calc_date is null)
		and d.debt_sum > 100



	exec xp_cmdshell 'start http://192.168.11.13:10080/campaign/startcampaign/?IDCampaign=5459752349';
  
	waitfor delay '00:00:03.000';

	exec xp_cmdshell 'tskill iexplore';

	waitfor delay '00:00:03.000';

	exec xp_cmdshell 'tskill cmd';

END;
GO