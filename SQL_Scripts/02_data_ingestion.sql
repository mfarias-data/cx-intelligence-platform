-- ============================================
-- CX Intelligence Platform
-- Data Ingestion & ELT Process
-- ============================================

USE CX_Analytics_DW;
GO

-- ============================================
-- STAGING TABLE
-- Raw data arrives here exactly as received
-- ============================================

IF OBJECT_ID('Staging_Interactions', 'U') IS NOT NULL
    DROP TABLE Staging_Interactions;
GO

CREATE TABLE Staging_Interactions (
    interaction_id VARCHAR(100),
    timestamp VARCHAR(50),
    channel VARCHAR(20),
    category VARCHAR(50),
    customer_id VARCHAR(20),
    agent_id VARCHAR(20),
    duration_seconds VARCHAR(20),
    resolution_status VARCHAR(20),
    reopened_flag VARCHAR(10),
    satisfaction_score VARCHAR(10)
);
GO

-- ============================================
-- BULK INSERT
-- Update the path according to your environment
-- ============================================

/*
BULK INSERT Staging_Interactions
FROM 'C:\Data\omnichannel_interactions.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
*/
GO

-- ============================================
-- ELT PROCESS
-- Explicit type conversion
-- ============================================

INSERT INTO Fact_Interactions (
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

    CAST(s.timestamp AS DATETIME2),

    CAST(s.customer_id AS INT),

    CAST(s.agent_id AS INT),

    dc.ChannelID,

    dcat.CategoryID,

    CAST(s.duration_seconds AS INT),

    CAST(s.resolution_status AS VARCHAR(20)),

    CAST(s.reopened_flag AS BIT),

    CAST(s.satisfaction_score AS INT)

FROM Staging_Interactions s

INNER JOIN Dim_Channel dc
    ON dc.ChannelName = s.channel

INNER JOIN Dim_Category dcat
    ON dcat.CategoryName = s.category;
GO
