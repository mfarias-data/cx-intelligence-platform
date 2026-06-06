USE CX_Analytics_DW;
GO

-- ============================================
-- LOAD DIM_AGENT
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
-- LOAD FACT_INTERACTIONS
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
