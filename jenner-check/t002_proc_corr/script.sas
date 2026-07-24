/* Danish Bhatkar - Final Project: Premier League 1993-2023 */
/* Correlation of Total Points against goals scored and conceded (PROC CORR PEARSON SPEARMAN). */

/* --- Inline sample of the real premier-league-matches.csv (season 1993 subset,
   the same 8 columns as the Kaggle source) so the bundle is self-contained. --- */
data rawdata;
	infile datalines dsd dlm='|';
	length Home $20 Away $20 FTR $1 Date $10;
	input Season_End_Year Wk Date $ Home $ HomeGoals AwayGoals Away $ FTR $;
	datalines;
1993|1|1992-08-15|Coventry City|2|1|Middlesbrough|H
1993|1|1992-08-15|Leeds United|2|1|Wimbledon|H
1993|1|1992-08-15|Sheffield Utd|2|1|Manchester Utd|H
1993|1|1992-08-15|Crystal Palace|3|3|Blackburn|D
1993|1|1992-08-15|Arsenal|2|4|Norwich City|A
1993|1|1992-08-15|Ipswich Town|1|1|Aston Villa|D
1993|1|1992-08-15|Everton|1|1|Sheffield Weds|D
1993|1|1992-08-15|Southampton|0|0|Tottenham|D
1993|1|1992-08-15|Chelsea|1|1|Oldham Athletic|D
1993|1|1992-08-16|Nott'ham Forest|1|0|Liverpool|H
1993|1|1992-08-17|Manchester City|1|1|QPR|D
1993|2|1992-08-18|Blackburn|1|0|Arsenal|H
1993|2|1992-08-18|Wimbledon|0|1|Ipswich Town|A
1993|2|1992-08-19|Tottenham|0|2|Coventry City|A
1993|2|1992-08-19|Liverpool|2|1|Sheffield Utd|H
1993|2|1992-08-19|Aston Villa|1|1|Leeds United|D
1993|2|1992-08-19|Oldham Athletic|1|1|Crystal Palace|D
1993|2|1992-08-19|Middlesbrough|2|0|Manchester City|H
1993|2|1992-08-19|Norwich City|2|1|Chelsea|H
1993|2|1992-08-19|QPR|3|1|Southampton|H
1993|2|1992-08-19|Manchester Utd|0|3|Everton|A
1993|2|1992-08-19|Sheffield Weds|2|0|Nott'ham Forest|H
1993|3|1992-08-22|Tottenham|2|2|Crystal Palace|D
1993|3|1992-08-22|Wimbledon|1|2|Coventry City|A
1993|3|1992-08-22|Blackburn|1|0|Manchester City|H
1993|3|1992-08-22|Norwich City|1|1|Everton|D
1993|3|1992-08-22|Sheffield Weds|3|3|Chelsea|D
1993|3|1992-08-22|Manchester Utd|1|1|Ipswich Town|D
1993|3|1992-08-22|Aston Villa|1|1|Southampton|D
1993|3|1992-08-22|Middlesbrough|4|1|Leeds United|H
1993|3|1992-08-22|QPR|3|2|Sheffield Utd|H
1993|3|1992-08-22|Oldham Athletic|5|3|Nott'ham Forest|H
1993|3|1992-08-23|Liverpool|0|2|Arsenal|A
1993|4|1992-08-24|Southampton|0|1|Manchester Utd|A
1993|4|1992-08-25|Sheffield Utd|2|2|Wimbledon|D
1993|4|1992-08-25|Ipswich Town|2|2|Liverpool|D
1993|4|1992-08-25|Crystal Palace|1|1|Sheffield Weds|D
1993|4|1992-08-25|Leeds United|5|0|Tottenham|H
1993|4|1992-08-25|Everton|1|0|Aston Villa|H
1993|4|1992-08-26|Manchester City|3|1|Norwich City|H
1993|4|1992-08-26|Arsenal|2|0|Oldham Athletic|H
1993|4|1992-08-26|Coventry City|0|1|QPR|A
1993|4|1992-08-26|Chelsea|0|0|Blackburn|D
1993|5|1992-08-29|Sheffield Utd|0|2|Aston Villa|A
1993|5|1992-08-29|Nott'ham Forest|0|2|Manchester Utd|A
1993|5|1992-08-29|Southampton|2|1|Middlesbrough|H
1993|5|1992-08-29|Crystal Palace|1|2|Norwich City|A
1993|5|1992-08-29|Manchester City|3|3|Oldham Athletic|D
1993|5|1992-08-29|Chelsea|1|0|QPR|H
1993|5|1992-08-29|Arsenal|2|1|Sheffield Weds|H
1993|5|1992-08-29|Coventry City|0|2|Blackburn|A
1993|5|1992-08-29|Everton|0|0|Wimbledon|D
1993|5|1992-08-29|Leeds United|2|2|Liverpool|D
1993|5|1992-08-30|Ipswich Town|1|1|Tottenham|D
1993|6|1992-08-31|Norwich City|3|1|Nott'ham Forest|H
1993|6|1992-09-01|Middlesbrough|2|2|Ipswich Town|D
1993|6|1992-09-01|Wimbledon|0|1|Manchester City|A
1993|6|1992-09-01|Liverpool|1|1|Southampton|D
1993|6|1992-09-01|Oldham Athletic|2|2|Leeds United|D
1993|6|1992-09-02|Manchester Utd|1|0|Crystal Palace|H
1993|6|1992-09-02|Sheffield Weds|1|2|Coventry City|A
1993|6|1992-09-02|QPR|0|0|Arsenal|D
1993|6|1992-09-02|Tottenham|2|0|Sheffield Utd|H
1993|6|1992-09-02|Aston Villa|1|3|Chelsea|A
1993|7|1992-09-05|Norwich City|1|0|Southampton|H
1993|7|1992-09-05|Oldham Athletic|0|1|Coventry City|A
1993|7|1992-09-05|Sheffield Weds|0|3|Manchester City|A
1993|7|1992-09-05|Wimbledon|3|2|Arsenal|H
1993|7|1992-09-05|Middlesbrough|2|0|Sheffield Utd|H
1993|7|1992-09-05|QPR|0|0|Ipswich Town|D
1993|7|1992-09-05|Blackburn|4|1|Nott'ham Forest|H
1993|7|1992-09-05|Aston Villa|3|0|Crystal Palace|H
1993|7|1992-09-05|Tottenham|2|1|Everton|H
1993|7|1992-09-05|Liverpool|2|1|Chelsea|H
1993|7|1992-09-06|Manchester Utd|2|0|Leeds United|H
1993|8|1992-09-12|Crystal Palace|2|2|Oldham Athletic|D
1993|8|1992-09-12|Manchester City|0|1|Middlesbrough|A
1993|8|1992-09-12|Everton|0|2|Manchester Utd|A
1993|8|1992-09-12|Chelsea|2|3|Norwich City|A
1993|8|1992-09-12|Southampton|1|2|QPR|A
1993|8|1992-09-12|Ipswich Town|2|1|Wimbledon|H
1993|8|1992-09-12|Arsenal|0|1|Blackburn|A
1993|8|1992-09-12|Sheffield Utd|1|0|Liverpool|H
1993|8|1992-09-12|Nott'ham Forest|1|2|Sheffield Weds|A
1993|8|1992-09-13|Leeds United|1|1|Aston Villa|D
1993|8|1992-09-14|Coventry City|1|0|Tottenham|H
1993|6|1992-09-15|Blackburn|2|3|Everton|A
1993|9|1992-09-19|Wimbledon|1|1|Blackburn|D
1993|9|1992-09-19|Tottenham|1|1|Manchester Utd|D
1993|9|1992-09-19|Norwich City|1|0|Sheffield Weds|H
;
run;

