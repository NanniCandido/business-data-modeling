-- Author: Elaine da Silva
-- Date: 11/29/2024
-- Purpose: Assignment 2 of BDAS3017 course
use covid
go
------------------------------------
--- Create the totals per 10000 view
------------------------------------
CREATE OR ALTER VIEW vwTotals_per10000 as
WITH cte_totals (pro_code, total_cases, total_fatalities, total_vaccinated, maxDate) 
AS
(
SELECT c.co_pro_code_fk, 
	   sum(c.co_total_cases)*10000.0 as total_cases, 
	   sum(c.co_total_fatalities)*10000.0 as total_fatalities, 
	   sum(c.co_total_vaccinated)*10000.0 as total_vaccinated, 
	   MAX(c.co_date) as maxDate
  FROM covidData c
WHERE c.co_date =  (SELECT MAX(t.co_date) FROM covidData t WHERE t.co_pro_code_fk = c.co_pro_code_fk)
GROUP BY c.co_pro_code_fk, 
	   c.co_total_cases, 
	   c.co_total_fatalities, 
	   c.co_total_vaccinated
 )
 SELECT cte.pro_code as province,
        cte.total_cases/p.pro_population as casesBy10000, 
        cte.total_fatalities/p.pro_population as deathsBy10000, 
		cte.total_vaccinated/p.pro_population as vaccinatedBy10000
   FROM cte_totals cte
    INNER JOIN provinceData p ON p.pro_code = cte.pro_code
