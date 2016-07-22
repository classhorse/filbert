# -*- coding: utf-8 -*-
import pypyodbc as p
import os
import sys
import codecs
import getpass
from colorama import init
from termcolor import colored
import time
import xlrd
import xlwt
from tkinter import *
sys.stdout = codecs.getwriter('cp866')(sys.stdout,'replace') #подключаем русский язык
init()

cmd_size = lambda : os.system('mode con lines=49')
cls = lambda: os.system('cls')
magenta = lambda: os.system('color d')
white = lambda: os.system('color f')
yellow = lambda: os.system('color e')
green = lambda : os.system('color a')
user = getpass.getuser()

cmd_size()
yellow()

row1 = colored(u'███████ ─── ██████████████████████████████████████████████████','white')
row2 = colored(u'█────██ ─── █───█─██─█───█───█────█────█────█───█───█───█────█','white')
row3 = colored(u'█─██─██ ─── ██─██──█─██─██─███─██─█─██─█─██─█─████─██─███─██─█','blue')
row4 = colored(u'█─█──██ ─── ██─██─█──██─██───█────█────█────█───██─██───█────█','blue')
row5 = colored(u'█─██─██ ─── ██─██─██─██─██─███─█─██─████─█─██─████─██─███─█─██','blue')
row6 = colored(u'█─────█ ─── █───█─██─██─██───█─█─██─████─█─██───██─██───█─█─██','red')
row7 = colored(u'█████─█ ─── ██████████████████████████████████████████████████','red')

bpl = '' #используется для конкатенации (тут банк и портфель)


class QiHi(object):
    """Logo Animation"""

    def qi_rus(self):
        yellow()
        print u'\n\n', row1
        cls()
        print u'\n\n\n', row2
        cls()
        print u'\n\n\n\n', row3
        cls()
        print u'\n\n\n\n\n', row4
        cls()
        print u'\n\n\n\n\n\n', row5
        cls()
        print u'\n\n\n\n\n\n\n', row6
        cls()
        print u'\n\n\n\n\n\n\n\n', row7
        cls()
        print u'\n\n\n\n\n\n\n', row6
        cls()
        print u'\n\n\n\n\n\n', row5
        cls()
        print u'\n\n\n\n\n', row4
        cls()
        print u'\n\n\n\n', row3
        cls()
        print u'\n\n\n', row2
        cls()
        print u'\n\n', row1
        cls()
        print u'\n\n', row1, u'\n', row2
        cls()
        print u'\n\n', row1, u'\n', row2, u'\n', row3
        cls()
        print u'\n\n', row1, u'\n', row2, u'\n', row3, u'\n', row4
        cls()
        print u'\n\n', row1, u'\n', row2, u'\n', row3, u'\n', row4, u'\n', row5
        cls()
        print u'\n\n', row1, u'\n', row2, u'\n', row3, u'\n', row4, u'\n', row5, u'\n', row6
        cls()
        print u'\n\n', row1, u'\n', row2, u'\n', row3, u'\n', row4, u'\n', row5, u'\n', row6, u'\n', row7


class ExecQueryICollect(object):

    """Just exec some Query from db: i_collect"""

    def __init__(self):
        self.con_str = 'Driver={SQL Server};' \
                       'Server=192.168.11.9 ;' \
                       'Database=i_collect;' \
                       'Uid=sa;Pwd=12121212;'
        self.con = p.connect(self.con_str, autocommit=True)
        self.cur = self.con.cursor()

    def i_collect_exec(self, sql):
        self.cur.execute(sql)
        self.cur.close()


class ExecQueryWhData(object):

    """Just exec some Query from db: wh_data"""

    def __init__(self):
        self.con_str = 'Driver={SQL Server};' \
                       'Server=192.168.11.9 ;' \
                       'Database=wh_data;' \
                       'Uid=sa;Pwd=12121212;'
        self.con = p.connect(self.con_str, autocommit=True)
        self.cur = self.con.cursor()

    def wh_data_exec(self, sql):
        self.cur.execute(sql)
        self.cur.close()



