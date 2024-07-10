use DIM_ALZHEIMER_DB;

--Dim Strat 1
INSERT INTO [DIM_ALZHEIMER_DB].[dbo].[DimStratification1] (StratificationID1, AgeGroup, StratificationCategoryID1)
SELECT DISTINCT
    StratificationID1,
    [Age Group] AS AgeGroup,
    StratificationCategoryID1
FROM [ALZHEIMER_DB].[dbo].[AlzheimerStaging]


--Dim Strat 2
INSERT INTO [DIM_ALZHEIMER_DB].[dbo].[DimStratification2] (StratificationID2, Stratification2, StratificationCategory2, StratificationCategoryID2)
SELECT DISTINCT
    StratificationID2,
    Stratification2,
    StratificationCategory2,
    StratificationCategoryID2
FROM [ALZHEIMER_DB].[dbo].[AlzheimerStaging]

--Dim Class
INSERT INTO [DIM_ALZHEIMER_DB].[dbo].[DimClass] (ClassID, Class)
SELECT DISTINCT
    ClassID,
    Class
FROM [ALZHEIMER_DB].[dbo].[AlzheimerStaging]


--Dim Topic
INSERT INTO [DIM_ALZHEIMER_DB].[dbo].[DimTopic] (TopicID, Topic)
SELECT DISTINCT
    TopicID,
    Topic
FROM [ALZHEIMER_DB].[dbo].[AlzheimerStaging]


--Dim Location
INSERT INTO [DIM_ALZHEIMER_DB].[dbo].[DimLocation] (LocationID, LocationAbbr, LocationDesc)
SELECT DISTINCT
    LocationID,
    LocationAbbr,
    LocationDesc
FROM [ALZHEIMER_DB].[dbo].[AlzheimerStaging]

--Dim Value Type
INSERT INTO [DIM_ALZHEIMER_DB].[dbo].[DimDataValueType] (DataValueTypeID, Data_Value_Type)
SELECT DISTINCT
    DataValueTypeID,
    Data_Value_Type
FROM [ALZHEIMER_DB].[dbo].[AlzheimerStaging]

--Dim Question
INSERT INTO [DIM_ALZHEIMER_DB].[dbo].[DimQuestion] (QuestionID, Question)
SELECT DISTINCT
    QuestionID,
    Question
FROM [ALZHEIMER_DB].[dbo].[AlzheimerStaging]

--DIM FACT
INSERT INTO FactAlzheimer (
    RowId,
    YearStart,
    YearEnd,
    LocationID,
    ClassID,
    TopicID,
    QuestionID,
    DataValueTypeID,
    Data_Value,
    Low_Confidence_Limit,
    High_Confidence_Limit,
    StratificationID1,
    StratificationID2,
    Longitud,
    Latitud
)
SELECT
    RowId,
    YearStart,
    YearEnd,
    LocationID,
    ClassID,
    TopicID,
    QuestionID,
    DataValueTypeID,
    Data_Value,
    Low_Confidence_Limit,
    High_Confidence_Limit,
    StratificationID1,
    StratificationID2,
    Longitud,
    Latitud
FROM [ALZHEIMER_DB].[dbo].[AlzheimerStaging];



