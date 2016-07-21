--for xml

,(
  select 
   number2+' ' +contact_face+' '+ dsc+'||' 
  from 
   phone
  where 
   parent_id  = per.id  
   and block_flag  = 0 
   --and dsc <> 'Импортировано при загрузке данных.' 
   and load_dt  between @bd and @ed
 
  for xml path('') 

 ) [Уточненная контактная информация]