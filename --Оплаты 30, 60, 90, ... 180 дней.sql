--Оплаты 30, 60, 90, ... 180 дней
--для Лили

declare @plusse time;

Set  @plusse = '23:59:59'

SELECT

	--tab1.DPD,
--	cast(tab1.sign_date as date) 'Дата входа'
	debt.id
	,isnull(sum(tab1.pay30),0) 'Оплаты 30 дней'
	,isnull(sum(tab1.pay60),0) 'Оплаты 60 дней'
	,isnull(sum(tab1.pay90),0) 'Оплаты 90 дней'
	,isnull(sum(tab1.pay120),0) 'Оплаты 120 дней'
	,isnull(sum(tab1.pay150),0) 'Оплаты 150 дней'
	,isnull(sum(tab1.pay180),0) 'Оплаты 180 дней'
	,isnull(debt.start_sum,0) start_sum
	,isnull(debt.total_sum,0) total_sum
	,cast(p.sign_date as date) sign_date
	--isnull(sum(tab1.pay30),0)/sum(tab1.ostatok1) "Эффективность за 30 дней",
	--(isnull(sum(tab1.pay60),0)+isnull(sum(tab1.pay30),0))/sum(tab1.ostatok1) "Эффективность за 60 дней",
	--(isnull(sum(tab1.pay90),0)+isnull(sum(tab1.pay60),0)+isnull(sum(tab1.pay30),0))/sum(tab1.ostatok1) "Эффективность за 90 дней",
	--(isnull(sum(tab1.pay120),0)+isnull(sum(tab1.pay90),0)+isnull(sum(tab1.pay60),0)+isnull(sum(tab1.pay30),0))/sum(tab1.ostatok1) "Эффективность за 120 дней",
	--(isnull(sum(tab1.pay150),0)+isnull(sum(tab1.pay120),0)+isnull(sum(tab1.pay90),0)+isnull(sum(tab1.pay60),0)+isnull(sum(tab1.pay30),0))/sum(tab1.ostatok1) "Эффективность за 150 дней",
	--(isnull(sum(tab1.pay180),0)+isnull(sum(tab1.pay150),0)+isnull(sum(tab1.pay120),0)+isnull(sum(tab1.pay90),0)+isnull(sum(tab1.pay60),0)+isnull(sum(tab1.pay30),0))/sum(tab1.ostatok1) "Эффективность за 180 дней"

FROM
	DEBT
	inner join portfolio p on p.id = debt.r_portfolio_id
	join
