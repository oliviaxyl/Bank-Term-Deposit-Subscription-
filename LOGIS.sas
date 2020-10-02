*****************************************;
**      Multivariate Analysis          **;
*****************************************;

/* adjust var default */
data save.DEV;
set save.DEV;
if default="no" then default_adj="no";
else default_adj="unknown";
drop default;
run;

data save.VAL;
set save.VAL;
if default="no" then default_adj="no";
else default_adj="unknown";
drop default;
run;

/* variable pdays */
data save.DEV;
set save.DEV;
if pdays=999 then pdays_adj=0;
else pdays_adj=1;
drop pdays;
run;

data save.VAL;
set save.VAL;
if pdays=999 then pdays_adj=0;
else pdays_adj=1;
drop pdays;
run;
***********************************************;



/* Logistic Regression */

** first **;

ods graphics on;
title1 'First model';
proc logistic data=save.DEV descending /*plots=ROC(id=prob)*/;
class job marital education housing(ref="unknown") default_adj loan(ref="unknown") contact month day_of_week(ref="mon") poutcome(ref="nonexist") / param=ref;
model GOOD=age job marital education housing default_adj loan contact month day_of_week duration campaign previous poutcome emp_var_rate;
/*roc 'All variables considered' age job marital education housing default_adj loan contact month day_of_week duration campaign previous poutcome emp_var_rate;*/
run;
ods graphics off;
title1;

** stepwise selection **;
ods html file="C:\Users\xliu702\Desktop\bankproject\stepwise.html";
ods graphics on;
proc logistic data=save.DEV outmodel=save.model descending plots=ROC;
class job marital education housing(ref="unknown") default_adj loan(ref="unknown") contact month day_of_week(ref="mon") poutcome(ref="nonexist") / param=ref;
model GOOD=age job marital education housing default_adj loan contact month day_of_week duration campaign previous poutcome emp_var_rate / selection=stepwise rsq;
roc age job marital education housing default_adj loan contact month day_of_week duration campaign previous poutcome emp_var_rate;
run;
ods graphics off;
ods html close;