bank = u'''
    SELECT DISTINCT
        b.id
        ,N''+ b.name as name
    FROM
        i_collect.dbo.bank as b
        inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
    WHERE
        p.status = 2
    ORDER BY
        N'' + b.name asc
    '''
portfolio = u'''
    SELECT DISTINCT
        p.id
        ,N''+ p.name as name
    FROM
        i_collect.dbo.portfolio p
    WHERE
        p.status = 2
        and p.parent_id {}
    ORDER BY
        N'' + p.name asc
    '''

phone_typ = u'''
    select
        di.code
        ,N''+ di.name name
    from
        i_collect.dbo.dict di
    where
        parent_id = 4'''

class QueryICollect(object):

    """SQL Query from Database: i_collect"""

    def __init__(self, sql):
        self.con_str = 'Driver={SQL Server};' \
                       'Server=192.168.11.9 ;' \
                       'Database=i_collect;' \
                       'Uid=sa;Pwd=12121212;'
        self.con = p.connect(self.con_str, autocommit=True)
        self.cur = self.con.cursor()
        self.r = self.cur.execute(sql)
        self.column_list = [tuple[0] for tuple in self.r.description]
        self.res = self.r.fetchall()

    @property
    def one(self):
        print self.column_list[0]
        for i in self.res:
            print i[0]
        self.cur.close()

    @property
    def two(self):
        print self.column_list[0], ' ', self.column_list[1]
        for i in self.res:
            print i[0], ' ', i[1]
        self.cur.close()


class QueryWhData(object):

    """SQL Query from Database: wh_data"""

    #TODO реализовать хранилище данных с типом продукта
    product = '''
    blah blah blah
    '''

    def __init__(self, sql):
        self.con_str = 'Driver={SQL Server};' \
                       'Server=192.168.11.9 ;' \
                       'Database=wh_data;' \
                       'Uid=sa;Pwd=12121212;'
        self.con = p.connect(self.con_str, autocommit=True)
        self.cur = self.con.cursor()
        self.r = self.cur.execute(sql)
        self.column_list = [tuple[0] for tuple in self.r.description]
        self.res = self.r.fetchall()

    @property
    def one(self):
        print self.column_list[0]
        for i in self.res:
            print i[0]
        self.cur.close()

    @property
    def two(self):
        print self.column_list[0], ' ', self.column_list[1]
        for i in self.res:
            print i[0], ' ', i[1]
        self.cur.close()



