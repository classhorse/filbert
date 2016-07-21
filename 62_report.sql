/*********************
		62 report
*********************/

SELECT
  debt.id AS debt_id,
  person.f,
  person.i,
  person.o,
  debt.debt_sum,
  d51.code-4 as gmtname,
  portfolio.name,
  debt.id AS did,
  debt.parent_id
INTO tmp65
FROM
  debt 
    LEFT JOIN person (nolock) ON debt.parent_id = person.id
    LEFT JOIN portfolio (nolock) ON  debt.r_portfolio_id = portfolio.id
    LEFT JOIN (select * from dict (nolock) where parent_id = 51) d51 on debt.gmt = d51.code
WHERE
  debt.id IN(

12008,
12147,
12283

  );

SELECT 
  parent_id person_id,
  MAX(CASE WHEN RowNum=1 THEN number ELSE NULL END) tel1,
  MAX(CASE WHEN RowNum=2 THEN number ELSE NULL END) tel2,
  MAX(CASE WHEN RowNum=3 THEN number ELSE NULL END) tel3,
  MAX(CASE WHEN RowNum=4 THEN number ELSE NULL END) tel4,
  MAX(CASE WHEN RowNum=5 THEN number ELSE NULL END) tel5,
  MAX(CASE WHEN RowNum=6 THEN number ELSE NULL END) tel6,
  MAX(CASE WHEN RowNum=7 THEN number ELSE NULL END) tel7,
  MAX(CASE WHEN RowNum=8 THEN number ELSE NULL END) tel8,
  MAX(CASE WHEN RowNum=9 THEN number ELSE NULL END) tel9,
  MAX(CASE WHEN RowNum=10 THEN number ELSE NULL END) tel10,
  MAX(CASE WHEN RowNum=11 THEN number ELSE NULL END) tel11,
  MAX(CASE WHEN RowNum=12 THEN number ELSE NULL END) tel12,
  MAX(CASE WHEN RowNum=13 THEN number ELSE NULL END) tel13,
  MAX(CASE WHEN RowNum=14 THEN number ELSE NULL END) tel14,
  MAX(CASE WHEN RowNum=15 THEN number ELSE NULL END) tel15,
  MAX(ISNULL(max_dt_all,'01.01.2999')) max_dt_all
INTO tmp65_1
FROM 
(
   SELECT
    ph.id,
    ph.parent_id,
    '8'+SUBSTRING(ph.number2,2,64) number,
    ROW_NUMBER() OVER(partition by ph.parent_id ORDER BY     
    (CASE WHEN ph.typ=1 THEN 1
          WHEN ph.typ=2 THEN 2
          WHEN ph.typ=4 THEN 3
          WHEN ph.typ IN(31,32,101,102,104,201,202,204) THEN 4
          WHEN ph.typ IN(3,33,103,203) THEN 5
          WHEN ph.typ=44 THEN 6
          ELSE 1000 END) +
    (CASE WHEN ISNULL(cl_max.Row1,-1)=-1 THEN 0
          WHEN ISNULL(cl_max.Row1,0)>0 AND ISNULL(cl_max.RowNot1,0)=0 THEN 100
          WHEN DATEADD(DAY,-1,getdate())>cl_max.maxDt THEN 100
          WHEN DATEADD(DAY,-1,getdate())<=cl_max.maxDt THEN 200          
          ELSE -1 END) +
    ISNULL(contact_result_set.filbert_result,0)) RowNum,
    cl_max.max_dt_all
  FROM
    phone (nolock) ph 
      LEFT JOIN 
        (	
        	SELECT 
			  r_phone_id,
			  SUM(CASE WHEN r_user_id = 1 THEN 1 ELSE 0 END) Row1,
			  SUM(CASE WHEN r_user_id <> 1 THEN 1 ELSE 0 END) RowNot1,  
			  MAX(CASE WHEN r_user_id <> 1 THEN dt ELSE NULL END) maxDt,
              MAX(CASE WHEN r_user_id <> 1 THEN id ELSE 0 END) maxID,
              MAX(dt) max_dt_all
			FROM 
			  contact_log (nolock)
			WHERE 
			  typ IN(1,3) AND contact_log.parent_id IN (SELECT parent_id FROM tmp65)
			GROUP BY r_phone_id
        ) cl_max
           ON ph.id = cl_max.r_phone_id
      LEFT JOIN contact_log (nolock) ON contact_log.id =cl_max.maxID
      LEFT JOIN contact_result_set (nolock) ON contact_log.result = contact_result_set.code
  WHERE 
    ph.block_flag = 0 AND ph.typ<>44 and ph.parent_id IN (SELECT parent_id FROM tmp65) AND LEN(ph.number)=11
) zzzccc
GROUP BY parent_id


;SELECT
  tmp65.debt_id,
  tmp65.f,
  tmp65.i,
  tmp65.o,
  tmp65.debt_sum,
  tmp65.gmtname,
  tmp65.name,
  tmp65_1.tel1,
  tmp65_1.tel2,
  tmp65_1.tel3,
  tmp65_1.tel4,
  tmp65_1.tel5,
  tmp65_1.tel6,
  tmp65_1.tel7,
  tmp65_1.tel8,
  tmp65_1.tel9,
  tmp65_1.tel10,
  tmp65_1.tel11,
  tmp65_1.tel12,
  tmp65_1.tel13,
  tmp65_1.tel14,
  tmp65_1.tel15,
  tmp65.debt_id AS did,
  (CASE WHEN tmp65_1.max_dt_all='01.01.2999' THEN '01.01.1900' ELSE tmp65_1.max_dt_all END) max_dt_all
FROM
  tmp65 
    LEFT JOIN tmp65_1 ON tmp65.parent_id = tmp65_1.person_id
WHERE ISNULL(tmp65_1.tel1,'') != ''
ORDER BY (CASE WHEN tmp65_1.max_dt_all='01.01.2999' THEN '01.01.1900' ELSE tmp65_1.max_dt_all END)


drop table tmp65;
drop table tmp65_1;


