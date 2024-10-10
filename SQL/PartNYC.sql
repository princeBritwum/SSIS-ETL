    
  CREATE PARTITION FUNCTION NycTripFunc (int)  
      AS RANGE RIGHT FOR VALUES ( 20160301,20160401,20160501,20160601,20160701,20160801,20160901,20161001,20161101,20161201,20170101 ) ;
    
  --b. Create the partition schema using the partition function
  
  CREATE PARTITION SCHEME NycTripSchema  
      AS PARTITION NycTripFunc  
      ALL TO ('PRIMARY') ;  
  
  --4. Create the NycTrip Table 
  
  CREATE SEQUENCE NycSeq
  START WITH 1
  INCREMENT BY 1;


CREATE TABLE [dbo].[PartNycTrip](
	
    [TripID] INT DEFAULT NEXT VALUE FOR NycSeq,
	[LoadDate] [date] NULL,
	[pickupdatekey] [int] NOT NULL,
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
    CONSTRAINT [PKNycTrip_TripPickupdatekey] PRIMARY KEY CLUSTERED 
(	
	[TripID] ASC,
	[pickupdatekey] ASC

))
ON NycTripSchema ([pickupdatekey]);

  --CREATE NON CLUSTERED INDEXES
  
  CREATE NONCLUSTERED INDEX PKNycTrip_PickDropDate
  ON [dbo].[PartNycTrip]([tpep_pickup_datetime],[tpep_dropoff_datetime]);
  
  CREATE NONCLUSTERED INDEX PKNycTrip_LoadDate
  ON [dbo].[PartNycTrip]([LoadDate]);
