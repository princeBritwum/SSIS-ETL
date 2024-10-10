USE [AWDW2022]
GO
/****** Object:  StoredProcedure [dbo].[ImportYellowTripDataDaily]    Script Date: 10/10/2024 7:47:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ================================================
ALTER PROCEDURE [dbo].[ImportYellowTripDataDaily]
AS
BEGIN
	TRUNCATE TABLE [dbo].[StageNycTrip] -- REMOVE DATA BEFORE LOAD
    -- Perform the bulk insert from the specified CSV file
    BULK INSERT [dbo].[StageNycTrip]
    FROM 'C:\Users\PrinceBritwum\Documents\Data\yellow_tripdata_2016-05.csv'
    WITH (
        FIRSTROW = 2,              -- Skip the header row
        FIELDTERMINATOR = ',',      -- Fields are separated by commas
        ROWTERMINATOR = '\n',       -- Rows are separated by new lines
        TABLOCK                   -- Optional: Use for table-level lock for better performance during insert
    );
    
    PRINT 'Data import from yellow_tripdata_2016-05.csv completed successfully.';
END;