/* Cleaning dataset (Danish's compbl/strip cleaning) */
data cleandata (rename=(Season_End_Year = YearEnd));
	set rawdata;
	Home = compbl(Home);
	Away = compbl(Away);
	FTR = strip(FTR);
run;

/* Points column added as per the rules of Premier League Football */
data pointstable;
	set cleandata;
	if FTR = 'H' then do;
		HomePoints = 3;
		AwayPoints = 0;
	end;
	else if FTR = 'D' then do;
		HomePoints = 1;
		AwayPoints = 1;
	end;
	else do;
		HomePoints = 0;
		AwayPoints = 3;
	end;
run;

proc sort data=pointstable out=homegames;
by YearEnd Home;run;
proc sort data=pointstable out=awaygames;
by YearEnd Away; run;

/* Codes for creating final points table */
data homepoints (keep= YearEnd Home TotPointsH);
	set homegames;
	by YearEnd Home;
	retain TotpointsH 0;
	if First.Home=1 then TotpointsH = 0;
	TotpointsH + HomePoints;
	if Last.Home=1;
run;

data awaypoints  (keep= YearEnd Away TotPointsA);
	set awaygames;
	by YearEnd Away;
	retain TotpointsA 0;
	if First.Away=1 then TotpointsA = 0;
	TotpointsA + AwayPoints;
	if Last.Away=1;
run;

data PointsTablemerged;
	merge homepoints (rename=(Home=Team)) awaypoints(rename=(Away=Team));
	by YearEnd Team;
	TotPoints = TotPointsH + TotPointsA;
	drop TotPointsH TotPointsA;
run;

/* Codes for creating goals table */
data GoalsH (keep= YearEnd Home GoalsForH GoalsAgainstH);
	set homegames;
	by YearEnd Home;
	retain GoalsForH 0 GoalsAgainstH 0;
	if First.Home=1 then do;
		GoalsForH = 0;
		GoalsAgainstH = 0;
	end;
	GoalsForH+HomeGoals;
	GoalsAgainstH+AwayGoals;
	if Last.Home=1;
run;

data GoalsA (keep= YearEnd Away GoalsForA GoalsAgainstA);
	set awaygames;
	by YearEnd Away;
	retain GoalsAgainstA 0 GoalsForA 0;
	if First.Away=1 then do;
		GoalsAgainstA = 0;
		GoalsForA = 0;
	end;
	GoalsForA+AwayGoals;
	GoalsAgainstA+HomeGoals;
	if Last.Away=1;
run;

/* Final Goals Table */
data GoalsTable;
	merge GoalsH (rename=(Home=Team)) GoalsA(rename=(Away=Team));
	by YearEnd Team;
	GoalsFor = GoalsForH + GoalsForA;
	GoalsAgainst = GoalsAgainstH + GoalsAgainstA;
	GoalDiff = GoalsFor - GoalsAgainst;
	keep YearEnd Team GoalsFor GoalsAgainst GoalDiff;
run;

/* Merged table with points, goals for/against, goal difference */
data mergedtable;
	merge GoalsTable PointsTableMerged;
	by YearEnd Team;
run;
proc sort data=mergedtable out=sortedtable;
	by YearEnd descending TotPoints;
run;

/* Ranking for each Season */
data ranking;
	set sortedtable;
	by YearEnd;
	Rank + 1;
	if First.YearEnd=1 then rank=1;
run;

title 'Correlation of Total Points against Scoring and Conceding of Goals';
proc corr data=ranking PEARSON spearman noprob;
	var  GoalsFor GoalsAgainst;
	with TotPoints;
	label TotPoints='Total Points' GoalsFor = 'Goals Scored' GoalsAgainst = 'Goals Conceded';
run;
title;
