create procedure Filbert_HOROVOD (@n int)
AS
BEGIN
--------------------------------------------------------------------
	if @n = 1
		begin
			select * into tmp_campaign_1 from [INFINITY2].[Cx_Work].[public].[Table_5000081023]--экземпляр # кампании
			;delete from [INFINITY2].[Cx_Work].[public].[Table_5000081023]
			;insert into [INFINITY2].[Cx_Work].[public].[Table_5000081023]
			(
			[ID]
			,[State]
			,[ID_долга]
			,[Банк]
			,[Фамилия]
			,[Имя]
			,[Отчество]
			,[Телефон1]
			,[Телефон2]
			,[Телефон3]
			,[Телефон4]
			,[Телефон5]
			,[Остаток_долга]
			,[Дата_перезвона]
			,[Часовой_пояс]
			,[Телефон_для_перезвона]
			,[last_call_dt]
			)
	
		select
			tc1.*
		from
			tmp_campaign_1 tc1
			inner join i_collect.dbo.debt as d on tc1.[ID] = d.id
			left join
					(
					select
						cl.r_debt_id
						,cl.dt
					from
						i_collect.dbo.contact_log cl
					where
						cl.typ = 1
						and cl.id in
								(
								select
									max(id)
								from
									contact_log
								group by
									r_debt_id
								)		
					group by
						cl.r_debt_id
						,cl.dt
			
					)cl on cl.r_debt_id = d.id
		order by
			cl.dt asc		
			;delete from 
			[INFINITY2].[Cx_Work].[public].[Table_5000081023]
		where
			 [ID] in
						(
						select
							d.id
						from
							i_collect.dbo.debt d
						where
							d.status in (6,7,8,10)
						group by
							d.id
						)
			or [ID] in
						(
						select
							wt.r_debt_id
						from
							i_collect.dbo.work_task_log as wt
							left join i_collect.dbo.users as u on wt.r_user_id = u.id
						where
							u.id not in (1604, -1)										
							and wt.id in 
									(
									select
										max(id)
									from
										i_collect.dbo.work_task_log
									group by
										r_debt_id
									)
						group by
							wt.r_debt_id
						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081023]
		set [State] = null
		where [State] is not null
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081023]
		set [Телефон1] = null
		where [Телефон1] in
			(
				select
					p.number
				from
					i_collect.dbo.phone p
				where
					p.typ = 3
			union all
		
				select
					p.number2
				from
					i_collect.dbo.phone p
				where
					p.typ = 3

			)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081023]
		set [Телефон2] = null
		where [Телефон2] in
			(
				select
					p.number
				from
					i_collect.dbo.phone p
				where
					p.typ = 3
			union all
		
				select
					p.number2
				from
					i_collect.dbo.phone p
				where
					p.typ = 3

			)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081023]
		set [Телефон3] = null
		where [Телефон3] in
			(
				select
					p.number
				from
					i_collect.dbo.phone p
				where
					p.typ = 3
			union all
		
				select
					p.number2
				from
					i_collect.dbo.phone p
				where
					p.typ = 3

			)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081023]
		set [Телефон4] = null
		where [Телефон4] in
			(
				select
					p.number
				from
					i_collect.dbo.phone p
				where
					p.typ = 3
			union all
		
				select
					p.number2
				from
					i_collect.dbo.phone p
				where
					p.typ = 3

			)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081023]
		set [Телефон5] = null
		where [Телефон5] in
			(
				select
					p.number
				from
					i_collect.dbo.phone p
				where
					p.typ = 3
			union all
		
				select
					p.number2
				from
					i_collect.dbo.phone p
				where
					p.typ = 3

			)
		end
		
