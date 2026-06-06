-- ============================================
-- CX Intelligence Platform
-- Database Schema Creation
-- ============================================

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'CX_Analytics_DW')
BEGIN
    ALTER DATABASE CX_Analytics_DW
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE CX_Analytics_DW;
END
GO

CREATE DATABASE CX_Analytics_DW;
GO

USE CX_Analytics_DW;
GO

-- ============================================
-- DIMENSIONS
-- ============================================

CREATE TABLE Dim_Channel (
    ChannelID INT IDENTITY(1,1) PRIMARY KEY,
    ChannelName VARCHAR(20) NOT NULL,
    IsDigital BIT NOT NULL
);

CREATE TABLE Dim_Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE Dim_Agent (
    AgentID INT PRIMARY KEY,
    AgentName VARCHAR(100) NOT NULL,
    TeamLeader VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL
);

CREATE TABLE Dim_Calendar (
    DateKey DATE PRIMARY KEY,
    CalendarYear INT,
    CalendarMonth INT,
    MonthName VARCHAR(20),
    QuarterNumber INT
);

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
(ChannelName, IsDigital)
VALUES
('Chat',1),
('Voice',0),
('Email',1),
('Bot',1);

INSERT INTO Dim_Category
(CategoryName)
VALUES
('Technical Support'),
('Billing'),
('Shipping'),
('Product Information'),
('Software Update'),
('Account Access');

GO
