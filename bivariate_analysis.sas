*****************************************;
**          Bivariate Analysis         **;
*****************************************;
proc logistic data=save.DEV descending;
model GOOD=age;
run;

proc logistic data=save.DEV descending;
model GOOD=duration;
run;

proc logistic data=save.DEV descending;
model GOOD=campaign;
run;

proc logistic data=save.DEV descending;
model GOOD=emp_var_rate;
run;

proc logistic data=save.DEV descending;
model GOOD=pdays;
run;

proc logistic data=save.DEV descending;
model GOOD=previous;
run;

*** categorical ****;
*** crosstabs ******;
ODS html file="C:\Users\fengs\Dropbox\RESEARCH\output\crosstab.html";

proc freq data=save.DEV;
table (job marital education default housing loan contact month day_of_week poutcome)*GOOD;
run;

ODS html close;

proc means data =save.DEV;
var age duration campaign previous emp_var_rate;    /*** the visual display of statistics information **/
run;
