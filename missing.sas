******************************************************
*****          Checking missing value             ****
******************************************************;


/* create a format to group missing and nonmissing */
proc format;
 value $missfmt ' '='Missing' other='Not Missing';
 value  missfmt  . ='Missing' other='Not Missing';
run;
 
proc freq data=save.bank_additional1; 
format _CHAR_ $missfmt.; /* apply format for the duration of this PROC */
tables _CHAR_ / missing missprint nocum nopercent;
format _NUMERIC_ missfmt.;
tables _NUMERIC_ / missing missprint nocum nopercent;
run;


**************************************************;
** run PROC FREQ to check missing value **********;
proc freq data=save.bank_additional1;
table age job marital education default housing loan contact month day_of_week duration campaign pdays previous poutcome emp_var_rate y;
run;

** no missing value **;
