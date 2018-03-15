title "Median Length at Age Comparison";
data spb;/*Specifies data set name*/
input site$ length age;/*Specifies variable names in data set; the next line is the data will follow*/
datalines;
ohio	104	0
ohio	108	0

"Insert your data
in place of the restricted
datalines I have provided"

tribs	228	4
tribs	360	5
;
proc sort data=spb;/*sorts data by age*/
by age;
run;
proc means n mean stderr; class site; by age; var length;/* basic descriptive statistics for length by site by age*/
run;
proc npar1way Wilcoxon data=spb; by age; class site; var length;/* kruskal-wallis and wilcoxon nonparametric test comparing length by site within age grouping*/
run;/* runs proc*/
quit;
