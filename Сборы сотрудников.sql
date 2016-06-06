--Сборы сотрудников


SELECT 
	(
		SELECT  
			f + ' ' + SUBSTRING(i,1,1) + '.' + SUBSTRING(o,1,1)+'.' 
		
		FROM 
			users 
		
		WHERE 
			id = payment_v.r_user_id
			
	)fio,
			
	SUM(sum) sum

FROM
	payment_v

WHERE
	dt BETWEEN '01.10.2015' AND '31.10.2015 23:59:59'
	AND r_user_id IN
					(
						SELECT
							id
							
						FROM
							users
						
						WHERE
							r_department_id IN(47,48,60,66)
					)
	AND  is_cancel = 0

GROUP BY
	r_user_id

ORDER BY
	2;

