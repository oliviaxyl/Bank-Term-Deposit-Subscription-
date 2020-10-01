/*Assign libname*/

libname save "C:\Users\xliu702\Desktop\bankproject";

/* Import bank term deposit data n = 41188 p = 20 */
/* Obtained from the University of California’s Machine Learning Repository, 
Center for Machine Learning and Intelligent Systems. */
/* Data related with direct marketing campaigns (phone calls) of a 
Portuguese banking institution. */

proc import datafile="C:\Users\xliu702\Desktop\bankproject\bank-additional-full.csv"
out=save.bank
dbms=CSV replace;
delimiter=";";
getnames=yes;
;
run;   

/* Show first 10 observations */

proc print data=save.bank(obs=10);
run;

/* Randomly split data into train and valid sets */
/* save.train# = 20454 save.valid# = 20734 */

data save.train save.valid;                                                                                                             
set save.bank;                                                                                                                                                                                                                                                              
random1=ranuni(14380132);                                                                                                                
 if random1<0.5 then output save.train;                                                                                                 
 else output save.valid;                                                                                                                
 run;   

/* Transfer campaign results 'yes' or 'no' into 0 and 1 */

data save.train;
set save.train;
if y="yes" then good=1;
else good=0;
run;

/* Sample down no deposit data(good=0), while save all deposit data(good=1) */
/* save.no# = 18125 */

data save.no;
set save.train;
if y="yes" then delete;
run;

/* save.nodata# = 15840 save.yesdata # =2285(p<0.127) */

data save.nodata save.yesdata;                                                                                                             
set save.no;                                                                                                                                                                                                                                                              
random1=ranuni(14380132);                                                                                                                
 if random1<0.127 then output save.nodata;                                                                                                 
 else output save.yesdata;                                                                                                                
 run;   

/* save.yes# = 2329 */

 data save.yes;
 set save.train;
if y="no" then delete;
run;

/* save.sdtrain# = 2329 + 2285 = 4614 */

data save.sdtrain;
set save.yes save.nodata;
run;

/* Check frequency tables of numeric variables */

proc freq data=save.train; 
tables age duration campaign pdays previous emp_var_rate cons_price_idx cons_conf_idx euribor3m nr_employed;
run;

/* format */

proc format;

VALUE age
 
0-28 = '0 to 28'
29-31 = '29 to 31'
32-33= '32 to 33'
34-35 = '34 to 35'
36-38 = '36 to 38'
39-41 = '39 to 41'
42-45= '42 to 45'
46-49= '46 to 49'
50-54= '50 to 54'
55-HIGH= '55 or more'
;

VALUE campaign
1 ='1'
2 ='2'
3='3'
4-5='4 to 5'
6-HIGH='6 or more'
;


value duration 
0-36='0 to 36'
37-59='37 to 59'
60-74='60 to 74'
75-88='75 to 88'
89-102='89 to 102'
103-116='103 to 116'
117-130='117 to 130'
131-145='131 to 145'
146-162='146 to 162'
163-179='163 to 179'
180-199='180 to 199'
200-221='200 to 221'
222-248='222 to 248'
249-280='249 to 280'
281-319='281 to 319'
320-368='320 to 368'
369-438='369 to 438'
439-549='439 to 549'
550-746='550 to 746'
747- HIGH='747 or more'
;
value pdays
0-3='0 to 3'
4-5='4 to 5'
6-9='6 to 9'
10-25='10 to 25'
26-HIGH='26 or more'
;

VALUE previous
0 = '0'
1 = '1'
2-HIGH= '2 or more'
;

value emp_var_rate
low--3='low to -3'
-2.9 ='-2.9'
-1.8 ='-1.8'
-1.7--0.2='-1.7 to -0.2'
-0.1='-0.1'
1.1='1.1'
1.2-HIGH='1.2 or more'
;

value cons_price_idx
low-92.843='low to 92.843'
92.893-93.075 ='92.893 to 93.075'
93.2-93.369 ='93.2 to 93.369'
93.444-93.876='93.444 to 93.876'
93.918='93.918'
93.994-94.215='93.994 to 94.215'
94.465-HIGH='94.465 or more'
;

