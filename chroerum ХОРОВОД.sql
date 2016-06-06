--H O R V O D


	drop table campaign1;


	/*
		Table_5000081023 1
		Table_5000081044 2
		Table_5015640658 3
		Table_5042218921 4

		Table_5052709673 5

		Table_5064249944 6
		Table_5068758013 7
		Table_5336960870 8
	*/


select 
	* 
into campaign1

from openquery
	(
	INFINITY2, 
		'
		select 
			--cast("ID_долга" as int)
			*
		from 
			"Table_5336960870"
		'
	)
;

	select * from campaign1


--use i_collect
--select 
--	--q.[ID_долга]
--	--,cl.dt
--	q.*	
--from 
--	campaign1 q
--	left join
--			(
--			select
--				cl.r_debt_id
--				,cl.dt
--			from
--				i_collect.dbo.contact_log cl
--			where
--				cl.typ = 1
--				and cl.id in
--						(
--						select
--							max(id)
--						from
--							contact_log
--						group by
--							r_debt_id
--						)		
--			group by
--				cl.r_debt_id
--				,cl.dt
			
--			)cl on cl.r_debt_id = q.[ID_долга]
	
--where
--	cast(q.[ID_долга] as int) not in
--									(
--									select
--										dp.parent_id
--									from
--										debt_promise dp
--									where
--										dp.dt >= dateadd(day, -4, getdate())
--									)

--	and cast(q.[ID_долга] as int) not in
--										(
--										select
--											dc.parent_id
--										from
--											debt_calc dc
--										where
--											dc.calc_date >= dateadd(day, -4, getdate())
--										)
											
	


--order by
--	cl.dt asc


--	--select top 10 r_debt_id from contact_log

----		truncate table campaign1