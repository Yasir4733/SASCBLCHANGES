USE [master]
GO
RESTORE DATABASE [MyDatabaseTest] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.YASIR\MSSQL\Backup\CBL_backup_2022_04_04_000000_8042671.bak' 
WITH MOVE N'CBL' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.YASIR\MSSQL\DATA\MyDatabaseTest.mdf',  
     MOVE N'CBL_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL15.YASIR\MSSQL\DATA\MyDatabaseTest_log.ldf',  
RECOVERY, -- 'with recovery' is optional here - it's the default if not specified - database will be available
REPLACE;