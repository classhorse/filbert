
---------------------------------------------------------------------------------
/*
#2
*/
delete
from 
	[INFINITY2].[Cx_Work].[public].[Table_5000081044]
where
	[ID_долга] in
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
	or [ID_долга] in
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

;

UPDATE [INFINITY2].[Cx_Work].[public].[Table_5000081044]
set [State] = null
where [State] is not null
;
---------------------------------------------------------------------------------
/*
#3
*/
delete
from 
	[INFINITY2].[Cx_Work].[public].[Table_5015640658]
where
	[ID_долга] in
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
	or [ID_долга] in
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

;

UPDATE [INFINITY2].[Cx_Work].[public].[Table_5015640658]
set [State] = null
where [State] is not null
;
------------------------------