class ModuleList(object):

    """concatenate behavior part of SQL queries"""

    first_query = None

    def __init__(self):
        self.try_dict = {

            'prom': [u'''
    inner join
            (
            select
                dp.parent_id
            from
                i_collect.dbo.debt_promise as dp
                left join
                        (
                            select
                                dp2.id as id
                                ,(case
                                    when (dp2.prom_sum is not null)
                                    then 1
                                    else 0
                                end) as kol_ob
                            from
                                i_collect.dbo.debt_promise as dp2
                            group by
                                dp2.id,
                                dp2.prom_sum
                        )dp2    on dp2.id=dp.id
            where
                dp.dt %s
            group by
                dp.parent_id
            having
                sum(dp2.kol_ob) %s
            )dp
                on d.id = dp.parent_id\n''',
                     colored(u'даты регистрации и количество обещаний ', 'green'),
                     (colored(u'даты регистрации', 'magenta'),
                      colored(u'количество', 'magenta'))]

            , 'miss_prom': [u'''
    inner join
            (
            select
                dp.parent_id
            from
                i_collect.dbo.debt_promise as dp
            where
                (dp.cover_sum = 0 or dp.cover_sum is null)
                and dp.dt %s
            group by
                dp.parent_id
            having count(dp.id) %s
            )dp_miss
                on dp_miss.parent_id = d.id\n''',
                            colored(u'даты и количество пропущенных обещаний', 'green'),
                            (colored(u'даты', 'magenta'),
                             colored(u'количество', 'magenta'))]

            , 'calc': [u'''
    inner join
            (
            select
                dc.parent_id
            from
                [i_collect].[dbo].[debt_calc] as dc
                left join(
                    select
                        dc2.id as id
                        ,(case
                            when(
                                dc2.int_sum is not null
                                and dc2.is_confirmed = 1
                                and dc2.is_cancel = 0
                            )
                            then dc2.int_sum
                            else 0
                            end
                        ) as PP_sum
                        ,(case
                            when(
                                dc2.int_sum is not null
                                and dc2.is_confirmed = 1
                                and dc2.is_cancel = 0
                            )
                            then 1
                            else 0
                            end
                        ) as PP_kolvo
                    from
                        [i_collect].[dbo].[debt_calc] as dc2
                    group by
                        dc2.is_confirmed,
                        dc2.int_sum,
                        dc2.id,
                        dc2.is_cancel
                ) dc2
                    on dc2.id=dc.id
                where
                    dc.calc_date %s
                group by
                    dc.parent_id
                having
                    sum(dc2.PP_kolvo) %s
                    and sum(dc2.PP_sum) %s
            )dc
                on dc.parent_id = d.id''',
                       colored(u'даты оплат, суммы и количество', 'green'),
                       (colored(u'даты', 'magenta'),
                        colored(u'суммы', 'magenta'),
                        colored(u'количество', 'magenta'))]

            , 'phone': [u'''
    inner join
            (
            /*return parametres phone numbers*/
            select
                ph.parent_id
                ,ph.number
            from
                i_collect.dbo.phone ph
            where
                ph.typ %s
                and ph.status %s
            )ph
                on ph.parent_id = per.id''',
                        colored(u'тип телефона и статус', 'green'), (colored(u'''
1   Мобильный
2   Домашний
3   Рабочий
4   Дополнительный
41  Поручитель-Мобильный
42  Поручитель-Домашний
43  Поручитель-Рабочий
104 Поручитель-Дополнительный
201 Залогодатель-Мобильный
202 Залогодатель-Домашний
203 Залогодатель-Рабочий
204 Залогодатель-Дополнительный
31  Моб.Третье лицо
32  Дом.Третье лицо
33  Раб. Третье лицо
44  Суд Приставы
34  Доп. Третье лицо
205 Созаемщик-Мобильный
206 Созаемщик-Рабочий

тип телефона''', 'magenta'), colored(u'''
1   Не звонили ни разу
2   Результата не было
3   Неверный номер
4   Результат
5   Последний результат
6   Автоинформатор

статус телефона''', 'magenta'))]

            , 'perspect': [u'''
inner join
        (
        select
            c.r_debt_id
        from
            contact_log c
        where
            c.typ in (1,3)
            and c.dt %s
            and cl.result in(
            1,2,4,5,11,12,14,15,16,201,202,204,207,208,210,212,213,706,
            707,712,714,715,717,718,719,720,721,723,726,729,737,738,739,
            740,816,817,818,819,820,821,824,825,826,838,839,840,842,861,
            862,863,865,866,867,868,870,874,875,877,880,120154,120155,
            120156,120183,120186,120187,120188,120189,120190,120191,120193,
            120194,120197,120198,120199,120200,120201,120202,120205,120206,
            120207,120214,120215,120216,120217,120218,120221,120222,120223,
            120224,120225,120226,120227,120228,120231,120233,120234,120235,
            120237,120239,120240,120241,320157,320161,320272,320273,320274,
            320280,320283,320284,320287,320297,320300,320301,320304,320310,
            320311,320313,320316,320317,320318,320319,320320,320322,320712,
            320607,320616,320609,320713,320614,320617,320610,320714,320635,
            320704,320637,320715,320640,320705,320710,321084,321023,321024,
            21025,321137,321138,321139,321140,321057,321034,321032,321028,
            321035,321033,321031,321027,321142,321143,321144,321145,321083,
            321078,321073,321085,321082,321077,321072,321062,321081,321076,
            321071,321061,321147,321148,321149,321150,321080,321075,321070,
            321086,321079,321074,321069,321060,321022,321021,321020,321017,
            321152,321153,321154,321155,320879,320880,320881,320882,320929,
            320927,320925,320930,320928,320926,320924,320921,321158,321159,
            321160,321161,320920,320919,320918,321157,320917,320916,320915,
            320912,320910,320909,320908,320905,321164,321165,321166,321167,
            320903,320902,320901,321163,320900,320899,320898,320895,320893,
            320892,320891,320888,321226,321225,321223,321224,321221,321220,
            321219,321218,321215,320936,320938,320932,321213,321212,321211,
            321210,321209,321208,321207,321206,321205,321202,321200,321199,
            321198,321195,321183,321181,321179,321178,321177,321176,321175,
            321174,321173,320935,320937,320931
            --феникс
            ,321513,321457,321458,321459,321486,321484,321482,321462,321485,
            321483,321465,321461,321512,321507,321502,321514,321511,321506,
            321501,321491,321510,321505,321500,321490,321509,321504,321499,
            321515,321508,321503,321498,321489,321456,321455,321454,321451
            --МТС
            ,320712,320607,320616,320609,320713,320614,320617,320610,320714,
            320635,320704,320637,320715,320640,320705,320710)
            )
        group by
            c.r_debt_id
        having count(c.id) %s
        )persp
            on persp.r_debt_id = d.id\n''',
                            colored(u'даты и количество '
                                    u'перспективных контактов по долгу', 'green'),
                            (colored(u'даты', 'magenta'), colored(u'количество', 'magenta'))]

        }

        self.concate = u'''
SELECT top 10
    count(d.id)
FROM
    i_collect.dbo.bank as b
    inner join i_collect.dbo.portfolio as p on b.id = p.parent_id
    inner join i_collect.dbo.debt as d on p.id = d.r_portfolio_id
    inner join i_collect.dbo.person as per on d.parent_id = per.id
'''


    def concatenator(self):

        """ concatenate SQL parts """

        print colored(u'\nТеперь выбираем модули\nПросто напиши '
                      u'через запятую модули, которые будешь использовать\n\n\n' , 'green')
        for k, v in sorted(self.try_dict.items()):
            print '\n', k, colored('-', 'magenta'), v[1]

        r = raw_input(colored(u'\n\n\n\nimport: ', 'magenta'))
        print u'\n'
        r = r.replace(' ', '').split(',')

        result_query = self.concate
        for module in r:
            if module in self.try_dict:
                query, description, fields = self.try_dict[module]
                params = []
                print description
                for field in fields:
                    value = raw_input('%s : ' % field)
                    params.append(value)
                query = query % tuple(params)
                result_query = u'\n'.join([result_query, query])
        self.first_query = result_query
        return result_query


