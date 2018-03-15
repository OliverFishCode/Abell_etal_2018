title "Water Sr vs Finray Sr";
goptions reset ;/* reset graphing options*/
data Sr;/*Specifies data set name*/
input site$ water ray;/*Specifies variable names in data set; the next line is the data will follow*/
datalines;
BGP	2.03	0.458166046
BGP	2.03	0.464343736

"Insert your data
in place of the restricted
datalines I have provided"

OHR	2.5	0.683052692
OHR	2.5	0.739904257
;
proc univariate data=Sr normal;/*Provides general descriptive statistics, as well as normality test for response variable*/
var ray;
run;
proc glm data=Sr;/*General linear model*/
model ray=water/ p clm;/* Specifies model; p = predictions, clm = confidence limit mean 95% default*/
output out=a p=p;/*creates new data set of predictions named "a"*/
run;/* runs proc*/
title "Water Ba vs Finray Ba";
data Ba;
input site$ water ray;
datalines;
BGP	0.62	0.013107582
BGP	0.62	0.03009903

"Insert your data
in place of the restricted
datalines I have provided"

OHR	0.29	0.011774744
OHR	0.29	0.021694391
;
proc univariate data=Ba normal;
var ray;
run;
proc glm data=Ba;
model ray=water/ p clm;
output out=b p=p;
run;
quit;
