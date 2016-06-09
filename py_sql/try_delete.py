import pypyodbc
con_str = 'Driver={SQL Server Native Client 11.0};' \
          'Server=192.168.11.9 ;' \
          'Database=i_collect;' \
          'Uid=sa;Pwd=12121212;'
con = pypyodbc.connect(con_str)



def try_clean():
    global con_str
    global con
    cur = con.cursor()
    sql = 'delete from python_test_sql'
    cur.execute(sql)
    con.commit()