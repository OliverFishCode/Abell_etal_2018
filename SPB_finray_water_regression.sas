title "Water Sr vs Finray Sr";
data Sr;
input site$ water Sr ray$;
datalines;
BGP	2.03	0.458166046 pel
BGP	2.03	0.464343736 pel

"Insert your data
in place of the restricted
datalines I have provided"

OHR	2.5	0.683052692 pec
OHR	2.5	0.739904257 pec
;
proc univariate data=Sr normal;
var Sr;
run;
proc glm data=Sr;
model Sr=water/ p clm;
output out=a p=p;
run;
proc gplot data=a;
plot Sr*water p*water/overlay;
run;
proc glm data=Sr;
class ray;
model Sr=water|ray / p clm;
run;

title "Water Ba vs Finray Ba";
data Ba;
input site$ water Ba ray$;
datalines;
BGP	0.62	0.013107582	pel
BGP	0.62	0.03009903	pel

"Insert your data
in place of the restricted
datalines I have provided"

OHR	0.29	0.011774744	pec
OHR	0.29	0.021694391	pec
;
proc univariate data=Ba normal;
var Ba;
run;
proc glm data=Ba;
class ray;
model Ba=water|ray/ p clm;
output out=b p=p;
run;
proc gplot data=b;
plot Ba*water p*water/overlay;
run;
proc glm data=Ba; class ray;
model Ba=water ray / p clm;
run;

quit;
