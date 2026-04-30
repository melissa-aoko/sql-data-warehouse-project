/*
============================================================
Script: Bronze Layer Table Creation (DDL)
============================================================

Description:
This script creates the Bronze layer tables for the data 
warehouse. The Bronze layer is the raw data ingestion layer 
that stores data exactly as received from source systems 
(CRM and ERP) with minimal transformation.

The script follows a DROP-AND-CREATE approach:
- Checks if each table already exists using OBJECT_ID
- Drops the table if it exists
- Recreates the table with the defined schema

------------------------------------------------------------

Tables Created:

CRM Tables:
- bronze.crm_cust_info      : Customer master data
- bronze.crm_prod_info      : Product master data
- bronze.crm_sales_details  : Sales transaction data

ERP Tables:
- bronze.erp_cust_az12      : Customer demographic data
- bronze.erp_loc_a101       : Customer location data
- bronze.erp_px_cat_g1v2    : Product category and hierarchy data

------------------------------------------------------------

Design Notes:
- Data types are kept simple and close to source format
  (e.g., NVARCHAR, INT) to preserve raw data integrity
- No constraints (PK/FK) are applied in the Bronze layer
- Minimal validation is enforced at this stage
- Some date fields are stored as INT (raw format) and may
  require transformation in later layers (Silver/Gold)

------------------------------------------------------------

Dependencies:
- Requires the 'bronze' schema to exist
- Intended to be executed before data loading procedures

------------------------------------------------------------

Example Usage:

-- Run the script to (re)create all Bronze tables
-- Typically executed once during setup or reset

------------------------------------------------------------

Warnings:
- This script will DROP existing tables and all data within them
- Use with caution in non-development environments

============================================================
*/
IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info
CREATE TABLE bronze.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname  NVARCHAR(50),
	cst_material_status  NVARCHAR(50),
	cst_gndr  NVARCHAR(50),
	cst_create_date DATE
);
IF OBJECT_ID ('bronze.crm_prod_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prod_info
CREATE TABLE bronze.crm_prod_info(
	prod_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dr DATETIME,
	prd_end_dt DATETIME

);
IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quality INT,
	sls_price INT
);
IF OBJECT_ID ('bronze.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12
CREATE TABLE bronze.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101
CREATE TABLE bronze.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2
CREATE TABLE bronze.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
);
