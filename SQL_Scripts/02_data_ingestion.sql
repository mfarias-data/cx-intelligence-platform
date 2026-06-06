USE CX_Analytics_DW;
GO

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

    agent_name VARCHAR(100),

    team_leader VARCHAR(100),

    department VARCHAR(50),

    duration_seconds VARCHAR(20),

    resolution_status VARCHAR(20),

    reopened_flag VARCHAR(10),

    satisfaction_score VARCHAR(10)
);

GO

/*
BULK INSERT Staging_Interactions
FROM 'C:\Data\omnichannel_interactions.csv'
WITH (
    FORMAT='CSV',
    FIRSTROW=2,
    FIELDTERMINATOR=',',
    ROWTERMINATOR='\n',
    TABLOCK
);
*/

GO

-- ============================================
-- LOAD AGENT DIMENSION
-- ============================================

INSERT INTO Dim_Agent
(
    AgentID,
    AgentName,
    TeamLeader,
    Department
)
SELECT DISTINCT

    CAST(agent_id AS INT),

    agent_name,

    team_leader,

    department

FROM Staging_Interactions;

GO

-- ============================================
-- LOAD FACT TABLE
-- ============================================

INSERT INTO Fact_Interactions
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

    CAST(s.timestamp AS DATETIME2),

    CAST(s.customer_id AS INT),

    CAST(s.agent_id AS INT),

    dc.ChannelID,

    dcat.CategoryID,

    CAST(s.duration_seconds AS INT),

    s.resolution_status,

    CAST(s.reopened_flag AS BIT),

    CAST(s.satisfaction_score AS INT)

FROM Staging_Interactions s

INNER JOIN Dim_Channel dc
ON s.channel = dc.ChannelName

INNER JOIN Dim_Category dcat
ON s.category = dcat.CategoryName;

GO
