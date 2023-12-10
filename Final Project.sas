/* Danish Bhatkar */
/* Final Project */
/* Analysis of English Football Premier League(1993-2023) */

/* Importing raw data */
proc import datafile="/home/dbhatka/EPG294/Final Project/Data Files/premier-league-matches.csv"
			dbms=csv out=rawdata replace;
			guessingrows=max;
run;

/* Cleaning dataset and saving it to a folder for future use */
/* The numeric and date columns are already clean */
data finproj.cleandata (rename=(Season_End_Year = YearEnd));
	set rawdata;
	Home = compbl(Home);
	Away = compbl(Away);
	FTR = strip(FTR);
run;


/* Points column added as per the rules of Premier League Football */
/* This column will be used for further analysis */
data pointstable;
	set finproj.cleandata;
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


/* Final Points Table for all years */
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


/* Final Goals Table for all Years */
data GoalsTable;
	merge GoalsH (rename=(Home=Team)) GoalsA(rename=(Away=Team));
	by YearEnd Team;
	GoalsFor = GoalsForH + GoalsForA;
	GoalsAgainst = GoalsAgainstH + GoalsAgainstA;
	GoalDiff = GoalsFor - GoalsAgainst;
	keep YearEnd Team GoalsFor GoalsAgainst GoalDiff;
run;


/* Merged Table with calculated attributes like points, goals for, goals against and goals difference */
data mergedtable;
	merge GoalsTable PointsTableMerged;
	by YearEnd Team;
run;
proc sort data=mergedtable out=finproj.sortedtable;
	by YearEnd descending TotPoints;
run;


/* Ranking for each Season */
data finproj.ranking;
	set finproj.sortedtable;
	by YearEnd;
	Rank + 1;
	if First.YearEnd=1 then rank=1;
run;


/* Title Winners Table */
data finproj.winners (drop= Rank);
	set finproj.ranking;
	if Rank=1;
run;


/* Calculation of Total Points in all the Seasons */
proc sort data=finproj.ranking out=pointssorting;
	by Team;
run;
data finproj.pointsTotal;
	set pointssorting;
	by Team;
	retain TotalPoints 0;
	TotalPoints+TotPoints;
	if First.Team=1 then TotalPoints=TotPoints;
	drop TotPoints Rank YearEnd Goal:;
	if Last.Team=1;
run;


data finproj.decadesorting;
	set finproj.winners;
	if YearEnd >=1993 and YearEnd<=2003 then Decade = '1993-2003';
	else if YearEnd <=2013 then Decade = '2003-2013';
	else Decade = '2013-2023';
run;

/* options orientation=landscape; */
options nodate;
ods powerpoint file="/home/dbhatka/EPG294/Final Project/FinalProject.pptx" style=snow;


proc contents data=finproj.cleandata; run;
proc means data=finproj.cleandata; run;

title 'Clean Data';
proc print data=finproj.cleandata (obs=15); run;
title 'Sorted Data';
proc print data=finproj.sortedtable (obs=15); run;
title 'Rankings';
proc print data=finproj.ranking (obs=15); run;
title 'Winners';
proc print data=finproj.winners (obs=15); run;
title 'Points Table';
proc print data=finproj.pointsTotal (obs=15); run;
title 'Points Table by Decade';
proc print data=finproj.decadeSorting (obs=15); run;

ods graphics on;
title "Number of Titles won from 1993 to 2023";
proc gchart data=finproj.winners;
	pie Team / descending clockwise other=2 value=arrow explode='Liverpool' 'Arsenal' noheading;
run;
quit;
title;

title "Total Number of Points Scored from 1993 to 2023";
proc gchart data=finproj.pointsTotal;
	pie Team / sumvar=TotalPoints descending clockwise other=2 value=arrow
				explode='Tottenham' 'Everton' noheading;
	where TotalPoints > 1600;
run;
quit;
title;

title "Titles won by the Top 5 teams in the last 3 Decades";
proc sgplot data=finproj.decadesorting;
	vbar Team / barwidth=0.8 dataskin=matte group=Decade groupdisplay=cluster grouporder=data datalabel;
	label YearEnd = 'Number of Titles';
	yaxis label='Number of Titles';
	where Team in ('Manchester Utd' 'Manchester City' 'Arsenal' 'Chelsea' 'Liverpool');
run;
title;

title "Standings in the Last 30 Years";
proc sgplot data=finproj.ranking;
	vline YearEnd / response=Rank stat=mean group=Team dataskin=crisp;
	styleattrs datacontrastcolors=(gold lightskyblue red);
	yaxis values=(1 to 20) reverse;
	where Team in ('Manchester Utd' 'Manchester City' 'Chelsea');
	Label Rank = Rank YearEnd = Year;
run;
title;

proc sgplot data=finproj.ranking;
	reg x=TotPoints y=GoalsFor / group=Team;
	where Team in ('Manchester Utd' 'Manchester City' 'Chelsea');
	styleattrs datacontrastcolors=(red skyblue gold) datalinepatterns=(2);
	label GoalsFor = 'Goals Scored' TotPoints = 'Points Scored';
	title 'Comparison of Goals Scored against Points Scored for the Top 3 Teams';
run;
title;

proc sgplot data=finproj.ranking;
	reg x=TotPoints y=GoalsAgainst / group=Team;
	where Team in ('Manchester Utd' 'Manchester City' 'Chelsea');
	styleattrs datacontrastcolors=(red skyblue gold) datalinepatterns=(2);
	label GoalsAgainst = 'Goals Conceded' TotPoints = 'Points Scored';
	title 'Comparison of Goals Conceded against Points Scored for the Top 3 Teams';
run;
title;

title 'Correlation of Total Points against Scoring and Conceding of Goals';
proc corr data=finproj.ranking PEARSON spearman noprob;
	var  GoalsFor GoalsAgainst;
	with TotPoints;
	label TotPoints='Total Points' GoalsFor = 'Goals Scored' GoalsAgainst = 'Goals Conceded';
run;
title;

proc reg data=finproj.ranking plots(only) = fitplot;
	model Rank = TotPoints;
	where YearEnd >= 2008 and YearEnd <=2023;
	label TotPoints = 'Total Points';
	title 'Regression Analysis';
	title2 'Predicting Total Number of Points Required by a Team to Win the Premier League';
	title3 '(Based on the last 15 years to conduct analysis as per the recent trend)';
run;
title; title1; title2;
ods graphics off;

ods powerpoint close;