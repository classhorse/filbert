# coding: utf8
import pypyodbc

con_str = 'Driver={SQL Server};' \
          'Server=192.168.11.9 ;' \
          'Database=i_collect;' \
          'Uid=sa;Pwd=12121212;'

con = pypyodbc.connect(con_str)

print ('''
█──█─████─████─████─█─█─████─████
█──█─█──█─█──█─█──█─█─█─█──█─█──██
████─█──█─████─█──█─█─█─█──█─█──██
█──█─█──█─█─█──█──█─███─█──█─█──██
█──█─████─█─█──████──█──████─████
''')
# print ('Привет, я робот HOROVOD 2.0')
# name = str(input(u'Как тебя зовут? '))
# print ('Привет '+name + '!')

def horovod_1():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
    use msdb
    EXEC dbo.sp_add_job @job_name = N'HOROVOD'

    declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int)


    EXEC sp_add_jobstep
    @job_name = N'Horovod_1',
    @step_name = N'Horovod_1',
    @database_name = N'i_collect',
    @subsystem = N'TSQL',
    @command = N'exec Filbert_HOROVOD 3',
    @retry_attempts = 0,
    @retry_interval = 0 ;

    EXEC dbo.sp_add_schedule
    @schedule_name = N'Ave_Satan',
    @freq_type = 1,
    @active_start_time = @tt ;
    USE msdb ;

    EXEC sp_attach_schedule
    @job_name = N'Ave_Satan',
    @schedule_name = N'Ave_Satan';

    EXEC dbo.sp_add_jobserver
    @job_name = N'Ave_Satan';'''

    cur.execute(sql)
    cur.commit()
    cur.close()
    con.close()

while True:
    ask = int(input('''
Добро пожаловать в систему HOROVOD 2.0
Обновить кампанию полностью или частично ?
1 - полностью
2 - частями

просто напиши цифру: '''))

    if ask == 1:
        ask_1 = int(input('''
Полностью ? отличный выбор !
А какую именно?

1 - Outbound_1      5 - Outbound_5
2 - Outbound_2      6 - Outbound_6
3 - Outbound_3      7 - Outbound_7
4 - Outbound_4      8 - Outbound_8

Номер кампании: '''))

        if ask_1 == 1:
            pass
        elif ask_1 == 2:
            pass
        elif ask_1 == 3:
            pass
        elif ask_1 == 4:
            pass
        elif ask_1 == 5:
            pass
        elif ask_1 == 6:
            pass
        elif ask_1 == 7:
            pass
        elif ask_1 == 8:
            pass
        else:
            'А вот нет у нас такой кампании ¯\_(ツ)_/¯'


    elif ask == 2:
        ask_2 = int(input('''
Частично ? Хорошо ! А какую кампанию именно ?

1 - Outbound_1      5 - Outbound_5
2 - Outbound_2      6 - Outbound_6
3 - Outbound_3      7 - Outbound_7
4 - Outbound_4      8 - Outbound_8

-->'''))

        if ask_2 == 1:
            ask_2_1 = int(input('''
Вот что я могу сделать с первой кампанией:

1 - Сортировать ее по дате   3 - Удалить закрепленные дела за коллегами
2 - Удалить закрытые дела    4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))

            if ask_2_1 == 1:
                pass
            elif ask_2_1 == 2:
                pass
            elif ask_2_1 == 3:
                pass
            elif ask_2_1 == 4:
                pass
            else:
                print 'А вот нет у меня такой задачи (◕‿◕)'

        elif ask_2 == 2:
            ask_2_2 = int(input(''':
Вот что я могу сделать со второй кампанией

1 - Сортировать ее по дате   3 - Удалить закрепленные дела за коллегами
2 - Удалить закрытые дела    4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_2 == 1:
                pass
            elif ask_2_2 == 2:
                pass
            elif ask_2_2 == 3:
                pass
            elif ask_2_2 == 4:
                pass
            else:
                print 'А вот нет у меня такой задачи (✿◠‿◠) '

        elif ask_2 == 3:
            ask_2_3 = int(input('''
Что нужно сделать с третьей кампанией?:
1 - Сортировать ее по дате   3 - Удалить закрепленные дела за коллегами
2 - Удалить закрытые дела    4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_3 == 1:
                pass
            elif ask_2_3 == 2:
                pass
            elif ask_2_3 == 3:
                pass
            elif ask_2_3 == 4:
                pass
            else:
                print 'А вот нет у меня такой задачи |◔◡◉|'

        elif ask_2 == 4:
            ask_2_4 = int(input('''
Что нужно сделать с четвертой кампанией?:
1 - Сортировать ее по дате   3 - Удалить закрепленные дела за коллегами
2 - Удалить закрытые дела    4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_4 == 1:
                pass
            elif ask_2_4 == 2:
                pass
            elif ask_2_4 == 3:
                pass
            elif ask_2_4 == 4:
                pass
            else:
                print 'А вот нет у меня такой задачи ◉◡◉'

        elif ask_2 == 5:
            ask_2_5 = int(input('''
Что нужно сделать с пятой кампанией?:
1 - Сортировать ее по дате   3 - Удалить закрепленные дела за коллегами
2 - Удалить закрытые дела    4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_5 == 1:
                pass
            elif ask_2_5 == 2:
                pass
            elif ask_2_5 == 3:
                pass
            elif ask_2_5 == 4:
                pass
            else:
                print 'А вот нет у меня такой задачи (✿｡✿)'

        elif ask_2 == 6:
            ask_2_6 = int(input('''
Что нужно сделать с шестой кампанией?:
1 - Сортировать ее по дате   3 - Удалить закрепленные дела за коллегами
2 - Удалить закрытые дела    4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_6 == 1:
                pass
            elif ask_2_6 == 2:
                pass
            elif ask_2_6 == 3:
                pass
            elif ask_2_6 == 4:
                pass
            else:
                print 'А вот нет у меня такой задачи (ᵔᴥᵔ)'

        elif ask_2 == 7:
            ask_2_7 = int(input('''
Что нужно сделать с седьмой кампанией?:
1 - Сортировать ее по дате   3 - Удалить закрепленные дела за коллегами
2 - Удалить закрытые дела    4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_7 == 1:
                pass
            elif ask_2_7 == 2:
                pass
            elif ask_2_7 == 3:
                pass
            elif ask_2_7 == 4:
                pass
            else:
                print 'А вот нет у меня такой задачи ( ͡° ͜ʖ ͡°)'

        elif ask_2 == 8:
            ask_2_8 = int(input('''
Что нужно сделать с восьмой кампанией?:
1 - Сортировать ее по дате   3 - Удалить закрепленные дела за коллегами
2 - Удалить закрытые дела    4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_8 == 1:
                pass
            elif ask_2_8 == 2:
                pass
            elif ask_2_8 == 3:
                pass
            elif ask_2_8 == 4:
                pass
            else:
                print 'А вот нет у меня такой задачи (づ｡◕‿‿◕｡)づ '

        else:
            print 'А вот нет у нас такой кампании ( ́ ◕◞ε◟◕`) '

    else:
        print 'А вот нет у меня такой цифры (づ￣ ³￣)づ  '
