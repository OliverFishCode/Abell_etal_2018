Title 'spb ohio weighted catch curve';
data ohio;/*Specifies data set name*/
input age catch;/*Specifies variable names in data set; the next line is the data will follow*/
LogN = Log(catch);/* creats new variable log of catch*/
datalines;

"Insert your data
in place of the restricted
datalines I have provided"

;
proc glimmix data = ohio method = laplace;/* regression with with laplace estimation*/
model LogN = age/cl;/* specifies model */
output out = river	predicted = W;/* create new data set of the predictions to be used as weighting in next model */
/* same as above, but predicts from previous catch curve are used as weights*/
proc glimmix data = river method = laplace;
model LogN = age/cl;
weight W;
output out=weight_river predicted=p1;
run;

Title 'spb tribs weighted catch curve';
data tributaries;
input age catch;
LogN = Log(catch);
datalines;

"Insert your data
in place of the restricted
datalines I have provided"

;
proc glimmix data = tributaries method = laplace;
model LogN = age/cl;
output out = trib Predicted = W;
proc glimmix data = trib method = laplace;
model LogN = age/cl;
Weight W;
output out=weight_trib predicted=p2;
run;

quit;
