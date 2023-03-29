-- **********************************************
-- Création du job 
-- **********************************************
USE [msdb]
GO

/****** Object:  Job [SauveJT]    Script Date: 29/03/2023 12:16:16 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 29/03/2023 12:16:16 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'SauveJT', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Pas de description disponible.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'PIONE\alima', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [E1]    Script Date: 29/03/2023 12:16:17 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'E1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=2, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP LOG [BD1] TO  DISK = N''C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\BD1.bak'' WITH NOFORMAT, NOINIT,  NAME = N''BD1-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Message]    Script Date: 29/03/2023 12:16:17 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Message', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'insert TableMessage (DateMessage, Message) values(Getdate(), ''Journal sauvegardé'')
', 
		@database_name=N'BD1', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

-- **********************************************
-- Création de l'alerte
-- **********************************************
USE [msdb]
GO
DECLARE @jobid uniqueidentifier
select @jobid = job_id FROM msdb.dbo.sysjobs where name='SauveJT'


/****** Object:  Alert [JT saturé]    Script Date: 29/03/2023 12:17:22 ******/
EXEC msdb.dbo.sp_add_alert @name=N'JT saturé', 
		@message_id=0, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=0, 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'Databases|Percent Log Used|BD1|>|80', 
		@job_id=@jobid
GO
-- **********************************************
-- Table Message
-- **********************************************
USE [BD1]
GO
CREATE TABLE [dbo].[TableMessage](
	[Message] [nvarchar](max) NULL,
	[DateMessage] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- **********************************************
-- Tester
-- **********************************************
DECLARE @i int=1

WHILE @i < 100
  BEGIN
	insert TableMessage (DateMessage, Message) values(GETDATE(), 'Remplissage')
	SET @i=@i+1
  END
WHILE (1=1)
BEGIN
    update TableMessage set Message=Message
	WAITFOR DELAY '00:00:00.001'; 
END
select * from TableMessage
