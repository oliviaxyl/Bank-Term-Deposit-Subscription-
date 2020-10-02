ODS html file="C:\Users\xliu702\Desktop\bankproject\crosstab.html";
proc freq data=save.DEV;
tables age*GOOD/norow nopercent;
format age age.;
run;

proc freq data=save.DEV;
tables campaign*GOOD/norow nopercent;
format campaign campaign.;
run;

proc freq data=save.DEV;
tables duration*GOOD/norow nopercent;
format duration duration.;
run;

proc freq data=save.DEV;
tables pdays*GOOD/norow nopercent;
format pdays pdays.;
run;


proc freq data=save.DEV;
tables previous*GOOD/norow nopercent;
format previous previous.;
run;

proc freq data=save.DEV;
tables emp_var_rate*GOOD/norow nopercent;
format emp_var_rate emp_var_rate.;
run;

proc freq data=save.DEV;
tables cons_price_idx*GOOD/norow nopercent;
format cons_price_idx cons_price_idx.;
run;

proc freq data=save.DEV;
tables cons_conf_idx*GOOD/norow nopercent;
format cons_conf_idx cons_conf_idx.;
run;

proc freq data=save.DEV;
tables euribor3m*GOOD/norow nopercent;
format euribor3m euribor3m.;
run;

proc freq data=save.DEV;
tables nr_employed*GOOD/norow nopercent;
format nr_employed nr_employed.;
run;


ODS html close;
