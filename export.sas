*************************************************************************************************************;
** Export sas data into a Excel file **;
proc export data=save.bank_additional1 DBMS=xlsx OUTFILE="C:\Users\xliu702\Desktop\bankproject\bankexc.xlsx";
run;
*************************************************************************************************************;

*** Check frequency table of numeric var******;
proc freq data=save.bank_additional1;
table age duration campaign pdays previous emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed;
run;
** the output shows that we can treat this var as a CHAR **;


proc print data=save.bank_additional1 (obs=10);
run;
