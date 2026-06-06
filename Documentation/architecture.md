# Architecture Overview

## Project Objective

The CX Intelligence Platform was developed to simulate a real-world Customer Experience analytics environment, enabling the collection, transformation, modeling, and analysis of omnichannel customer interactions.

The project demonstrates a complete analytics workflow, from raw data ingestion to business-ready insights.

---

## Data Flow

```text
CSV Dataset
    ↓
Staging_Interactions
    ↓
ETL Process
    ↓
Dimensional Data Warehouse
    ↓
Semantic Layer
    ↓
Power BI Dashboard
```

---

## Database Components

### Staging Layer

- Staging_Interactions

Raw imported data used as ETL source.

### Dimension Tables

- Dim_Agent
- Dim_Channel
- Dim_Category
- Dim_Calendar

### Fact Table

- Fact_Interactions

Stores all customer interaction events.

### Semantic Layer

- vw_CustomerExperience
- vw_AgentPerformance
- vw_ChannelPerformance
- vw_CategoryPerformance
- vw_ExecutiveDashboard

---

## Technology Stack

- SQL Server Express
- SQL Server Management Studio (SSMS)
- Python
- Pandas
- Power BI
- GitHub

---

## Project Structure

```text
sql/
├── 01_database_schema.sql
├── 02_data_ingestion.sql
├── 03_semantic_layer.sql
└── 04_data_quality_checks.sql

docs/
├── architecture.md
├── data_dictionary.md
├── powerbi_design.md
└── root_cause_analysis.md
```