--------------------------------------------------------------------
	else if @n = 2
		begin
			select * into tmp_campaign_2 from [INFINITY2].[Cx_Work].[public].[Table_5000081044]
			;delete from [INFINITY2].[Cx_Work].[public].[Table_5000081044]
			;insert into [INFINITY2].[Cx_Work].[public].[Table_5000081044]
			(
			[ID]
			,[State]
			,[ID_долга]
			,[Банк]
			,[Фамилия]
			,[Имя]
			,[Отчество]
			,[Телефон1]
			,[Телефон2]
			,[Телефон3]
			,[Телефон4]
			,[Телефон5]
			,[Остаток_долга]
			,[Дата_перезвона]
			,[Часовой_пояс]
			,[Телефон_для_перезвона]
			,[Телефон6]
			,[Телефон7]
			,[Телефон8]
			,[Телефон9]
			,[Телефон10]
			,[Телефон11]
			,[Телефон12]
			,[Телефон13]
			,[Телефон14]
			,[Телефон15]
			,[КолПопыток]
			,[ПерсональныйОпер]
			)
		select
			tc1.*
		from
			tmp_campaign_2 tc1
			inner join i_collect.dbo.debt as d on tc1.[ID] = d.id
			left join
					(
					select
						cl.r_debt_id
						,cl.dt
					from
						i_collect.dbo.contact_log cl
					where
						cl.typ = 1
						and cl.id in
								(
								select
									max(id)
								from
									contact_log
								group by
									r_debt_id
								)		
					group by
						cl.r_debt_id
						,cl.dt
			
					)cl on cl.r_debt_id = d.id
		order by
			cl.dt asc
			;delete from 
			[INFINITY2].[Cx_Work].[public].[Table_5000081044]
		where
			 [ID] in
						(
						select
							d.id
						from
							i_collect.dbo.debt d
						where
							d.status in (6,7,8,10)
						group by
							d.id
						)
			or [ID] in
						(
						select
							wt.r_debt_id
						from
							i_collect.dbo.work_task_log as wt
							left join i_collect.dbo.users as u on wt.r_user_id = u.id
						where
							u.id not in (1604, -1)										
							and wt.id in 
									(
									select
										max(id)
									from
										i_collect.dbo.work_task_log
									group by
										r_debt_id
									)
						group by
							wt.r_debt_id
						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
		set [State] = null
		where [State] is not null
	
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон1] = null
				where [Телефон1] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон2] = null
				where [Телефон2] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон3] = null
				where [Телефон3] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон4] = null
				where [Телефон4] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон5] = null
				where [Телефон5] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон6] = null
				where [Телефон6] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон7] = null
				where [Телефон7] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон8] = null
				where [Телефон8] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон9] = null
				where [Телефон9] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон10] = null
				where [Телефон10] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон11] = null
				where [Телефон11] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон12] = null
				where [Телефон12] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон13] = null
				where [Телефон13] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон14] = null
				where [Телефон14] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
				set [Телефон15] = null
				where [Телефон15] in
					(
						select
							p.number
						from
							i_collect.dbo.phone p
						where
							p.typ = 3
					union all
		
						select
							p.number2
						from
							i_collect.dbo.phone p
						where
							p.typ = 3

					)
		end
		
----------------------------------------------------------------------
	else if @n = 3
		begin
			select * into tmp_campaign_3 from [INFINITY2].[Cx_Work].[public].[Table_5015640658]
			;delete from [INFINITY2].[Cx_Work].[public].[Table_5015640658]
			;insert into [INFINITY2].[Cx_Work].[public].[Table_5015640658]
				(
				[ID] ,
				[State] ,
				[ID_долга] ,
				[Банк] ,
				[Фамилия] ,
				[Имя] ,
				[Отчество] ,
				[Телефон1] ,
				[Телефон2] ,
				[Телефон3] ,
				[Телефон4] ,
				[Телефон5] ,
				[Телефон6] ,
				[Телефон7] ,
				[Телефон8] ,
				[Телефон9] ,
				[Телефон10] ,
				[Телефон11] ,
				[Телефон12] ,
				[Телефон13] ,
				[Телефон14] ,
				[Телефон15] ,
				[Остаток_долга] ,
				[Дата_перезвона] ,
				[Часовой_пояс] ,
				[Телефон_для_перезвона] 
				)
			select
				tc1.*
			from
				tmp_campaign_3 tc1
				inner join i_collect.dbo.debt as d on tc1.[ID] = d.id
				left join
						(
						select
							cl.r_debt_id
							,cl.dt
						from
							i_collect.dbo.contact_log cl
						where
							cl.typ = 1
							and cl.id in
									(
									select
										max(id)
									from
										contact_log
									group by
										r_debt_id
									)		
						group by
							cl.r_debt_id
							,cl.dt
			
						)cl on cl.r_debt_id = d.id
			order by
				cl.dt asc
			;delete from 
				[INFINITY2].[Cx_Work].[public].[Table_5015640658]
			where
				 [ID] in
							(
							select
								d.id
							from
								i_collect.dbo.debt d
							where
								d.status in (6,7,8,10)
							group by
								d.id
							)
				or [ID] in
							(
							select
								wt.r_debt_id
							from
								i_collect.dbo.work_task_log as wt
								left join i_collect.dbo.users as u on wt.r_user_id = u.id
							where
								u.id not in (1604, -1)										
								and wt.id in 
										(
										select
											max(id)
										from
											i_collect.dbo.work_task_log
										group by
											r_debt_id
										)
							group by
								wt.r_debt_id
							)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
			set [State] = null
			where [State] is not null
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон1] = null
					where [Телефон1] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон2] = null
					where [Телефон2] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон3] = null
					where [Телефон3] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон4] = null
					where [Телефон4] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон5] = null
					where [Телефон5] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон6] = null
					where [Телефон6] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон7] = null
					where [Телефон7] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон8] = null
					where [Телефон8] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон9] = null
					where [Телефон9] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон10] = null
					where [Телефон10] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон11] = null
					where [Телефон11] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон12] = null
					where [Телефон12] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон13] = null
					where [Телефон13] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон14] = null
					where [Телефон14] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
					set [Телефон15] = null
					where [Телефон15] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
		end

