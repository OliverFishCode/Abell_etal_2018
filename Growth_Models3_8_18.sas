title "Ohio Growth Models";
goptions reset ;/* reset graphing options*/
data ohio;/*Specifies data set name*/
input tl age;/* tl = length of an individual (measured as total length), Specifies variable names in data set; the next line is the data will follow*/
cards;
104	0
108	0

"Insert your data
in place of the restricted
datalines I have provided"

347	5
360	5
;
run;
proc nlin data=ohio;/*Non-linear regression*/
title "trad vonb";
parms linf=346.25 k=0.73 t0=0;/*intitial parameter guess's used to inform parameter estimation starting point*/
model tl= linf*(1-EXP(-k*(age-t0)));/*Specifies the growth model*/
output out=a_pred predicted=p student=s residual=r;/*creates new data set of predictions named "a_pred"; p = predictions, s = studentized, r = residuals*/
run; /* runs proc*/
proc gplot data=a_pred;/* plots predictions and observed data on same plot against age*/
plot tl*age p*age/overlay;
run;
proc nlin data=ohio;
title "logistic ";
parms linf=382 k=0.73 t0=0;
model tl= linf*((1+exp(-k*(age-t0)))**-1);
output out=c_pred predicted=p student=s residual=r;
run;
proc gplot data=c_pred;
plot tl*age p*age/overlay;
run;
proc nlin data=ohio maxiter=300;
title "gompertz ";
parms linf=400 k=0.73 t0=0  ;
model tl= linf*exp(-(1/k)*exp(-k*(age-t0)));
output out=kk_pred predicted=p student=s residual=r u95m=ucl l95m=lcl stdp=sem;
run;
proc gplot data=kk_pred;
plot tl*age p*age/overlay;
run;
title "Tributary Growth Models";
data trib;
input tl age;
cards;
71	0
104	0

"Insert your data
in place of the restricted
datalines I have provided"

358	4
360	5
;
run;
proc nlin data=trib;
title "trad vonb trib";
parms linf=400 k=0.73 t0=0;
model tl= linf*(1-EXP(-k*(age-t0)));
output out=e_pred predicted=p student=s residual=r;
run;
proc gplot data=e_pred;
plot tl*age p*age/overlay;
run;
proc nlin data=trib;
title "logistic t0 trib";
parms linf=400 k=0.73 t0=0;
model tl= linf/(1+exp(-k*(age-t0)));
output out=g_pred predicted=p student=s residual=r;
run;
proc gplot data=g_pred;
plot tl*age p*age/overlay;
run;
proc nlin data=trib maxiter=300;
title "gompertz ptrib";
parms linf=400 k=0.73 t0=0  ;
model tl= linf*exp(-(1/k)*exp(-k*(age-t0)));
output out=kk2_pred predicted=p student=s residual=r u95m=ucl l95m=lcl stdp=sem;
run;
proc gplot data=kk2_pred;
plot tl*age p*age/overlay;
run;
quit;
