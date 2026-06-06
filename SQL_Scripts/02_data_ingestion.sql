-- ============================================
-- CX Intelligence Platform
-- Data Ingestion & ETL Process
-- ============================================

USE CX_Analytics_DW;
GO

-- ============================================
-- CLEAN TARGET TABLES
-- ============================================

DELETE FROM dbo.Fact_Interactions;
DELETE FROM dbo.Dim_Agent;
GO

-- ============================================
-- LOAD AGENT DIMENSION
-- ============================================

INSERT INTO dbo.Dim_Agent
(
    AgentID,
    AgentName,
    TeamLeader,
    Department
)
SELECT DISTINCT

    agent_id,
    agent_name,
    team_leader,
    department

FROM dbo.Staging_Interactions;
GO

-- ============================================
-- LOAD FACT TABLE
-- ============================================

INSERT INTO dbo.Fact_Interactions
(
    InteractionID,
    InteractionDateTime,
    CustomerID,
    AgentID,
    ChannelID,
    CategoryID,
    DurationSeconds,
    ResolutionStatus,
    ReopenedFlag,
    SatisfactionScore
)
SELECT

    CAST(s.interaction_id AS UNIQUEIDENTIFIER),

    s.timestamp,

    s.customer_id,

    s.agent_id,

    dc.ChannelID,

    dcat.CategoryID,

    s.duration_seconds,

    s.resolution_status,

    s.reopened_flag,

    s.satisfaction_score

FROM dbo.Staging_Interactions s

INNER JOIN dbo.Dim_Channel dc
    ON s.channel = dc.ChannelName

INNER JOIN dbo.Dim_Category dcat
    ON s.category = dcat.CategoryName;
GO

-- ============================================
-- VALIDATION
-- ============================================

SELECT COUNT(*) AS TotalAgents
FROM dbo.Dim_Agent;

SELECT COUNT(*) AS TotalInteractions
FROM dbo.Fact_Interactions;
GO