class Predicats(object):

    """Show simple predicats"""

    def show_predicats(self):
            print colored(u'\n\nПриветствую тебя', 'yellow')\
                , user, colored(u'\nДобро пожаловать в '
                                u'систему Q-Interpreter 0.1\n', 'yellow')
            print colored(u'\n\n\n\n\nИспользуй стандартные '
                          u'SQL предикаты для параметризации, такие как:\n','green')
            print colored(u'in', 'magenta')\
                ,u'список, например', \
                colored('in (49, 14)', 'magenta')
            print colored(u'not in', 'magenta'), u'список исключений, например', \
                colored(u'not in (6,7,8,10)', 'magenta')
            print colored(u'=', 'magenta'), u'равно'
            print colored(u'!=', 'magenta'), u'не равно'
            print colored(u'>', 'magenta'), u'больше'
            print colored(u'<', 'magenta'), u'меньше'
            print colored(u'>=', 'magenta'), u'больше или равно'
            print colored(u'<=', 'magenta'), u'меньше или равно'
            print colored(u'!<', 'magenta'), u'не меньше'
            print colored(u'!>', 'magenta'), u'не больше'
            print colored(u'between', 'magenta')\
                , u"между, например", colored(u"between '01-01-2015' "
                                              u"and 07-07-2016", 'magenta')


