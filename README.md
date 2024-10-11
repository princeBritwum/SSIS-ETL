# SSIS-ETL

In this Project I make use of SSIS to Extract Transform and Load Data from a shared folder into an MSSQL and Snowflake DataWarehouse.

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

### 3. Extract Data from Shared Folder and MSSQL DB int the to Staging Table in MSSQL using SSIS
- Open Visual Studio as Administrator  (SSMS) and open the NYC_Package.dtsx file. Once opened, you will identify two tasks ; The Execute SQL Task and the Data Flow Task. The Execute SQL Task runs the procedure [ProdecuereLoadData.sql] every night to load the daily transaction file from the Data Lake storage into the Staging Table in the Datawarehouse. Take note that we caould also use the Bulk Insert Task to similarly load Data into the Staging table. But for the purposes of this Tutorial, we will use the Stored Procedure.
  
![Data/ExecuteSQL Task.png](https://github.com/princeBritwum/SSIS-ETL/blob/main/Data/ExecuteSQL%20Task.png?raw=true)


### 4. Load Data from Staging Table, Apply Transformation and Load in to Datawarehouse Table in MSSQL using Data Flow Task

- When the Data is Loaded, We do some transformation by merging payment details to the Transaction Data.

![Data/ControlFlow.png](https://github.com/princeBritwum/SSIS-ETL/blob/main/Data/ControlFlow.png)

The transformation is done at the data flow. In addition to the transaction data from Data Lake, we also have payment data residing on another Mssql.
We will use merge join to join it with our transaction Data to get more granular details for analysis and insight.

-There after, we will Load the Merged data into our Data Warehouse Table
![Data/DataFlow.png](https://github.com/princeBritwum/SSIS-ETL/blob/main/Data/DataFlow.png?raw=true)

### 5. Query Data from Data Warehouse
- Now our Job is almost done, we have followed through the ETL to load data from two Sources into an MSSQL Datawarehouse, Lets Select from the DW Table to confirm if our data was truly loaded.
- We will run the query below to get the total sales for the first Week of the month of May grouped by the PaymentType which was in the Payement Table, We can run other queries against the DW warehouse table to get more insight into the trends and pattern of customers.

  ```sql
  SELECT
        A.[PaymentType],
        CAST( A.[tpep_pickup_datetime] AS DATE) Date,
        COUNT(A.[passenger_count]) AS "PassengerCount",
        SUM(A.[total_amount]) Total_Sales
  
    FROM [AWDW2022].[dbo].[DWNycTrip] A
    WHERE DAY(CAST( A.[tpep_pickup_datetime] AS DATE)) >=1 
    AND DAY(CAST( A.[tpep_pickup_datetime] AS DATE)) <= 7
    GROUP BY A.[PaymentType], CAST( A.[tpep_pickup_datetime] AS DATE)
    ORDER BY CAST( A.[tpep_pickup_datetime] AS DATE)


- The result of the query run is below;
![Data/Result.png](https://github.com/princeBritwum/SSIS-ETL/blob/main/Data/Result.png?raw=true)

### 6. Migrate data from MSSQL to Snowflake Datawarehouse

We all know managing Datawarehouse on Premise is a hustle and our customer knows and experience that too, They are looking to Migrate to Snowflake, a cloud based Datawarehouse with flexibilty to increase compute power and storage in a split second. 
- To begin we will set up our Snowflake Datawarehouse and Database.
- We will then setup a pipeline in our existing SSIS package to load data from our MSSQL Database to our Snowflake Datawarehouse

- We will create our Database and Table in our Datawarehouse as below
![Data/SnowflakeDBTable.png](https://github.com/princeBritwum/SSIS-ETL/blob/main/Data/SnowflakeDBTable.png?raw=true)

### 7. Now we will Update our SSIS Package below to accomodate snowflake Datawarehouse.

![Data/SSIS-Snow.png](https://github.com/princeBritwum/SSIS-ETL/blob/main/Data/SSIS-Snow.png?raw=true)

