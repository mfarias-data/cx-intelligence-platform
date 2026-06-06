-- ============================================
-- CX Intelligence Platform
-- Semantic Layer
-- Version: 1.0
-- ============================================

USE CX_Analytics_DW;
GO

-- ============================================
-- CUSTOMER EXPERIENCE
-- ============================================

CREATE OR ALTER VIEW dbo.vw_CustomerExperience
AS
SELECT

```
CAST(f.InteractionDateTime AS DATE) AS InteractionDate,

ch.ChannelName,

cat.CategoryName,

COUNT(*) AS TotalInteractions,

AVG(CAST(f.SatisfactionScore AS DECIMAL(10,2))) AS AvgSatisfactionScore,

SUM(CASE
        WHEN f.ReopenedFlag = 1 THEN 1
        ELSE 0
    END) AS ReopenedCases,

SUM(CASE
        WHEN f.ResolutionStatus = 'Resolved' THEN 1
        ELSE 0
    END) AS ResolvedCases,

CAST(
    100.0 *
    SUM(CASE
            WHEN f.ReopenedFlag = 1 THEN 1
            ELSE 0
        END)
    / COUNT(*)
    AS DECIMAL(10,2)
) AS ReopenRate
```

FROM dbo.Fact_Interactions f

INNER JOIN dbo.Dim_Channel ch
ON f.ChannelID = ch.ChannelID

INNER JOIN dbo.Dim_Category cat
ON f.CategoryID = cat.CategoryID

GROUP BY

```
CAST(f.InteractionDateTime AS DATE),
ch.ChannelName,
cat.CategoryName;
```

GO

-- ============================================
-- AGENT PERFORMANCE
-- ============================================

CREATE OR ALTER VIEW dbo.vw_AgentPerformance
AS
SELECT

```
a.AgentID,
a.AgentName,
a.TeamLeader,
a.Department,

COUNT(*) AS TotalInteractions,

AVG(CAST(f.DurationSeconds AS DECIMAL(10,2))) AS AvgHandleTimeSeconds,

AVG(CAST(f.SatisfactionScore AS DECIMAL(10,2))) AS AvgSatisfactionScore,

CAST(
    100.0 *
    SUM(CASE
            WHEN f.ReopenedFlag = 1 THEN 1
            ELSE 0
        END)
    / COUNT(*)
    AS DECIMAL(10,2)
) AS ReopenRate
```

FROM dbo.Fact_Interactions f

INNER JOIN dbo.Dim_Agent a
ON f.AgentID = a.AgentID

GROUP BY

```
a.AgentID,
a.AgentName,
a.TeamLeader,
a.Department;
```

GO

-- ============================================
-- CHANNEL PERFORMANCE
-- ============================================

CREATE OR ALTER VIEW dbo.vw_ChannelPerformance
AS
SELECT

```
ch.ChannelID,
ch.ChannelName,
ch.IsDigital,

COUNT(*) AS TotalInteractions,

AVG(CAST(f.DurationSeconds AS DECIMAL(10,2))) AS AvgHandleTimeSeconds,

AVG(CAST(f.SatisfactionScore AS DECIMAL(10,2))) AS AvgSatisfactionScore,

SUM(CASE
        WHEN f.ReopenedFlag = 1 THEN 1
        ELSE 0
    END) AS ReopenedCases,

CAST(
    100.0 *
    SUM(CASE
            WHEN f.ReopenedFlag = 1 THEN 1
            ELSE 0
        END)
    / COUNT(*)
    AS DECIMAL(10,2)
) AS ReopenRate
```

FROM dbo.Fact_Interactions f

INNER JOIN dbo.Dim_Channel ch
ON f.ChannelID = ch.ChannelID

GROUP BY

```
ch.ChannelID,
ch.ChannelName,
ch.IsDigital;
```

GO

-- ============================================
-- CATEGORY PERFORMANCE
-- ============================================

CREATE OR ALTER VIEW dbo.vw_CategoryPerformance
AS
SELECT

```
cat.CategoryID,
cat.CategoryName,

COUNT(*) AS TotalInteractions,

AVG(CAST(f.DurationSeconds AS DECIMAL(10,2))) AS AvgHandleTimeSeconds,

AVG(CAST(f.SatisfactionScore AS DECIMAL(10,2))) AS AvgSatisfactionScore,

SUM(CASE
        WHEN f.ReopenedFlag = 1 THEN 1
        ELSE 0
    END) AS ReopenedCases,

SUM(CASE
        WHEN f.ResolutionStatus = 'Resolved' THEN 1
        ELSE 0
    END) AS ResolvedCases,

CAST(
    100.0 *
    SUM(CASE
            WHEN f.ReopenedFlag = 1 THEN 1
            ELSE 0
        END)
    / COUNT(*)
    AS DECIMAL(10,2)
) AS ReopenRate
```

FROM dbo.Fact_Interactions f

INNER JOIN dbo.Dim_Category cat
ON f.CategoryID = cat.CategoryID

GROUP BY

```
cat.CategoryID,
cat.CategoryName;
```

GO

-- ============================================
-- EXECUTIVE DASHBOARD
-- ============================================

CREATE OR ALTER VIEW dbo.vw_ExecutiveDashboard
AS
SELECT

```
COUNT(*) AS TotalInteractions,

COUNT(DISTINCT AgentID) AS ActiveAgents,

AVG(CAST(SatisfactionScore AS DECIMAL(10,2))) AS AvgCSAT,

AVG(CAST(DurationSeconds AS DECIMAL(10,2))) AS AvgHandleTimeSeconds,

SUM(CASE
        WHEN ReopenedFlag = 1 THEN 1
        ELSE 0
    END) AS ReopenedCases,

CAST(
    100.0 *
    SUM(CASE
            WHEN ReopenedFlag = 1 THEN 1
            ELSE 0
        END)
    / COUNT(*)
    AS DECIMAL(10,2)
) AS ReopenRate,

SUM(CASE
        WHEN ResolutionStatus = 'Resolved' THEN 1
        ELSE 0
    END) AS ResolvedCases,

CAST(
    100.0 *
    SUM(CASE
            WHEN ResolutionStatus = 'Resolved' THEN 1
            ELSE 0
        END)
    / COUNT(*)
    AS DECIMAL(10,2)
) AS ResolutionRate
```

FROM dbo.Fact_Interactions;
GO