value cons_conf_idx
low--47.1='low to -47.1'
-46.2--45.9 ='-46.2 to -45.9'
-42.7 ='-42.7' 
-42 ='-42'
-41.8--37.5='41.8 to -37.5'
-36.4='-36.4'
-36.1-HIGH='-36.1 or more'
;

value euribor3m 
low-0.782='low to 0.782'
0.788-1.044='0.788 to 1.044'
1.046-1.264='1.046 to 1.264'
1.266-1.291='1.266 to 1.291'
1.299-1.334='1.299 to 1.334'
1.344-1.406='1.344 to 1.406'
1.41-4.021='1.41 to 4.021'
4.076-4.153='4.076 to 4.153'
4.191-4.855='4.191 to 4.855'
4.856='4.856'
4.857-4.86='4.857 to 4.86'
4.864-4.957='4.864 to 4.957'
4.958-4.959='4.958 to 4.959'
4.96-4.961='4.96 to 4.961'
4.962='4.962'
4.963='4.963'
4.964-4.966='4.964 to 4.966'
4.967- HIGH='4.967 or more'
;

value nr_employed
low-5076.2='low to 5076.2'
5099.1-5176.3='5099.1 to 5176.3'
5191='5191' 
5195.8='5195.8'
5196-HIGH='5196 or more'
;
run;

/* Apply formats on numeric variables */

ODS html file= "C:\Users\xliu702\Desktop\bankproject\num_crosstab.html"; 
 proc freq data=save.sdtrain;
 tables duration*good/norow nopercent;
 format duration duration.;
 run;
proc freq data=save.sdtrain;
 tables pdays*good/norow nopercent;
 format pdays pdays.;
 run;
proc freq data=save.sdtrain;
 tables age*good/norow nopercent;
 format age age.;
run;


proc freq data=save.sdtrain;
 tables campaign*good/norow nopercent;
format campaign campaign.;
 run;


proc freq data=save.sdtrain;
 tables previous*good/norow nopercent;
format previous previous.;
 run;

proc freq data=save.sdtrain;
 tables emp_var_rate*good/norow nopercent;
format emp_var_rate emp_var_rate.;
 run;

proc freq data=save.sdtrain;
 tables cons_price_idx*good/norow nopercent;
format cons_price_idx cons_price_idx.;
 run;

proc freq data=save.sdtrain;
 tables cons_conf_idx*good/norow nopercent;
format cons_conf_idx cons_conf_idx.;
 run;

proc freq data=save.sdtrain;
 tables euribor3m*good/norow nopercent;
format euribor3m euribor3m.;
 run;

proc freq data=save.sdtrain;
 tables nr_employed*good/norow nopercent;
format nr_employed nr_employed.;
 run;
ods html close;

/* character variables */

ODS html file= "C:\Users\xliu702\Desktop\bankproject\char_crosstab.html"; 
proc freq data=save.sdtrain;
 tables job*good/norow nopercent;
 run;

proc freq data=save.sdtrain;
 tables marital*good/norow nopercent;
 run;

proc freq data=save.sdtrain;
 tables education*good/norow nopercent;
 run;

proc freq data=save.sdtrain;
 tables default*good/norow nopercent;
 run;

proc freq data=save.sdtrain;
 tables housing*good/norow nopercent;
 run;

proc freq data=save.sdtrain;
 tables loan*good/norow nopercent;
 run;

proc freq data=save.sdtrain;
 tables contact*good/norow nopercent;
 run;

proc freq data=save.sdtrain;
 tables month*good/norow nopercent;
 run;

proc freq data=save.sdtrain;
 tables day_of_week*good/norow nopercent;
 run;

proc freq data=save.sdtrain;
 tables poutcome*good/norow nopercent;
 run;
ods html close;

/* Before this step, crosstab and define dummy variables in excel. */
/* 'Duration' not needed for model - only serves as benchmark purpose. */
/* Drop 'cons_conf_inx' - trend up and down. */
 
/* Dummy coding1 (50 dummies in total) */

Data save.sdtrain1;
set save.sdtrain;

if pdays >= 10 and pdays <=25 	then pdays1=1; else pdays1=0;
if pdays>=26			then pdays2=1; else pdays2=0;

if age >= 0 and age <=31 	then age1=1; else age1=0;
if age >= 55            	then age2=1; else age2=0;

