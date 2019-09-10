libname HW2 'C:\dxn180002';
proc contents data = HW2.vite;
Proc print data = HW2.vite;run;
proc ttest data = HW2.vite H0=140 Sides = L alpha=.05;
*class strata;
var SBP;
title ' ';
run;

data HW2.strata1;
set HW2.vite;
if strata = '1';
run;
proc print data = HW2.strata1;run;

data HW2.strata2;
set HW2.vite;
if strata = '2';
run;
 proc ttest data = HW2.strata1 h0=140 sides=u alpha=0.05;
      var sbp;
   run;
   *strata1 can't reject the null strata2 can reject null;
   proc ttest data = HW2.strata2 h0=140 sides=u alpha=0.05;
      var sbp;
   run;

*There are two reasons why it may not work. 
 The first is that the data has three possibilities to describe visits (0 baseline, 1 first treatment, 2 second treatment). 
 The incorporation of the 1st treatment has the potential to interfere with the hypothesis test. 
 The second reason is that not all people actually receive the medication, due to the prescence of the placebo group.
The current structure of the data, would inaccurately compare people who have and haven’t received medication across visits 
and this could distort the data. The data has three possibilities to describe visits (0 baseline, 1 first treatment, 2 second treatment). 
   ; 
*remove visit 1 for strata 1;
data HW2.St1novis1;
set HW2.strata1;
if visit=1 then delete; run;
*remove visit 1 for strata 2;
data HW2.St2novis1;
set HW2.strata2;
if visit=1 then delete; run;

*sort the strata 1 treatment group;
Data HW2.strata1treatment;
Set HW2.St1novis1;
if treatment =0 then delete;run;
*For strata 1 treatment group, the treatment made a difference;
proc ttest data = HW2.Strata1treatment H0=0 sides = 2 alpha = 0.05;
class visit;
var Plaque;
run;
*sort the strata 1 placebo group;
Data HW2.strata1placebo;
Set HW2.St1novis1;
if treatment =1 then delete;run;
*for strata 1 people, the placebo did not make a statistiscally significant difference across time, fail to reject null;
proc ttest data = HW2.Strata1placebo H0=0 sides = 2 alpha = 0.05;
class visit;
var Plaque;
run;
*sort the strata 2 treatment group;
Data HW2.strata2treatment;
Set HW2.St2novis1;
if treatment =0 then delete;run;
*For strata 2 treatment group, we fail to reject the null hypothesis;
proc ttest data = HW2.Strata2treatment H0=0 sides = 2 alpha = 0.05;
class visit;
var Plaque;
run;
*sort the strata 2 placebo group;
Data HW2.strata2placebo;
Set HW2.St2novis1;
if treatment =1 then delete;run;
*for strata 2 people, the placebo did not make a difference across time;
proc ttest data = HW2.Strata2placebo H0=0 sides = 2 alpha = 0.05;
class visit;
var Plaque;
run;
*comparison of placebo vs treatment for strata 1;
data HW2.st1tre_vs_plac;
set HW2.strata1;
if visit = '2';run;
*we can reject the null hypothesis for strata 1, the means between the treatment group and the placebo group are significantly different.;
proc glm data = HW2.st1tre_vs_plac;
class treatment;
model Plaque = treatment;
run;

*comparison of placebo vs treatment for strata 2;
data HW2.st2tre_vs_plac;
set HW2.strata2;
if visit = '2';run;
*we fail to reject the null hypothesis for strata 2, there is not statistical evidence to suggest that the means between the treatment
and the placebo group are different;
proc glm data = HW2.st2tre_vs_plac;
class treatment;
model Plaque = treatment;
run;

*Results:As previously mentioned the people in strata 1 experienced a larger difference in plaque means than the people in strata 2. 
We were able to reject the null hypothesis for individuals in the first strata who received treatment, 
but we couldn’t for individuals who received treatment in the second strata.
What was interesting about this was that people in strata 1 had greater initial plaque levels (0.60mm and above) 
than people in strata 2 (0.60mm and below), and experienced a more dramatic effect from the vitamin E treatments. 
It’s similar to the idea where a person who just starts exercising consistently immediately experiences more dramatic results 
than the person who has been consistently exercising for a long time. 
