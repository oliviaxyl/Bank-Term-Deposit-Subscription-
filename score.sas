*************************************;
**      SCORING PROGRAM            **;
*************************************;
ods pdf file="C:\Users\fengs\Dropbox\RESEARCH\output\score.pdf";
proc logistic inmodel=save.model;
score data=save.VAL out=save.score_VAL fitstat;
run;
ods pdf close;
