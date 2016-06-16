use msdb
EXEC dbo.sp_add_job @job_name = N'Ave_Satan'

declare @tt int = cast(replace(convert(varchar, dateadd(minute, 1, getdate()), 108), ':', '') as int)


EXEC sp_add_jobstep
@job_name = N'Ave_Satan',
@step_name = N'Ave_Satan',
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
@job_name = N'Ave_Satan';