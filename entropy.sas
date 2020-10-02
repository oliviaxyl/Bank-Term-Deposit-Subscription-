******************************************************;
**                ENTROPY                           **;
**  This program is designed to cut down on the     **;
** number of candidate independent variables for    **;
** modeling.                                        **;
**                                                  **;
******************************************************;

** work directory ***;
%let path= ;

** number of variables desired **;
%let vardep= ;

** number of intervals desired **;
%let numgroup=10;

** input SAS dataset name **;
%let dataname=save.DEV;

** list all independent variables here ***;
%macro varlist;

* put variable list here *;

%mend;

*****************************************************************;
libname perm "&path";
filename varout "&path.selected.txt"; /* top variable list */
title "Source data = &dataname";
options nodate center error=1 compress=no ls=122 ps=68 pageno=1;

* ---------------------------------------------------*;
* this program will rank each independent variable and 
* calculate the "importance" based on entropy to a given
* dependent variable. the top given number of variables
* will be selected and outputted for model building and
* other analysis.                                   
* ---------------------------------------------------*;

** separate the numeric and character variables **;
data source;
set &dataname(keep=&vardep %varlist);
array NVar _numeric_;
do over NVar;
if NVar=. then NVar=-1;
end;
array CVar $ _character_;
do over CVar;
if CVar=' ' then CVar='-';
end;

proc contents data=source(drop=&vardep) out=varnames(keep=name type) noprint;
run;
data numerVar charVar;
set varnames;
if type=1 then output numerVar;
else if type=2 then output charVar;

** calculate the importance for all numeric var **;
%macro calcN;
data _null_;
set numerVar nobs=numobs;
call symput('numvar',numobs);
run;

%do i=1 %to &numvar;
data _null_;
set numerVar(obs=&i firstobs=&i);
call symput('varname',name);
proc rank data=source(where=(&vardep>=0)) out=testrank(keep=&varname &vardep &bracket)
                                          groups=&numgroup ties=high;
