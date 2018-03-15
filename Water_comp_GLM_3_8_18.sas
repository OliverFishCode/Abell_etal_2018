title "generalized linear model of SrCa";
data water_srca;/*Specifies data set name*/
input site $ value time year;/*Specifies variable names in data set; the next line is the data will follow*/
datalines;
ohio	2.53	1	2013
ohio	2.47	2	2013

"Insert your data
in place of the restricted
datalines I have provided"

big		1.59	3	2015
big		1.51	1	2016
;
run;
proc sort data=water_srca;/* sorts data by site */
by site;
run;/* runs proc*/
proc glimmix data=water_srca method=laplace;/* generalized linear model with laplace estimation*/
class site time year;/* specifies site, time and year as catergorical effects*/
model value = site time year/ dist= gamma;/* specifies model and use of gamma series of distributions [data not normal])*/
lsmeans site/ lines adjust = tukey ;/* Tukey adjusted pairwise comparisons*/
run;
proc glimmix data=water_srca method=laplace;
class site time year;
model value = site time year/ dist= gamma ddfm=SATTERTHWAITE;/* same as above, but satterthwaite's adjusts for non-homogeniety of variances*/
lsmeans site/ lines adjust = tukey ADJDFE=row;/* same as above, but adjusts denominator degrees of freedom by row [this coupled with satterthwaites] is games-howell post hoc*/
run;
title "generalize linear model for BaCa";
data water_baca;
input site $ value time year;
datalines;
ohio	0.28	1	2014
ohio	0.31	2	2014

"Insert your data
in place of the restricted
datalines I have provided"

big		0.29	4	2015
big		0.28	1	2016
;
run;

proc sort data=water_baca;
by site;
run;
proc univariate data=water_baca;
var value;
by site;
run;
proc glimmix data=water_baca method=laplace;
class site time year;
model value = site time year/ dist=gamma ddfm=SATTERTHWAITE;
lsmeans site/ lines adjust = tukey ADJDFE=row;
run;
quit;