/*
	{
*/
		(
		select 
			debt.id id
			,debt.typ typ
			,bank.name bank
			,portfolio.name port
			--,(case 
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)< 30) then   '0000-30'	
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)>31  and  Datediff(day, debt.start_date, portfolio.sign_date)< 60 ) then   '0031-60'
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)>60 and Datediff(day, debt.start_date, portfolio.sign_date)< 90 ) then  '0061-90'
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)>90 and Datediff(day, debt.start_date, portfolio.sign_date)< 120 ) then   '0091-120'
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)>120 and Datediff(day, debt.start_date, portfolio.sign_date)< 150 ) then  '0121-150'
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)>150 and Datediff(day, debt.start_date, portfolio.sign_date)< 180 ) then  '0151-180'
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)>180 and Datediff(day, debt.start_date, portfolio.sign_date)< 270 ) then  '0181-270'
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)>270 and Datediff(day, debt.start_date, portfolio.sign_date)< 360 ) then   '0271-360'
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)>360 and Datediff(day, debt.start_date, portfolio.sign_date)< 540 ) then   '0361-540'
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)>540 and Datediff(day, debt.start_date, portfolio.sign_date)< 720 ) then   '0541-720'
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)>720 and Datediff(day, debt.start_date, portfolio.sign_date)< 1000 ) then   '0721-1000'
			--	when (Datediff(day, debt.start_date, portfolio.sign_date)>1000 and Datediff(day, debt.start_date, portfolio.sign_date)< 1500 ) then   '1000-1500'  
			
			--	else  '1500+' 
			--end) as DPD
			,portfolio.sign_date
			,debt.name dname
			,ost30.ss ostatok30
			,ost60.ss ostatok60
			,ost90.ss ostatok90
			,ost120.ss ostatok120
			,ost150.ss ostatok150
			,ost0.ss ostatok1
			,sum30.ss pay30
			,sum60.ss pay60
			,sum90.ss pay90
			,sum120.ss pay120
			,sum150.ss pay150
			,sum180.ss pay180
			,Datediff(day, debt.start_date, portfolio.sign_date) ddpd
		from 
			debt
			join portfolio on portfolio.id = debt.r_portfolio_id
			join bank  on bank.id = portfolio.parent_id

			left join --1
					( 
					select 
						debt.id id,
						SUM(payment_v.int_sum) ss
					from 
						payment_v
						JOIN debt on debt.id=payment_v.parent_id
						JOIN portfolio on debt.r_portfolio_id=portfolio.id
					where 
						payment_v.calc_date BETWEEN portfolio.sign_date  and (portfolio.sign_date+29+@plusse) 
						and payment_v.is_confirmed=1 and payment_v.is_cancel=0
					group by 
						debt.id
					) sum30 on sum30.id = debt.id

			left join --2 
					( 
					select 
						debt.id id, 
						SUM(payment_v.int_sum) ss
						FROm payment_v
						JOIN debt on debt.id=payment_v.parent_id
						JOIN portfolio on debt.r_portfolio_id=portfolio.id
					where 
						payment_v.calc_date BETWEEN (portfolio.sign_date+30)  and (portfolio.sign_date+59+@plusse) and payment_v.is_confirmed=1 and payment_v.is_cancel=0
					group by 
						debt.id
					) sum60 on sum60.id = debt.id

			left join --3
					( 
					select 
						debt.id id, 
						SUM(payment_v.int_sum) ss
						FROm payment_v
						JOIN debt on debt.id=payment_v.parent_id
						JOIN portfolio on debt.r_portfolio_id=portfolio.id
					where 
						payment_v.calc_date BETWEEN (portfolio.sign_date+60)  and (portfolio.sign_date+89+@plusse) 
						and payment_v.is_confirmed = 1 
						and payment_v.is_cancel = 0
					group by 
						debt.id
					) sum90 on sum90.id = debt.id

			left join --4
					(
					select
						debt.id id, 
						SUM(payment_v.int_sum) ss
					from 
						payment_v
						JOIN debt on debt.id=payment_v.parent_id
						JOIN portfolio on debt.r_portfolio_id=portfolio.id
					where 
						payment_v.calc_date BETWEEN (portfolio.sign_date+90)  and (portfolio.sign_date+119+@plusse) and payment_v.is_confirmed=1 and payment_v.is_cancel=0
					group by 
						debt.id
					) sum120 on sum120.id = debt.id


			left join --5
					( 
					select 
						debt.id id, 
						SUM(payment_v.int_sum) ss
					from payment_v
						JOIN debt on debt.id=payment_v.parent_id
						JOIN portfolio on debt.r_portfolio_id=portfolio.id
					WHERE 
						payment_v.calc_date BETWEEN (portfolio.sign_date+120)  and (portfolio.sign_date+149+@plusse) and payment_v.is_confirmed=1 and payment_v.is_cancel=0
					GROUP BY 
						debt.id
					) sum150 on sum150.id = debt.id

			left join--6
					( 
					select 
						debt.id id, 
						SUM(payment_v.int_sum) ss
					from 
						payment_v
						JOIN debt on debt.id=payment_v.parent_id
						JOIN portfolio on debt.r_portfolio_id=portfolio.id
					WHERE 
						payment_v.calc_date BETWEEN (portfolio.sign_date+150)  and (portfolio.sign_date+180) and payment_v.is_confirmed=1 and payment_v.is_cancel = 0
					GROUP BY 
						debt.id
					) sum180 on sum180.id = debt.id

			Left join 
					(
					SELECT 
						debt.id id,
						(debt_balance_log.debt_sum) ss
					FROM 
						debt
						join portfolio on debt.r_portfolio_id=portfolio.id
						Join bank on portfolio.parent_id = bank.id
						JOIN debt_balance_log on debt_balance_log.parent_id=debt.id
						join 
							( 
							SELECT 
								MAX(debt_balance_log.id) mid 
							FROM 
								debt_balance_log
								join debt on debt.id = debt_balance_log.parent_id
								join portfolio on portfolio.id = debt.r_portfolio_id              
							WHERE 
								debt_balance_log.dt<(portfolio.sign_date +30) 
							GROUP BY 
								debt_balance_log.parent_id

							) b	on b.mid=debt_balance_log.id


						join debt_status_log on debt.id= debt_status_log.parent_id
						join 
							(
							SELECT 
								MAX(debt_status_log.id) mid 
							FROM 
								debt_status_log
								join debt on debt.id = debt_status_log.parent_id
								join portfolio on portfolio.id = debt.r_portfolio_id
	              			where 
								debt_status_log.dt < (portfolio.sign_date +30) 
							group by 
								debt_status_log.parent_id
							) b1 on b1.mid = debt_status_log.id Where debt_status_log.status not in (6,7,8,10)

					)Ost30 on ost30.id = debt.id

			Left join 
					(
					select 
						debt.id id,
						(debt_balance_log.debt_sum) ss
					from 
						debt
						JOIN portfolio on debt.r_portfolio_id=portfolio.id
						Join bank on portfolio.parent_id = bank.id
						JOIN debt_balance_log on debt_balance_log.parent_id=debt.id
						JOIN 
							( 
							SELECT 
								MAX(debt_balance_log.id) mid 
							FROM 
								debt_balance_log
								join debt on debt.id = debt_balance_log.parent_id
								join portfolio on portfolio.id = debt.r_portfolio_id
              
							WHERE 
								debt_balance_log.dt<(portfolio.sign_date +60) 
							GROUP BY 
								debt_balance_log.parent_id
							) b on b.mid=debt_balance_log.id


						join debt_status_log on debt.id= debt_status_log.parent_id
						join 
							(
							select 
								MAX(debt_status_log.id) mid 
							from 
								debt_status_log
								join debt on debt.id = debt_status_log.parent_id
								join portfolio on portfolio.id = debt.r_portfolio_id
              				where 
								debt_status_log.dt< (portfolio.sign_date +60) 
							group by 
								debt_status_log.parent_id
							) b1 on b1.mid = debt_status_log.id Where debt_status_log.status not in (6,7,8,10)

					)Ost60 on ost60.id = debt.id


					Left join 
							(
							SELECT 
								debt.id id,
								(debt_balance_log.debt_sum) ss
							FROM 
								debt
								JOIN portfolio on debt.r_portfolio_id=portfolio.id
								Join bank on portfolio.parent_id = bank.id
								JOIN debt_balance_log on debt_balance_log.parent_id=debt.id
								JOIN 
									( 
									SELECT 
										MAX(debt_balance_log.id) mid 
									FROM 
										debt_balance_log
										join debt on debt.id = debt_balance_log.parent_id
										join portfolio on portfolio.id = debt.r_portfolio_id
              
									WHERE 
										debt_balance_log.dt<(portfolio.sign_date +90) 
									GROUP BY 
										debt_balance_log.parent_id
									) b on b.mid = debt_balance_log.id


								join debt_status_log on debt.id= debt_status_log.parent_id
								join 
									(
									SELECT 
										MAX(debt_status_log.id) mid 
									FROM 
										debt_status_log
										join debt on debt.id = debt_status_log.parent_id
										join portfolio on portfolio.id = debt.r_portfolio_id
              
									WHERE 
										debt_status_log.dt< (portfolio.sign_date +90) 
									GROUP BY 
										debt_status_log.parent_id
									) b1 on b1.mid=debt_status_log.id 
									
							WHERE 
								debt_status_log.status not in (6,7,8,10)								
							)Ost90 on ost90.id = debt.id


							Left join 
									(
									SELECT 
										debt.id id,
										(debt_balance_log.debt_sum) ss
									FROM 
										debt
										JOIN portfolio on debt.r_portfolio_id=portfolio.id
										Join bank on portfolio.parent_id = bank.id
										JOIN debt_balance_log on debt_balance_log.parent_id=debt.id
										JOIN 
											( 
											SELECT 
												MAX(debt_balance_log.id) mid 
											FROM 
												debt_balance_log
												join debt on debt.id = debt_balance_log.parent_id
												join portfolio on portfolio.id = debt.r_portfolio_id
              
											WHERE 
												debt_balance_log.dt<(portfolio.sign_date +120) 
											GROUP BY 
												debt_balance_log.parent_id
											) b on b.mid=debt_balance_log.id


										join debt_status_log on debt.id= debt_status_log.parent_id
										join 
											(
											SELECT 
												MAX(debt_status_log.id) mid 
											FROM 
												debt_status_log
												join debt on debt.id = debt_status_log.parent_id 	
												join portfolio on portfolio.id = debt.r_portfolio_id
              								WHERE 
												debt_status_log.dt< (portfolio.sign_date +120) 
											GROUP BY 
												debt_status_log.parent_id
											) b1 on b1.mid=debt_status_log.id

									WHERE 
										debt_status_log.status not in (6,7,8,10)

									)Ost120 on ost120.id = debt.id

							Left join 
									(
									SELECT 
										debt.id id,
										(debt_balance_log.debt_sum) ss
									FROM 
										debt
										JOIN portfolio on debt.r_portfolio_id=portfolio.id
										Join bank on portfolio.parent_id = bank.id
										JOIN debt_balance_log on debt_balance_log.parent_id=debt.id
										JOIN 
											( 
											SELECT 
												MAX(debt_balance_log.id) mid 
											FROM 
												debt_balance_log
												join debt on debt.id = debt_balance_log.parent_id
												join portfolio on portfolio.id = debt.r_portfolio_id
              
											WHERE 
												debt_balance_log.dt<(portfolio.sign_date +150) 
											GROUP BY 
												debt_balance_log.parent_id
											) b on b.mid=debt_balance_log.id



										join debt_status_log on debt.id= debt_status_log.parent_id
										join 
											(
											SELECT 
												MAX(debt_status_log.id) mid 
											FROM 
												debt_status_log
												join debt on debt.id = debt_status_log.parent_id 	join portfolio on portfolio.id = debt.r_portfolio_id
              								WHERE 
												debt_status_log.dt < (portfolio.sign_date +150) 
											GROUP BY 
												debt_status_log.parent_id
											) b1 on b1.mid=debt_status_log.id
							
										WHERE 
											debt_status_log.status not in (6,7,8,10)

										)Ost150 on ost150.id = debt.id


