Libname HW1 'C:\dxn180002';
Proc Import DATAFILE= "C:\dxn180002\Pizza.csv"
	OUT=HW1.Pizzatest
	DBMS=csv
	REPLACE;
	GETNAMES=Yes;
RUN;

Proc Print Data = HW1.Pizzatest;
Proc Contents Data = HW1.Pizzatest;
Run;

*The problem with proc import in this data file is that it doesn't correctly 
represent all of the toppings. It treats certain toppings (eggplant and shrimp) as characters and not numbers 
and it cuts off data points occassionally, it doesn't provide as much flexibility as the datastep.When you use the datastep 
it treats everything numerically;
libname HW1 'C:\dxn180002';
Data HW1.Pizzanew;
Infile 'C:\dxn180002\Pizza.csv' DLM =',' FIRSTOBS=2 DSD;
Input SurveyNum Arugula PineNut Squash Shrimp Eggplant;
Run;

Proc Print Data = HW1.Pizzanew;
Run;
proc contents data = HW1.Pizzanew;run;
proc means data = HW1.Pizzanew;run;

Data HW1.ToppingAvg;
Input Topping $ Average_Rating;
Datalines;
	Arugula 3.0750000 
	PineNut	3.1400000 
	Squash 	3.1625000 
	Shrimp	2.9666667 
	Eggplant 2.8600000
;
proc print data = HW1.ToppingAvg;
Run; 
