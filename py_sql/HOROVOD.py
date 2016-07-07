# -*- coding: utf-8 -*-

import pypyodbc
import os
import time
import socket
import getpass


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




print u'Hi ', user, u', welcome to '
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
print (u'''                                        Lestat Kim   v 1.0.2''')
time.sleep(0.014)
color_d()
print (u'''██████████████████████████████████''')

time.sleep(0.07)
color_b()


done = u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''



def Horovod(n):
    global con_str
    global con
    cur = con.cursor()
    sql = '''
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


    insert = u'''
    insert into wh_data.dbo.Filbert_horovod_log_2 (num, hostname, dt)
    values ( '{}', '{}', getdate() )
    '''
    cur.execute(insert.format(n.decode('cp866'), user.decode('cp866')))
    cur.execute(sql.replace('N__', n))
    cur.close()



while True:
    try:
        ask = int(input(u'''

    Update the Campaign's in parts or full ?

    1 - Full
    2 - In parts



    Enter the number:  '''))
        cls()
        if ask == 1:
            ask_1 = int(input(u'''

    Full, excellent! Which one ?

    1 - Outbound_1      5 - Outbound_5
    2 - Outbound_2      6 - Outbound_6
    3 - Outbound_3      7 - Outbound_7
    4 - Outbound_4      8 - Outbound_8



    Enter the number:  '''))

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
                print u'Error  ¯\_(ツ)_/¯'


        elif ask == 2:
            ask_2 = int(input(u'''

    In parts ? Excellent, which one?

    1 - Outbound_1      5 - Outbound_5
    2 - Outbound_2      6 - Outbound_6
    3 - Outbound_3      7 - Outbound_7
    4 - Outbound_4      8 - Outbound_8



    Enter the number  '''))

            cls()

            if ask_2 == 1:
                ask_2_1 = int(input(u'''

    Select an action:

    1 - Sort by last call date
    2 - Remove the closed debts
    3 - Remove fixed debts
    4 - Remove office phone number's
    5 - Remove debts with promises



    Enter the number:   '''))

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
                    print u'Error (◕‿◕)'

            elif ask_2 == 2:
                ask_2_2 = int(input(u'''

    Select an action:

    1 - Sort by last call date
    2 - Remove the closed debts
    3 - Remove fixed debts
    4 - Remove office phone number's
    5 - Remove debts with promises



    Enter the number:   '''))

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
                    print u'Error (✿◠‿◠) '

            elif ask_2 == 3:
                ask_2_3 = int(input(u'''

    Select an action:

    1 - Sort by last call date
    2 - Remove the closed debts
    3 - Remove fixed debts
    4 - Remove office phone number's
    5 - Remove debts with promises



    Enter the number:   '''))

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
                    print u'Error |◔◡◉|'

            elif ask_2 == 4:
                ask_2_4 = int(input(u'''

    Select an action:

    1 - Sort by last call date
    2 - Remove the closed debts
    3 - Remove fixed debts
    4 - Remove office phone number's
    5 - Remove debts with promises



    Enter the number:   '''))

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
                    print u'Error ◉◡◉'

            elif ask_2 == 5:
                ask_2_5 = int(input(u'''

    Select an action:

    1 - Sort by last call date
    2 - Remove the closed debts
    3 - Remove fixed debts
    4 - Remove office phone number's
    5 - Remove debts with promises



    Enter the number:   '''))

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
                    print u'Error (✿｡✿)'

            elif ask_2 == 6:
                ask_2_6 = int(input(u'''

    Select an action:

    1 - Sort by last call date
    2 - Remove the closed debts
    3 - Remove fixed debts
    4 - Remove office phone number's
    5 - Remove debts with promises



    Enter the number:   '''))

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
                    print u'Error (ᵔᴥᵔ)'

            elif ask_2 == 7:
                ask_2_7 = int(input(u'''

    Select an action:

    1 - Sort by last call date
    2 - Remove the closed debts
    3 - Remove fixed debts
    4 - Remove office phone number's
    5 - Remove debts with promises



    Enter the number:   '''))

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
                    print u'Error ( ͡° ͜ʖ ͡°)'

            elif ask_2 == 8:
                ask_2_8 = int(input(u'''

    Select an action:

    1 - Sort by last call date
    2 - Remove the closed debts
    3 - Remove fixed debts
    4 - Remove office phone number's
    5 - Remove debts with promises



    Enter the number:   '''))

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
                    print u'Error (づ｡◕‿‿◕｡)づ '

            else:
                print u'Error ( ́ ◕◞ε◟◕`) '

        else:
            print u'Error (づ￣ ³￣)づ  '
    except ValueError:
        print u'Valid number, please'
