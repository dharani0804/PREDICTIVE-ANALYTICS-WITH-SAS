Libname HW1 'C:\dxn180002';
Data HW1.Survey;
Infile 'C:\dxn180002\WLSurveys.dat' dlm='09'x;
Input
subject :3.height :3. weightv1 :3.weightv2 :3.weightv3 :3. 
weightv4 :3.weightv5 :3.Q1V1 :3. Q2V1 :3.Q3V1 :3. Q4V1 :3.
Q5V1 :3.Q6V1 :3.Q1V2 :3.Q2V2 :3.Q3V2 :3.Q4V2 :3.Q5V2 :3. 
Q6V2 :3.Q1V3 :3.Q2V3 :3.Q3V3 :3.Q4V3 :3.Q5V3 :3.Q6V3 :3.
Q1V4 :3.Q2V4 :3.Q3V4 :3.Q4V4 :3.Q5V4 :3.Q6V4 :3.
Q1V5 :3. Q2V5 :3. Q3V5 :3.Q4V5 :3.Q5V5 :3.Q6V5 :3.;
Proc print data = HW1.Survey;
Title 'Weight Loss Survey';
Footnote ' ';
run;

proc format;
  value recodeItems
    0 = 3
    1 = 2
    2 = 1
    3 = 0
    other=.
  ;
run;

Data HW1.CorrectedQuestion(drop=_:);
   Set HW1.Survey;
   array q Q2V1 Q3V1 Q5V1 Q2V2 Q3V2 Q5V2 Q2V3 Q3V3 Q5V3 Q2V4 Q3V4 Q5V4 Q2V5 Q3V5 Q5V5 ; 
   do _i=1 to dim(q);
      q[_i]=put(q[_i],recodeItems.);
  end;
run;

proc print data = HW1.CorrectedQuestion;run;

Data HW1.CorrectedB;
Set HW1.CorrectedQuestion;
array q Q1V1 Q4V1 Q6V1 Q1V2 Q4V2 Q6V2 Q1V3 Q4V3 Q6V3 Q1V4 Q4V4 Q6V4 Q1V5 Q4V5 Q6V5; 
   do i=1 to dim(q);
      if Q[i] = -99 then Q[i] = .; 
   end;
   drop i;
run;
proc print data = CorrectedB;run;

Data HW1.BodyMass;
Set HW1.CorrectedB;
bmiv1 = (weightv1/(height**2))*703;
bmiv2 = (weightv2/(height**2))*703;
bmiv3 = (weightv3/(height**2))*703;
bmiv4 = (weightv4/(height**2))*703;
bmiv5 = (weightv5/(height**2))*703;

proc print data =HW1.Bodymass;run;

Data HW1.Over25BMI;
Set HW1.BodyMass;
if bmiv1 GT 25; 
if bmiv2 GT 25; 
if bmiv3 GT 25; 
if bmiv4 GT 25;
if bmiv5 GT 25;
run;

proc print data = HW1.Over25BMI;
Title 'BMI over 25';run;


