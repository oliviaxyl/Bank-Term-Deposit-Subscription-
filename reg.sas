proc reg data=save.train2 outest=estfile;
score: model Good =
pdays1--pdays2
age1--age2
campaign1--campaign3
previous1--previous2
emp_var_rate1
cons_price_idx1--cons_price_idx3
euribor3m1--euribor3m4
nr_employed1--nr_employed2
day_of_week1--day_of_week2
job1--job5
marital1--marital3
education1--education3
default1--default2
housing1--housing2
loan1--loan2
cellular1
month1--month9
poutcome1--poutcome2
;
run;
