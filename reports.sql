SELECT 
	211 ID_system,
	contact_log.id ID_cont,
	debt.ext_id BIS_unit,
	LEFT(debt.account,4) SCAB,
	SUBSTRING(debt.account,5,6) SCAN,
	RIGHT(debt.account,3) SCAS,
	debt.credit_date,

	(CASE 
		When contact_log.result in (117,220,321,830,831,832,858,859,860,872,879,882) 
		then 20392 

		when contact_log.result in (533,771) 
		then 20180 

		when contact_log.result in (776,568) 
		then 20181 

		when contact_log.result in (774,538) 
		then 20183 

		when contact_log.result in (778,548) 
		then 20184 

		when contact_log.result in (777,775,536,537) 
		then 20324 

		when contact_log.result in (800,559) 
		then 20362 

		when contact_log.result in (801,560) 
		then 20291 

		when (contact_log.typ=2 and contact_log.result NOT in (117,220,321,533,771,776,568,774,538,778,548,777,775,536,537,800,559,801,560)) 
		then 20414 

		when (contact_log.typ=1 and contact_log.result NOT in (117,220,321,533,771,776,568,774,538,778,548,777,775,536,537,800,559,801,560)) 
		then 20030 

		when (contact_log.typ=3 and contact_log.result NOT in (117,220,321,533,771,776,568,774,538,778,548,777,775,536,537,800,559,801,560)) 
		then 20031 

		else 1 
	end) ID_typ_mer,


	
	(CASE 
		WHEN contact_result_set.r_id in (479,481,485,490,2,35) 
		then 20044 

		when contact_result_set.r_id in (480,491,486) 
		then 20045 

		when contact_result_set.r_id in (482,487,492,3,40) 
		then 20048 

		when contact_result_set.r_id in (484,489,494,495,496,325,13) 
		then 20051 

		when contact_result_set.r_id in (483,488,493,474,17,102,414) 
		then 20153 

		else 20051 

	end) ID_typ_otvet,

	20053 ID_typ_reaction,

	(CASE 
		WHEN contact_log.result in (827,828,829,871,878,881) 
		then 20080 

		when contact_log.result in (830,831,832,858,859,860,872,879,882) 
		then 20085 

		when contact_log.result in (841,845,864) 
		then 20013 

		when contact_log.result in (822,823,851,852,869,876) 
		then 20137 

		when (contact_result_set.r_id in (883,833) and contact_log.result NOT in (827,828,829,871,878,881,830,831,832,858,859,860,872,879,882,841,822,823,845,851,852,864,869,876)) 
		then 20214 

		when debt.reason=901 
		then 20129 

		when debt.reason=902 
		then 20122 

		when debt.reason=903 
		then 20007 

		when debt.reason=904 
		then 20123 

		when debt.reason=905 
		then 20158 

		when debt.reason=907 
		then 20128 

		when debt.reason=908 
		then 20014 

		when debt.reason=909 
		then 20140 

		when debt.reason=910 
		then 20023 

		when debt.reason=911 
		then 20008 

		when debt.reason=912 
		then 20009 

		when debt.reason=913 
		then 20074 

		when debt.reason=914 
		then 20075 

		when debt.reason=915 
		then 20076 

		when debt.reason=916 
		then 20077 

		when debt.reason=917 
		then 20025 

		when debt.reason=918 
		then 20033 


		else 20146 

	end) ID_reason,

	contact_log.dt,

	(CASE 
		WHEN debt_promise.prom_sum IS NOT NULL 
		then '1' 

		else '0' 

	end) prom_flag,


	(CASE 
		WHEN debt_promise.prom_sum IS NOT NULL 
		then CONVERT(VARCHAR(10), debt_promise.prom_date,104) 

		else '' 

	end) prom_date,

	(CASE 
		WHEN debt_promise.prom_sum IS NOT NULL 
		then debt_promise.prom_sum 

		else ' ' 

	end) prom_sum,

	contact_log.r_user_id,
	' ' code_script,
	cnt.attempt_cnt,

	(CASE 
		WHEN contact_log.r_phone_id IS NOT NULL 
		then phone.number 

		when contact_log.r_adres_id IS NOT NULL 
		then address.full_adr 

		else ' ' 

	end) tel_contact,

	contact_result_set.text+': '+contact_log.dsc comment_dsc,

	'' naprav_contact,

	'12:00:00' contact_length,

	(CASE 
		WHEN contact_log.result in (842,824,825,826,865,870,877,880) 
		then 'Y' 

		else 'N' 

	end) perezv_flag
