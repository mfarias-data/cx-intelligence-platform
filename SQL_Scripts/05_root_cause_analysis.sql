-- ============================================
-- CX Intelligence Platform
-- Root Cause Analysis
-- ============================================

USE CX_Analytics_DW;
GO

-- ============================================
-- 1. Category + Channel Performance
-- ============================================

SELECT

    Channel,
    IssueCategory,

    COUNT(*) AS TotalInteractions,

    AVG(CAST(IsFCR AS FLOAT)) * 100 AS FCR_Percentage,

    AVG(CAST(ReopenedFlag AS FLOAT)) * 100 AS ReopenRate,

    AVG(CAST(DurationSeconds AS FLOAT)) AS AvgHandleTime,

    AVG(CAST(SatisfactionScore AS FLOAT)) AS AvgCSAT

FROM vw_CX_Dashboard_Core

GROUP BY
    Channel,
    IssueCategory

ORDER BY
    ReopenRate DESC,
    FCR_Percentage ASC;
GO


-- ============================================
-- 2. Worst Performing Segments
-- ============================================

SELECT TOP 10

    Channel,
    IssueCategory,

    COUNT(*) AS TotalInteractions,

    AVG(CAST(IsFCR AS FLOAT)) * 100 AS FCR_Percentage,

    AVG(CAST(ReopenedFlag AS FLOAT)) * 100 AS ReopenRate

FROM vw_CX_Dashboard_Core

GROUP BY
    Channel,
    IssueCategory

ORDER BY
    ReopenRate DESC,
    FCR_Percentage ASC;
GO


-- ============================================
-- 3. Monthly Evolution
-- ============================================

SELECT

    InteractionYear,
    InteractionMonth,

    Channel,
    IssueCategory,

    COUNT(*) AS TotalInteractions,

    AVG(CAST(IsFCR AS FLOAT)) * 100 AS FCR_Percentage,

    AVG(CAST(ReopenedFlag AS FLOAT)) * 100 AS ReopenRate

FROM vw_CX_Dashboard_Core

GROUP BY

    InteractionYear,
    InteractionMonth,

    Channel,
    IssueCategory

ORDER BY

    InteractionYear,
    InteractionMonth;
GO


-- ============================================
-- 4. Executive RCA Summary
-- ============================================

SELECT

    Channel,
    IssueCategory,

    COUNT(*) AS TotalInteractions,

    SUM(CASE
        WHEN ResolutionStatus <> 'Resolved'
        THEN 1
        ELSE 0
    END) AS UnresolvedCases,

    AVG(CAST(IsFCR AS FLOAT)) * 100 AS FCR_Percentage,

    AVG(CAST(ReopenedFlag AS FLOAT)) * 100 AS ReopenRate,

    AVG(CAST(SatisfactionScore AS FLOAT)) AS AvgCSAT

FROM vw_CX_Dashboard_Core

GROUP BY
    Channel,
    IssueCategory

HAVING COUNT(*) >= 20

ORDER BY
    UnresolvedCases DESC;
GO
