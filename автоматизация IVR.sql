Обновляется каждые 3 дня, начиная с 5.02.2016

declare @t table
					(		
						id bigint,		
						d_id text,
						t1 text,
						gmt text
					)


insert into @t (id ,d_id, t1, gmt)

/*values*/
	SELECT 
		abs(checksum(newid())),
		cast(debt.id as varchar),
		cast(phone.number as varchar),
		cast(gmt.code-4 as varchar)
	FROM 
		debt
		JOIN person on debt.parent_id=person.id
		JOIN (SELECT * from dict where parent_id=51) gmt on gmt.code=debt.gmt
		JOIN portfolio on portfolio.id=debt.r_portfolio_id
		JOIN phone on phone.parent_id=person.id
		/*users*/
		inner join 
				(
					select
						wt.r_debt_id
					from
						i_collect.dbo.work_task as wt
						left join i_collect.dbo.users as u on wt.r_user_id = u.id
					where
						(u.id in (1604, 1618, -1) or u.id is null)
						and wt.id in 
								(
									select
										max(id)
									from
										work_task
									group by
										r_debt_id
								)
				)wt 	on debt.id = wt.r_debt_id

	WHERE
		debt.status in (1,2,3,4,11,13,15) AND
		portfolio.status = 2 AND
		debt.debt_sum > 100 AND
		portfolio.parent_id != 25 and
		phone.typ NOT in (1,2,3,4,44) AND
		phone.block_flag = 0
		AND	(debt.mark1 IN (1,2,4) OR debt.mark1 IS NULL)
		
/*\values*/

;
	delete openquery (INFINITY, 'select * from "Table_5036788976"');

	insert openquery(INFINITY, 'select "ID", "ID_долга", "Телефон1", "Часовой_пояс"  from "Table_5036788976"') 
	select * from @t;

--exec xp_cmdshell 'start http://yandex.ru'
--exec xp_cmdshell 'tskill exlorer'

--EXEC sp_configure 'xp_cmdshell', 1
--RECONFIGURE with override

--exec xp_cmdshell 'start http://yandex.ru'

exec xp_cmdshell 'start http://192.168.11.13:10080/campaign/startcampaign/?IDCampaign=5045656240'

http://192.168.11.13:10080/campaign/startcampaign/?IDCampaign=5045656240;
exec xp_cmdshell 'tskill iexplore'