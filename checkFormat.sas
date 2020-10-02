/******* check the formatting ******/

proc freq data=save.DEV;
tables age;
format age age.;
run;

proc freq data=save.DEV;
tables campaign;
format campaign campaign.;
run;

proc freq data=save.DEV;
tables duration;
format duration duration.;
run;

proc freq data=save.DEV;
tables pdays;
format pdays pdays.;
run;
