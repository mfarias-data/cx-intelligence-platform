-- ============================================
-- CX Intelligence Platform
-- Semantic Layer
-- ============================================

USE CX_Analytics_DW;
GO

CREATE OR ALTER VIEW vw_CX_Dashboard_Core AS
SELECT

    f.InteractionID,
    f.InteractionDateTime,

    -- Date attributes
    YEAR(f.InteractionDateTime) AS InteractionYear,
    MONTH(f.InteractionDateTime) AS InteractionMonth,
    DATEPART(HOUR, f.InteractionDateTime) AS InteractionHour,

    -- Dimensions
    c.ChannelName AS Channel,
    cat.CategoryName AS IssueCategory,

    f.CustomerID,
    f.AgentID,

    -- Operational metrics
    f.DurationSeconds,
    f.ResolutionStatus,
    f.ReopenedFlag,
    f.SatisfactionScore,

    -- SLA Logic
    CASE
        WHEN c.ChannelName = 'Bot'
             AND f.DurationSeconds <= 180
        THEN 1

        WHEN c.ChannelName <> 'Bot'
             AND f.DurationSeconds <= 600
        THEN 1

        ELSE 0
    END AS WithinSLA,

    -- FCR Logic
    CASE
        WHEN f.ResolutionStatus = 'Resolved'
             AND f.ReopenedFlag = 0
        THEN 1

        ELSE 0
    END AS IsFCR

FROM Fact_Interactions f

INNER JOIN Dim_Channel c
    ON f.ChannelID = c.ChannelID

INNER JOIN Dim_Category cat
    ON f.CategoryID = cat.CategoryID;
GO
