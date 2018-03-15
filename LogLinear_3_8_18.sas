title "Log-linear analysis of natal origins based on Ba:Ca and Sr:Ca";
data SPB;/*Specifies data set name*/
input  count origin$ year_class	catch_location$	gen_catch$ lump$;/* Specifies variable names in data set, Lump variable is combines trib embayments with river into one category*/
datalines;
0	TRIB	2009	BIG	TRIB	TRIB
1	TRIB	2010	BIG	TRIB	TRIB

"Insert your data
in place of the restricted
datalines I have provided"

6	RIVER	2013	OHIO	RIVER	RIVER
2	RIVER	2014	OHIO	RIVER	RIVER
;
run;
proc sort data=SPB;/*sorts data set by year class*/
by year_class;
run;
proc univariate data=SPB;/*Provides general descriptive statistics,you can check Poisson mean variance relationship*/
var count;
by year_class;/*you can swith to a differnt categorization if needed*/
run;/* runs proc*/
title "origin";
proc glimmix data=SPB method=laplace;/*Generalized linear model using laplace estimation*/
class origin year_class	catch_location gen_catch lump;/*Specifies categorical effects*/
model count=lump origin lump*origin /s  dist=negbin link=log;/*Specifies model,solution, distribution and link function; negative binomial used instead of Poisson due to overdispersion*/
lsmeans origin*lump / lines adjust=tukey;/* Tukey adjusted pairwise differances, lines specifies Tukey lettering of similar groups for visulization*/
run;
