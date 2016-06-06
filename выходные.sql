--select

	sum(cl.kolvo_vseh) as vseh,
	sum(cl.kolvo_kontaktnih) as kont,
	sum(cl.kolvo_musor) as musor

from

	i_collect.dbo.bank as b
	inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
	inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
	inner join i_collect.dbo.person as per on d.parent_id = per.id

	left join
			(
				select					
					cl.r_debt_id,

					count(cl.id) as kolvo_vseh,

					--контактные
					count(case
							when cl.result in
												(--контактные
														1,2, 3,4,5,8,11,12,13,14,15,16,309,310,720,721,722,723,737,738,739,740,
														803,804,805,806,806,807,808,809,813,816,817,818,819,820,821,822,823,824,
														825,826,827,828,829,830,831,832,838,839,840,841,842,20044,120044,120045,
														120048,120153,120154,120155,120156,120160,120162,120165,120166,120167,
														120168,120169,120170,120171,120172,120173,120174,120175,120176,120183,
														120185,120186,120187,120188,120189,120190,120191,120193,120194,120195,
														120196,120197,120198,120199,120200,120201,120202,120205,120206,120207,
														120211,120212,120213,120214,120215,120216,120217,120218,120219,120220,
														120221,120222,120223,120224,120225,120226,120227,120228,120229,120230,
														120231,120232,120233,120234,120235,120236,120237,120240,120241
												)
							then cl.id

						end) as kolvo_kontaktnih,

					--мусор
					count(case
							when cl.result in
												(--мусор
													9,311,312,313,314,315,318,322,323,324,325,
													703,704,833,834,835,836,837,120161,120177,
													120178,120179,120180,120181
												)
							then cl.id
						end) as kolvo_musor


				from			
						
					i_collect.dbo.contact_log as cl

				where

					cl.typ = 1
					and cl.r_user_id != 1
					and cl.dt between '26-12-2015 07:59:59' and '27-12-2015 23:59:59'
					
					and cl.r_debt_id in
										(
											select
											
												cl.r_debt_id

											from
												
												i_collect.dbo.contact_log as cl

											where
												
												cl.typ = 1
												and cl.r_user_id = 1
												and cl.dt between '26-12-2015 07:59:59' and '27-12-2015 23:59:59'

											group by
												
												cl.r_debt_id

										)

				group by
					
					cl.r_debt_id

			)cl		on d.id = cl.r_debt_id