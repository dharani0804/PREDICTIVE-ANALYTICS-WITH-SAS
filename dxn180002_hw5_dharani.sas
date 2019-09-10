libname HW5 'c:\dxn180002'; 

proc contents data = HW5.crackers_hw5;
run;
 proc surveyselect data=HW5.crackers_hw5 out=HW5.cracker outall samprate=0.8 seed=100;
run;
data HW5.reformat (keep=obs Purchase Brand Feature Display Price);
  set HW5.cracker;
  array pur(*) PRIVATE SUNSHINE KEEBLER NABISCO;
  array pri(*) PRICEPRIVATE PRICESUNSHINE PRICEKEEBLER PRICENABISCO;
  array fea(*) FeatPrivate FeatSunshine FeatKeebler FeatNabisco;
  array dis(*) DisplPrivate DisplSunshine DisplKeebler DisplNabisco;
  do i=1 to 4;
    Purchase=pur(i);
    Brand=vname(pur(i));
    Feature=fea(i);
    Display=dis(i);
    Price=pri(i);
    output;
  end;
run;
proc print data = hw5.reformat (obs=20) ; run;

proc logistic data=HW5.reformat;
 strata obs;
 class brand (ref = 'NABISCO') / param=ref;
 model purchase (event='1') = brand price display feature brand*display brand*feature;
run;
proc contents data =  HW5.reformat; run;
data 
data;
proc print data = hw5.reformat(obs=100); run;
data hw5.reformat2;
set hw5.reformat;
brandis= brand*display;
brandfeat= brand*feature;
run; 
proc mdc data = HW5.reformat;
 id obs;
 class brand;
  model purchase = brand price display feature brand*display brand*feature/type = clogit nchoice = 4 ;
 restrict BrandNabisco=0;
  restrict BrandNabiscoFeature=0;
  restrict BrandNabiscoDisplay=0;
 run;
 proc mdc data = HW5.reformat; discrete
 id obs;
 class brand;
  model purchase = brand price display feature brand*display brand*feature/ type = mixedlogit nchoice = 4 mixed=(normalparm=price);


