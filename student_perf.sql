/*
Created by: Brandy Nolan
Created On: August 18, 2024
Description: Kaggle dataset includes features that are commonly considered in educational research.
*/

-- Gender distribution is split 50/50
SELECT
	`Gender`,
    COUNT(*) total,
    CONCAT(ROUND(COUNT(`Gender`) * 100.0 / SUM(COUNT(`Gender`)) OVER (), 2),"%") percentage
FROM 
	`students`.`student_performance` 
GROUP BY
	`Gender`;
    
-- Parental Support by Gender 
SELECT
	`ParentalSupport`,
	SUM(CASE WHEN `Gender` = 'Female' THEN 1 ELSE 0 END) AS Female,
    CONCAT(ROUND(SUM(CASE WHEN `Gender` = 'Female' THEN 1 ELSE 0 END) / (SELECT COUNT(*) FROM students.student_performance) * 100,2),"%") AS Female_Support_Percent,
    SUM(CASE WHEN `Gender` = 'Male' THEN 1 ELSE 0 END) AS Male,
    CONCAT(ROUND(SUM(CASE WHEN `Gender` = 'Male' THEN 1 ELSE 0 END) / (SELECT COUNT(*) FROM students.student_performance) * 100,2),"%") AS Male_Support_Percent
FROM 
	`students`.`student_performance` 
GROUP BY
	`ParentalSupport`
ORDER BY 1;

-- Alex and Emma showed the most improvement amongst their classmates.
SELECT
	`Name`,
	SUM(`FinalGrade`- `PreviousGrade` ) `Grade Improvement`
FROM 
	`students`.`student_performance` 
GROUP BY 
	`Name`
ORDER BY
	2 DESC;
    
-- On average Male students showed a slightly greater improvement over Female students
SELECT
	`Gender`,
	ROUND(AVG(`FinalGrade`- `PreviousGrade`),2) `Grade Improvement`
FROM 
	`students`.`student_performance` 
GROUP BY 
	`Gender`
ORDER BY
	2 DESC;

-- KPIs by gender
 SELECT
	`Gender`,
	ROUND(AVG(`AttendanceRate`),0) Avg_Attendace_Rate,
    ROUND(AVG(`StudyHoursPerWeek`),0) Avg_Study_Hrs_Week,
    ROUND(AVG(`ExtracurricularActivities`),0) Avg_Extracurricualr_Activities
 FROM 
	`students`.`student_performance` 
GROUP BY
	`Gender`
    
-- Avg Final Grade by Parental support
SELECT 
    `ParentalSupport`, 
    ROUND(AVG(`FinalGrade`),0) AS `Avg_FinalGrade`
FROM 
    `students`.`student_performance`
GROUP BY 
    `ParentalSupport`;