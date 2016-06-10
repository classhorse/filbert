import pypyodbc


con_str = 'Driver={SQL Server};' \
          'Server=192.168.11.9 ;' \
          'Database=master;' \
          'Uid=sa;Pwd=12121212;'
con = pypyodbc.connect(con_str)


print('Привет, я робот campaign_cleaner 0.1')
name = input('Как тебя зовут?  ')
print('Привет '+name + '!')

def clean_1_campaign():
    global con_str
    global con
    cur = con.cursor()
    sql = 'execute dbo.clean_dailer_campaign @num = 1'
    cur.execute(sql)
    con.commit()

def clean_2_campaign():
    global con_str
    global con
    cur = con.cursor()
    sql = 'execute dbo.clean_dailer_campaign @num = 2'
    cur.execute(sql)
    con.commit()

def clean_3_campaign():
    global con_str
    global con
    cur = con.cursor()
    sql = 'execute dbo.clean_dailer_campaign @num = 3'
    cur.execute(sql)
    con.commit()

def clean_4_campaign():
    global con_str
    global con
    cur = con.cursor()
    sql = 'execute dbo.clean_dailer_campaign @num = 4'
    cur.execute(sql)
    con.commit()

def clean_5_campaign():
    global con_str
    global con
    cur = con.cursor()
    sql = 'execute dbo.clean_dailer_campaign @num = 5'
    cur.execute(sql)
    con.commit()

def clean_6_campaign():
    global con_str
    global con
    cur = con.cursor()
    sql = 'execute dbo.clean_dailer_campaign @num = 6'
    cur.execute(sql)
    con.commit()



def clean_7_campaign():
    global con_str
    global con
    cur = con.cursor()
    sql = 'execute dbo.clean_dailer_campaign @num = 7'
    cur.execute(sql)
    con.commit()


def clean_8_campaign():
    global con_str
    global con
    cur = con.cursor()
    sql = 'execute dbo.clean_dailer_campaign @num = 8'
    cur.execute(sql)
    con.commit()





while True:
    c = int(input(u'''Какую кампанию мне нужно очистить?:  '''))
    if c == 1:
        print('Начинаю очистку..')
        clean_1_campaign()
        con.close()
        print('Готово!')
    elif c == 2:
        print('Начинаю очистку..')
        clean_2_campaign()
        con.close()
        print('Готово!')
    elif c == 3:
        print('Начинаю очистку..')
        clean_3_campaign()
        con.close()
        print('Готово!')
    elif c == 4:
        print('Начинаю очистку..')
        clean_4_campaign()
        con.close()
        print('Готово!')
    elif c == 5:
        print('Начинаю очистку..')
        clean_5_campaign()
        con.close()
        print('Готово!')
    elif c == 6:
        print('Начинаю очистку..')
        clean_6_campaign()
        con.close()
        print('Готово!')
    elif c == 7:
        print('Начинаю очистку..')
        clean_7_campaign()
        con.close()
        print('Готово!')
    elif c == 8:
        print('Начинаю очистку..')
        clean_8_campaign()
        con.close()
        print('Готово!')
    else:
        print(u'А вот нет такой кампании ¯\_(ツ)_/¯ ')