if campaign = 1 then campaign1=1; else campaign1=0;
if campaign >= 4 and campaign <=5 	then campaign2=1; else campaign2=0;
if campaign >= 6 then campaign3=1; else campaign3=0;

if previous = 1	then previous1=1; else previous1=0;
if previous >= 2	then previous2=1; else previous2=0;

if emp_var_rate>=-0.1 then emp_var_rate1=1; else emp_var_rate1=0;

if cons_price_idx<=92.843 then cons_price_idx1=1; else cons_price_idx1=0;
if 92.893<=cons_price_idx<=93.075 then cons_price_idx2=1; else cons_price_idx2=0;
if 93.2<=cons_price_idx<=93.876 then cons_price_idx3=1; else cons_price_idx3=0;

if euribor3m<=0.782 then euribor3m1=1; else euribor3m1=0;
if 0.788<=euribor3m<=1.044 then euribor3m2=1; else euribor3m2=0;
if 1.046<=euribor3m<=1.264 then euribor3m3=1; else euribor3m3=0;
if 1.266<=euribor3m<=4.021 then euribor3m4=1; else euribor3m4=0;

if nr_employed<=5076.2 then nr_employed1=1; else nr_employed1=0;
if 5099.1<=nr_employed<=5176.3 then nr_employed2=1; else nr_employed2=0;

/* day of week */
if day_of_week='tue' then day_of_week1=1; else day_of_week1=0;
if day_of_week='fri' then day_of_week2=1; else day_of_week2=0;
if day_of_week='mon' then day_of_week3=1; else day_of_week3=0;

/* job */
if job="retired" or job="student" then job1=1; else job1=0;
if job="admin." or job="housemaid" then job2=1; else job2=0;
if job="unemployed" then job3=1; else job3=0;
if job="blue-collar" or job="services" or job="entrepreneur" then job4=1; else job4=0;

/* marital */
if marital="single" then marital1=1; else marital1=0;
if marital="married" then marital2=1; else marital2=0;
if marital="divorced" then marital3=1; else marital3=0;

/* education */
if education= "unknown" then education1=1; else education1=0;
if education="university.degree" then education2=1; else education2=0;
if education="basic.4y""basic.6y" then education3=1; else education3=0;
if education= "basic.9y" then education4=1; else education4=0;
/* default */
if default="no" then default1=1; else default1=0;
/* housing */
if housing="yes" then housing1=1; else housing1=0;
if housing="no" then housing2=1; else housing2=0;
/* loan */
if loan="no" then loan1=1; else loan1=0;
if loan="yes" then loan2=1; else loan2=0;
/* contact */
if contact="cellular" then contact1=1; else contact1=0;
/* month */
if month="mar" or month="dec" then month1=1; else month1=0;
if month="sep" then month2=1; else month2=0;
if month="oct" then month3=1; else month3=0;
if month="apr" then month4=1; else month4=0;
if month="jul" or month="may" or month="nov" then month5=1; else month5=0;

/* poutcome */
if poutcome="success" then poutcome1=1; else poutcome1=0;
if poutcome="nonexistent" then poutcome2=1; else poutcome2=0;
run;
quit;

/* Regression first try */

proc reg data=save.sdtrain1 outest=estfile;
score: model Good =
pdays1--pdays2
age1--age2
campaign1--campaign3
previous1--previous2
emp_var_rate1
cons_price_idx1--cons_price_idx3
euribor3m1--euribor3m4
nr_employed1--nr_employed2
day_of_week1--day_of_week3
job1--job4
marital1--marital3
education1--education4
default1
housing1--housing2
loan1--loan2
contact1
month1--month5
poutcome1--poutcome2
;
run;
quit;

/* Remove those which are linearly combined to other variables 
- 'nr_employed2' 'education3' 'loan2' 'poutcome2' */

/*Dummy coding2*/

Data save.sdtrain2;
set save.sdtrain;

if pdays >= 10 and pdays <=25 	then pdays1=1; else pdays1=0;
if pdays>=26			then pdays2=1; else pdays2=0;

if age >= 0 and age <=31 	then age1=1; else age1=0;
if age >= 55            	then age2=1; else age2=0;

if campaign = 1 then campaign1=1; else campaign1=0;
if campaign >= 4 and campaign <=5 	then campaign2=1; else campaign2=0;
if campaign >= 6 then campaign3=1; else campaign3=0;

