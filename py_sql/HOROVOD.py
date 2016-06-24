# -*- coding: utf-8 -*-
import pypyodbc

con_str = 'Driver={SQL Server};' \
          'Server=192.168.11.9 ;' \
          'Database=i_collect;' \
          'Uid=sa;Pwd=12121212;'

con = pypyodbc.connect(con_str)

print (u'''
█──█─████─████─████─█─█─████─████
█──█─█──█─█──█─█──█─█─█─█──█─█──██
████─█──█─████─█──█─█─█─█──█─█──██
█──█─█──█─█─█──█──█─███─█──█─█──██
█──█─████─█─█──████──█──████─████
                                        Lestat Kim   v.3.0
██████████████████████████████████
''')

l = '__'


def Horovod(n):
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD N__';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD N__',
      @step_name = N'HOROVOD N__',
      @database_name = N'i_collect',
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


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD N__')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill.replace('N__', n))
    cur.commit()
    cur.execute(sql.replace('N__', n))
    cur.commit()
    cur.close()



while True:
    ask = int(input(u'''
Welcome to the system HOROVOD 3.0
Update the campaign's partially of full ?
1 - full
2 - partially

Enter the number: '''))

    if ask == 1:
        ask_1 = int(input(u'''
Full, excellent! Which one ?

1 - Outbound_1      5 - Outbound_5
2 - Outbound_2      6 - Outbound_6
3 - Outbound_3      7 - Outbound_7
4 - Outbound_4      8 - Outbound_8

Enter the number: '''))

        if ask_1 == 1:
            Horovod('1')
            print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
            print l * 28
        elif ask_1 == 2:
            Horovod('2')
            print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
            print l * 28
        elif ask_1 == 3:
            Horovod('3')
            print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
            print l * 28
        elif ask_1 == 4:
            Horovod('4')
            print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
            print l * 28
        elif ask_1 == 5:
            Horovod('5')
            print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
            print l * 28
        elif ask_1 == 6:
            Horovod('6')
            print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
            print l * 28
        elif ask_1 == 7:
            Horovod('7')
            print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
            print l * 28
        elif ask_1 == 8:
            Horovod('8')
            print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
            print l * 28
        else:
            u'Error  ¯\_(ツ)_/¯'


    elif ask == 2:
        ask_2 = int(input(u'''
partially ? Excellent ! Which one?

1 - Outbound_1      5 - Outbound_5
2 - Outbound_2      6 - Outbound_6
3 - Outbound_3      7 - Outbound_7
4 - Outbound_4      8 - Outbound_8

-->'''))

        if ask_2 == 1:
            ask_2_1 = int(input(u'''
Select an action:

1 - Sort by last call date
2 - Remove the closed debts
3 - Remove fixed debts
4 - Remove office phone number's
5 - Remove debts with promises

Enter the number:   '''))

            if ask_2_1 == 1:
                Horovod('11')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_1 == 2:
                Horovod('12')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_1 == 3:
                Horovod('13')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_1 == 4:
                Horovod('14')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_1 == 5:
                Horovod('15')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            else:
                print u'Error (◕‿◕)'

        elif ask_2 == 2:
            ask_2_2 = int(input(u''':
Select an action:

1 - Sort by last call date
2 - Remove the closed debts
3 - Remove fixed debts
4 - Remove office phone number's
5 - Remove debts with promises

Enter the number:   '''))
            if ask_2_2 == 1:
                Horovod('21')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_2 == 2:
                Horovod('22')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_2 == 3:
                Horovod('23')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_2 == 4:
                Horovod('24')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_2 == 5:
                Horovod('25')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
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
            if ask_2_3 == 1:
                Horovod('31')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_3 == 2:
                Horovod('32')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_3 == 3:
                Horovod('33')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_3 == 4:
                Horovod('34')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_3 == 5:
                Horovod('35')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
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
            if ask_2_4 == 1:
                Horovod('41')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_4 == 2:
                Horovod('42')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_4 == 3:
                Horovod('43')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_4 == 4:
                Horovod('44')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_4 == 5:
                Horovod('45')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
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
            if ask_2_5 == 1:
                Horovod('51')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_5 == 2:
                Horovod('52')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_5 == 3:
                Horovod('53')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_5 == 4:
                Horovod('54')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_5 == 5:
                Horovod('55')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
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
            if ask_2_6 == 1:
                Horovod('61')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_6 == 2:
                Horovod('62')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_6 == 3:
                Horovod('63')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_6 == 4:
                Horovod('64')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_6 == 5:
                Horovod('65')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
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
            if ask_2_7 == 1:
                Horovod('71')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_7 == 2:
                Horovod('72')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_7 == 3:
                Horovod('73')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_7 == 4:
                Horovod('74')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_7 == 5:
                Horovod('75')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
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
            if ask_2_8 == 1:
                Horovod('81')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_8 == 2:
                Horovod('82')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_8 == 3:
                Horovod('83')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_8 == 4:
                Horovod('84')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            elif ask_2_8 == 5:
                Horovod('85')
                print u'''
╔╔╗╦╔╗╦╗╔╗
║║║║║║╠╣║║
║╚╝║╚╝╩╝╚╝'''
                print l * 28
            else:
                print u'Error (づ｡◕‿‿◕｡)づ '

        else:
            print u'Error ( ́ ◕◞ε◟◕`) '

    else:
        print u'Error (づ￣ ³￣)づ  '
