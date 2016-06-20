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

def Horovod(number):
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__N__';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__N__',
      @step_name = N'HOROVOD__N__',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD N__ ',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__N__',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__N__',
      @schedule_name = N'HOROVOD__N__'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__N__';'''

    cur.execute(sql.replace('N__', number))
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
            print 'Начинаю рефакторинг..'
            Horovod('1')
            print 'Готово!'
        elif ask_1 == 2:
            print 'Начинаю рефакторинг..'
            Horovod('2')
            print 'Готово!'
        elif ask_1 == 3:
            print 'Начинаю рефакторинг..'
            Horovod('3')
            print 'Готово!'
        elif ask_1 == 4:
            print 'Начинаю рефакторинг..'
            Horovod('4')
            print 'Готово!'
        elif ask_1 == 5:
            print 'Начинаю рефакторинг..'
            Horovod('5')
            print 'Готово!'
        elif ask_1 == 6:
            print 'Начинаю рефакторинг..'
            Horovod('6')
            print 'Готово!'
        elif ask_1 == 7:
            print 'Начинаю рефакторинг..'
            Horovod('7')
            print 'Готово!'
        elif ask_1 == 8:
            print 'Начинаю рефакторинг..'
            Horovod('8')
            print 'Готово!'
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

1 - Сортировать ее по дате последнего звонка
2 - Удалить закрытые дела
3 - Удалить закрепленные дела за коллегами
4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))

            if ask_2_1 == 1:
                print 'Начинаю рефакторинг..'
                Horovod('11')
                print 'Готово!'
            elif ask_2_1 == 2:
                print 'Начинаю рефакторинг..'
                Horovod('12')
                print 'Готово!'
            elif ask_2_1 == 3:
                print 'Начинаю рефакторинг..'
                Horovod('13')
                print 'Готово!'
            elif ask_2_1 == 4:
                print 'Начинаю рефакторинг..'
                Horovod('14')
                print 'Готово!'
            else:
                print 'А вот нет у меня такой задачи (◕‿◕)'

        elif ask_2 == 2:
            ask_2_2 = int(input(''':
Вот что я могу сделать со второй кампанией

1 - Сортировать ее по дате последнего звонка
2 - Удалить закрытые дела
3 - Удалить закрепленные дела за коллегами
4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_2 == 1:
                print 'Начинаю рефакторинг..'
                Horovod('21')
                print 'Готово!'
            elif ask_2_2 == 2:
                print 'Начинаю рефакторинг..'
                Horovod('22')
                print 'Готово!'
            elif ask_2_2 == 3:
                print 'Начинаю рефакторинг..'
                Horovod('23')
                print 'Готово!'
            elif ask_2_2 == 4:
                print 'Начинаю рефакторинг..'
                Horovod('24')
                print 'Готово!'
            else:
                print 'А вот нет у меня такой задачи (✿◠‿◠) '

        elif ask_2 == 3:
            ask_2_3 = int(input('''
Что нужно сделать с третьей кампанией?:
1 - Сортировать ее по дате последнего звронка
2 - Удалить закрытые дела
3 - Удалить закрепленные дела за коллегами
4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_3 == 1:
                print 'Начинаю рефакторинг..'
                Horovod('31')
                print 'Готово!'
            elif ask_2_3 == 2:
                print 'Начинаю рефакторинг..'
                Horovod('32')
                print 'Готово!'
            elif ask_2_3 == 3:
                print 'Начинаю рефакторинг..'
                Horovod('33')
                print 'Готово!'
            elif ask_2_3 == 4:
                print 'Начинаю рефакторинг..'
                Horovod('34')
                print 'Готово!'
            else:
                print 'А вот нет у меня такой задачи |◔◡◉|'

        elif ask_2 == 4:
            ask_2_4 = int(input('''
Что нужно сделать с четвертой кампанией?:
1 - Сортировать ее по дате последнего звронка
2 - Удалить закрытые дела
3 - Удалить закрепленные дела за коллегами
4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_4 == 1:
                print 'Начинаю рефакторинг..'
                Horovod('41')
                print 'Готово!'
            elif ask_2_4 == 2:
                print 'Начинаю рефакторинг..'
                Horovod('42')
                print 'Готово!'
            elif ask_2_4 == 3:
                print 'Начинаю рефакторинг..'
                Horovod('43')
                print 'Готово!'
            elif ask_2_4 == 4:
                print 'Начинаю рефакторинг..'
                Horovod('44')
                print 'Готово!'
            else:
                print 'А вот нет у меня такой задачи ◉◡◉'

        elif ask_2 == 5:
            ask_2_5 = int(input('''
Что нужно сделать с пятой кампанией?:
1 - Сортировать ее по дате последнего звронка
2 - Удалить закрытые дела
3 - Удалить закрепленные дела за коллегами
4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_5 == 1:
                print 'Начинаю рефакторинг..'
                Horovod('51')
                print 'Готово!'
            elif ask_2_5 == 2:
                print 'Начинаю рефакторинг..'
                Horovod('52')
                print 'Готово!'
            elif ask_2_5 == 3:
                print 'Начинаю рефакторинг..'
                Horovod('53')
                print 'Готово!'
            elif ask_2_5 == 4:
                print 'Начинаю рефакторинг..'
                Horovod('54')
                print 'Готово!'
            else:
                print 'А вот нет у меня такой задачи (✿｡✿)'

        elif ask_2 == 6:
            ask_2_6 = int(input('''
Что нужно сделать с шестой кампанией?:
1 - Сортировать ее по дате последнего звронка
2 - Удалить закрытые дела
3 - Удалить закрепленные дела за коллегами
4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_6 == 1:
                print 'Начинаю рефакторинг..'
                Horovod('61')
                print 'Готово!'
            elif ask_2_6 == 2:
                print 'Начинаю рефакторинг..'
                Horovod('62')
                print 'Готово!'
            elif ask_2_6 == 3:
                print 'Начинаю рефакторинг..'
                Horovod('63')
                print 'Готово!'
            elif ask_2_6 == 4:
                print 'Начинаю рефакторинг..'
                Horovod('64')
                print 'Готово!'
            else:
                print 'А вот нет у меня такой задачи (ᵔᴥᵔ)'

        elif ask_2 == 7:
            ask_2_7 = int(input('''
Что нужно сделать с седьмой кампанией?:
1 - Сортировать ее по дате последнего звронка
2 - Удалить закрытые дела
3 - Удалить закрепленные дела за коллегами
4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_7 == 1:
                print 'Начинаю рефакторинг..'
                Horovod('71')
                print 'Готово!'
            elif ask_2_7 == 2:
                print 'Начинаю рефакторинг..'
                Horovod('72')
                print 'Готово!'
            elif ask_2_7 == 3:
                print 'Начинаю рефакторинг..'
                Horovod('73')
                print 'Готово!'
            elif ask_2_7 == 4:
                print 'Начинаю рефакторинг..'
                Horovod('74')
                print 'Готово!'
            else:
                print 'А вот нет у меня такой задачи ( ͡° ͜ʖ ͡°)'

        elif ask_2 == 8:
            ask_2_8 = int(input('''
Что нужно сделать с восьмой кампанией?:
1 - Сортировать ее по дате последнего звронка
2 - Удалить закрытые дела
3 - Удалить закрепленные дела за коллегами
4 - Удалить рабочие номера телефонов

Введи номер задачи:   '''))
            if ask_2_8 == 1:
                print 'Начинаю рефакторинг..'
                Horovod('81')
                print 'Готово!'
            elif ask_2_8 == 2:
                print 'Начинаю рефакторинг..'
                Horovod('82')
                print 'Готово!'
            elif ask_2_8 == 3:
                print 'Начинаю рефакторинг..'
                Horovod('83')
                print 'Готово!'
            elif ask_2_8 == 4:
                print 'Начинаю рефакторинг..'
                Horovod('84')
                print 'Готово!'
            else:
                print 'А вот нет у меня такой задачи (づ｡◕‿‿◕｡)づ '

        else:
            print 'А вот нет у нас такой кампании ( ́ ◕◞ε◟◕`) '

    else:
        print 'А вот нет у меня такой цифры (づ￣ ³￣)づ  '
