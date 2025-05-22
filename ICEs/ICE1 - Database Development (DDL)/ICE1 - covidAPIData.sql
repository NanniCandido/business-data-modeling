-- DBAS3019 - Business Data Modelling
-- Elaine da Silva & Hang Ngo
-- DDL Covid Data API Database
-- Scripts to create the covid19 Database
-- The database will be used to store and track data from Covid19
-- It will be updated daily using an automated script to gather the data from the API
-- https://api.opencovid.ca 
--
use master;
GO
-------------------------------------------------------------------------------------
-- CREATING THE covidData DATABASE
-------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'covid')
BEGIN
  CREATE DATABASE covid;
END;
GO

USE covid
GO

-------------------------------------------------------------------------------------
-- CREATING TABLES WITH ITS PRIMARY KEYS IN THE covidAPIData DATABASE
-------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='covidData' AND xtype='U')
BEGIN
	CREATE TABLE [dbo].[covidData](
		[co_date] [date] NOT NULL DEFAULT GETDATE(),
		[co_pro_code_fk] [varchar](5) NOT NULL,
		[co_change_cases] [int] NOT NULL,
		[co_change_fatalities] [int] NOT NULL,
		[co_change_vaccinations] [int] NOT NULL,
		[co_change_vaccinated] [int] NOT NULL,
		[co_change_vaccines_distributed] [int] NOT NULL,
		[co_total_cases] [bigint] NOT NULL,
		[co_total_fatalities] [bigint] NOT NULL,
		[co_total_vaccinations] [bigint] NOT NULL,
		[co_total_vaccinated] [bigint] NOT NULL,
		[co_total_vaccines_distributed] [bigint] NOT NULL,
		CONSTRAINT covidData_pk PRIMARY KEY CLUSTERED 
(	
	[co_date] ASC,
	[co_pro_code_fk] ASC
));
END;	
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='province' AND xtype='U')
BEGIN
CREATE TABLE [dbo].[provinceData](
	[pro_code] [varchar](5) NOT NULL,
	[pro_name] [varchar](50) NULL,
	[pro_population] [int] NULL,
	[pro_area] [int] NULL,
	[pro_density] [float] NULL,
	[pro_gdp] [int] NULL
    CONSTRAINT pro_code_pk PRIMARY KEY CLUSTERED (pro_code));
END;
GO

-------------------------------------------------------------------------------------
-- CREATING FK CONSTRAINTS IN THE COVIDDATA TABLE
-------------------------------------------------------------------------------------	
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='co_pro_code_fk' AND xtype='F')	
BEGIN
ALTER TABLE covidData 
 ADD CONSTRAINT co_pro_code_fk FOREIGN KEY(co_pro_code_fk) REFERENCES provinceData(pro_code)
ON UPDATE CASCADE
ON DELETE CASCADE;
END;
GO

-------------------------------------------------------------------------------------
-- CREATING CHECK CONSTRAINTS IN THE PROVINCE TABLE
-------------------------------------------------------------------------------------		
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='pro_code_ck' AND xtype='C')	
BEGIN
ALTER TABLE provinceData 
   ADD CONSTRAINT pro_code_ck CHECK(pro_code in 
   ('AB', 'BC', 'MB', 'NB', 'NS', 'NL', 'NT', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT', 'NFR', 'FA', '_RC'))
END;
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='pro_name_ck' AND xtype='C')	
BEGIN
ALTER TABLE provinceData 
  ADD CONSTRAINT pro_name_ck CHECK(pro_name 
  in ('Alberta', 'British Columbia', 'Manitoba', 'New Brunswick', 'Nova Scotia', 
      'Newfoundland and Labrador', 'Northwest Territories', 'Nunavut', 'Ontario', 
	  'Prince Edward Island', 'Quebec', 'Saskatchewan', 'Yukon','Repatriated Canadians',
	  'Federal Allocation','National Federal Reserve'))
END;
GO