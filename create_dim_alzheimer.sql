use DIM_ALZHEIMER_DB;

IF OBJECT_ID('FactAlzheimer', 'U') IS NOT NULL
    DROP TABLE FactAlzheimer;

IF OBJECT_ID('DimLocation', 'U') IS NOT NULL
    DROP TABLE DimLocation;

IF OBJECT_ID('DimClass', 'U') IS NOT NULL
    DROP TABLE DimClass;

IF OBJECT_ID('DimTopic', 'U') IS NOT NULL
    DROP TABLE DimTopic;

IF OBJECT_ID('DimQuestion', 'U') IS NOT NULL
    DROP TABLE DimQuestion;

IF OBJECT_ID('DimDataValueType', 'U') IS NOT NULL
    DROP TABLE DimDataValueType;

IF OBJECT_ID('DimAgeGroup', 'U') IS NOT NULL
    DROP TABLE DimAgeGroup;

IF OBJECT_ID('DimStratification1', 'U') IS NOT NULL
    DROP TABLE DimStratification1;

IF OBJECT_ID('DimStratification2', 'U') IS NOT NULL
    DROP TABLE DimStratification2;

IF OBJECT_ID('DimQuestion', 'U') IS NOT NULL
    DROP TABLE DimQuestion;

-----------------------------------------------------------------------------------
CREATE TABLE DimQuestion (
    QuestionID FLOAT PRIMARY KEY,
    Question VARCHAR(255)
);

CREATE TABLE DimStratification1 (
    StratificationID1 VARCHAR(255) PRIMARY KEY,
    AgeGroup VARCHAR(255),
    StratificationCategoryID1 VARCHAR(255)
);

CREATE TABLE DimStratification2 (
    StratificationID2 VARCHAR(255) PRIMARY KEY,
    Stratification2 VARCHAR(255),
    StratificationCategory2 VARCHAR(255),
    StratificationCategoryID2 VARCHAR(255)
);

CREATE TABLE DimClass (
    ClassID VARCHAR(255) PRIMARY KEY,
    Class VARCHAR(255)
);

CREATE TABLE DimTopic (
    TopicID VARCHAR(255) PRIMARY KEY,
    Topic VARCHAR(255)
);

CREATE TABLE DimLocation (
    LocationID BIGINT PRIMARY KEY,
    LocationAbbr VARCHAR(255),
    LocationDesc VARCHAR(255)
);

CREATE TABLE DimDataValueType (
    DataValueTypeID VARCHAR(255) PRIMARY KEY,
    Data_Value_Type VARCHAR(255)
);

CREATE TABLE FactAlzheimer (
    RowId VARCHAR(255),
    YearStart BIGINT,
    YearEnd BIGINT,
    LocationID BIGINT,
    ClassID VARCHAR(255),
    TopicID VARCHAR(255),
    DataValueTypeID VARCHAR(255),
    Data_Value VARCHAR(255),
    Low_Confidence_Limit FLOAT,
    High_Confidence_Limit FLOAT,
    StratificationID1 VARCHAR(255),
    StratificationID2 VARCHAR(255),
    Longitud VARCHAR(50),
    Latitud VARCHAR(50),
    QuestionID FLOAT,
    FOREIGN KEY (LocationID) REFERENCES DimLocation(LocationID),
    FOREIGN KEY (ClassID) REFERENCES DimClass(ClassID),
    FOREIGN KEY (TopicID) REFERENCES DimTopic(TopicID),
    FOREIGN KEY (DataValueTypeID) REFERENCES DimDataValueType(DataValueTypeID),
    FOREIGN KEY (StratificationID1) REFERENCES DimStratification1(StratificationID1),
    FOREIGN KEY (StratificationID2) REFERENCES DimStratification2(StratificationID2),
    FOREIGN KEY (QuestionID) REFERENCES DimQuestion(QuestionID)
);
