--SQL  Queries to implement CDC

--MAKE YOUR USER OWNER OF DATABASE

-- EXEC sp_changedbowner 'sa'

--ENABLE CHANGE DATA TRACKING

EXEC sys.sp_cdc_enable_db





--CHECK WEATHER CDC IS ENABLED OR NOT

SELECT name, is_cdc_enabled FROM sys.databases

-- Enable CDC on a specific table

EXEC sys.sp_cdc_enable_table

@source_schema = 'dbo',

@source_name = 'Accounts',

@role_name = NULL,

@supports_net_changes = 1







-- Check that CDC is enabled in the table

EXECUTE sys.sp_cdc_help_change_data_capture

@source_schema = 'dbo',

@source_name = 'Accounts';

GO

--SHOW ACCOUNTS TABLE

SELECT * FROM Accounts





-- CHANGE TRACKING TABLE

SELECT * FROM [CDC].[cdc].[dbo_Accounts_CT]


--INSERT VALUES

INSERT INTO Accounts Values (5, 'Thomas', 'Tuchel', 'tuchel@gmail.com')



--DELETE ROW

DELETE FROM Accounts where ID = 7