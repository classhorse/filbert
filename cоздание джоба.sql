CREATE FUNCTION dbo.RunJob (@g datetime)
RETURNS varchar(150)

AS
BEGIN
.....

EXEC [msdb]..[sp_add_jobstep] @job_name = @CreatedJobName,
   @step_name = N'Run rMegaReport',
   @subsystem = N'TSQL',
   @command = N' здесь твой мега селект, который ты хочешь формировать в джобе';

.......
     RETURN('маладец');
END;




EXEC [msdb]..[sp_add_jobstep] @job_name = @CreatedJobName,
  @step_name = N'Run rMegaReport',
  @subsystem = N'TSQL',
  @command =
  'select date from table where date between convert(date,'''+convert(varchar(10),@d1,104)+''',104) and '





declare @ExecString varchar(150)='declare @t table(id int identity(1,1), dt datetime);';
declare @dt datetime = getdate();
set @ExecString += 'insert into @t(dt)
values(convert(datetime,'''+convert(varchar(20),@dt,113)+''',113)); select * from @t;';
exec(@ExecString);
@execstring это твой @command


[17:05:46] Gubka Bob(Вова): в VS надо просто 
declare @sd2 = @SD
declare @ed2 = @ED

select dbo.RunJub(@SD2, @ED2
[17:06:15 | Изменены 17:06:42] Gubka Bob(Вова): а функцию RunJob один раз сделать create из менеджемент студии sql





  --создание Джоба  
  --Создание задания
declare @CreatedPartName nvarchar(50) = 'PR_TaskID_',
 @Date datetime = getdate(),
 @HowManyIdleBeforeStartMM int = 5;
declare @CreatedJobName nvarchar(200)=@CreatedPartName+'TASK_ID',
 @CreatedSheduleName nvarchar(200)=@CreatedPartName+'TASK_ID'+'_RunOnce',
 @mitmp int = cast(DATEPART(mi, @Date)+@HowManyIdleBeforeStartMM as varchar(2));
if @mitmp>60 set @mitmp -= 60;
declare @active_start_time int=cast(cast(DATEPART(hh, @Date) as varchar(2))+case when @mitmp<10 then '0' else '' end+ cast(@mitmp as varchar(2))+'00' as int);



  EXEC [msdb]..[sp_add_job] @job_name = @CreatedJobName;
  EXEC [msdb]..[sp_add_jobstep] @job_name = @CreatedJobName,
   @step_name = N'Run rMegaReport',
   @subsystem = N'TSQL',
   @command = N'select 1';

  EXEC [msdb]..[sp_add_schedule]
   @schedule_name = @CreatedSheduleName,
   @freq_type = 1,
   @active_start_time = @active_start_time;

  EXEC [msdb]..[sp_attach_schedule]
     @job_name = @CreatedJobName,
     @schedule_name = @CreatedSheduleName;
  EXEC [msdb]..[sp_add_jobserver]
   @job_name = @CreatedJobName;