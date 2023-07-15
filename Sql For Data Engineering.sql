
  SELECT  *
      ,Coalesce([Age],29.7) as AgeCleaned
           
      ,Coalesce([Cabin],'Not Specified') as CabinCleaned
	 
    ,CASE
        WHEN lower(sex) IN ('f', 'female') THEN 'Female'
        WHEN sex IN ('male', 'm') THEN 'Male'
        ELSE TRIM(sex)
    END AS genderCleaned
	, LTRIM(RTRIM(SUBSTRING(Name, 1, CASE WHEN CHARINDEX(',', Name) > 0 THEN CHARINDEX(',', Name) - 1 ELSE LEN(Name) END))) AS Last_Name
    ,CASE
        WHEN PATINDEX('%Mr.%', Name) > 0 THEN 'Mr.'
        WHEN PATINDEX('%Mrs.%', Name) > 0 THEN 'Mrs.'
        WHEN PATINDEX('%Miss.%', Name) > 0 THEN 'Miss.'
        WHEN PATINDEX('%Mme.%', Name) > 0 THEN 'Mme.'
        WHEN PATINDEX('%Cap.%', Name) > 0 THEN 'Cap.'
        WHEN PATINDEX('%Rev.%', Name) > 0 THEN 'Rev.'
        WHEN PATINDEX('%Major%', Name) > 0 THEN 'Major'
        WHEN PATINDEX('%Countess.%', Name) > 0 THEN 'Countess.'
        WHEN PATINDEX('%Mlle.%', Name) > 0 THEN 'Mlle.'
        WHEN PATINDEX('%Col.%', Name) > 0 THEN 'Col.'
        WHEN PATINDEX('%Master.%', Name) > 0 THEN 'Master.'
        WHEN PATINDEX('%Dr.%', Name) > 0 THEN 'Dr.'
        WHEN PATINDEX('%Don.%', Name) > 0 THEN 'Don.'
        ELSE ''
    END AS Title
	, CASE
        WHEN CHARINDEX('.', Name) > 0 THEN SUBSTRING(Name, CHARINDEX('.', Name) + 1, LEN(Name))
        ELSE Name
    END AS First_Name
INTO #DB
FROM [New Database].[dbo].[newtable]
	
select *
from #DB