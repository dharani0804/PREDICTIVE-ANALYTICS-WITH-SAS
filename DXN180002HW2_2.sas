libname HW2 'C:\dxn180002';
proc contents data = HW2.study_gpa;run;
proc print data = HW2.study_gpa;run;
proc sgplot data = HW2.study_gpa(where=(section in ('01' '02'))) ;
  vbox AveTime / category=section;
  title ' Comparison of Study Time between Sections';
  run;
  proc sgplot data = HW2.study_gpa(where=(section in ('01' '02'))) ;
  vbox GPA / category=section;
  title ' Comparison of Study Time between Sections';
  run;
proc sgplot data = HW2.study_gpa;
	reg x= AveTime y= GPA /group = section;
	title 'Relationship between Study Time and GPA across Sections';
	Run;
proc sgplot data = HW2.study_gpa;
	reg x= AveTime y= GPA /group = section clm cli transparency=0.5 lineattrs=(pattern=solid);
	title 'Relationship between Study Time and GPA across Sections';
	Run;
	
	*Section 1 seemed to study more than section 2 and it also performed better in regards to overal GPA. 
	Which makes me believe that there is a positive correlation between;