if previous = 1	then previous1=1; else previous1=0;
if previous >= 2	then previous2=1; else previous2=0;

if emp_var_rate>=-0.1 then emp_var_rate1=1; else emp_var_rate1=0;

if cons_price_idx<=92.843 then cons_price_idx1=1; else cons_price_idx1=0;
if 92.893<=cons_price_idx<=93.075 then cons_price_idx2=1; else cons_price_idx2=0;
if 93.2<=cons_price_idx<=93.876 then cons_price_idx3=1; else cons_price_idx3=0;

if euribor3m<=0.782 then euribor3m1=1; else euribor3m1=0;
if 0.788<=euribor3m<=1.044 then euribor3m2=1; else euribor3m2=0;
if 1.046<=euribor3m<=1.264 then euribor3m3=1; else euribor3m3=0;
if 1.266<=euribor3m<=4.021 then euribor3m4=1; else euribor3m4=0;

if nr_employed<=5076.2 then nr_employed1=1; else nr_employed1=0;

/* day of week */
if day_of_week='tue' then day_of_week1=1; else day_of_week1=0;
if day_of_week='fri' then day_of_week2=1; else day_of_week2=0;
if day_of_week='mon' then day_of_week3=1; else day_of_week3=0;

/* job */
if job="retired" or job="student" then job1=1; else job1=0;
if job="admin." or job="housemaid" then job2=1; else job2=0;
if job="unemployed" then job3=1; else job3=0;
if job="blue-collar" or job="services" or job="entrepreneur" then job4=1; else job4=0;

/* marital */
if marital="single" then marital1=1; else marital1=0;
if marital="married" then marital2=1; else marital2=0;
if marital="divorced" then marital3=1; else marital3=0;

/* education */
if education= "unknown" then education1=1; else education1=0;
if education="university.degree" then education2=1; else education2=0;
if education= "basic.9y" then education4=1; else education4=0;
/* default */
if default="no" then default1=1; else default1=0;
/* housing */
if housing="yes" then housing1=1; else housing1=0;
if housing="no" then housing2=1; else housing2=0;
/* loan */
if loan="no" then loan1=1; else loan1=0;
/* contact */
if contact="cellular" then contact1=1; else contact1=0;
/* month */
if month="mar" or month="dec" then month1=1; else month1=0;
if month="sep" then month2=1; else month2=0;
if month="oct" then month3=1; else month3=0;
if month="apr" then month4=1; else month4=0;
if month="jul" or month="may" or month="nov" then month5=1; else month5=0;

/* poutcome */
if poutcome="success" then poutcome1=1; else poutcome1=0;
run;
quit;

/* Regression second try */

proc reg data=save.sdtrain2 outest=estfile;
score: model Good =
pdays1--pdays2
age1--age2
campaign1--campaign3
previous1--previous2
emp_var_rate1
cons_price_idx1--cons_price_idx3
euribor3m1--euribor3m4
nr_employed1
day_of_week1--day_of_week3
job1--job4
marital1--marital3
education1--education2
education4
default1
housing1--housing2
loan1
contact1
month1--month5
poutcome1
;
run;
quit;


/* Remove those variables with wrong trends compared with crosstab tables 
- 'previous1' 'previous2' 'cons_price_idx1' 'cons_price_idx2' 'cons_price_idx3' 'euribor3m1' 
'euribor3m2' 'euribor3m3' 'euribor3m4' 'emp_var_rate1' 'job3' 'marital2' 'housing2' */

/* Dummy coding3 */

Data save.sdtrain3;
set save.sdtrain;

if pdays >= 10 and pdays <=25 	then pdays1=1; else pdays1=0;
if pdays>=26			then pdays2=1; else pdays2=0;

if age >= 0 and age <=31 	then age1=1; else age1=0;
if age >= 55            	then age2=1; else age2=0;

if campaign = 1 then campaign1=1; else campaign1=0;
if campaign >= 4 and campaign <=5 	then campaign2=1; else campaign2=0;
if campaign >= 6 then campaign3=1; else campaign3=0;

if nr_employed<=5076.2 then nr_employed1=1; else nr_employed1=0;

/* day of week */
if day_of_week='tue' then day_of_week1=1; else day_of_week1=0;
if day_of_week='fri' then day_of_week2=1; else day_of_week2=0;
if day_of_week='mon' then day_of_week3=1; else day_of_week3=0;