----------------------------------------------------------------------
	else if @n = 4
		begin
			select * into tmp_campaign_4 from [INFINITY2].[Cx_Work].[public].[Table_5042218921]
			;delete from [INFINITY2].[Cx_Work].[public].[Table_5042218921]
			;insert into [INFINITY2].[Cx_Work].[public].[Table_5042218921]
				(
				[ID]  ,
				[State] ,
				[ID_долга] ,
				[Банк] ,
				[Фамилия] ,
				[Имя] ,
				[Отчество] ,
				[Телефон1] ,
				[Телефон2] ,
				[Телефон3] ,
				[Телефон4] ,
				[Телефон5] ,
				[Телефон6] ,
				[Телефон7] ,
				[Телефон8] ,
				[Телефон9] ,
				[Телефон10] ,
				[Телефон11] ,
				[Телефон12] ,
				[Телефон13] ,
				[Телефон14] ,
				[Телефон15] ,
				[Остаток_долга] ,
				[Дата_перезвона] ,
				[Часовой_пояс] ,
				[Телефон_для_перезвона] ,
				[ПерсональныйОператор] 
				)
			select
				tc1.*
			from
				tmp_campaign_4 tc1
				inner join i_collect.dbo.debt as d on tc1.[ID] = d.id
				left join
						(
						select
							cl.r_debt_id
							,cl.dt
						from
							i_collect.dbo.contact_log cl
						where
							cl.typ = 1
							and cl.id in
									(
									select
										max(id)
									from
										contact_log
									group by
										r_debt_id
									)		
						group by
							cl.r_debt_id
							,cl.dt
			
						)cl on cl.r_debt_id = d.id
			order by
				cl.dt asc
			;delete from 
				[INFINITY2].[Cx_Work].[public].[Table_5042218921]
			where
				 [ID] in
							(
							select
								d.id
							from
								i_collect.dbo.debt d
							where
								d.status in (6,7,8,10)
							group by
								d.id
							)
				or [ID] in
							(
							select
								wt.r_debt_id
							from
								i_collect.dbo.work_task_log as wt
								left join i_collect.dbo.users as u on wt.r_user_id = u.id
							where
								u.id not in (1604, -1)										
								and wt.id in 
										(
										select
											max(id)
										from
											i_collect.dbo.work_task_log
										group by
											r_debt_id
										)
							group by
								wt.r_debt_id
							)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
			set [State] = null
			where [State] is not null
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон1] = null
					where [Телефон1] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон2] = null
					where [Телефон2] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон3] = null
					where [Телефон3] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон4] = null
					where [Телефон4] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон5] = null
					where [Телефон5] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон6] = null
					where [Телефон6] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон7] = null
					where [Телефон7] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон8] = null
					where [Телефон8] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон9] = null
					where [Телефон9] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон10] = null
					where [Телефон10] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон11] = null
					where [Телефон11] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон12] = null
					where [Телефон12] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон13] = null
					where [Телефон13] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон14] = null
					where [Телефон14] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5042218921]
					set [Телефон15] = null
					where [Телефон15] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
		end
		
