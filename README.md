# 🦠 COVID-19 Data Automation & Reporting

**Institution**: Nova Scotia Community College (NSCC)  
**Program**: IT – Data Analytics  
**Course**: DBAS3019 – Business Data Modelling  
**Instructor**: George Campanis  
**Term**: Fall 2024

---

## 📌 Project Overview

This end-to-end academic project simulates the development of a **daily COVID-19 monitoring and reporting system** for a fictional health services provider, **HeartBeat Inc.** The goal is to demonstrate a full data solution: from API integration to ETL automation, database updates, and final reporting.

Throughout the semester, the solution was built incrementally through assignments and in-class exercises, applying real-world business modelling concepts and data engineering techniques.

---

## 🚀 Objectives

- Automate the **daily download** of COVID-19 data (cases, deaths, and vaccinations) from [https://api.opencovid.ca](https://api.opencovid.ca)
- Parse and transform the data using **MS SSIS**
- **Merge** new data into an existing **SQL Server database**, avoiding duplication
- **Automate execution** of the SSIS package via **Windows Task Scheduler**
- Build and publish reports using **MS SSRS** and **Power BI**, including:
  - Tabular views by province
  - Calculations per 100,000 population
  - Geospatial map of case/vaccine concentrations

---

## 🧱 Project Components

### ✅ Assignments & Deliverables

| Assignment | Description |
|------------|-------------|
| Assignment 2 | DFD (Data Flow Diagram) of the solution |
| Assignment 3 | Data Dictionary and ERD (Entity Relationship Diagram) |
| Assignment 4 | Network Diagram (system architecture and data flow) |

### ⚙️ In-Class Exercises (ICE)

| ICE | Activity |
|-----|----------|
| ICE 1 | Create DDL scripts and database structure in MS SQL Server |
| ICE 2 | Connect to the public COVID API and extract data with SSIS |
| ICE 3 | Automate daily API extraction and implement merge logic (INSERT/UPDATE) in SSIS |
| ICE 4 | Automate execution of the SSIS package using a **PowerShell** script triggered by **Windows Task Scheduler** |
| ICE 5 | Develop COVID-19 report in **Power BI** with visual analytics and maps |

---

## 🛠️ Tools & Technologies

- **Microsoft SQL Server** (with SQL, DDL scripts)
- **PowerShell** – to download data from API inside the SSIS package through script automation
- **MS SSIS (SQL Server Integration Services)** – ETL and API automation
- **Windows Task Scheduler** – job automation
- **Power BI** – dashboard and geospatial mapping
- **MS SSRS** – tabular reports
- **API**: [Open COVID API](https://api.opencovid.ca)

---

## 🗂️ Sample Artifacts (if shared)

- 📄 `ERD.pdf` – Data model diagram  
- 📄 `DFD.pdf` – Data flow diagram  
- 📄 `NetworkDiagram.png` – Infrastructure overview  
- 📄 `Covid_API_SSIS_Pipeline.png` – SSIS workflow screenshot  
- 📄 `TaskScheduler_Success.png` – Windows automation confirmation  
- 📄 `PowerBI_Report_Screenshot.png` – Final dashboard view

> *Note: Due to institutional policies, some assets may not be publicly shared.*

---

## 📈 Key Learning Outcomes

- API data ingestion and transformation using SSIS  
- Incremental load with merge logic (upsert operations)  
- Scheduling and automation of ETL jobs  
- Business data modeling with ERD, DFD, and system diagrams  
- Storytelling and visualization with SSRS and Power BI  
- Building scalable and maintainable data workflows

---