class FirstStepAfterAnimation(object):

    """Ask junior about start the Q-Interpreter"""

    cmd_off = lambda: os.system('tskill cmd')

    def __init__(self):
        self.ask_continue = raw_input(u'\n\n\nПродолжаем? y \ n:   ')


    def start_or_not(self):
        if self.ask_continue == u'n' or self.ask_continue == u'N':
            print u'До новых встреч!'
            exit()
            self.cmd_off()
        else:
            cls()


class ForTheStartWeMust(object):

    """Print what we gonna do"""

    start = u'\n\nДля начала мы выберем Банк(-и) и Портфель(-и)\n'

    def start_func(self):
        print colored(self.start, 'green')
        time.sleep(1.4)




class BankAndPortfParam(object):

    """Param bank and portfolio string for concatenate"""

    bank_list = u'\nWHERE\n     b.id {}\n'  # первое условие со списком банков
    portfolio_list = u'     and p.id {0}\n'  # условие
    bank_inp = None
    port_inp = None


    def bank(self):
        global bpl
        print QueryICollect(bank).two  # показываем список открытых банков
        bank_input = raw_input(colored(u'\nБанк(-и):   ', 'magenta'))  # выбираем список банков
        bpl += self.bank_list.format(bank_input)
        cls()

        print QueryICollect(portfolio.format(bank_input)).two  # показываем список портфелей выбранных банков
        self.port_inp = raw_input(colored(u'\nПортфель(-и):  ', 'magenta'))  # выбираем список портфелей
        bpl += self.portfolio_list.format(self.port_inp)
        cls()

    def ret(self):
        return bpl




#TODO тут будет второй concatenator

class ModuleList2(object):

    """concatenate application* part of SQL queries"""

    first_query = None

    def __init__(self):
        self.try_dict = {

        'bank_dpd': [u'     and ', colored(u'банковская просрочка', 'green'),
                     (colored(u'даты', 'magenta'), colored(u'количество', 'magenta'))]

        }

    def concatenator_2(self):
        """ concatenate SQL parts """

        print colored(u'\nТеперь выбираем модули\nПросто напиши через запятую модули, которые будешь использовать\n\n\n',
                      'green')
        for k, v in sorted(self.try_dict.items()):
            print '\n', k, colored('-', 'magenta'), v[1]

        r = raw_input(colored(u'\n\n\n\nimport: ', 'magenta'))
        print u'\n'
        r = r.replace(' ', '').split(',')

        result_query = self.concate
        for module in r:
            if module in self.try_dict:
                query, description, fields = self.try_dict[module]
                params = []
                print description
                for field in fields:
                    value = raw_input('%s : ' % field)
                    params.append(value)
                query = query % tuple(params)
                result_query = u'\n'.join([result_query, query])
        self.first_query = result_query
        return result_query


def Main():

    """Start Main() of Q-Interpreter"""


    QiHi().qi_rus()  #Animnation
    Predicats().show_predicats() #показываем SQL предикаты
    FirstStepAfterAnimation().start_or_not() #продолжаем работать с программой
    ForTheStartWeMust().start_func() #показываем для начала выбрать банк и портфель
    BankAndPortfParam().bank() #выбираем банки и портфели



    x = ModuleList().concatenator() + bpl
    print x


if __name__ == '__main__':
    Main()