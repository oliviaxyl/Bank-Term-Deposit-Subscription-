*********************************************;
**             EDA PROGRAM                 **;
*********************************************;

%let perf=GOOD;  /* performance variable */
%let data=save.DEV; /*Dateset name*/

footnote;
title;

%macro EDA(var);
proc tabulate data=&data missing format=6.;
class &var &perf;
table &var all='TOTAL',
      &perf * N='#'
	  all * N='TOTAL #'
	  all * (pctn='TOTAL %' * F=6.2)
/ box=" &var " rts=15
;
where &perf in (0,1);
run;

%mend EDA;

%macro EDA2(var);
proc rank data=&data groups=10 ties=low out=rnk;
var &var;
ranks rank;
run;

proc means data=rnk mean min max;
var &var &perf;
class rank/missing;
where &perf in (0,1);
run;

%mend EDA2;
options ls=90;

/********* CHAR **********/
%EDA(job)
%EDA(marital)
%EDA(education)
%EDA(default)
%EDA(housing)
%EDA(loan)
%EDA(contact)
%EDA(month)
%EDA(day_of_week)
%EDA(poutcome)


/********* NUM **********/

%EDA2(age)
%EDA2(duration)
%EDA2(campaign)
%EDA2(pdays)
%EDA2(previous)
  
%EDA2(emp_var_rate) 
%EDA2(cons_price_idx) 
%EDA2(cons_conf_idx)
%EDA2(euribor3m)
%EDA2(nr_employed) 


OPTIONS LS=90;


