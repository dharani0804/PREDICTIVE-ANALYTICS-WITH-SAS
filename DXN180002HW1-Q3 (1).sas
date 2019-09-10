

libname HW1 'C:\dxn180002';
Data HW1.Hotel;
Infile 'C:\dxn180002\hotel.dat' missover;
Input  
	room 
	num_guests 
	_checkin_month 
	_checkin_day 
	_checkin_year 
	_checkout_month 
	_checkout_day 
	_checkout_year
	used_internet $
	internet_use_days 49-52
	room_type $ 53-68
	room_rate ;
RUN;

PROC PRINT data = hotel;
	TITLE 'Original Data';
RUN;

DATA hotels;
SET hotel;
date_in=input(catx('-',_checkin_year,_checkin_month,_checkin_day),yymmdd10.);
date_out=input(catx('-',_checkout_year,_checkout_month,_checkout_day),yymmdd10.);
stay_length_days = date_out - date_in;
room_charge = stay_length_days * room_rate;
added_guest_fee = (num_guests - 1) * 10 * stay_length_days;
internet_fee = 9.95 + (internet_use_days * 4.95);
total_charges = sum(room_charge, added_guest_fee, internet_fee);
grand_total = total_charges + (total_charges * 0.075);
FORMAT 
	date_in yymmdd10.
	date_out yymmdd10.;
DROP _:;

RUN;

PROC PRINT data = hotels;
	TITLE 'Processed Data';
RUN;



/*Grrand Total for room 211 is $1354.50*/
