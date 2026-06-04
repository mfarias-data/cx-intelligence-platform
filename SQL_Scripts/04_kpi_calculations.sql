-- ============================================
-- CX Intelligence Platform
-- KPI Calculations
-- ============================================

USE CX_Analytics_DW;
GO

WITH InteractionMetrics AS
(
    SELECT

        InteractionID,
        InteractionDateTime,
        Channel,
        IssueCategory,
        DurationSeconds,
        ResolutionStatus,
        ReopenedFlag,
        SatisfactionScore,

        WithinSLA,
        IsFCR

    FROM vw_CX_Dashboard_Core
),

KPI_Summary AS
(
    SELECT

        Channel,

        COUNT(*) AS TotalInteractions,

        AVG(CAST(DurationSeconds AS FLOAT)) AS AHT_Seconds,

        AVG(CAST(WithinSLA AS FLOAT)) * 100 AS SLA_Percentage,

        AVG(CAST(IsFCR AS FLOAT)) * 100 AS FCR_Percentage,

        AVG(CAST(SatisfactionScore AS FLOAT)) AS Avg_CSAT,

        AVG(CAST(ReopenedFlag AS FLOAT)) * 100 AS ReopenRate

    FROM InteractionMetrics

    GROUP BY Channel
)

SELECT *
FROM KPI_Summary
ORDER BY TotalInteractions DESC;
GO


-- ============================================
-- Monthly Performance Trend
-- ============================================

SELECT

    InteractionYear,
    InteractionMonth,

    COUNT(*) AS TotalInteractions,

    AVG(CAST(WithinSLA AS FLOAT)) * 100 AS SLA_Percentage,

    AVG(CAST(IsFCR AS FLOAT)) * 100 AS FCR_Percentage,

    AVG(CAST(SatisfactionScore AS FLOAT)) AS Avg_CSAT,

    AVG(CAST(DurationSeconds AS FLOAT)) AS AHT_Seconds

FROM vw_CX_Dashboard_Core

GROUP BY
    InteractionYear,
    InteractionMonth

ORDER BY
    InteractionYear,
    InteractionMonth;
GO


-- ============================================
-- Category Performance Ranking
-- ============================================

SELECT

    IssueCategory,

    COUNT(*) AS TotalInteractions,

    AVG(CAST(IsFCR AS FLOAT)) * 100 AS FCR_Percentage,

    AVG(CAST(ReopenedFlag AS FLOAT)) * 100 AS ReopenRate,

    RANK() OVER (
        ORDER BY AVG(CAST(IsFCR AS FLOAT)) ASC
    ) AS FCR_Rank

FROM vw_CX_Dashboard_Core

GROUP BY IssueCategory;
GO
