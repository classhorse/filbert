sp_configure 'show advanced options', 1
reconfigure

sp_configure 'Ad Hoc Distributed Queries', 1
reconfigure




SELECT 
	*

FROM 
OPENROWSET

(
   'MSDASQL', 'Driver=PostgreSQL Unicode(x64);uid=KimLA;Server=192.168.11.13;port=10000;database=Cx_Work;pwd=78787878',
    
	
	'
		SELECT
			 *
			
		FROM 
			"Table_5036788937"
		  
	'
)a


select * from openquery(INFINITY, 'select * from sql_test')

update openquery (INFINITY, 'select * from sql_test where text is null')
set text = 'lol'

insert openquery(INFINITY, 'select * from sql_test')
values (777, 'azaza')