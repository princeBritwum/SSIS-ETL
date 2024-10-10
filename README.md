# SSIS-ETL

This repository demonstrates an ETL process to load data from a shared folder into a SQL Server Data Warehouse using SSIS

# Bulk Insert Excel to Data Warehouse

This repository demonstrates how to load data from an Excel file into a SQL Server staging table using BULK INSERT and then use SSIS to load the staging data into a data warehouse.

## Prerequisites

- SQL Server or SQL Server Express
- SQL Server Management Studio (SSMS)
- SQL Server Integration Services (SSIS)
- An Excel file with data to load (sample included)

## Setup Instructions

### 1. Set up the Database and Tables
- Run the `SQL/CreateStageTable.sql` script to create the staging table.
- Run the `SQL/CreateDataWarehouseTable.sql` script to create the data warehouse table.

### 2. Create the Stored Procedure
- Run the `SQL/ImportExcelToStageProcedure.sql` script to create the stored procedure that handles the bulk insert.

### 3. Load Data from Excel to Staging Table
- Open SQL Server Management Studio (SSMS).
- Execute the stored procedure to bulk insert data from an Excel file into the staging table:

```sql
EXEC [dbo].[ImportExcelData] @FilePath = 'C:\path_to_your_file\sample-data.xlsx';