/* job */
if job="retired" or job="student" then job1=1; else job1=0;
if job="admin." or job="housemaid" then job2=1; else job2=0;
if job="blue-collar" or job="services" or job="entrepreneur" then job4=1; else job4=0;

/* marital */
if marital="single" then marital1=1; else marital1=0;
if marital="divorced" then marital3=1; else marital3=0;

/* education */
if education= "unknown" then education1=1; else education1=0;
if education="university.degree" then education2=1; else education2=0;
if education= "basic.9y" then education4=1; else education4=0;
/* default */
if default="no" then default1=1; else default1=0;
/* housing */
if housing="yes" then housing1=1; else housing1=0;
/* loan */
if loan="no" then loan1=1; else loan1=0;
/* contact */
if contact="cellular" then contact1=1; else contact1=0;
/* month */
if month="mar" or month="dec" then month1=1; else month1=0;
if month="sep" then month2=1; else month2=0;
if month="oct" then month3=1; else month3=0;
if month="apr" then month4=1; else month4=0;
if month="jul" or month="may" or month="nov" then month5=1; else month5=0;

/* poutcome */
if poutcome="success" then poutcome1=1; else poutcome1=0;
run;
quit;

/* Regression third try */

proc reg data=save.sdtrain3 outest=estfile;
score: model Good =
pdays1--pdays2
age1--age2
campaign1--campaign3
nr_employed1
day_of_week1--day_of_week3
job1--job2
job4
marital1
marital3
education1--education2
education4
default1
housing1
loan1
contact1
month1--month5
poutcome1
;
run;
quit;

/* Remove those variables with wrong trends compared with crosstab tables 
- 'job4' 'month5' */

/* Dummy coding4 */

Data save.sdtrain4;
set save.sdtrain;

if pdays >= 10 and pdays <=25 	then pdays1=1; else pdays1=0;
if pdays>=26			then pdays2=1; else pdays2=0;

if age >= 0 and age <=31 	then age1=1; else age1=0;
if age >= 55            	then age2=1; else age2=0;

if campaign = 1 then campaign1=1; else campaign1=0;
if campaign >= 4 and campaign <=5 	then campaign2=1; else campaign2=0;
if campaign >= 6 then campaign3=1; else campaign3=0;

if nr_employed<=5076.2 then nr_employed1=1; else nr_employed1=0;

/* day of week */
if day_of_week='tue' then day_of_week1=1; else day_of_week1=0;
if day_of_week='fri' then day_of_week2=1; else day_of_week2=0;
if day_of_week='mon' then day_of_week3=1; else day_of_week3=0;

/* job */
if job="retired" or job="student" then job1=1; else job1=0;
if job="admin." or job="housemaid" then job2=1; else job2=0;

/* marital */
if marital="single" then marital1=1; else marital1=0;
if marital="divorced" then marital3=1; else marital3=0;

/* education */
if education= "unknown" then education1=1; else education1=0;
if education="university.degree" then education2=1; else education2=0;
if education= "basic.9y" then education4=1; else education4=0;
/* default */
if default="no" then default1=1; else default1=0;
/* housing */
if housing="yes" then housing1=1; else housing1=0;
/* loan */
if loan="no" then loan1=1; else loan1=0;
/* contact */
if contact="cellular" then contact1=1; else contact1=0;
/* month */
if month="mar" or month="dec" then month1=1; else month1=0;
if month="sep" then month2=1; else month2=0;
if month="oct" then month3=1; else month3=0;
if month="apr" then month4=1; else month4=0;

/* poutcome */
if poutcome="success" then poutcome1=1; else poutcome1=0;
run;
quit;

/* Regression forth try */

proc reg data=save.sdtrain4 outest=estfile;
score: model Good =
pdays1--pdays2
age1--age2
campaign1--campaign3
nr_employed1
day_of_week1--day_of_week3
job1--job2
marital1
marital3
education1--education2
education4
default1
housing1
loan1
contact1
month1--month4
poutcome1
;
run;
quit;

/* Remove those variables with wrong trends compared with crosstab tables 
- 'education2' */

/* Dummy coding5 */

Data save.sdtrain5;
set save.sdtrain;

