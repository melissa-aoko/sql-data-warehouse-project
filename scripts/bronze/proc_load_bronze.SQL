/*
============================================================
Stored Procedure: Load Bronze Layer (Source ->  Bronze)
============================================================

Description:
This stored procedure is responsible for loading raw data 
into the Bronze layer of the data warehouse. It performs a 
full refresh by truncating existing tables and bulk inserting 
data from source CSV files.

The procedure loads data from two source systems:
1. CRM (Customer Relationship Management)
   - bronze.crm_cust_info
   - bronze.crm_prod_info
   - bronze.crm_sales_details

2. ERP (Enterprise Resource Planning)
   - bronze.erp_cust_az12
   - bronze.erp_loc_a101
   - bronze.erp_px_cat_g1v2

Each table is:
- Truncated before loading (ensures no duplicate data)
- Populated using BULK INSERT from local CSV files
- Timed individually for performance monitoring

At the end of execution, the total batch load duration is printed.

------------------------------------------------------------

Parameters:
None

------------------------------------------------------------

Error Handling:
- Uses TRY...CATCH block
- Captures and prints error number and state if a failure occurs

------------------------------------------------------------

Dependencies:
- Source CSV files must exist at the specified file paths
- SQL Server must have access to the file system location
- Target Bronze tables must already be created

------------------------------------------------------------

Example Usage:

EXEC bronze.load_bronze;

------------------------------------------------------------

Notes:
- This procedure performs a FULL LOAD (not incremental)
- Ensure no active dependencies on target tables before execution
- File paths are currently hardcoded and may need adjustment
  for different environments (e.g., dev, test, prod)

============================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '========================================';
		PRINT 'Loading Bronze Layer';
		PRINT '========================================';

		PRINT '----------------------------------------';
		PRINT 'loading CRM Tables';
		PRINT '----------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>>Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>>Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM '<<DATA_PATH>>\source_crm\cust_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration:'+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+ 'seconds';
		PRINT '-------------------'

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_prod_info;

		PRINT '>>Inserting Data Into: bronze.crm_prod_info';
		BULK INSERT bronze.crm_prod_info
		FROM '<<DATA_PATH>>\source_crm\prd_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration:'+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+ 'seconds';
		PRINT '-------------------'

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>>Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM '<<DATA_PATH>>\source_crm\sales_details.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration:'+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+ 'seconds';
		PRINT '-------------------'


		PRINT '----------------------------------------';
		PRINT 'loading ERP Tables';
		PRINT '----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>>Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM '<<DATA_PATH>>\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);

		SET @end_time = GETDATE();
		PRINT '>>Load Duration:'+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+ 'seconds';
		PRINT '-------------------'

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>>Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM '<<DATA_PATH>>\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);

		SET @end_time = GETDATE();
		PRINT '>>Load Duration:'+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+ 'seconds';
		PRINT '-------------------'


		PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>>Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM '<<DATA_PATH>>\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);

		SET @end_time = GETDATE();
		PRINT '>>Load Duration:'+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR)+ 'seconds';
		PRINT '-------------------'

		SET @batch_end_time = GETDATE();
		PRINT '================================='
		PRINT 'Loading Bronze Layer is complete'
		PRINT '>>Total Load Duration:'+ CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR)+ 'seconds';
		PRINT '================================='
	END TRY
	BEGIN CATCH
		PRINT '================================='
		PRINT 'ERROR OCCURED DURING LOADNG BRONZE LAYER'
		PRINT 'Error messsage' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error messsage' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '================================='
	END CATCH

END
