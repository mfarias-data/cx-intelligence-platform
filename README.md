# CX Intelligence Platform

End-to-end Customer Experience Analytics platform designed to transform omnichannel customer service data into actionable business insights.

This project simulates a large-scale enterprise customer support operation and demonstrates the application of Data Engineering, Analytics, Business Intelligence, and Automation practices to identify operational bottlenecks and improve customer experience performance.

---

## Business Scenario

A large enterprise observed a decline in customer support efficiency following a digital service transformation initiative.

Key indicators revealed:

- 15% reduction in First Contact Resolution (FCR)
- Increase in Average Handle Time (AHT)
- Growth in ticket reopen rates
- Lower customer satisfaction scores

The objective of this project is to identify root causes, measure operational impact, and provide data-driven recommendations.

---

## Project Goals

- Build a structured Customer Experience analytics environment
- Implement a Star Schema data model
- Develop KPI monitoring dashboards
- Perform root cause analysis
- Automate SLA monitoring processes
- Generate executive-level business insights

---

## Tech Stack

### Data Engineering
- SQL Server
- T-SQL
- ETL / ELT Processes
- Views
- Common Table Expressions (CTEs)
- Window Functions

### Analytics & BI
- Power BI
- DAX
- Star Schema Modeling
- KPI Development

### Automation
- Python
- SLA Alert Automation

---

## Repository Structure

```text
cx-intelligence-platform/

├── SQL_Scripts/
├── Data_Modeling/
├── PowerBI_Dashboard/
├── Analytics_Report/
├── Automation/
├── Sample_Data/
└── README.md
```

---

## Data Model

The solution follows a Star Schema architecture.

### Fact Table

- Fact_Interactions

### Dimension Tables

- Dim_Channel
- Dim_Agent
- Dim_Category
- Dim_Calendar

---

## Key Performance Indicators

### SLA Compliance

Percentage of interactions handled within the agreed service level.

### First Contact Resolution (FCR)

Percentage of customer issues resolved during the first interaction.

### Average Handle Time (AHT)

Average interaction handling duration.

### Customer Satisfaction (CSAT)

Average customer satisfaction score.

### Backlog Evolution

Trend analysis of opened versus closed interactions over time.

---

## Root Cause Analysis

Analysis identified a significant increase in unresolved interactions within a specific support category and channel combination.

The investigation revealed:

- Elevated ticket reopen rates
- Decreased FCR performance
- Increased operational workload
- Reduced customer satisfaction

Business recommendations were developed based on these findings.

---

## Automation

The project includes an SLA monitoring solution capable of identifying service breaches and generating operational alerts.

---

## Sample Dataset

A synthetic dataset was generated using Python to simulate real-world omnichannel customer support operations.

Dataset characteristics:

- 5,000+ interactions
- Multiple service channels
- Resolution tracking
- Reopen indicators
- Customer satisfaction scores
- Service-level monitoring

---

## Author

Maurício Farias Machado

Data Analytics | Business Intelligence | Customer Experience Analytics
