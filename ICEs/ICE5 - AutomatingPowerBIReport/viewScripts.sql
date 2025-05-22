-- Author: Elaine da Silva
-- Date: 11/29/2024
-- Purpose: Assignment 2 of BDAS3017 course
use covid19Data
go
-----------------------------------
--- Create the CASES per 10000 view
-----------------------------------
CREATE OR ALTER VIEW vwCases_per10000 as
WITH cte_cases (province, cumulative_cases, MAXDate) 
AS
(
SELECT REPLACE(REPLACE(REPLACE(REPLACE(c.province, 'PEI', 'Prince Edward Island'), 'NL', 'Newfoundland and Labrador'),'BC', 'British Columbia'),'NWT', 'Northwest Territories') province, 
	   c.cumulative_cases, MAX(c.date_cases) MAXDate
  FROM cases c
WHERE c.province != 'Repatriated'
  AND c.date_cases =  (SELECT MAX(t.date_cases) FROM cases t WHERE t.province = c.province)
GROUP BY c.province, c.cumulative_cases
 )
 SELECT cte.province, cte.cumulative_cases*10000.0/p.population cases_per10000
   FROM cte_cases cte
    LEFT JOIN population p ON p.province = cte.province

-----------------------------------
--- Create the DEATHS per 10000 view
-----------------------------------
CREATE OR ALTER VIEW vwDeaths_per10000 AS
WITH cte_deaths (province, cumulative_deaths, MAXDate) 
AS
(
SELECT REPLACE(REPLACE(REPLACE(REPLACE(c.province, 'PEI', 'Prince Edward Island'), 'NL', 'Newfoundland and Labrador'),'BC', 'British Columbia'),'NWT', 'Northwest Territories') province, 
	   c.cumulative_deaths, MAX(c.date_deaths) AS MAXDate
  FROM deaths c
WHERE c.province != 'Repatriated'
  AND c.date_deaths =  (SELECT MAX(t.date_deaths) AS MAXDate FROM deaths t WHERE t.province = c.province)
GROUP BY c.province, c.cumulative_deaths
 )
 SELECT cte.province, cte.cumulative_deaths*10000.0/p.population deaths_per10000 
   FROM cte_deaths cte
    LEFT JOIN population p ON p.province = cte.province

------------------------------------
--- Create the VACCINES per 10000 view
------------------------------------
CREATE OR ALTER VIEW vwVaccines_per10000 AS
WITH cte_vaccines (province, cumulative_vaccines, MAXDate) 
AS
(
SELECT REPLACE(REPLACE(REPLACE(REPLACE(c.province, 'PEI', 'Prince Edward Island'), 'NL', 'Newfoundland and Labrador'),'BC', 'British Columbia'),'NWT', 'Northwest Territories') AS province, 
	   c.cumulative_vaccines, MAX(c.date_vaccines) AS MAXDate
  FROM vaccines c
WHERE c.province != 'Repatriated'
  AND c.date_vaccines =  (SELECT MAX(t.date_vaccines) FROM vaccines t WHERE t.province = c.province)
GROUP BY c.province, c.cumulative_vaccines
 )
 SELECT cte.province, cte.cumulative_vaccines*10000.0/p.population AS vaccines_per10000 
   FROM cte_vaccines cte
    LEFT JOIN population p ON p.province = cte.province

------------------------------------
--- Create the SUMMARY View
------------------------------------
CREATE OR ALTER VIEW vwSummary AS
WITH cte_summary (sum_year, sum_month, MAXDate) 
AS
(
SELECT YEAR(date_active) sum_year, DATEPART(mm, date_active) sum_month, 
	   MAX(date_active) AS MAXDate FROM summary 
group by YEAR(date_active), DATEPART(mm, date_active)
)
SELECT cte.sum_month, cte.sum_year,
       LEFT(DATENAME(MONTH, cte.MAXDate), 3) + '-' + CAST(YEAR(cte.MAXDate) AS VARCHAR) AS formattedDate,
	   s.cumulative_cases cases, s.cumulative_deaths deaths, s.cumulative_recovered recovered
FROM summary s INNER JOIN cte_summary cte ON s.date_active = cte.MAXdate
