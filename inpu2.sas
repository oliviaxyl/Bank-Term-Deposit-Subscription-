/******* input 2 program *******/

***** creating GOOD variable *****;
data save.bank_additional1;
set save.bank_additional1;
if y="no" then GOOD=0;
else if y="yes" then GOOD=1;
run;
proc freq data=save.bank_additional1;
table y GOOD;
run;

***** creating DEV and VAL ******;
data save.DEV save.VAL;
set save.total;
if ranuni(14380132)<0.5 then output save.DEV;
else output save.VAL;
run;


proc freq data=save.DEV;
table y / missing;
title 'DEV';
run;

proc freq data=save.VAL;
table y / missing;
title 'DEV';
run;

title;


proc contents data=save.DEV;
run;

proc freq data=save.DEV;
tables education;

run;

proc print data=save.train2(obs=30);
run;