if pdays >= 10 and pdays <=25 	then pdays1=1; else pdays1=0;
if pdays>=26			then pdays2=1; else pdays2=0;

if age >= 0 and age <=31 	then age1=1; else age1=0;
if age >= 55            	then age2=1; else age2=0;

if campaign = 1 then campaign1=1; else campaign1=0;
if campaign >= 4 and campaign <=5 	then campaign2=1; else campaign2=0;
if campaign >= 6 then campaign3=1; else campaign3=0;

if nr_employed<=5076.2 then nr_employed1=1; else nr_employed1=0;

/* day of week */
if day_of_week='tue' then day_of_week1=1; else day_of_week1=0;
if day_of_week='fri' then day_of_week2=1; else day_of_week2=0;
if day_of_week='mon' then day_of_week3=1; else day_of_week3=0;

/* job */
if job="retired" or job="student" then job1=1; else job1=0;
if job="admin." or job="housemaid" then job2=1; else job2=0;

/* marital */
if marital="single" then marital1=1; else marital1=0;
if marital="divorced" then marital3=1; else marital3=0;

/* education */
if education= "unknown" then education1=1; else education1=0;
if education= "basic.9y" then education4=1; else education4=0;
/* default */
if default="no" then default1=1; else default1=0;
/* housing */
if housing="yes" then housing1=1; else housing1=0;
/* loan */
if loan="no" then loan1=1; else loan1=0;
/* contact */
if contact="cellular" then contact1=1; else contact1=0;
/* month */
if month="mar" or month="dec" then month1=1; else month1=0;
if month="sep" then month2=1; else month2=0;
if month="oct" then month3=1; else month3=0;
if month="apr" then month4=1; else month4=0;

/* poutcome */
if poutcome="success" then poutcome1=1; else poutcome1=0;
run;
quit;

/* Regression fifth try */

proc reg data=save.sdtrain5 outest=estfile;
score: model Good =
pdays1--pdays2
age1--age2
campaign1--campaign3
nr_employed1
day_of_week1--day_of_week3
job1--job2
marital1
marital3
education1
education4
default1
housing1
loan1
contact1
month1--month4
poutcome1
;
run;
quit;

/* Remove those variables with p-value > 0.1 - 'pdays1' 'campaign2' 'day_of_week2' 
'marital1' 'marital3' 'education1' 'education4' 'housing1' 'poutcome1' */

/* Dummy coding6 */
Data save.sdtrain6;
set save.sdtrain;

if pdays>=26			then pdays2=1; else pdays2=0;

if age >= 0 and age <=31 	then age1=1; else age1=0;
if age >= 55            	then age2=1; else age2=0;

if campaign = 1 then campaign1=1; else campaign1=0;
if campaign >= 6 then campaign3=1; else campaign3=0;

if nr_employed<=5076.2 then nr_employed1=1; else nr_employed1=0;

/* day of week */
if day_of_week='tue' then day_of_week1=1; else day_of_week1=0;
if day_of_week='mon' then day_of_week3=1; else day_of_week3=0;

/* job */
if job="retired" or job="student" then job1=1; else job1=0;
if job="admin." or job="housemaid" then job2=1; else job2=0;

/* default */
if default="no" then default1=1; else default1=0;

/* loan */
if loan="no" then loan1=1; else loan1=0;
/* contact */
if contact="cellular" then contact1=1; else contact1=0;
/* month */
if month="mar" or month="dec" then month1=1; else month1=0;
if month="sep" then month2=1; else month2=0;
if month="oct" then month3=1; else month3=0;
if month="apr" then month4=1; else month4=0;

run;
quit;

/* Regression sixth try */

proc reg data=save.sdtrain6 outest=estfile;
score: model Good =
pdays2
age1--age2
campaign1
campaign3
nr_employed1
day_of_week1
day_of_week3
job1--job2
default1
loan1
contact1
month1--month4
;
run;
quit;

/* Remove those variables with p-value > 0.1 - 'campaign1' 'age2' */

/* Dummy coding7 */
Data save.sdtrain7;
set save.sdtrain;

if pdays>=26			then pdays2=1; else pdays2=0;

if age >= 0 and age <=31 	then age1=1; else age1=0;

if campaign >= 6 then campaign3=1; else campaign3=0;

if nr_employed<=5076.2 then nr_employed1=1; else nr_employed1=0;

