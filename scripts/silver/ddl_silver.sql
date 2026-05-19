/*===========================================================
  SILVER LAYER TABLE CREATION SCRIPT
  ===========================================================
  Purpose:
  This script creates all tables for the Silver Layer of the
  data warehouse. The Silver Layer stores cleaned and 
  transformed data imported from CRM and ERP source systems.

  Actions Performed:
  1. Check if each table already exists
  2. Drop existing table to avoid conflicts
  3. Recreate table with required columns and data types
  4. Add dwh_create_date for audit and load tracking

  Source Systems:
  - CRM (Customer Relationship Management)
  - ERP (Enterprise Resource Planning)

  Tables Created:
  - silver.crm_cust_info       -> Customer information
  - silver.crm_prd_info        -> Product information
  - silver.crm_sales_details   -> Sales transaction data
  - silver.erp_loc_a101        -> Customer location data
  - silver.erp_cust_az12       -> Additional customer details
  - silver.erp_px_cat_g1v2     -> Product category information
===========================================================*/


/*===========================================================
  TABLE: silver.crm_cust_info
  Description:
  Stores cleaned customer information from the CRM system.
===========================================================*/
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;
GO

CREATE TABLE silver.crm_cust_info (
    cst_id             INT,
    cst_key            NVARCHAR(50),
    cst_firstname      NVARCHAR(50),
    cst_lastname       NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr           NVARCHAR(50),
    cst_create_date    DATE,
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO


/*===========================================================
  TABLE: silver.crm_prd_info
  Description:
  Stores product details from the CRM system.
===========================================================*/
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;
GO

CREATE TABLE silver.crm_prd_info (
    prd_id          INT,
    cat_id          NVARCHAR(50),
    prd_key         NVARCHAR(50),
    prd_nm          NVARCHAR(50),
    prd_cost        INT,
    prd_line        NVARCHAR(50),
    prd_start_dt    DATE,
    prd_end_dt      DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO


/*===========================================================
  TABLE: silver.crm_sales_details
  Description:
  Stores sales transaction records from the CRM system.
===========================================================*/
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;
GO

CREATE TABLE silver.crm_sales_details (
    sls_ord_num     NVARCHAR(50),
    sls_prd_key     NVARCHAR(50),
    sls_cust_id     INT,
    sls_order_dt    DATE,
    sls_ship_dt     DATE,
    sls_due_dt      DATE,
    sls_sales       INT,
    sls_quantity    INT,
    sls_price       INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO


/*===========================================================
  TABLE: silver.erp_loc_a101
  Description:
  Stores customer location and country information 
  from the ERP system.
===========================================================*/
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;
GO

CREATE TABLE silver.erp_loc_a101 (
    cid             NVARCHAR(50),
    cntry           NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO


/*===========================================================
  TABLE: silver.erp_cust_az12
  Description:
  Stores additional customer demographic details
  from the ERP system.
===========================================================*/
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;
GO

CREATE TABLE silver.erp_cust_az12 (
    cid             NVARCHAR(50),
    bdate           DATE,
    gen             NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO


/*===========================================================
  TABLE: silver.erp_px_cat_g1v2
  Description:
  Stores product category and maintenance information
  from the ERP system.
===========================================================*/
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;
GO

CREATE TABLE silver.erp_px_cat_g1v2 (
    id              NVARCHAR(50),
    cat             NVARCHAR(50),
    subcat          NVARCHAR(50),
    maintenance     NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
