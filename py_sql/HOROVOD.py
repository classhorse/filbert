# -*- coding: utf-8 -*-

import pypyodbc
import os
import time
import getpass
import sys
import codecs
sys.stdout = codecs.getwriter('cp866')(sys.stdout,'replace')
from colorama import init
from termcolor import colored
init()


class Query(object):

    """SQL Query from Database: i_collect"""
    job = """
   select distinct
    sj.name Name
    ,sjh.run_date Date
    ,sjh.run_time Time
    ,iif(sjs.last_run_outcome = 0, 'Error!!! make a pause', 'Wait') Status
from
    msdb.dbo.sysjobs sj
    left join msdb.dbo.sysjobhistory sjh on sj.job_id = sjh.job_id
    left join msdb.dbo.sysjobservers sjs on sj.job_id = sjs.job_id
where
    sj.name like 'HOROVOD%'

    """
    def __init__(self):
        self.con_str = 'Driver={SQL Server};' \
                       'Server=192.168.11.9 ;' \
                       'Database=msdb;' \
                       'Uid=sa;Pwd=12121212;'
        self.con = pypyodbc.connect(self.con_str, autocommit=True)
        self.cur = self.con.cursor()
        self.r = self.cur.execute(self.job)
        self.column_list = [tuple[0] for tuple in self.r.description]
        self.res = self.r.fetchall()

    def three(self):
        print self.column_list[0], '        ',  self.column_list[1], ' ',self.column_list[2], ' ', self.column_list[3]
        for i in self.res:
            print i[0], '   ', i[1], '      ', i[2], '     ', i[3]
        self.cur.close()


con_str = 'Driver={SQL Server};' \
          'Server=192.168.11.9 ;' \
          'Database=wh_data;' \
          'Uid=sa;Pwd=12121212;'
con = pypyodbc.connect(con_str, autocommit=True)

cls = lambda: os.system('cls')
color_a = lambda: os.system('color a') #зеленый
color_b = lambda: os.system('color b') #голубой
color_c = lambda: os.system('color c') #красный
color_d = lambda: os.system('color d') #лиловый
color_e = lambda: os.system('color e') #желтый
color_9 = lambda: os.system('color 9') #синий

color_b()
user = getpass.getuser()




print colored(u'Привет', 'cyan'), user, colored(u', Добро пожаловать в систему ', 'cyan')
time.sleep(1.4)

color_a()
print (u'''
██████████████████████████████████
''')
time.sleep(0.014)
color_b()
print (u'''█──█─████─████─████─█─█─████─████''')
time.sleep(0.014)
color_c()
print (u'''█──█─█──█─█──█─█──█─█─█─█──█─█──██''')
time.sleep(0.014)
color_d()
print (u'''████─█──█─████─█──█─█─█─█──█─█──██''')
time.sleep(0.014)
color_e()
print (u'''█──█─█──█─█─█──█──█─███─█──█─█──██''')
time.sleep(0.014)
color_9()
print (u'''█──█─████─█─█──████──█──████─████''')
time.sleep(0.014)
color_a()
print (u'''                                        Автор: Лестат | Версия 1.4''')
time.sleep(0.014)
color_d()
print (u'''██████████████████████████████████''')

time.sleep(0.07)
color_b()


