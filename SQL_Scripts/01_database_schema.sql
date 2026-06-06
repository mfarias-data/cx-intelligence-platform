-- ============================================
-- CX Intelligence Platform
-- Database Schema Creation
-- Version: 1.0
-- ============================================

-- ============================================
-- CREATE DATABASE IF NOT EXISTS
-- ============================================

USE master;
GO

IF DB_ID('CX_Analytics_DW') IS NULL
BEGIN
    CREATE DATABASE CX_Analytics_DW;
END
GO

USE CX_Analytics_DW;
GO

-- ============================================
-- CLEANUP
-- ============================================

IF OBJECT_ID('dbo.Fact_Interactions','U') IS NOT NULL
    DROP TABLE dbo.Fact_Interactions;
GO

IF OBJECT_ID('dbo.Dim_Agent','U') IS NOT NULL
    DROP TABLE dbo.Dim_Agent;
GO

IF OBJECT_ID('dbo.Dim_Category','U') IS NOT NULL
    DROP TABLE dbo.Dim_Category;
GO

IF OBJECT_ID('dbo.Dim_Channel','U') IS NOT NULL
    DROP TABLE dbo.Dim_Channel;
GO

IF OBJECT_ID('dbo.Dim_Calendar','U') IS NOT NULL
    DROP TABLE dbo.Dim_Calendar;
GO

-- ============================================
-- DIMENSION TABLES
-- ============================================

CREATE TABLE dbo.Dim_Channel
(
    ChannelID INT IDENTITY(1,1) PRIMARY KEY,

    ChannelName VARCHAR(20) NOT NULL,

    IsDigital BIT NOT NULL
);
GO

CREATE TABLE dbo.Dim_Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,

    CategoryName VARCHAR(50) NOT NULL
);
GO

CREATE TABLE dbo.Dim_Agent
(
    AgentID INT PRIMARY KEY,

    AgentName VARCHAR(100) NOT NULL,

    TeamLeader VARCHAR(100) NOT NULL,

    Department VARCHAR(50) NOT NULL
);
GO

CREATE TABLE dbo.Dim_Calendar
(
    DateKey DATE PRIMARY KEY,

    CalendarYear INT NOT NULL,

    CalendarMonth INT NOT NULL,

    MonthName VARCHAR(20) NOT NULL,

    QuarterNumber INT NOT NULL
);
GO

-- ============================================
-- FACT TABLE
-- ============================================

CREATE TABLE dbo.Fact_Interactions
(
    InteractionID UNIQUEIDENTIFIER PRIMARY KEY,

    InteractionDateTime DATETIME2 NOT NULL,

    CustomerID INT NOT NULL,

    AgentID INT NOT NULL,

    ChannelID INT NOT NULL,

    CategoryID INT NOT NULL,

    DurationSeconds INT NOT NULL,

    ResolutionStatus VARCHAR(20) NOT NULL,

    ReopenedFlag BIT NOT NULL,

    SatisfactionScore INT NOT NULL,

    CONSTRAINT FK_Fact_Channel
        FOREIGN KEY (ChannelID)
        REFERENCES dbo.Dim_Channel(ChannelID),

    CONSTRAINT FK_Fact_Category
        FOREIGN KEY (CategoryID)
        REFERENCES dbo.Dim_Category(CategoryID),

    CONSTRAINT FK_Fact_Agent
        FOREIGN KEY (AgentID)
        REFERENCES dbo.Dim_Agent(AgentID)
);
GO

-- ============================================
-- STATIC DIMENSIONS
-- ============================================

INSERT INTO dbo.Dim_Channel
(
    ChannelName,
    IsDigital
)
VALUES
('Chat',1),
('Voice',0),
('Email',1),
('Bot',1);
GO

INSERT INTO dbo.Dim_Category
(
    CategoryName
)
VALUES
('Technical Support'),
('Billing'),
('Shipping'),
('Product Information'),
('Software Update'),
('Account Access');
GO

-- ============================================
-- CALENDAR DIMENSION
-- ============================================

DECLARE @StartDate DATE = '2026-01-01';
DECLARE @EndDate DATE = '2026-12-31';

WHILE @StartDate <= @EndDate
BEGIN

    INSERT INTO dbo.Dim_Calendar
    (
        DateKey,
        CalendarYear,
        CalendarMonth,
        MonthName,
        QuarterNumber
    )
    VALUES
    (
        @StartDate,
        YEAR(@StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH,@StartDate),
        DATEPART(QUARTER,@StartDate)
    );

    SET @StartDate = DATEADD(DAY,1,@StartDate);

END
GO

-- ============================================
-- VALIDATION
-- ============================================

SELECT 'Dim_Channel' AS TableName,
       COUNT(*) AS Records
FROM dbo.Dim_Channel

UNION ALL

SELECT 'Dim_Category',
       COUNT(*)
FROM dbo.Dim_Category

UNION ALL

SELECT 'Dim_Calendar',
       COUNT(*)
FROM dbo.Dim_Calendar;
GO
