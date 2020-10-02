**************************************************************
****               START PROGRAM                          ****
**************************************************************;

libname save "C:\Users\fengs\Dropbox\DATA MINING\final\data"; /* change it to your directory */
libname library "C:\Users\fengs\Dropbox\DATA MINING\final\format"; /* this too */


data save.bank1;
infile "C:\Users\fengs\Dropbox\RESEARCH\data\bank_nosign.csv" DLM=';' firstobs=2;
input age job $ marital $ education $ default $ balance housing $ loan $ contact $ day month $ duration campaign pdays previous poutcome $ y $;

run;
proc contents data=save.bank1 position;
run;

proc print data=save.bank1 (obs=10);
run;


data save.bank_additional1;
infile "C:\Users\fengs\Dropbox\RESEARCH\data\bank_additional_full_nos.csv" DLM=';' firstobs=2;
input age job $ marital $ education $ default $ housing $ loan $ contact $ month $ day_of_week $ duration campaign pdays previous poutcome $ emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed y $;
keep age job marital education default housing loan contact month day_of_week duration campaign pdays previous poutcome emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed y;
run;
proc contents data=save.bank_additional1;
run;
proc print data=save.bank_additional1 (obs=10);
run;