/* day of week */
if day_of_week='tue' then day_of_week1=1; else day_of_week1=0;
if day_of_week='mon' then day_of_week3=1; else day_of_week3=0;

/* job */
if job="retired" or job="student" then job1=1; else job1=0;
if job="admin." or job="housemaid" then job2=1; else job2=0;

/* default */
if default="no" then default1=1; else default1=0;

/* loan */
if loan="no" then loan1=1; else loan1=0;
/* contact */
if contact="cellular" then contact1=1; else contact1=0;
/* month */
if month="mar" or month="dec" then month1=1; else month1=0;
if month="sep" then month2=1; else month2=0;
if month="oct" then month3=1; else month3=0;
if month="apr" then month4=1; else month4=0;

run;
quit;

/* Regression seventh try */

proc reg data=save.sdtrain7 outest=estfile;
score: model Good =
pdays2
age1
campaign3
nr_employed1
day_of_week1
day_of_week3
job1--job2
default1
loan1
contact1
month1--month4
;
run;
quit;

/* Remove those variables with p-value > 0.1 - 'job2' 'loan1' 'month2'*/
/* Dummy coding8 */
Data save.sdtrain8;
set save.sdtrain;

if pdays>=26			then pdays2=1; else pdays2=0;

if age >= 0 and age <=31 	then age1=1; else age1=0;

if campaign >= 6 then campaign3=1; else campaign3=0;

if nr_employed<=5076.2 then nr_employed1=1; else nr_employed1=0;

/* day of week */
if day_of_week='tue' then day_of_week1=1; else day_of_week1=0;
if day_of_week='mon' then day_of_week3=1; else day_of_week3=0;

/* job */
if job="retired" or job="student" then job1=1; else job1=0;

/* default */
if default="no" then default1=1; else default1=0;

/* contact */
if contact="cellular" then contact1=1; else contact1=0;
/* month */
if month="mar" or month="dec" then month1=1; else month1=0;
if month="oct" then month3=1; else month3=0;
if month="apr" then month4=1; else month4=0;

run;
quit;

/* Regression eighth try (this is the final try). */
/* All variables remain p < 0.1. This is our final model.  */

proc reg data=save.sdtrain8 outest=estfile;
score: model Good =
pdays2
age1
campaign3
nr_employed1
day_of_week1
day_of_week3
job1
default1
contact1
month1
month3--month4
;
run;
quit;

/* Scoring program */

proc score data=save.sdtrain8 score=estfile type=parms out=save.score_sdtrain;
var
pdays2
age1
campaign3
nr_employed1
day_of_week1
day_of_week3
job1
default1
contact1
month1
month3--month4
;
run;
quit;

/* Score*1000 */

data save.score_sdtrain;
set save.score_sdtrain;
score = int(score*1000);
run;

/* Score frequency */

proc format;
value score 
1000-high = '1000 or more'
951-1000 = '951-1000'
901-950 = '901-950'
851-900 = '851-900' 
801-850 = '801-850'
751-800 = '751-800'
701-750 = '701-750'
651-700 = '651-700' 
601-650 = '601-650'
551-600 = '551-600'
501-550 = '501-550'
451-500 = '451-500' 
401-450 = '401-450'
351-400 = '351-400'
301-350 = '301-350'
251-300 = '251-300'
201-250 = '201-250'
151-200 = '151-200'
101-150 = '101-150'
51-100 = '51-100'
0-50 = '0-50';
run;

/* Score crosstab */

ODS html file= "C:\Users\xliu702\Desktop\bankproject\score(train).xls"; 
 proc freq data=save.score_sdtrain;
 tables score*good/norow nopercent;
 format score score.;
 run;
 ods html close;

/* K-S test (K-S table in excel) */
/* Final score card - Final regression output with parameters */

/* Now apply final regression model on valid data */
/* Transfer yes or no to 0 and 1 */

data save.valid;
set save.valid;
if y="yes" then good=1;
else good=0;
run;

/* Sample down no deposit data(good=0), while save all deposit data(good=1)*/
/* save.no# = 18423 */

data save.no;
set save.valid;
if y="yes" then delete;
run;

/* save.nodata# = 2316 save.yesdata#= 16107 */