------------------------------------------------------------------------------------------------

FROm 
	contact_log
	LEFT OUTER JOIN phone on phone.id = contact_log.r_phone_id
	LEFT OUTER JOIN address on address.id = contact_log.r_adres_id
	LEFT OUTER JOIN debt_promise on debt_promise.id=contact_log.r_prom_id

	join contact_result_set on contact_log.result=contact_result_set.code

	JOIN debt on contact_log.r_debt_id=debt.id
	LEFT OUTER JOIN 
					(
						SELECT 

							contact_log.r_debt_id,
							COUNT(id) attempt_cnt

						FROM 

							contact_log

						WHERE 

							dt BETWEEN (@SD) AND (@ED)

						GROUP BY 
							r_debt_id

					)cnt 	on cnt.r_debt_id=debt.id



	JOIN portfolio on debt.r_portfolio_id=portfolio.id

WHERE 
	portfolio.parent_id=69 
	and portfolio.code NOT in (999) 
	and contact_log.typ in (1,2,3,7) 
	and contact_log.dt BETWEEN (@SD) AND (@ED) 



--------------------------------------------UNION-----------------------------------------------------

UNION




SELECT 
	211 ID_system,
	contact_log.id ID_cont,
	debt.ext_id BIS_unit,

	LEFT(debt.account,4) SCAB,
	SUBSTRING(debt.account,5,6) SCAN,
	RIGHT(debt.account,3) SCAS,
	debt.credit_date,
	20191 ID_typ_mer,
	20044 ID_typ_otvet,
	20053 ID_typ_reaction,

	(CASE 
		WHEN debt.reason=901 
		then 20129 

		when debt.reason=902 
		then 20122 

		when debt.reason=903 
		then 20007 

		when debt.reason=904 
		then 20123 

		when debt.reason=905 
		then 20158 

		when debt.reason=907 
		then 20128 

		when debt.reason=908 
		then 20014 

		when debt.reason=909 
		then 20140 

		when debt.reason=910 
		then 20023 

		when debt.reason=911 
		then 20008 

		when debt.reason=912 
		then 20009 

		when debt.reason=913 
		then 20074 

		when debt.reason=914 
		then 20075 

		when debt.reason=915 
		then 20076 

		when debt.reason=916 
		then 20077 

		when debt.reason=917 
		then 20025 

		when debt.reason=918 
		then 20033 


		else 20146 

	end) ID_reason,

	contact_log.dt,
	'' prom_flag,
	'' prom_date,
	'' prom_sum,
	1 r_user_id,
	'' code_script,
	cnt.attempt_cnt,
	phone.number tel_contact,
	contact_result_set.text comment_dsc,
	'' naprav_contact,
	'12:00:00' contact_length,
	'N' perezv_flag

FROM 
	contact_log
	JOIN debt on debt.id=contact_log.r_debt_id
	
	LEFT OUTER JOIN 
					(
						SELECT 

							contact_log.r_debt_id,
							COUNT(id) attempt_cnt

						FROM

							contact_log

						WHERE 

							dt BETWEEN (@SD) AND (@ED)

						GROUP BY 

							r_debt_id

					)cnt 	on cnt.r_debt_id = debt.id

					
	JOIN contact_result_set on contact_result_set.code = contact_log.result
	LEFT OUTER JOIN phone on phone.id = contact_log.r_phone_id
	JOIN portfolio on debt.r_portfolio_id = portfolio.id

WHERE 
	
	portfolio.parent_id=69 and portfolio.code NOT in (999) and contact_log.dt BETWEEN (@SD) AND (@ED) and contact_log.typ=19

-----------------------------UNION--------------------------------------


UNION 


