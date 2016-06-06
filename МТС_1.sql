--1� ����� ���

declare @SD date = '01-03-2016'
declare @ED date = '07-03-2016'

select
	d.ext_id 'ID ��������',
	per.f+' '+per.i+' '+per.o '��� ��������',
	d.contract '� ���������� ��������',	

	[i_collect].dbo.[FILBERT_zvonok_i_viezd](d.id, @SD, @ED)+' '+[i_collect].dbo.[FILBERT_ivr+sms](d.id, @SD, @ED) '��������, ����������� ������������ �� �������� ������',

	isnull(replace
		((
		case
			when hrka.name = '��� - ����������� / ����������� ������������' then '������� ������������/����. �����������'
			when hrka.name = '��� - ������� / ��� ����������' then '��������� � ���'
			when hrka.name = '��� - ������ / ������ ��� �����' then '����/������ ��� �����'
			when hrka.name = '��� - �������������' then '���������� �� �������������'
			when hrka.name = '��� - ������ �������������' then '������ �������������'
			else hrka.name
		end
		), '��� - ', ''),'') '��������������',

	(case
		when sum(cl.debtor) > 0 then '������� � ��������� ����������'
		when sum(cl.face) > 0 then '������� ���������� � 3-�� �����'
		when sum(cl.nocontact) > 0 then '��� ��������'
		else '��� ��������'
	end) 
		 '������ �������� �� ����� ��������� �������',

	i_collect.dbo.FILBERT_DopInfPhone(per.id, @SD, @ED) '����� ���������� ����������(����� �������)',
	i_collect.dbo.FILBERT_DopInfAddress(per.id, @SD, @ED) '����� ���������� ����������(����� �����)',
	replace(isnull(reason.name,''), '��� - ', '') '������� ������������� �������������'
	
from
	i_collect.dbo.bank as b
	inner join portfolio as p on b.id = p.parent_id
	inner join debt as d on p.id = d.r_portfolio_id
	inner join person as per on d.parent_id = per.id

/*������� ������������� �������������*/
	left join
			(
			select
				d.parent_id,
				name
			from
				debt_dsc_log d
				left join (select
								di.code,
								di.name
							from
								dict di
							where
								di.parent_id = 13
							)di		on d.reason = di.code
			where
				d.id in (
						select
							max(id)
						from
							debt_dsc_log
						group by
							parent_id
						)

			)reason		on d.id = reason.parent_id
	
/*��������������*/
	left join
			(
			select
				ddl.parent_id,
				di.name
			from
				debt_dsc_log ddl
				/*������� (������� ������������� �������������)
				������� ������ ���'������ � ����� ��� �������*/
				left join
						(
						select
							code,name
						from
							dict
						where
							parent_id = 13
							and code in(1000,1001,1002,1003,1004,1005,1006,1007,1008)
						)di		on ddl.reason = di.code

			)hrka		on hrka.parent_id = d.id

/*������ ��������*/
	outer apply
			(
			select distinct
				cl.r_debt_id,				
				count
					(case
						when cl.result in (320712,320607,320616,320608,320609,320714,320635,320704,320636,320637)
						then 1 else 0
					end) debtor,

				count
					(case
						when cl.result not in (320712,320607,320616,320608,320609,320714,320635,320704,320636,320637)
								and cl.result in 
												(320713,320614,320617,320615,320654,320610,320652,320648,
												320649,320650,320651,320715,320640,320705,320641,320711,
												320710,320642,320706,320707,320708,320709)
						then 1 else 0
					end) face,

				count
					(case
						when cl.result not in 
											(320712,320607,320616,320608,320609,320714,320635,320704,320636,320637,
											320713,320614,320617,320615,320654,320610,320652,320648,320649,320650,
											320651,320715,320640,320705,320641,320711,320710,320642,320706,320707,
											320708,320709) or cl.result is null
						then 1 else 0
					end) nocontact
					



					
			from
				contact_log cl
			where
				cl.r_debt_id =  d.id
				and cl.typ = 1
				and cl.dt between @SD and @ED
			group by
				cl.r_debt_id

			)cl



group by
	d.ext_id,
	per.f, per.i, per.o,
	d.contract,
	d.id,
	hrka.name,
	per.id,
	reason.name