data save.nodata save.yesdata;                                                                                                             
set save.no;                                                                                                                                                                                                                                                              
random1=ranuni(14380132);                                                                                                                
 if random1<0.127 then output save.nodata;                                                                                                 
 else output save.yesdata;                                                                                                                
 run;   

/* save.yes# = 2311 */

 data save.yes;
 set save.valid;
if y="no" then delete;
run;

/* save.sdvalid# = 2316 + 2311 = 4627 */

data save.sdvalid;
set save.yes save.nodata;
run;

/* Dummy coding8 for valid data */

Data save.sdvalid8;
set save.sdvalid;

if pdays>=26			then pdays2=1; else pdays2=0;

if age >= 0 and age <=31 	then age1=1; else age1=0;

if campaign >= 6 then campaign3=1; else campaign3=0;

if nr_employed<=5076.2 then nr_employed1=1; else nr_employed1=0;

/* day of week */
if day_of_week='tue' then day_of_week1=1; else day_of_week1=0;
if day_of_week='mon' then day_of_week3=1; else day_of_week3=0;

/* job */
if job="retired" or job="student" then job1=1; else job1=0;

/* default */
if default="no" then default1=1; else default1=0;

/* contact */
if contact="cellular" then contact1=1; else contact1=0;
/* month */
if month="mar" or month="dec" then month1=1; else month1=0;
if month="oct" then month3=1; else month3=0;
if month="apr" then month4=1; else month4=0;

run;
quit;

/* Apply regression on valid data */

proc reg data=save.sdvalid8 outest=estfile;
score: model Good =
pdays2
age1
campaign3
nr_employed1
day_of_week1
day_of_week3
job1
default1
contact1
month1
month3--month4
;
run;
quit;

/* Scoring program */

proc score data=save.sdvalid8 score=estfile type=parms out=save.score_sdvalid;
var
pdays2
age1
campaign3
nr_employed1
day_of_week1
day_of_week3
job1
default1
contact1
month1
month3--month4
;
run;
quit;

/* Score*1000 */

data save.score_sdvalid;
set save.score_sdvalid;
score = int(score*1000);
run;

/* Score crosstab */

ODS html file= "C:\Users\xliu702\Desktop\bankproject\score(valid).xls"; 
 proc freq data=save.score_sdvalid;
 tables score*good/norow nopercent;
 format score score.;
 run;
 ods html close;

 /* Now apply final regression model on the whole dataset (combine)*/
/* Transfer yes or no to 0 and 1 */

data save.sdall;
set save.sdvalid save.sdtrain;
run;


/* Dummy coding8  for the whole dataset */

Data save.sdall8;
set save.sdall;

if pdays>=26			then pdays2=1; else pdays2=0;

if age >= 0 and age <=31 	then age1=1; else age1=0;

if campaign >= 6 then campaign3=1; else campaign3=0;

if nr_employed<=5076.2 then nr_employed1=1; else nr_employed1=0;

/* day of week */
if day_of_week='tue' then day_of_week1=1; else day_of_week1=0;
if day_of_week='mon' then day_of_week3=1; else day_of_week3=0;

/* job */
if job="retired" or job="student" then job1=1; else job1=0;

/* default */
if default="no" then default1=1; else default1=0;

/* contact */
if contact="cellular" then contact1=1; else contact1=0;
/* month */
if month="mar" or month="dec" then month1=1; else month1=0;
if month="oct" then month3=1; else month3=0;
if month="apr" then month4=1; else month4=0;

run;
quit;

/* Apply regression on the whole dataset */

proc reg data=save.sdall8 outest=estfile;
score: model Good =
pdays2
age1
campaign3
nr_employed1
day_of_week1
day_of_week3
job1
default1
contact1
month1
month3--month4
;
run;
quit;

/* Scoring program */

proc score data=save.sdall8 score=estfile type=parms out=save.score_sdall;
var
pdays2
age1
campaign3
nr_employed1
day_of_week1
day_of_week3
job1
default1
contact1
month1
month3--month4
;
run;
quit;

/* Score*1000 */

data save.score_sdall;
set save.score_sdall;
score = int(score*1000);
run;

/* Score crosstab */

ODS html file= "C:\Users\xliu702\Desktop\bankproject\score(all).xls"; 
 proc freq data=save.score_sdall;
 tables score*good/norow nopercent;
 format score score.;
 run;
 ods html close;


/* end */