SELECT 
	
	211 ID_system,
	debt_sms.id ID_cont,
	debt.ext_id BIS_unit,
	LEFT(debt.account,4) SCAB,
	SUBSTRING(debt.account,5,6) SCAN,
	RIGHT(debt.account,3) SCAS,
	debt.credit_date,
	20411 ID_typ_mer,
	20044 ID_typ_otvet,
	20053 ID_typ_reaction,
	
	(CASE 
		WHEN debt.reason=901 
		then 20129 

		when debt.reason=902 
		then 20122 

		when debt.reason=903 
		then 20007 

		when debt.reason=904 
		then 20123 

		when debt.reason=905 
		then 20158 

		when debt.reason=907 
		then 20128 

		when debt.reason=908 
		then 20014 

		when debt.reason=909 
		then 20140 

		when debt.reason=910 
		then 20023 

		when debt.reason=911 
		then 20008 

		when debt.reason=912 
		then 20009 

		when debt.reason=913 
		then 20074 

		when debt.reason=914 
		then 20075 

		when debt.reason=915 
		then 20076 

		when debt.reason=916 
		then 20077 

		when debt.reason=917 
		then 20025 

		when debt.reason=918 
		then 20033 

		else 20146 

	end) ID_reason,
	debt_sms.send_date dt,
	'' prom_flag,
	'' prom_date,
	'' prom_sum,
	1 r_user_id,
	'' code_script,
	cnt.attempt_cnt,
	phone.number tel_contact,
	stts.name+':  '+debt_sms.text comment_dsc,
	'' naprav_contact,
	'12:00:00' contact_length,
	'N' perezv_flag


FROm 
	debt_sms
	JOIN 
		(
			SELECT 
				* 

			FROM 

				dict 

			WHERE 

				parent_id=50

		)stts 	on stts.code = debt_sms.status


	LEFT OUTER JOIN phone on debt_sms.r_phone_id = phone.id

	JOIN debt on debt_sms.parent_id = debt.id

	LEFT OUTER JOIN 
					(
						SELECT 

							contact_log.r_debt_id,
							COUNT(id) attempt_cnt

						FROM 

							contact_log

						WHERE 

							dt BETWEEN (@SD) AND (@ED)

						GROUP BY r_debt_id


					) cnt on cnt.r_debt_id=debt.id



---??	
IN portfolio on debt.r_portfolio_id=portfolio.id


WHERE 
	portfolio.parent_id=69 
	and portfolio.code NOT in (999) 
	and debt_sms.send_date BETWEEN (@SD) AND (@ED)


---------------------------------UNION--------------------------------

UNION


SELECT 
	211 ID_system,
	contact_log.id ID_cont,
	debt.ext_id BIS_unit,
	LEFT(debt.account,4) SCAB,
	SUBSTRING(debt.account,5,6) SCAN,
	RIGHT(debt.account,3) SCAS,
	debt.credit_date,
	20191 ID_typ_mer,
	20044 ID_typ_otvet,
	20053 ID_typ_reaction,
	
	(CASE 
		WHEN debt.reason=901 
		then 20129 

		when debt.reason=902 
		then 20122 

		when debt.reason=903 
		then 20007 

		when debt.reason=904 
		then 20123 

		when debt.reason=905 
		then 20158 

		when debt.reason=907 
		then 20128 

		when debt.reason=908 
		then 20014 

		when debt.reason=909 
		then 20140 

		when debt.reason=910 
		then 20023 

		when debt.reason=911 
		then 20008 

		when debt.reason=912 
		then 20009 

		when debt.reason=913 
		then 20074 

		when debt.reason=914 
		then 20075 

		when debt.reason=915 
		then 20076 

		when debt.reason=916 
		then 20077 

		when debt.reason=917 
		then 20025 

		when debt.reason=918 
		then 20033 

		else 20146 

	end) ID_reason,
	contact_log.dt,
	'' prom_flag,
	'' prom_date,
	'' prom_sum,
	1 r_user_id,
	'' code_script,
	cnt.attempt_cnt,
	phone.number tel_contact,
	contact_result_set.text comment_dsc,
	'' naprav_contact,
	'12:00:00' contact_length,
	'N' perezv_flag

FROM 
	contact_log
	JOIN debt on debt.id = contact_log.r_debt_id

	LEFT OUTER JOIN 
					(
						SELECT

							contact_log.r_debt_id,
							COUNT(id) attempt_cnt

						FROM 

							contact_log
						
						WHERE 

							dt BETWEEN (@SD) AND (@ED)

						GROUP BY 

							r_debt_id

					)cnt 	on cnt.r_debt_id = debt.id


	JOIN contact_result_set on contact_result_set.code = contact_log.result
	LEFT OUTER JOIN phone on phone.id = contact_log.r_phone_id
	JOIN portfolio on debt.r_portfolio_id = portfolio.id

	WHERE 

		portfolio.parent_id=69 
		and portfolio.code NOT in (999) 
		and contact_log.dt BETWEEN (@SD) AND (@ED) 
		and contact_log.typ=6


	ORDER BY 
		BIS_unit, 
		SCAB, 
		SCAN, 
		SCAS, 
		dt