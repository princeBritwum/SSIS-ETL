# SSIS-ETL

In this Project I make use of SSIS to Extract Transform and Load Data from a shared folder into a DataWarehouse.

# Bulk Insert Excel to Data Warehouse

This repository demonstrates how to load data from an Excel file into a SQL Server staging table using BULK INSERT and then use SSIS to load the staging data into a data warehouse.

## Prerequisites

- SQL Server or SQL Server Express
- SQL Server Management Studio (SSMS)
- SQL Server Integration Services (SSIS)
- Visual Studio 2022
- An Excel file with data to load (sample included)



### Problem Statement
The client has daily sales transactions exported from an Sales Application to Azure DataLake Gen2 Storage every close of Business day. The client transaction system generates well over 1 million records of sales every day. He wants to utilize SSIS (SQL Sever Integration Services) to Extract, Transform and Load the daily transaction to the MSSQL DataWarehouse. The Data Analyst will then use Power BI for to create visualizations and generate insights for the Business 

### Approach
**As indicated in the architecture, this is how we plan to implement the solution**
- First of we use pandas to transform the transaction files in parquet to csv
- When we have the files in CSV , we will then use Bulk insert to data from fileserver to a staging table
- We will then insert into the lading table which has have been properly partitioned for performance when using as a source for Power BI and other anlytics activities
- In Power BI we will implement incremental refresh to incrementaly load data from landing table (source table) into Power BI.
- We will also define roles level security in the report to provide secured access and view to only allowed and permited users
- We will make use of AML toolkit to make meta data changes to our report since we dont want to break the incremental partions created when we published to Power BI Service
- We would also use Tabular Editor 3 to see how to manage the partitions created by incremental refresh

**We have a lot to do so lets dive in >>**


## Setup Instructions

### 1. Set up the Database and Tables
- Run the `SQL/[dbo].[StageNycTrip].sql` script to create the staging table.
- Run the `SQL/PartNYC.sql` script to create the data warehouse table.

### 2. Create the Stored Procedure
- Run the `ProdecuereLoadData.sql` script to create the stored procedure that handles the bulk insert.

### 3. Load Data from Shared Folder to Staging Table in MSSQL using SSIS
- Open Visual Studio as Administrator  (SSMS) and open the NYC_Package.dtsx file. Once opened, you will identify two tasks ; The Execute SQL Task and the Data Flow Task. The Execute SQL Task runs the procedure [ProdecuereLoadData.sql] every night to load the daily transaction file from the Data Lake storage into the Staging Table in the Datawarehouse. Take note that we caould also use the Bulk Insert Task to similarly load Data into the Staging table. But for the purposes of this Tutorial, we will use the Stored Procedure.
- When the Data is Loaded, We do some transformation by 
- Execute the stored procedure to bulk insert data from an Excel file into the staging table:

  -----------------------------------------



```sql
EXEC [dbo].[ImportExcelData] @FilePath = 'C:\path_to_your_file\sample-data.xlsx';

