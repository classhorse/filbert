--under develop
/*  main select 
    with 15 phone columns
*/





SELECT top 100
    d.id
    ,N''+per.f as F
    ,N''+per.i as I
    ,N''+per.o as O
    ,d.debt_sum
    ,d.gmt-4 gmt
    ,N''+p.name as bank


FROM
    i_collect.dbo.bank as b
    inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
    inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
    inner join i_collect.dbo.person as per on d.parent_id = per.id

    left join i_collect.dbo.phone ph on ph.parent_id = per.id
    left join wh_data.dbo.type_of_product_special wh on wh.id = d.id
    

