/*	For Pivot Table
	of a volume of the portfolio
	and payments of employees
*/


use i_collect;
go


declare @d1 datetime = '01-06-2016 00:00:01'
declare @d2 datetime = '30-06-2016 23:59:59'
declare @dep varchar(32) = 'Межрегиональное взыскание'
--u.f + ' ' + left(u.i, 1) + ', ' + left(u.o, 1) + '.' fio


select
	'июнь' 'месяц'
	,b.name
	,wt.fio
	,sum(dbl.debt_sum) 'Портфель в рублях'
	,count(d.id) 'Портфель в штуках'
	--,sum(v.int_sum) 'Оплаты руб.'
	--,count(v.id) 'Оплаты шт.'
	--,sum(v.summa) 'Оплаты руб.'
	--,sum(v.kolvo) 'Оплаты шт.'

from
	bank as b
	inner join portfolio as p on b.id = p.parent_id
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id

	/*	.users
		watching only 
		dep.name == 'Межрегиональное взыскание'
	*/
	inner join 
			(
			select
				wt.r_debt_id
				,u.r_department_id
				,u.id
				,u.f + ' ' + left(u.i, 1) + ', ' + left(u.o, 1) + '.' fio
			from
				i_collect.dbo.work_task_log as wt
				left join i_collect.dbo.users as u on wt.r_user_id = u.id
				left join i_collect.dbo.department as dep on u.r_department_id = dep.dep
			where
				dep.name = @dep
				and wt.id in 
						(
						select
							max(id)
						from
							i_collect.dbo.work_task_log
						where
							fd !> @d1
						group by
							r_debt_id
						)
			)wt 	on d.id = wt.r_debt_id

	/*	debt sum
		!> beginning of the month
	*/
	left join 
			(
			select
				dbl.parent_id,
				dbl.debt_sum
			from
				[i_collect].[dbo].[debt_balance_log] as dbl
			where
				dbl.id in
						(
						select
							max(d.id)
						from
							[i_collect].[dbo].[debt_balance_log] as d
						where
							d.dt < @d1
						group by
							d.parent_id
						)
							
			group by
				dbl.parent_id,
				dbl.debt_sum

			)dbl
				on d.id = dbl.parent_id

	--/*	Payment for employees
	--	!!!Doesn't work (
	--*/
	--left join
	--		(
	--		select
	--			v.parent_id
	--			,sum(v.int_sum) summa
	--			,count(v.id) kolvo
	--		from
	--			payment_v v
	--		where
	--			v.calc_date between @d1 and @d2
	--		group by
	--			v.parent_id
	--		)v
	--			on v.parent_id = d.id
			

where
	b.id in (49, 14, 10, 70, 9, 11)

group by
	b.name
	,wt.fio
order by
	wt.fio asc





select count(*) from [INFINITY2].[Cx_Work].[public].[Table_5068758013]


select * from wh_data.dbo.Filbert_horovod_log_2 order by id asc