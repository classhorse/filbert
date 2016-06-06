declare @SD date
declare @ED date

set @SD = '01-02-2015 07:00:00'
set @ED = '31-12-2015 23:59:59'

SELECT distinct
	debt.account,
	211 as ID_system,
	contact_log.id as ID_cont,
	debt.ext_id as BIS_unit,
	LEFT(debt.account,4) as SCAB,
	SUBSTRING(debt.account,5,6) as SCAN,
	RIGHT(debt.account,3) as SCAS,
	convert(varchar, debt.credit_date,104) as credit_date,

	(CASE 
		When contact_result_set.text like '%умер%' then 20392 
		when contact_log.typ=2 then 20414 
		when contact_log.typ=1 then 20030 
		when contact_log.typ=3 then 20031 else 1 
	end) as ID_typ_mer,

	(CASE WHEN contact_result_set.r_id in (2,20,35,272,326,338,840,849,852) then 20044 
		when contact_result_set.r_id in (327,841,850,853) then 20045 
		when contact_result_set.r_id in (328,842,851,854) then 20048 
		when contact_result_set.r_id in (3,17,21,102,269,329,339,363,843,844,848,877,901) then 20153 
		else 20051 
	end) as ID_typ_otvet,
		
	20053 as ID_typ_reaction,
	(CASE 
		WHEN contact_result_set.text like '%Не удалось передать информацию%' then 20080 
		when contact_result_set.text like '%умер%' then 20085 
		when contact_result_set.text like '%Рабочий%' then 20159 
		when contact_log.result in (841,845,864) then 20137	
		when contact_result_set.text like '%Отказ от оплаты%' then 20013
		when (contact_result_set.r_id in (833,883) or contact_log.result=857) then 20214
		when debt.reason=901 then 20129 
		when debt.reason=902 then 20122 
		when debt.reason=903 then 20007 
		when debt.reason=904 then 20123 
		when debt.reason=905 then 20158 
		when debt.reason=907 then 20128 
		when debt.reason=908 then 20014 
		when debt.reason=909 then 20140 
		when debt.reason=910 then 20023 
		when debt.reason=911 then 20008 
		when debt.reason=912 then 20009 
		when debt.reason=913 then 20074 
		when debt.reason=914 then 20075 
		when debt.reason=915 then 20076 
		when debt.reason=916 then 20077 
		when debt.reason=917 then 20025 
		when debt.reason=918 then 20033 
		else 20146 
	end) as ID_reason,

	CONVERT(VARCHAR(10),contact_log.dt,104) as dt,

	(CASE 
		WHEN debt_promise.prom_sum IS NOT NULL 
		then '1' else '0' 
	end) as prom_flag,

	(CASE 
		WHEN debt_promise.prom_sum IS NOT NULL 
		then CONVERT(VARCHAR(10), debt_promise.prom_date,104) 
		else '' 
	end) as prom_date,

	(CASE 
		WHEN debt_promise.prom_sum IS NOT NULL 
		then ROUND(debt_promise.prom_sum, 2) 
		else ' ' 
	end) as prom_sum,

	contact_log.r_user_id,
	' ' code_script,
	cnt.attempt_cnt,
	(CASE 
		WHEN contact_log.r_phone_id IS NOT NULL 
		then phone.number 
		else ' ' 
	end) as tel_contact,

	contact_result_set.text+': '+contact_log.dsc as comment_dsc,

	(
		CASE 
			WHEN contact_log.typ = 3 
			then 'I' 
			else 'O' 
		end) naprav_contact,

	'12:00:00' as contact_length,

	(CASE 
		WHEN contact_log.result in (842,824,825,826,865,870,877,880) 
		then 'Y' 
		else 'N'
	 end) as perezv_flag



FROm 
	contact_log
	LEFT OUTER JOIN phone on phone.id = contact_log.r_phone_id
	LEFT OUTER JOIN address on address.id = contact_log.r_adres_id
	LEFT OUTER JOIN debt_promise on debt_promise.id = contact_log.r_prom_id
	JOIn contact_result_set on contact_log.result = contact_result_set.code
	JOIN debt on contact_log.r_debt_id = debt.id
	LEFT OUTER JOIN 

				(
					SELECT 
						debt.id r_debt_id,
						ISNULL(cont.ascnt,0)+ISNULL(sms.cnt,0) as attempt_cnt	
					FROM 
						debt
						LEFT OUTER JOIN 
									(
										SELECT 
											r_debt_id,
											COUNT(id) as ascnt
										FROM 
											contact_log 
							
										WHERE 
											dt BETWEEN (@SD) AND (@ED)

										GROUP BY 
											r_debt_id

									) cont on cont.r_debt_id = debt.id

						LEFT OUTER JOIN 
									(
										SELECT 
											parent_id,
											COUNT(id) as cnt
					
										FROM 
											debt_sms
					
										WHERE 
											send_date BETWEEN (@SD) AND (@ED)
					
										GROUP BY 
											parent_id

									) sms on sms.parent_id=debt.id

				) cnt on cnt.r_debt_id=debt.id


	JOIN portfolio on debt.r_portfolio_id=portfolio.id

WHERE
	-- portfolio.parent_id = 69 
	 --and portfolio.code NOT in (999) 
	  contact_log.typ in (1,2,3) 
	 and contact_log.dt BETWEEN (@SD) AND (@ED)
	 and debt.account = '5108025827200'