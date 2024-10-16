    CREATE TABLE [dbo].[StageNycTrip](
   	[VendorId] [int] NULL,
   	[tpep_pickup_datetime] [datetime] NULL,
   	[tpep_dropoff_datetime] [datetime] NULL,
   	[passenger_count] [int] NULL,
   	[trip_distance] [float] NULL,
   	[PULocationID] [float] NULL,
   	[DOLocationID] [float] NULL,
   	[RatecodeID] [int] NULL,
   	[store_and_fwd_flag] [nchar](10) NULL,
   	[payment_type] [int] NULL,
   	[fare_amount] [float] NULL,
   	[extra] [float] NULL,
   	[mta_tax] [float] NULL,
   	[Improvement_surcharge] [float] NULL,
   	[tip_amount] [float] NULL,
   	[tolls_amount] [float] NULL,
   	[total_amount] [float] NULL,
   	[Congestion_Surcharge] [float] NULL,
   	[Airport_fee] [float] NULL
   ) ON [PRIMARY]
