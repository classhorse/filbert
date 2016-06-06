--120 report

SELECT DISTINCT
  p.f+' '+p.i+' '+p.o fio,
  debt.contract+' / '+convert(varchar(10),debt.credit_date,104) dogovor,
  bank.name bname,
  (
  select 
    round(debt_sum,2) debt_sum 
  from 
    debt_balance_log
  where 
    id in
      (
      select
        max(id) 
      from 
        debt_balance_log
      where 
        parent_id = payment_v.parent_id
        and dt < [dbo].filbert_report_120(debt.id,payment_v.dt,payment_v.r_user_id)
      )
  ) as debt_sum,

  convert(varchar(10),[dbo].filbert_report_120(debt.id,payment_v.dt,payment_v.r_user_id),104) as date_lock,
  payment_v.sum as paid_sum,
  payment_v.commission / payment_v.sum as apercent,
  payment_v.commission as agent_sum,
  us.agent,
  debt.debt_sum_extra,
  us.dname,
  us.fname as filial,
  --us.viezd,
  payment_v.dt paydate,
  datediff(day,debt.start_date,payment_v.dt) debt_length,
  payment_v.id pid,
  portfolio.name portf_name
FROM 
  debt
  join debt_balance_log on debt_balance_log.parent_id = debt.id
  join person p on debt.parent_id=p.id
  join payment_v on payment_v.parent_id=debt.id
  join 
    (
    select 
      users.id uid,
      users.f+' '+substring(users.i,1,1)+'.'+substring(users.o,1,1) agent,
      department.name dname,
      fil.name fname
      ,sum(case when contact_log.typ in (2, 5) and contact_log.dt between /*:d1*/'01-04-2016' and  /*:d2*/'03-04-2016' then 1 else 0 end) viezd
    from 
      users
      left outer join contact_log on contact_log.r_user_id=users.id
      left outer join department on users.r_department_id=department.dep
      left outer join (select * from dict where parent_id=61) fil on fil.code=users.filial
    where 
      users.position like '%агент%'
    group by 
      users.id,
      users.f+' '+substring(users.i,1,1)+'.'+substring(users.o,1,1),
      department.name,
      fil.name

    )us   on payment_v.r_user_id = us.uid

  join portfolio on debt.r_portfolio_id=portfolio.id
  join bank on portfolio.parent_id=bank.id

WHERE 
  payment_v.dt between '01-04-2016' and '03-04-2016' --:d1 and :d2 
  and payment_v.is_cancel = 0 
  and payment_v.is_confirmed = 1