----------------------------------------------------------------------
	else if @n = 6
		begin
			select * into tmp_campaign_6 from [INFINITY2].[Cx_Work].[public].[Table_5064249944]
			;delete from [INFINITY2].[Cx_Work].[public].[Table_5064249944]
			;insert into [INFINITY2].[Cx_Work].[public].[Table_5064249944]
				(
				[ID] ,
				[State] ,
				[ID_долга] ,
				[Банк] ,
				[Фамилия] ,
				[Имя] ,
				[Отчество] ,
				[Остаток_долга] ,
				[Часовой_пояс] ,
				[Телефон1] ,
				[Телефон2] ,
				[Телефон_для_перезвона] ,
				[ПерсональныйОператор] ,
				[Телефон3] ,
				[Телефон4] ,
				[Телефон5] ,
				[Телефон6] ,
				[Телефон7] ,
				[Телефон8] ,
				[Телефон9] ,
				[Телефон10] ,
				[Телефон11] ,
				[Телефон12] ,
				[Телефон13] ,
				[Телефон14] ,
				[Телефон15] ,
				[Дата_перезвона] 
				)
			select
				tc1.*
			from
				tmp_campaign_6 tc1
				inner join i_collect.dbo.debt as d on tc1.[ID] = d.id
				left join
						(
						select
							cl.r_debt_id
							,cl.dt
						from
							i_collect.dbo.contact_log cl
						where
							cl.typ = 1
							and cl.id in
									(
									select
										max(id)
									from
										contact_log
									group by
										r_debt_id
									)		
						group by
							cl.r_debt_id
							,cl.dt
			
						)cl on cl.r_debt_id = d.id
			order by
				cl.dt asc
			;delete from 
				[INFINITY2].[Cx_Work].[public].[Table_5064249944]
			where
					[ID] in
							(
							select
								d.id
							from
								i_collect.dbo.debt d
							where
								d.status in (6,7,8,10)
							group by
								d.id
							)
				or [ID] in
							(
							select
								wt.r_debt_id
							from
								i_collect.dbo.work_task_log as wt
								left join i_collect.dbo.users as u on wt.r_user_id = u.id
							where
								u.id not in (1604, -1)										
								and wt.id in 
										(
										select
											max(id)
										from
											i_collect.dbo.work_task_log
										group by
											r_debt_id
										)
							group by
								wt.r_debt_id
							)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
			set [State] = null
			where [State] is not null
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон1] = null
					where [Телефон1] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон2] = null
					where [Телефон2] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон3] = null
					where [Телефон3] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон4] = null
					where [Телефон4] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон5] = null
					where [Телефон5] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон6] = null
					where [Телефон6] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон7] = null
					where [Телефон7] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон8] = null
					where [Телефон8] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон9] = null
					where [Телефон9] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон10] = null
					where [Телефон10] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон11] = null
					where [Телефон11] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон12] = null
					where [Телефон12] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон13] = null
					where [Телефон13] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон14] = null
					where [Телефон14] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5064249944]
					set [Телефон15] = null
					where [Телефон15] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
		end
----------------------------------------------------------------------
	else if @n = 7
		begin
			select * into tmp_campaign_7 from [INFINITY2].[Cx_Work].[public].[Table_5068758013]
			;delete from [INFINITY2].[Cx_Work].[public].[Table_5068758013]
			;insert into [INFINITY2].[Cx_Work].[public].[Table_5068758013]
				(
				[ID] ,
				[State] ,
				[ID_долга] ,
				[Банк] ,
				[Фамилия] ,
				[Имя] ,
				[Отчество] ,
				[Остаток_долга] ,
				[Часовой_пояс] ,
				[ПерсональныйОператор] ,
				[Телефон_для_перезвона] ,
				[Дата_перезвона] ,
				[Телефон1] ,
				[Телефон2] ,
				[Телефон3] ,
				[Телефон4] ,
				[Телефон5] ,
				[Телефон6] ,
				[Телефон7] ,
				[Телефон8] ,
				[Телефон9] ,
				[Телефон10] ,
				[Телефон11] ,
				[Телефон12] ,
				[Телефон13] ,
				[Телефон14] ,
				[Телефон15] 
				)
			select
				tc1.*
			from
				tmp_campaign_7 tc1
				inner join i_collect.dbo.debt as d on tc1.[ID] = d.id
				left join
						(
						select
							cl.r_debt_id
							,cl.dt
						from
							i_collect.dbo.contact_log cl
						where
							cl.typ = 1
							and cl.id in
									(
									select
										max(id)
									from
										contact_log
									group by
										r_debt_id
									)		
						group by
							cl.r_debt_id
							,cl.dt
			
						)cl on cl.r_debt_id = d.id
			order by
				cl.dt asc
			;delete from 
				[INFINITY2].[Cx_Work].[public].[Table_5068758013]
			where
				 [ID] in
							(
							select
								d.id
							from
								i_collect.dbo.debt d
							where
								d.status in (6,7,8,10)
							group by
								d.id
							)
				or [ID] in
							(
							select
								wt.r_debt_id
							from
								i_collect.dbo.work_task_log as wt
								left join i_collect.dbo.users as u on wt.r_user_id = u.id
							where
								u.id not in (1604, -1)										
								and wt.id in 
										(
										select
											max(id)
										from
											i_collect.dbo.work_task_log
										group by
											r_debt_id
										)
							group by
								wt.r_debt_id
							)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
			set [State] = null
			where [State] is not null
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон1] = null
					where [Телефон1] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон2] = null
					where [Телефон2] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон3] = null
					where [Телефон3] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон4] = null
					where [Телефон4] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон5] = null
					where [Телефон5] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон6] = null
					where [Телефон6] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон7] = null
					where [Телефон7] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон8] = null
					where [Телефон8] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон9] = null
					where [Телефон9] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон10] = null
					where [Телефон10] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон11] = null
					where [Телефон11] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон12] = null
					where [Телефон12] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон13] = null
					where [Телефон13] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон14] = null
					where [Телефон14] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5068758013]
					set [Телефон15] = null
					where [Телефон15] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
		end
		
