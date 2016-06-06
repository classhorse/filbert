declare @lst varchar = (
					'Колл-Центр (1-я группа)',
					'Колл-Центр (2-я группа)',
					'Колл-Центр (3-я группа)',
					'Колл-Центр (4-я группа)',
					'Колл-Центр (5-я группа)',
					'Колл-Центр (6-я группа)'
	)
select @lst


select
	
	d.name
	,sum(v.sum)
from
	payment_v v
	left join users u on v.r_user_id = u.id
	left join department d on u.r_department_id = d.dep

where
	v.calc_date between '01-05-2016 00:00:01' and '07-05-2016 23:59:59'
	and d.name in (
					'Колл-Центр (1-я группа)',
					'Колл-Центр (2-я группа)',
					'Колл-Центр (3-я группа)',
					'Колл-Центр (4-я группа)',
					'Колл-Центр (5-я группа)',
					'Колл-Центр (6-я группа)'
	)

group by
	d.name




select
	d.name
	,sum(dc.int_sum)
from
	debt_calc dc
	left join users u on dc.r_user_id = u.id
	left join department d on u.r_department_id = d.dep

where
	dc.calc_date between '01-05-2016 00:00:01' and '07-05-2016 23:59:59'
	and d.name in (
					'Колл-Центр (1-я группа)',
					'Колл-Центр (2-я группа)',
					'Колл-Центр (3-я группа)',
					'Колл-Центр (4-я группа)',
					'Колл-Центр (5-я группа)',
					'Колл-Центр (6-я группа)'
	)

group by
	d.name