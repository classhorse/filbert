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
                                        Lestat Kim   v.0.3
██████████████████████████████████
''')
# print ('Привет, я робот HOROVOD 2.0')
# name = str(input(u'Как тебя зовут? '))
# print ('Привет '+name + '!')



def Horovod_1():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__1';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__1',
      @step_name = N'HOROVOD__1',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 1',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__ONE',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__1',
      @schedule_name = N'HOROVOD__1'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__1';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__1')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_11():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__11';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__11',
      @step_name = N'HOROVOD__11',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 11',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__11',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__11',
      @schedule_name = N'HOROVOD__11'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__11';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__11')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_12():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__12';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__12',
      @step_name = N'HOROVOD__12
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 12',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__12',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__12',
      @schedule_name = N'HOROVOD__12'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__12';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__12')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_13():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__13';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__13',
      @step_name = N'HOROVOD__13',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 13',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__13',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__13',
      @schedule_name = N'HOROVOD__13'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__13';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__13')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_14():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__14';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__14',
      @step_name = N'HOROVOD__14',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 14',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__14',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__14',
      @schedule_name = N'HOROVOD__14'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__14';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__14')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_2():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__2';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__2',
      @step_name = N'HOROVOD__2',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 2',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__2',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__2',
      @schedule_name = N'HOROVOD__2'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__2';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__2')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_21():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__21';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__21',
      @step_name = N'HOROVOD__21',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 21',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__21',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__21',
      @schedule_name = N'HOROVOD__21'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__21';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__21')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_22():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__22';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__22',
      @step_name = N'HOROVOD__22',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 22',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__22',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__22',
      @schedule_name = N'HOROVOD__22'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__22';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__22')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_23():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__23';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__23',
      @step_name = N'HOROVOD__23',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 23',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__23',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__23',
      @schedule_name = N'HOROVOD__23'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__23';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__23')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_24():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__24';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__24',
      @step_name = N'HOROVOD__24',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 24',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__24',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__24',
      @schedule_name = N'HOROVOD__24'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__24';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__24')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_3():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__3';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__3',
      @step_name = N'HOROVOD__3',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 3',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__3',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__3',
      @schedule_name = N'HOROVOD__3'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__3';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__3')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_31():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__31';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__31',
      @step_name = N'HOROVOD__31',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 31',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__31',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__31',
      @schedule_name = N'HOROVOD__31'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__31';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__31')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_32():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__32';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__32',
      @step_name = N'HOROVOD__32',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 32',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__32',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__32',
      @schedule_name = N'HOROVOD__32'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__32';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__32')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_33():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__33';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__33',
      @step_name = N'HOROVOD__33',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 33',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__33',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__33',
      @schedule_name = N'HOROVOD__33'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__33';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__33')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_34():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__34';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__34',
      @step_name = N'HOROVOD__34',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 34',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__34',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__34',
      @schedule_name = N'HOROVOD__34'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__34';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__34')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_4():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__4';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__4',
      @step_name = N'HOROVOD__4',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 4',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__4',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__4',
      @schedule_name = N'HOROVOD__4'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__4';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__4')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_41():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__41';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__41',
      @step_name = N'HOROVOD__41',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 41',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__41',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__41',
      @schedule_name = N'HOROVOD__41'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__41';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__41')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_42():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__42';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__42',
      @step_name = N'HOROVOD__42',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 42',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__42',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__42',
      @schedule_name = N'HOROVOD__42'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__42';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__42')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_43():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__43';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__43',
      @step_name = N'HOROVOD__43',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 43',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__43',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__43',
      @schedule_name = N'HOROVOD__43'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__43';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__43')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_44():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__44';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__44',
      @step_name = N'HOROVOD__44',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 44',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__44',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__44',
      @schedule_name = N'HOROVOD__44'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__44';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__44')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_5():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__5';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__5',
      @step_name = N'HOROVOD__5',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 5',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__5',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__5',
      @schedule_name = N'HOROVOD__5'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__5';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__5')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_51():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__51';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__51',
      @step_name = N'HOROVOD__51',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 51',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__51',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__51',
      @schedule_name = N'HOROVOD__51'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__51';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__51')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_52():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__52';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__52',
      @step_name = N'HOROVOD__52',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 52',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__52',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__52',
      @schedule_name = N'HOROVOD__52'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__52';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__52')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_53():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__53';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__53',
      @step_name = N'HOROVOD__53',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 53',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__53',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__53',
      @schedule_name = N'HOROVOD__53'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__53';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__53')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_54():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__54';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__54',
      @step_name = N'HOROVOD__54',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 54',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__54',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__54',
      @schedule_name = N'HOROVOD__54'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__54';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__54')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_6():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__6';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__6',
      @step_name = N'HOROVOD__6',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 6',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__6',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__6',
      @schedule_name = N'HOROVOD__6'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__6';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__6')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_61():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__61';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__61',
      @step_name = N'HOROVOD__61',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 61',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__61',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__61',
      @schedule_name = N'HOROVOD__61'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__61';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__61')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_62():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__62';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__62',
      @step_name = N'HOROVOD__62',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 62',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__62',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__62',
      @schedule_name = N'HOROVOD__62'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__62';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__62')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_63():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__63';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__63',
      @step_name = N'HOROVOD__63',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 63',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__63',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__63',
      @schedule_name = N'HOROVOD__63'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__63';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__63')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_64():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__64';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__64',
      @step_name = N'HOROVOD__64',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 64',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__64',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__64',
      @schedule_name = N'HOROVOD__64'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__64';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__64')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_7():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__7';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__7',
      @step_name = N'HOROVOD__7',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 7',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__7',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__7',
      @schedule_name = N'HOROVOD__7'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__7';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__7')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_71():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__71';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__71',
      @step_name = N'HOROVOD__71',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 71',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__71',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__71',
      @schedule_name = N'HOROVOD__71'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__71';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__71')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_72():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__72';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__72',
      @step_name = N'HOROVOD__72',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 72',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__72',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__72',
      @schedule_name = N'HOROVOD__72'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__72';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__72')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_73():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__73';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__73',
      @step_name = N'HOROVOD__73',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 73',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__73',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__73',
      @schedule_name = N'HOROVOD__73'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__73';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__73')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_74():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__74';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__74',
      @step_name = N'HOROVOD__74',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 74',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__74',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__74',
      @schedule_name = N'HOROVOD__74'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__74';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__74')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_8():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__8';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__8',
      @step_name = N'HOROVOD__8',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 8',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__8',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__8',
      @schedule_name = N'HOROVOD__8'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__8';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__8')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_81():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__81';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__81',
      @step_name = N'HOROVOD__81',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 81',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__81',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__81',
      @schedule_name = N'HOROVOD__81'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__81';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__81')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()


def Horovod_82():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__82';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__82',
      @step_name = N'HOROVOD__82',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 82',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__82',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__82',
      @schedule_name = N'HOROVOD__82'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__82';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__82')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_83():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__83';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__83',
      @step_name = N'HOROVOD__83',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 83',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__83',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__83',
      @schedule_name = N'HOROVOD__83'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__8';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__83')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

def Horovod_84():
    global con_str
    global con
    cur = con.cursor()
    sql = '''
      use msdb
      EXEC dbo.sp_add_job @job_name = N'HOROVOD__84';
      declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int);

      EXEC sp_add_jobstep
      @job_name = N'HOROVOD__84',
      @step_name = N'HOROVOD__84',
      @database_name = N'i_collect',
      @subsystem = N'TSQL',
      @command = N'exec Filbert_HOROVOD 84',
      @retry_attempts = 0,
      @retry_interval = 0

      ;EXEC dbo.sp_add_schedule
      @schedule_name = N'HOROVOD__84',
      @freq_type = 1,
      @active_start_time = @tt ;
      USE msdb

      ;EXEC sp_attach_schedule
      @job_name = N'HOROVOD__84',
      @schedule_name = N'HOROVOD__84'

      ;EXEC dbo.sp_add_jobserver
      @job_name = N'HOROVOD__84';'''


    kill = '''
    declare @Job_id binary(16)
    select @Job_id = job_id from msdb.dbo.sysjobs where (name = N'HOROVOD__84')

    if (@Job_id IS NOT NULL)
    begin
    exec msdb.dbo.sp_delete_job @Job_id
    end'''

    cur.execute(kill)
    cur.commit()
    cur.execute(sql)
    cur.commit()
    cur.close()

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
            Horovod_1()
            print 'Готово!'
        elif ask_1 == 2:
            print 'Начинаю рефакторинг..'
            Horovod_2()
            print 'Готово!'
        elif ask_1 == 3:
            print 'Начинаю рефакторинг..'
            Horovod_3()
            print 'Готово!'
        elif ask_1 == 4:
            print 'Начинаю рефакторинг..'
            Horovod_4()
            print 'Готово!'
        elif ask_1 == 5:
            print 'Начинаю рефакторинг..'
            Horovod_5()
            print 'Готово!'
        elif ask_1 == 6:
            print 'Начинаю рефакторинг..'
            Horovod_6()
            print 'Готово!'
        elif ask_1 == 7:
            print 'Начинаю рефакторинг..'
            Horovod_7()
            print 'Готово!'
        elif ask_1 == 8:
            print 'Начинаю рефакторинг..'
            Horovod_8()
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
                Horovod_11()
                print 'Готово!'
            elif ask_2_1 == 2:
                print 'Начинаю рефакторинг..'
                Horovod_12()
                print 'Готово!'
            elif ask_2_1 == 3:
                print 'Начинаю рефакторинг..'
                Horovod_13()
                print 'Готово!'
            elif ask_2_1 == 4:
                print 'Начинаю рефакторинг..'
                Horovod_14()
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
                Horovod_21()
                print 'Готово!'
            elif ask_2_2 == 2:
                print 'Начинаю рефакторинг..'
                Horovod_22()
                print 'Готово!'
            elif ask_2_2 == 3:
                print 'Начинаю рефакторинг..'
                Horovod_23()
                print 'Готово!'
            elif ask_2_2 == 4:
                print 'Начинаю рефакторинг..'
                Horovod_24()
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
                Horovod_31()
                print 'Готово!'
            elif ask_2_3 == 2:
                print 'Начинаю рефакторинг..'
                Horovod_32()
                print 'Готово!'
            elif ask_2_3 == 3:
                print 'Начинаю рефакторинг..'
                Horovod_33()
                print 'Готово!'
            elif ask_2_3 == 4:
                print 'Начинаю рефакторинг..'
                Horovod_34()
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
                Horovod_41()
                print 'Готово!'
            elif ask_2_4 == 2:
                print 'Начинаю рефакторинг..'
                Horovod_42()
                print 'Готово!'
            elif ask_2_4 == 3:
                print 'Начинаю рефакторинг..'
                Horovod_43()
                print 'Готово!'
            elif ask_2_4 == 4:
                print 'Начинаю рефакторинг..'
                Horovod_44()
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
                Horovod_51()
                print 'Готово!'
            elif ask_2_5 == 2:
                print 'Начинаю рефакторинг..'
                Horovod_52()
                print 'Готово!'
            elif ask_2_5 == 3:
                print 'Начинаю рефакторинг..'
                Horovod_53()
                print 'Готово!'
            elif ask_2_5 == 4:
                print 'Начинаю рефакторинг..'
                Horovod_54()
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
                Horovod_61()
                print 'Готово!'
            elif ask_2_6 == 2:
                print 'Начинаю рефакторинг..'
                Horovod_62()
                print 'Готово!'
            elif ask_2_6 == 3:
                print 'Начинаю рефакторинг..'
                Horovod_63()
                print 'Готово!'
            elif ask_2_6 == 4:
                print 'Начинаю рефакторинг..'
                Horovod_64()
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
                Horovod_71()
                print 'Готово!'
            elif ask_2_7 == 2:
                print 'Начинаю рефакторинг..'
                Horovod_72()
                print 'Готово!'
            elif ask_2_7 == 3:
                print 'Начинаю рефакторинг..'
                Horovod_73()
                print 'Готово!'
            elif ask_2_7 == 4:
                print 'Начинаю рефакторинг..'
                Horovod_74()
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
                Horovod_81()
                print 'Готово!'
            elif ask_2_8 == 2:
                print 'Начинаю рефакторинг..'
                Horovod_82()
                print 'Готово!'
            elif ask_2_8 == 3:
                print 'Начинаю рефакторинг..'
                Horovod_83()
                print 'Готово!'
            elif ask_2_8 == 4:
                print 'Начинаю рефакторинг..'
                Horovod_84()
                print 'Готово!'
            else:
                print 'А вот нет у меня такой задачи (づ｡◕‿‿◕｡)づ '

        else:
            print 'А вот нет у нас такой кампании ( ́ ◕◞ε◟◕`) '

    else:
        print 'А вот нет у меня такой цифры (づ￣ ³￣)づ  '