----------------------------------------------------------------------
	else if @n = 8
		begin			
			select * into tmp_campaign_8 from [INFINITY2].[Cx_Work].[public].[Table_5336960870]
			;delete from [INFINITY2].[Cx_Work].[public].[Table_5336960870]
			;insert into [INFINITY2].[Cx_Work].[public].[Table_5336960870]
				(
				[ID] ,
				[State] ,
				[ID_долга] ,
				[Банк] ,
				[Фамилия] ,
				[Имя] ,
				[Отчество] ,
				[Телефон1] ,
				[Телефон2] ,
				[Телефон3] ,
				[Телефон4] ,
				[Телефон5] ,
				[Телефон6] ,
				[Телефон7] ,
				[Телефон8] ,
				[Телефон9] ,
				[Телефон10] ,
				[Телефон11] ,
				[Телефон12] ,
				[Телефон13] ,
				[Телефон14] ,
				[Телефон15] ,
				[Остаток_долга] ,
				[Дата_перезвона],
				[Часовой_пояс] ,
				[Телефон_для_перезвона] ,
				[ПерсональныйОператор] 
				)
			select
				tc1.*
			from
				tmp_campaign_8 tc1
				inner join i_collect.dbo.debt as d on tc1.[ID] = d.id
				left join
						(
						select
							cl.r_debt_id
							,cl.dt
						from
							i_collect.dbo.contact_log cl
						where
							cl.typ = 1
							and cl.id in
									(
									select
										max(id)
									from
										contact_log
									group by
										r_debt_id
									)		
						group by
							cl.r_debt_id
							,cl.dt
			
						)cl on cl.r_debt_id = d.id
			order by
				cl.dt asc
			;delete from 
				[INFINITY2].[Cx_Work].[public].[Table_5336960870]
			where
				 [ID] in
							(
							select
								d.id
							from
								i_collect.dbo.debt d
							where
								d.status in (6,7,8,10)
							group by
								d.id
							)
				or [ID] in
							(
							select
								wt.r_debt_id
							from
								i_collect.dbo.work_task_log as wt
								left join i_collect.dbo.users as u on wt.r_user_id = u.id
							where
								u.id not in (1604, -1)										
								and wt.id in 
										(
										select
											max(id)
										from
											i_collect.dbo.work_task_log
										group by
											r_debt_id
										)
							group by
								wt.r_debt_id
							)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
			set [State] = null
			where [State] is not null
			--15
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон1] = null
					where [Телефон1] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон2] = null
					where [Телефон2] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон3] = null
					where [Телефон3] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон4] = null
					where [Телефон4] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон5] = null
					where [Телефон5] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон6] = null
					where [Телефон6] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон7] = null
					where [Телефон7] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон8] = null
					where [Телефон8] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон9] = null
					where [Телефон9] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон10] = null
					where [Телефон10] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон11] = null
					where [Телефон11] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон12] = null
					where [Телефон12] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон13] = null
					where [Телефон13] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон14] = null
					where [Телефон14] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
			;UPDATE [INFINITY2].[Cx_Work].[public].[Table_5336960870]
					set [Телефон15] = null
					where [Телефон15] in
						(
							select
								p.number
							from
								i_collect.dbo.phone p
							where
								p.typ = 3
						union all
		
							select
								p.number2
							from
								i_collect.dbo.phone p
							where
								p.typ = 3

						)
		end
		
----------------------------------------------------------------------



END
GO