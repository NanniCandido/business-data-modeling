
							---Date: Nov 11, 2024
							---Group name: Elaine & Hang 
							---Description:  DDL script for Covid Database 

USE master;
GO
-------------------------------------------------------------------------------------
-- CREATING THE DATABASE
-------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Covid')
BEGIN
  CREATE DATABASE Covid;
END;
GO

USE Covid
GO

-------------------------------------------------------------------------------------
-- CREATING TABLES WITH ITS PRIMARY KEYS IN THE 'Covid' DATABASE
-------------------------------------------------------------------------------------

---CovidData table----
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='CovidData' AND xtype='U')
BEGIN
	CREATE TABLE [dbo].[CovidData]
	(
		[co_date] [date] NOT NULL DEFAULT GETDATE(),
		[co_pro_code_fk] [varchar](5) NOT NULL,
		[co_change_cases] [int] NOT NULL,
		[co_change_fatalities] [int] NOT NULL,
		[co_change_vaccinations] [int] NOT NULL,
		[co_change_vaccinated] [int] NOT NULL,
		[co_change_vaccines_distributed] [int] NOT NULL,
		[co_total_cases] [int] NOT NULL,
		[co_total_fatalities] [int] NOT NULL,
		[co_total_vaccinations] [int] NOT NULL,
		[co_total_vaccinated] [int] NOT NULL,
		[co_total_vaccines_distributed] [int] NOT NULL,
		CONSTRAINT PK_Date_ProvinceCode PRIMARY KEY CLUSTERED 
			(	
				[co_date] ASC,
				[co_pro_code_fk] ASC
			)
	);
END;	
GO

---Province table----
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Province' AND xtype='U')
BEGIN
CREATE TABLE [dbo].[Province](
	[pro_code] [varchar](5) NOT NULL,
	[pro_name] [varchar](50) NOT NULL,
	[pro_population] [int] NOT NULL,
	[pro_area] [int] NOT NULL,
	[pro_density] [decimal](10, 2) NOT NULL,
	[pro_gdp] [int] NOT NULL,
	[pro_update_date] [date] NOT NULL,
    CONSTRAINT PK_ProvinceCode PRIMARY KEY CLUSTERED (pro_code));
END;
GO

-------------ADD CONSTRAINTS CHECK FOR PROVINCE NAME AND PROVINCE CODE-------------------------------
ALTER TABLE Province
	ADD CONSTRAINT CK_ProvinceName CHECK ([pro_name] IN ('Alberta', 'British Columbia', 
														'Manitoba', 'New Brunswick', 
														'Nova Scotia', 'Newfoundland & Labrador', 
														'Northwest Territories', 'Nunavut', 
														'Ontario', 'Prince Edward Island', 
														'Quebec', 'Saskatchewan', 'Yukon'));
ALTER TABLE Province 
	ADD CONSTRAINT CK_ProvinceCode CHECK ([pro_code] IN 
														('AB', 'BC', 'MB', 'NB', 'NL', 'NS', 'ON', 'PE', 
														'QC', 'SK', 'NT', 'NU', 'YT', '_RC', 'FA' ,'NFR'));
-------------------------------------------------------------------------------------
-- CREATING FK CONSTRAINTS IN THE COVID DATABASE
-------------------------------------------------------------------------------------	
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FK_ProvinceId' AND xtype='F')	
BEGIN
ALTER TABLE CovidData ADD CONSTRAINT FK_ProvinceCode FOREIGN KEY([co_pro_code_fk]) REFERENCES Province ([pro_code])
ON UPDATE CASCADE
ON DELETE CASCADE;
END;
GO