done = colored(u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝''', 'green')



def Horovod(n):
    global con_str
    global con
    cur = con.cursor()
    sql = u'''
      use msdb
      EXEC dbo.sp_add_job
      @job_name = N'HOROVOD N__',
      @delete_level = 1

      ;declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD N__',
      @step_name = N'HOROVOD N__',
      @database_name = N'wh_data',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD N__',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD N__',
      @freq_type = 1,
      @active_start_time = @tt;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD N__',
      @schedule_name = N'HOROVOD N__'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD N__';'''

    kill = u'''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD N__')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    insert = u'''
    insert into wh_data.dbo.Filbert_horovod_log_2 (num, hostname, dt)
    values ( '{}', '{}', getdate() )
    '''
    cur.execute(kill.replace('N__', n))
    cur.execute(insert.format(n.decode('cp866'), user.decode('cp866')))
    cur.execute(sql.replace('N__', n))
    cur.close()



while True:
    try:
        ask = int(input(colored(u'''

    Обновить кампанию полностью или частично ?

    1 - Полностью

    2 - Частично

    3 - Список роботов



    Введите номер:  ''', 'cyan')))
        cls()
        if ask == 1:
            ask_1 = int(input(colored(u'''

    Полностью ? Отлично! Какую именно?

    1 - Outbound_1      5 - Outbound_5
    2 - Outbound_2      6 - Outbound_6
    3 - Outbound_3      7 - Outbound_7
    4 - Outbound_4      8 - Outbound_8



    Введите номер:  ''', 'white')))

            cls()

            if ask_1 == 1:
                Horovod('1')
                print done
            elif ask_1 == 2:
                Horovod('2')
                print done
            elif ask_1 == 3:
                Horovod('3')
                print done
            elif ask_1 == 4:
                Horovod('4')
                print done
            elif ask_1 == 5:
                Horovod('5')
                print done
            elif ask_1 == 6:
                Horovod('6')
                print done
            elif ask_1 == 7:
                Horovod('7')
                print done
            elif ask_1 == 8:
                Horovod('8')
                print done
            else:
                print colored(u'Error  ¯\_(ツ)_/¯', 'red')


        elif ask == 2:
            ask_2 = int(input(colored(u'''

    Частично? Отлично! Какую именно?

    1 - Outbound_1      5 - Outbound_5
    2 - Outbound_2      6 - Outbound_6
    3 - Outbound_3      7 - Outbound_7
    4 - Outbound_4      8 - Outbound_8



    Введите номер:  ''', 'cyan')))

            cls()

            if ask_2 == 1:
                ask_2_1 = int(input(colored(u'''

    Введите действие:

    1 - Отсортировать по последней дате звонка
    2 - Удалить закрытые долги
    3 - Удалить закрепленные долги
    4 - Удалить рабочие номера телефонов с учетом часового пояса
    5 - Удалить долги с обещаниями



    Введите номер:   ''', 'cyan')))

                cls()

                if ask_2_1 == 1:
                    Horovod('11')
                    print done
                elif ask_2_1 == 2:
                    Horovod('12')
                    print done
                elif ask_2_1 == 3:
                    Horovod('13')
                    print done
                elif ask_2_1 == 4:
                    Horovod('14')
                    print done
                elif ask_2_1 == 5:
                    Horovod('15')
                    print done
                else:
                    print colored(u'Error  ¯\_(ツ)_/¯', 'red')

            elif ask_2 == 2:
                ask_2_2 = int(input(colored(u'''

    Введите действие:

    1 - Отсортировать по последней дате звонка
    2 - Удалить закрытые долги
    3 - Удалить закрепленные долги
    4 - Удалить рабочие номера телефонов с учетом часового пояса
    5 - Удалить долги с обещаниями



    Введите номер:   ''', 'cyan')))

                cls()

                if ask_2_2 == 1:
                    Horovod('21')
                    print done
                elif ask_2_2 == 2:
                    Horovod('22')
                    print done
                elif ask_2_2 == 3:
                    Horovod('23')
                    print done
                elif ask_2_2 == 4:
                    Horovod('24')
                    print done
                elif ask_2_2 == 5:
                    Horovod('25')
                    print done
                else:
                    print colored(u'Error  ¯\_(ツ)_/¯', 'red')

            elif ask_2 == 3:
                ask_2_3 = int(input(colored(u'''

    Введите действие:

    1 - Отсортировать по последней дате звонка
    2 - Удалить закрытые долги
    3 - Удалить закрепленные долги
    4 - Удалить рабочие номера телефонов с учетом часового пояса
    5 - Удалить долги с обещаниями



    Введите номер:   ''', 'cyan')))

                cls()

                if ask_2_3 == 1:
                    Horovod('31')
                    print done
                elif ask_2_3 == 2:
                    Horovod('32')
                    print done
                elif ask_2_3 == 3:
                    Horovod('33')
                    print done
                elif ask_2_3 == 4:
                    Horovod('34')
                    print done
                elif ask_2_3 == 5:
                    Horovod('35')
                    print done
                else:
                    print colored(u'Error  ¯\_(ツ)_/¯', 'red')

            elif ask_2 == 4:
                ask_2_4 = int(input(colored(u'''

    Введите действие:

    1 - Отсортировать по последней дате звонка
    2 - Удалить закрытые долги
    3 - Удалить закрепленные долги
    4 - Удалить рабочие номера телефонов с учетом часового пояса
    5 - Удалить долги с обещаниями



    Введите номер:   ''','cyan')))

                cls()

                if ask_2_4 == 1:
                    Horovod('41')
                    print done
                elif ask_2_4 == 2:
                    Horovod('42')
                    print done
                elif ask_2_4 == 3:
                    Horovod('43')
                    print done
                elif ask_2_4 == 4:
                    Horovod('44')
                    print done
                elif ask_2_4 == 5:
                    Horovod('45')
                    print done
                else:
                    print colored(u'Error  ¯\_(ツ)_/¯', 'red')

            elif ask_2 == 5:
                ask_2_5 = int(input(colored(u'''

    Введите действие:

    1 - Отсортировать по последней дате звонка
    2 - Удалить закрытые долги
    3 - Удалить закрепленные долги
    4 - Удалить рабочие номера телефонов с учетом часового пояса
    5 - Удалить долги с обещаниями



    Введите номер:   ''', 'cyan')))

                cls()

                if ask_2_5 == 1:
                    Horovod('51')
                    print done
                elif ask_2_5 == 2:
                    Horovod('52')
                    print done
                elif ask_2_5 == 3:
                    Horovod('53')
                    print done
                elif ask_2_5 == 4:
                    Horovod('54')
                    print done
                elif ask_2_5 == 5:
                    Horovod('55')
                    print done
                else:
                    print colored(u'Error  ¯\_(ツ)_/¯', 'red')

            elif ask_2 == 6:
                ask_2_6 = int(input(colored(u'''

    Введите действие:

    1 - Отсортировать по последней дате звонка
    2 - Удалить закрытые долги
    3 - Удалить закрепленные долги
    4 - Удалить рабочие номера телефонов с учетом часового пояса
    5 - Удалить долги с обещаниями



    Введите номер:   ''', 'cyan')))

                cls()

                if ask_2_6 == 1:
                    Horovod('61')
                    print done
                elif ask_2_6 == 2:
                    Horovod('62')
                    print done
                elif ask_2_6 == 3:
                    Horovod('63')
                    print done
                elif ask_2_6 == 4:
                    Horovod('64')
                    print done
                elif ask_2_6 == 5:
                    Horovod('65')
                    print done
                else:
                    print colored(u'Мимо! попробуй еще раз (= ', 'red')

            elif ask_2 == 7:
                ask_2_7 = int(input(colored(u'''

    Введите действие:

    1 - Отсортировать по последней дате звонка
    2 - Удалить закрытые долги
    3 - Удалить закрепленные долги
    4 - Удалить рабочие номера телефонов с учетом часового пояса
    5 - Удалить долги с обещаниями



    Введите номер:   ''','cyan')))

                cls()

                if ask_2_7 == 1:
                    Horovod('71')
                    print done
                elif ask_2_7 == 2:
                    Horovod('72')
                    print done
                elif ask_2_7 == 3:
                    Horovod('73')
                    print done
                elif ask_2_7 == 4:
                    Horovod('74')
                    print done
                elif ask_2_7 == 5:
                    Horovod('75')
                    print done
                else:
                    print colored(u'Error  ¯\_("/)_/¯', 'red')

            elif ask_2 == 8:
                ask_2_8 = int(input(colored(u'''

    Введите действие:

    1 - Отсортировать по последней дате звонка
    2 - Удалить закрытые долги
    3 - Удалить закрепленные долги
    4 - Удалить рабочие номера телефонов с учетом часового пояса
    5 - Удалить долги с обещаниями



    Введите номер:   ''', 'cyan')))

                cls()

                if ask_2_8 == 1:
                    Horovod('81')
                    print done
                elif ask_2_8 == 2:
                    Horovod('82')
                    print done
                elif ask_2_8 == 3:
                    Horovod('83')
                    print done
                elif ask_2_8 == 4:
                    Horovod('84')
                    print done
                elif ask_2_8 == 5:
                    Horovod('85')
                    print done
                else:
                    print colored(u'Error  ¯\_("/)_/¯', 'red')

            else:
                print colored(u'Мимо! попробуй еще раз (= ', 'red')        

        elif ask == 3:
            print colored(u'''

Робот номер 54, расшифровывается вот так:
5 - это номер кампании, 4 это действие (удаление рабочих)

Если робот сработал успешно - он удалится.

Если Status = Wait, значит он выполняется
Если Status = Error, значит вы не выждали паузу,
и робот не может выполнить задачу

Попробуйте выполнить его еще раз (:\n\n''', 'cyan')

            print colored(Query().three(), 'magenta')

        else:
            print colored(u'Error  ¯\_("/)_/¯', 'red')
    except ValueError:
        print colored(u'Error  ¯\_("/)_/¯', 'red')
