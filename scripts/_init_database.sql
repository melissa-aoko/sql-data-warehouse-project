/*
CREATE DATABASE AND SCHEMAS

Script purpose:
  This script creates a new database named 'DataWareHouse' afetr checking if it already exists.
  If the database exists , it is dropped and recreated . Additionally , the script sets up three schemas 
  within the database : 'bronze' , 'silver' and 'gold'

Warning:
  Running this script will drop the entire 'DataWareHouse' database if it exists. 
  All data in database will be permanently deleted. Ensure you have proper backups
  before running this script
*/

USE master;
GO
--drop and recreate 'DataWareHouse' database
IF EXISTS (SELECT1 FROM sys.databases WHERE name = 'DataWareHouse')
BEGIN
  ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWareHouse;
END;
GO
--create 'DataWareHouse' database
CREATE DATABASE DataWareHouse;

USE DataWareHouse;

--Create schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
