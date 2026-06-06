-- ============================================
-- CX Intelligence Platform
-- Database Schema Creation
-- ============================================

USE CX_Analytics_DW;
GO

-- ============================================
-- CLEANUP
-- ============================================

IF OBJECT_ID('Fact_Interactions','U') IS NOT NULL
    DROP TABLE Fact_Interactions;
GO

IF OBJECT_ID('Dim_Agent','U') IS NOT NULL
    DROP TABLE Dim_Agent;
GO

IF OBJECT_ID('Dim_Category','U') IS NOT NULL
    DROP TABLE Dim_Category;
GO

IF OBJECT_ID('Dim_Channel','U') IS NOT NULL
    DROP TABLE Dim_Channel;
GO

IF OBJECT_ID('Dim_Calendar','U') IS NOT NULL
    DROP TABLE Dim_Calendar;
GO

-- ============================================
-- DIMENSIONS
-- ============================================

CREATE TABLE Dim_Channel (

    ChannelID INT IDENTITY(1,1) PRIMARY KEY,

    ChannelName VARCHAR(20) NOT NULL,

    IsDigital BIT NOT NULL

);
GO

CREATE TABLE Dim_Category (

    CategoryID INT IDENTITY(1,1) PRIMARY KEY,

    CategoryName VARCHAR(50) NOT NULL

);
GO

CREATE TABLE Dim_Agent (

    AgentID INT PRIMARY KEY,

    AgentName VARCHAR(100) NOT NULL,

    TeamLeader VARCHAR(100) NOT NULL,

    Department VARCHAR(50) NOT NULL

);
GO

CREATE TABLE Dim_Calendar (

    DateKey DATE PRIMARY KEY,

    CalendarYear INT,

    CalendarMonth INT,

    MonthName VARCHAR(20),

    QuarterNumber INT

);
GO

-- ============================================
-- FACT TABLE
-- ============================================

CREATE TABLE Fact_Interactions (

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
        REFERENCES Dim_Channel(ChannelID),

    CONSTRAINT FK_Fact_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Dim_Category(CategoryID),

    CONSTRAINT FK_Fact_Agent
        FOREIGN KEY (AgentID)
        REFERENCES Dim_Agent(AgentID)

);
GO

-- ============================================
-- STATIC DIMENSIONS
-- ============================================

INSERT INTO Dim_Channel
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

INSERT INTO Dim_Category
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
