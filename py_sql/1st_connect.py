#python_sql

import pypyodbc

connection_string ='Driver={SQL Server Native Client 11.0};' \
                   'Server=192.168.11.9 ;' \
                   'Database=i_collect;' \
                   'Uid=sa;Pwd=12121212;'

connection = pypyodbc.connect(connection_string)
cur = connection.cursor()

r = cur.execute('''
                select
                    *
                from
                    [INFINITY].[Cx_Work].[public].[Table_5036788937]
''')





results = cur.fetchone()


for i in r:
    print (i)

results = cur.fetchone()
connection.close()