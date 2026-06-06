# CX Intelligence Platform

End-to-end Customer Experience Analytics platform designed to transform omnichannel customer service data into actionable business insights.

This project simulates a large-scale enterprise customer support operation and demonstrates modern Data Engineering, Data Analytics, Business Intelligence, and dimensional modeling practices.

---

## Project Overview

The CX Intelligence Platform was developed to simulate a real-world Customer Experience environment, enabling the ingestion, transformation, modeling, and analysis of customer support interactions across multiple service channels.

The solution follows a complete analytics workflow:

```text
CSV Dataset
    ↓
Staging Layer
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

## Business Scenario

A large enterprise seeks to improve customer experience performance by understanding operational trends across its customer support organization.

The project enables the analysis of:

- Customer Satisfaction (CSAT)
- Resolution Performance
- Interaction Volume
- Reopen Rate
- Average Handle Time (AHT)
- Agent Performance
- Channel Effectiveness
- Category Trends

---

## Project Goals

- Build a dimensional data warehouse using Star Schema modeling
- Implement repeatable ETL processes
- Create business-oriented analytical views
- Develop executive and operational KPIs
- Support Power BI dashboard development
- Demonstrate end-to-end analytics architecture

---

## Technology Stack

### Data Engineering

- SQL Server Express
- T-SQL
- ETL Processes
- Star Schema Modeling
- Dimensional Data Warehouse

### Analytics & BI

- Power BI
- DAX
- KPI Development
- Business Analytics

### Data Generation

- Python
- Pandas
- Synthetic Data Generation

### Version Control

- Git
- GitHub

---

## Repository Structure

```text
cx-intelligence-platform/

├── sql/
│   ├── 01_database_schema.sql
│   ├── 02_data_ingestion.sql
│   ├── 03_semantic_layer.sql
│   └── 04_data_quality_checks.sql
│
├── sample_data/
│
├── Documentation/
│   ├── architecture.md
│   ├── data_dictionary.md
│   ├── powerbi_design.md
│   └── root_cause_analysis.md
│
└── README.md
```

---

## Data Model

The solution follows a Star Schema architecture.

### Fact Table

- Fact_Interactions

### Dimension Tables

- Dim_Agent
- Dim_Channel
- Dim_Category
- Dim_Calendar

---

## Semantic Layer

The project exposes business-ready analytical views for reporting and dashboard consumption.

### Available Views

- vw_CustomerExperience
- vw_AgentPerformance
- vw_ChannelPerformance
- vw_CategoryPerformance
- vw_ExecutiveDashboard

---

## Key Performance Indicators

### Customer Satisfaction (CSAT)

Average customer satisfaction score.

### Average Handle Time (AHT)

Average interaction duration.

### Resolution Rate

Percentage of interactions successfully resolved.

### Reopen Rate

Percentage of interactions reopened after resolution.

### Interaction Volume

Total interactions by period, channel, category, or agent.

### Agent Performance

Operational performance indicators by agent and team.

---

## Data Quality

The project includes validation scripts to ensure:

- Referential integrity
- Data completeness
- Consistency checks
- ETL validation

---

## Sample Dataset

A synthetic dataset was generated using Python to simulate real-world customer support operations.

Dataset characteristics:

- 20,000 interactions
- Multiple support channels
- Multiple support categories
- Resolution tracking
- Reopen indicators
- Customer satisfaction scores
- Agent performance data

---

## Documentation

Additional project documentation is available in the `/Documentation` folder:

- Architecture Overview
- Data Dictionary
- Power BI Dashboard Design
- Root Cause Analysis Framework

---

## Author

Maurício Farias Machado

Data Analytics | Business Intelligence | Data Engineering
