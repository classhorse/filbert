░█░░░█▀█░█░█░█▀▀░
░█░░░█░█░█░█░█▀▀
░▀▀▀░▀▀▀░░▀░░▀▀▀░
Σ Ѵ
http://vkontakte.doguran.ru/kak-pisat-simvolami.php
http://vkontakte.doguran.ru/perecherknutyj-tekst-vkontakte.php -- ̶в̶о̶т̶ ̶т̶а̶к̶

--pypyODBC
http://snakeproject.ru/rubric/article.php?art=python_pyodbc --doka

select top 10
	id
	, N''+name as name
from 
	debt

--пароль от актов
202321

--собственные портфели
b.id in (49, 14, 10, 9, 11, 70)

--Формирование колл листов
ПО Контакт - Произвольные отчеты - #65

--Починить акты о выплате ЗП сотрудникам

O:/службы и отделы/ колл-центр / аналитики / РЛ

--[отчет о расходах ; Реестр вознаграждения]
нужно снять все фильтры и сохранить
или косяк что файл не так называется или не там лежит

--%%%%%%%%%%%%%%%%%%%
cast(sum(cl.true) as decimal (18,2)) / cast(sum(cl.false) as decimal (18,2))

--Номер строки
ROW_NUMBER() over (order by cl.skem desc) as '№п/п'

--уникальный ID
abs(checksum(newid()))

--Проходимость линии
1 линия = 700 телефонов / час

--communication
	JM17 Kale5301

--автоинформаторы
45, 145,146,147,164,165

--Кампании Дайлер:
Table_5000081023 1
Table_5000081044 2
Table_5015640658 3
Table_5042218921 4

Table_5052709673 5

Table_5064249944 6
Table_5068758013 7
Table_5336960870 8

БАЛТБАНК
ТКС
Париба
АТБ-агент
ББ-суд
Вивус
Джет Мани
Е-заем
Кеб
МТС
СКМ
СМС-Финанс


--Кампании IVR:
Table_5459752341 ИнформированиеББ_2
Table_5000081060 Цессия
Table_5036788937 Агентский
Table_5253663694 Агеентский 2
Table_5471183067 avto_voice
Table_5197538416 Автовзыскание_1
Table_5197538447 Автовзыскание_2
Table_5263348794 Test

select * from  [INFINITY].[Cx_Work].[public].[Table_5036788937]



	--пейджинг
	select 
		* 
	from 
		#table
	order by 
		id asc 
			offset 0 rows 
			fetch next 2 rows only
		
			

/*classic*/
SELECT 
	*

FROM
	bank as b
	inner join portfolio as p on b.id = p.parent_id
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id

/*promise*/
	left join 
			(
			select 
				dp.parent_id, 
				sum(dp2.OP_sum) as OP_sum,
				sum(dp2.kol_ob) as kol_ob
			from 
				i_collect.dbo.debt_promise as dp
				left join
						(
							select
								dp2.id as id,

								(case 
									when (dp2.prom_sum is not null ) 
									then dp2.prom_sum 				
									else 0 
								end) as OP_sum,

								(case 
									when (dp2.prom_sum is not null) 
									then 1 
									else 0 
								end) as kol_ob
							from 								
								i_collect.dbo.debt_promise as dp2
							group by
								dp2.id,
								dp2.prom_sum
						)dp2 	on dp2.id=dp.id
			group by 
				dp.parent_id
			)dp on d.id = dp.parent_id
		

/*calc*/
	left join 
			( 
			select 
				dc.parent_id,
				sum(dc2.PP_sum) as PP_sum,
				sum(dc2.PP_kolvo) as PP_kolvo
			from 
				[i_collect].[dbo].[debt_calc] as dc
				left join 
						(
							select 
									dc2.id as id,

									(case 
										when 
											(
												dc2.int_sum is not null 
												and dc2.is_confirmed = 1 
												and dc2.is_cancel = 0
											)
										then dc2.int_sum
										else 0
									end) as PP_sum,				

									(case 
										when 
											(
												dc2.int_sum is not null 
												and dc2.is_confirmed = 1 
												and dc2.is_cancel = 0
											)
										then 1
										else 0 
									end) as PP_kolvo	

							from 
								[i_collect].[dbo].[debt_calc] as dc2

							group by							 
								dc2.is_confirmed,
								dc2.int_sum,
								dc2.id,
								dc2.is_cancel
							) dc2 on dc2.id=dc.id			

				group by
					dc.parent_id
				) dc on dc.parent_id = d.id





/*users*/
	left join 
			(
			select
				wt.r_debt_id,
				u.r_department_id,
				u.id
			from
				i_collect.dbo.work_task_log as wt
				left join i_collect.dbo.users as u on wt.r_user_id = u.id
				left join i_collect.dbo.department as dep on u.r_department_id = dep.dep
			where
				wt.id in 
						(
						select
							max(id)
						from
							i_collect.dbo.work_task_log
						group by
							r_debt_id
						)
			)wt 	on d.id = wt.r_debt_id



/*discount*/
	inner join
			(
			select
				dd.r_debt_id,
				dis.name,
				dd.pay_sum,
				dd.write_off_sum
			from
				i_collect.dbo.debt_discount as dd
				inner join
						(
							select
								id,
								name
							from
								i_collect.dbo.discount
							where
								name like 'Прощение долга ББ 1'
						)dis 	on dd.r_discount_id = dis.id
			)dd 	on d.id = dd.r_debt_id





--регулярка
			SUBSTRING
					(
						la.dsc, 
						CHARINDEX('*', la.dsc), 
						CHARINDEX('**', la.dsc) 
					)






="За период с «01» "&"по "&"«"&ДЕНЬ(КОНМЕСЯЦА(ТДАТА();0))&"»"&" "&ВЫБОР(МЕСЯЦ(ТДАТА());"Января";"Февраля";"Марта";"Апреля";"Мая";"Июня";"Июля";"Августа";"Сентября";"Октября";"Ноября";"Декабря")&" "&ГОД(ТДАТА())&" г."
="За период с «01» "&"по "&"«"&ДЕНЬ(КОНМЕСЯЦА(ТДАТА();0))&"»"&" "&ВЫБОР(МЕСЯЦ(ТДАТА());"Января";"Февраля";"Марта";"Апреля";"Мая";"Июня";"Июля";"Августа";"Сентября";"Октября";"Ноября";"Декабря")&" "&ГОД(ТДАТА())&" г."


--действия за период (функция)
I_collect.[dbo].FILBERT_report_87(debt.id,'01.05.2015','31.05.2015 23:59:59')


--добавленные телефоны (функция)
I_collect.[dbo].FILBERT_DopInfPhone( per.id,  @d1 DATETIME,  @d2 DATETIME)
@id – id персоны






--предыдущий месяц
select
	dateadd(MINUTE, 1, cast(dateadd(day, 1, EOMONTH(dateadd(month, -2, getdate()))) as datetime))
	,dateadd(second, 59, dateadd(minute, 59, dateadd(hh, 23, cast(dateadd(month, -1, EOMONTH(getdate())) as datetime))))

--текущий месяц
select
	dateadd(SECOND, 1, cast(dateadd(day, 1, EOMONTH(dateadd(month, -1, getdate()))) as datetime))
	,dateadd(second, 59, dateadd(minute, 59, dateadd(hh, 23, cast(EOMONTH(getdate()) as datetime))))