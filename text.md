Premier League Data Analysis: Shift in Dominance
================================================

Overview
--------

This project aims to analyze the performance trends of teams in the English Premier League (EPL) from 1993 to 2023. The analysis focuses on identifying the top-performing teams, the shift in dominance over the years, and the correlation between goals scored, goals conceded, and points accumulated. Additionally, we examine predictive models to estimate the points required for a team to win the league based on historical data.

Data Source
-----------

The dataset used in this analysis is sourced from Kaggle, specifically the Premier League Matches 1993-2023 dataset. It contains information on every match played in the Premier League over the past 30 years, including the teams, goals scored, goals conceded, and match results (home win, away win, or draw).

**Data Source**:Premier League Matches 1993-2023 on Kaggle

Data Exploration & Cleaning
---------------------------

The data was initially in CSV format and imported using SAS procedures. Key steps involved:

*   Importing the dataset using PROC IMPORT.
    
*   Cleaning the dataset by removing unnecessary white spaces and duplications using PROC MEANS and other SAS cleaning methods.
    
*   Creating several permanent tables for analysis, including SortedData, Ranking, Winners, and PointsTable.
    

Data Analysis
-------------

### Key Insights:

*   Manchester United is the most successful team in terms of total points scored and titles won over the past 30 years.
    
*   A shift in dominance is observed, with Manchester City showing rapid improvement, particularly in the last decade.
    
*   Arsenal, Liverpool, and Tottenham, though consistent in scoring points, have won fewer titles compared to the top teams.
    
*   Chelsea's performance has seen a decline in recent years.
    

### Key Visualizations:

*   Pie charts showing the number of titles won and total points scored by top teams.
    
*   Bar graphs illustrating the performance trends of the top 5 teams by decade.
    
*   Scatter plots correlating goals scored and points earned.
    

Predictive Analysis
-------------------

### Linear Regression:

Using linear regression, we predict the number of points required for a team to win the league, based on historical performance. The regression model indicates that a team needs to score at least 83 points to have a high chance of winning the league.

### Correlation Analysis:

*   A strong correlation exists between total points and goals scored, with goals conceded showing a negative correlation with points.
    

Tools & Technologies
--------------------

*   **SAS**: Used for data cleaning, analysis, and creating visualizations.
    
*   **PowerPoint**: Final results and visualizations were exported using the ODS PowerPoint method for presentations.
    

How to Use
----------

1.  **Clone the repository** or download the project files.
    
2.  **Open the SAS files** (.sas) to view data import, cleaning, and analysis procedures.
    
3.  View the final PowerPoint presentation for summarized results and visualizations.
    

References
----------

*   Kaggle Premier League Dataset
    
*   SAS Documentation: [SAS 9.4](https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/pgmsaswlcm/home.htm)
    

About the Author
----------------

Danish BhatkarGraduate Student, Computer ScienceClemson University, Class of 2025Football and Data Science Enthusiast