Left join 
		(
		SELECT 
			debt.id id,
			(debt_balance_log.debt_sum) ss
		FROM 
			debt
			JOIN portfolio on debt.r_portfolio_id=portfolio.id
			JOIN debt_balance_log on debt_balance_log.parent_id=debt.id
			JOIN 
					( 
					SELECT 
						Min(debt_balance_log.id) mid 
					FROM 
						debt_balance_log
						join debt on debt.id = debt_balance_log.parent_id
						join portfolio on portfolio.id = debt.r_portfolio_id
 					GROUP BY 
						debt_balance_log.parent_id
					) b 
					on b.mid=debt_balance_log.id

		)Ost0 	on ost0.id = debt.id


where 
	 debt.id in (628989,
625932,
620392,
620619,
626460,
626601,
439175,
439369,
454746,
558170,
639016,
438991,
590889,
639236,
632615,
628096,
637386,
625119,
608437,
625439,
586344,
714898,
627436,
639114,
630752,
439248,
438854,
631882,
439158,
438856,
438781,
439388,
624861,
438871,
639129,
636862,
628240,
586103,
638150,
630125,
620486,
637030,
608117,
438956,
633637,
608189,
438805,
439230,
628763,
438908,
633543,
438909,
608418,
633582,
637546,
629213,
633573,
620627,
641235,
608291,
627435,
630228,
714985,
553608,
631198,
638832,
639149,
620554,
608387,
629925,
652863,
632833,
633547,
714981,
608325,
637334,
627727,
624363,
627562,
628848,
625362,
633267,
639945,
568961,
629364,
608030,
630714,
714861,
439067,
630358,
459558,
632412,
633620,
591696,
715028,
608237,
620680,
630717,
637516,
640513,
638853,
631060,
455919,
591904,
632074,
608282,
607884,
439014,
714990,
637574,
625016,
460629,
439421,
638931,
460813,
627666,
455934,
637137,
586236,
626543,
556335,
620886,
608183,
608065,
607907,
439267,
438996,
626990,
627297,
631713,
620444,
591599,
438796,
632145,
638717,
453594,
636712,
631725,
552294,
631992,
640453,
556955,
634038,
629317,
631957,
638037,
632654,
632475,
637749,
714860,
608101,
632061,
633570,
627072,
640184,
454279,
438968,
631235,
631385,
638547,
608194,
608436,
457067,
457427,
620926,
633041,
627086,
628261,
637935,
551777,
608040,
627521,
438987,
608062,
628714,
628872,
626051,
439118,
628843,
628734,
628511,
657026,
653594,
659880,
660462,
657636,
629836,
651157,
648810,
628814,
632140,
656469,
653149,
655112,
657077,
657757,
658133,
654178,
649982,
660369,
639670,
655667,
651373,
660598,
629179,
655591,
649435,
658365,
655153,
630317,
657857,
593841,
652458,
651483,
653909,
659009,
659202,
659201,
653456,
639301,
638902,
652371,
655123,
658035,
656938,
650609,
653083,
657714,
655211,
660029,
628952,
714996,
659802,
631530,
714965,
629394,
630025,
628815,
714986,
657208,
650193,
659953,
632780,
638509,
645629,
637186,
658400,
632022,
629417,
649072,
651019,
652243,
657916,
641034,
628549,
626124,
651121,
627180,
650690,
459743,
648875,
649867,
648333,
651233,
632778,
657662,
650672,
629285,
659152,
652337,
630071,
629749,
631474,
556868,
620889,
628929,
654421,
655852,
714966,
655770,
656930,
629207,
629226,
657151,
620824,
630489,
658602,
657781,
649468,
654488,
656943,
658549,
654501,
653479,
638876,
657024,
628435,
630616,
652097,
631287,
626278,
620699,
551233,
655495,
654254,
591867,
656359,
655374,
653695,
649066,
585151,
653399,
653784,
629478,
630256,
633618,
649901,
651251,
631404,
652427,
650220,
558208,
658779,
629492,
657650,
633462,
648394,
658446,
620592,
596960,
453992,
649039,
632136,
631512,
659233,
626144,
655218,
651393,
629370,
652677,
653950,
656990,
651242,
629365,
650238,
651461,
658806,
629516,
633418,
627653,
633508,
620925,
648400,
633087,
625767,
655867,
633516,
633276,
631135,
633265,
626505,
655834,
633503,
649307,
629945,
653493,
628634,
653722,
660606,
657156,
639720,
628316,
636793,
637888,
655640,
608147,
608450,
608462,
658829,
638526,
640475,
608423,
638038,
640785,
608389,
608388,
608283,
651415,
714889,
637315,
608373,
608209,
629063,
637774,
624973,
626937,
625091,
640094,
632494,
608196,
630494,
641145,
640794,
629609,
638056,
625339,
608353,
625384,
641234,
631741,
584507,
641282,
639069,
628533,
607951,
656140,
649220,
632946,
632789,
626287,
655390,
714978,
608417,
626533,
636783,
608177,
658018,
660281,
641012,
638974,
715018,
626116,
608031,
608219,
648972,
655136,
657840,
638896,
641005,
630079,
627849,
628054,
640529,
628269,
628295,
628322,
608461,
569739,
638817,
632972,
657692,
655099,
636875,
628757,
608135,
628728,
636887,
628825,
586370,
638111,
628956,
637535,
653033,
608459,
660058,
639948,
638695,
656552,
608424,
658053,
653753,
654408,
649962,
633404,
569029,
657041,
629954,
636826,
637358,
659729,
659852,
608351,
658709,
653615,
652562,
630642,
649311,
630405,
649226,
628527,
654271,
657660,
630731,
659220,
659704,
650528,
648436,
651292,
620892,
655872,
657219,
630069,
651076,
633440,
649980,
629176,
629401,
653634,
629501,
655473,
653020,
657596,
650579,
640349,
639002,
657152,
633154,
639627,
639449,
639355,
608468,
656377,
656646,
656513,
633043,
638424,
659702,
654149,
633125,
585223,
637512,
639109,
638347,
608191,
645660,
639195,
607993,
624094,
624172,
652994,
608220,
633685,
438857,
626849,
627158,
649222,
551496,
553598,
608340,
457305,
631321,
636771,
631085,
454071,
729495,
660113,
625830,
720195,
720426,
651003,
638067,
725507,
657698,
723606,
654465,
654513,
728798,
715776,
659883,
624588,
656725,
728535,
721906,
718786,
657569,
729337,
658995,
729099,
657964,
729195,
625493,
725505,
651609,
658832,
718724,
657753,
649404,
715529,
656054,
648699,
729573,
651915,
715395,
660471,
656640,
657078,
651048,
660177,
715522,
654855,
728458,
726617,
720524,
625847,
720473,
729850,
625513,
630291,
715432,
632947,
715102,
651558,
624230,
652103,
648958,
720489,
728344,
658436,
653156,
718739,
654875,
648338,
656410,
715137,
624174,
651291,
655642,
652918,
715654,
721439,
657729,
727234,
656690,
656745,
718605,
718750,
653754,
651277,
660529,
727394,
657227,
715896,
624247,
727979,
625018,
624273,
718473,
655923,
650718,
650345,
718594,
624328,
624335,
721803,
625964,
555872,
652082,
640085,
631501,
658444,
658027,
720507,
631170,
719131,
655090,
656228,
649289,
719188,
653225,
624486,
624492,
658131,
625176,
659214,
653672,
721756,
727249,
648598,
650211,
626814,
659187,
658561,
721639,
653764,
624839,
625123,
648253,
658758,
626379,
648562,
719926,
656170,
728717,
645677,
659822,
625098,
625095,
728851,
728392,
720235,
653279,
721437,
720390,
655607,
439258,
650561,
650663,
727817,
652798,
720596,
625460,
720626,
722811,
641037,
631548,
654620,
631035,
722964,
627383,
625794,
652937,
625905,
625970,
553265,
632372,
626115,
558775,
649410,
650107,
653976,
726824,
655235,
727273,
723037,
652149,
729537,
656019,
626547,
728219,
655601,
626620,
651020,
652462,
722059,
728730,
722116,
626837,
620422,
722023,
559395,
625265,
655599,
722099,
656573,
650692,
722169,
637321,
627148,
651025,
722238,
725457,
648799,
726787,
725050,
620605,
626301,
722427,
722460,
722487,
722501,
628061,
654496,
654447,
722699,
724680,
728577,
726229,
559480,
652892,
725555,
629649,
632106,
632041,
650932,
725306,
726077,
657308,
726967,
660258,
723922,
620450,
638375,
652105,
631448,
653862,
632409,
645649,
626921,
632129,
724855,
658090,
620382,
627952,
728110,
725617,
727109,
628300,
632141,
727313,
725801,
727911,
632298,
725861,
725898,
653432,
725974,
629911,
726017,
657541,
631409,
630285,
651680,
630332,
630450,
658304,
728002,
726369,
658271,
631625,
726391,
650808,
658541,
655561,
726875,
654425,
726506,
723684,
658581,
726579,
650237,
584127,
656363,
655463,
654220,
726909,
728126,
726949,
631595,
650340,
727181,
727222,
727214,
727237,
727301,
633458,
728255,
727472,
727521,
637096,
727643,
727608,
727627,
727678,
727701,
632318,
620845,
727913,
653580,
728036,
728069,
728130,
728134,
632637,
728240,
728333,
728341,
656046,
728465,
728482,
632950,
728671,
633397,
727858,
657895,
653144,
648271,
656219,
657191,
660160,
594007,
656301,
595406,
656314,
650510,
629150,
551479,
552428,
552433,
629309,
629345,
655682,
629500,
629687,
629705,
629756,
554052,
655400,
655735,
655885,
660301,
630908,
632897,
632986,
660228,
649241,
656870,
631444,
455487,
650523,
633030,
552344,
655760,
649295,
658569,
640478,
650772,
655551,
651103,
640209,
632544,
658039,
651038,
657952,
640805,
633395,
657267,
660302,
608206,
637115,
655942,
629697,
650979,
629848,
639550,
608228,
629990,
651002,
651672,
659965,
652023,
628849,
639252,
650437,
555313,
639223,
654635,
608149,
641002,
608176,
628136,
650181,
639334,
649133,
657785,
640229,
656442,
638680,
651145,
651782,
657805,
655891,
654180,
639458,
639824,
625466,
655874,
654846,
631476,
650525,
655797,
659890,
654791,
660309,
596965,
637219,
650389,
637247,
657032,
657278,
638309,
656190,
639821,
620683,
640792,
639099,
637729,
640524,
637294,
656367,
638258,
650987,
652306,
629960,
636812,
660373,
659555,
640555,
638930,
639396,
640500,
658683,
638718,
640958,
650143,
651948,
627071,
656052,
657011,
625083,
608335,
638797,
627509,
627150,
656660,
657142,
657015,
629450,
636969,
626703,
649152,
649571,
639712,
658278,
660035,
658863,
608054,
659857,
553611,
659627,
638273,
586390,
639677,
631475,
648251,
629217,
637683,
631613,
637879,
638841,
641135,
639183,
633323,
650821,
660043,
658820,
654363,
658874,
632529,
657539,
650806,
632638,
654598,
626716,
655471,
608394,
632492,
656809,
656001,
658198,
626784,
629821,
620701,
557538,
629577,
652329,
658585,
659209,
608005,
630013,
658980,
651086,
637206,
660455,
608230,
657149,
628594,
620582,
620917,
628784,
631507,
632463,
608430,
638128,
658964,
629812,
659766,
620561,
649212,
625752,
629384,
633420,
649081,
627376,
559948,
637300,
633587,
633627,
553589,
656162,
639076,
629981,
640818,
620643,
630136,
640007,
553469,
630268,
641064,
557001,
656920,
630369,
630461,
639681,
633578,
636835,
556092,
649546,
630965,
628926,
559302,
660137,
637792,
655756,
638688,
620748,
633608,
629746,
624326,
656393,
620503,
637983,
641130,
631487,
640849,
631535,
638410,
633599,
651434,
626700,
608467,
655168,
641101,
633631,
660088,
620841,
632263,
597789,
620920,
658180,
559544,
632940,
633042,
737500,
568560,
659655,
608231,
569949,
718729,
624895,
607854,
650497,
736500,
728280,
632888,
636927,
608421,
625044,
626158,
633322,
637945,
591470,
633082,
626559,
627170,
656806,
457147,
728043,
637239,
626013,
637257,
636919,
584055,
439147,
558312,
626560,
738329,
630755,
631525,
632432,
638086,
631434,
631591,
727414,
633328,
608320,
632292,
632621,
742071,
632856,
633005,
632613,
633313,
648996,
628216,
634363,
592838,
649726,
633448,
628144,
631993,
608427,
629194,
620346,
637136,
631707,
629810,
629495,
607901,
632049,
439053,
620901,
630026,
627697,
632913,
629831,
637756,
637256,
628335,
639921,
438897,
633089,
591706,
628246,
630227,
630044,
640534,
586377,
586400,
570148,
628437,
570213,
638739,
559218,
637263,
633293,
457568,
636786,
631925,
608138,
639315,
629147,
632488,
632819,
632818,
633558,
634314,
727390,
645639,
624384,
625529,
626369,
631305,
729035,
627246,
633228,
641229,
632551,
608245,
608227,
637517,
630818,
726815,
727304,
620809,
632791,
728467,
628748,
633210,
456091,
633277,
633450,
741619,
633721,
624701,
625939,
633086,
631552,
725353,
632119,
632505,
632297,
633467,
632236,
633955,
649455,
714856,
641197,
637647,
652051,
629940,
620896,
631011,
639490,
568561,
629952,
620867,
629585,
714870,
608121,
639147,
628297,
650736,
638054,
639200,
629934,
639338,
728286,
625235,
624643,
624232,
719864,
724869,
637499,
640851,
624874,
639584,
719516,
725021,
641015,
715144,
641184,
729980,
726312,
607834,
718480,
607839,
637324,
650897,
624149,
715136,
719419,
639177,
715409,
636920,
727998,
720550,
581801,
659337,
607875,
639598,
608087,
608093,
625784,
726595,
724801,
638237,
640860,
608326,
608035,
639426,
638533,
725892,
726519,
637123,
639840,
724980,
639455,
657715,
607896,
638148,
657879,
627868,
607902,
636722,
607908,
637533,
608297,
728250,
720274,
639438,
638750,
639344,
659101,
583438,
722817,
720730,
720737,
625789,
625800,
625894,
722934,
641069,
649172,
626055,
721327,
638478,
608045,
626402,
626468,
641019,
640680,
608048,
608384,
628265,
637432,
638323,
725043,
608144,
630554,
728501,
722394,
641110,
725058,
639218,
657663,
640578,
626193,
645655,
722849,
726029,
637271,
727197,
659319,
723364,
723495,
630827,
638722,
657693,
628112,
627588,
723723,
648539,
728317,
627777,
636755,
608302,
727335,
608303,
626343,
725885,
725091,
725295,
727611,
659497,
631386,
726943,
629819,
555831,
726108,
636868,
638447,
726193,
726200,
726205,
727178,
630337,
630425,
639587,
726316,
630846,
630853,
639884,
630995,
632138,
726627,
726678,
631188,
726738,
631463,
726826,
631402,
640046,
631522,
726976,
726950,
640728,
638522,
727636,
630876,
728099,
727484,
727220,
632814,
727925,
631984,
638319,
654193,
727450,
727567,
632121,
727615,
727631,
727721,
727739,
638529,
639323,
727824,
727862,
632411,
727898,
637632,
728117,
728174,
556231,
638163,
632790,
728394,
637396,
728409,
632873,
728510,
632994,
728616,
728627,
633061,
633067,
608428,
648824,
633102,
728725,
728731,
640088,
633291,
633312,
620908,
728825,
633354,
633423,
629683,
626712,
626103,
652214,
638082,
625657,
715876,
724890,
715784,
650982,
721031,
627369,
626809,
726023,
653682,
631108,
608052,
438858,
640247,
629262,
629531,
628359)

		) tab1  on tab1.id = debt.id
/*
	}
*/

GROUP BY 
--	cast(tab1.sign_date as date)
	debt.id
	,debt.start_sum
	,debt.total_sum
	,p.sign_date