use fms;
select * from booking;
select * from booking_details;
select * from flight;
select * from passenger;

#1. Display passenger name who has a 'e' as second letter in their name
select passname from passenger where passname like '_a%';

#2. Display the name of the youngest passenger.
select passname from passenger where passdob=(select max(passdob) from passenger);

#3. Display the name of the passenger, date of birth and age.
select passname,passdob,round(datediff(current_date,passdob)/365) as age from passenger;

#4. Display the number of flights leaving Kolkata.
select count(*) from flight where flightsource='kol';

#5. Display the name of city where the number of flights leaving and reaching is the same.
select a.flightsource from flight a group by a.flightsource having count(a.flightsource)=(select count(b.flightdest) from flight b where a.flightsource=b.flightdest);

#6. Display the name of the city which has flight source but no destination.
select flightsource from flight where flightsource not in(select flightdest from flight);

#7.Display the dates on which flight 1 and 4 is flying.
select flightdate from flight where flightid in(1,4);

#8.Display the number of passenger in each flight. Use column alias “PassCount”.
select count(a.passid) as PassCount,flightid from booking_details a,booking b where a.bookingid=b.bookingid group by b.flightid;

#9. Display the name and date of birth of passengers who are senior citizen (age>=60).
select passname,passdob from passenger where round((datediff(current_date,passdob)/365))>=60;

#10. Display the booking id having the highest number of passengers.
select bookingid from booking_details group by bookingid having count(passid)=(select count(passid) from booking_details group by bookingid order by count(passid) desc limit 1);

#11. Display the booking id (ticket) and the total cost for the booking. Use column alias “Total Fare”.
select a.bookingid,sum(b.ticketcost) as Total_Fare from booking_details a,flight b,booking c where c.flightid=b.flightid and a.bookingid=c.bookingid group by a.bookingid;

#12. Display the booking id (ticket) and the total cost for the booking. Use column alias “Total Fare”. Consider giving a rebate of 50% to senior citizen (age>=60).
select a.bookingid,sum(
case
when datediff(current_date,d.passdob)/365>=60 then b.ticketcost*0.5
else b.ticketcost
end) as Total_fare from booking_details a,flight b,booking c,passenger d where a.bookingid=c.bookingid and b.flightid=c.flightid and a.passid=d.passid group by a.bookingid;

#13. Display the city receiving the maximum number of flights.
select flightdest from flight group by flightdest having count(flightid)=(select count(flightid) from flight group by flightdest order by count(flightid) desc limit 1);

#14. Display the passenger’s name having more than 1 booking.
select passname from passenger where passid in(select passid from booking_details group by passid having count(bookingid)>1);

#15. Display flightid with no of booking.
select a.flightid,count(b.passid) from booking a,booking_details b where a.bookingid=b.bookingid group by a.flightid;

#16. Display the passenger (name only) who booked ticket on the day of flight for flight no 1.
select passname from passenger where passid in(select passid from booking_details where bookingid in(select bookingid from booking where bookdate in(select date(a.flightdate) from flight a,booking b where a.flightid=b.flightid and date(a.flightdate)=b.bookdate and a.flightid=1)));

#17. Display flights having the same source and destination.
select a.flightid from flight a,flight b where a.flightid!=b.flightid and a.flightsource=b.flightsource and a.flightdest=b.flightdest; 

#18. Display the record in the following format. Column alias “Booking Summary”
#Hints:“ Ticket No:1 Flight id: 1 Total Passengers :3 Total Fare:6000”
#“Ticket No:2 Flight id: 3 Total Passengers :1 Total Fare :2500”
select concat('Ticket No:',cast(b.bookingid as char),'Flight id:',cast(b.flightid as char),'Total Passengers:',cast(count(c.passid) as char),'Total Fare:',cast(sum(a.ticketcost) as char)) as Booking_Summary from flight a,booking b,booking_details c where a.flightid=b.flightid and b.bookingid=c.bookingid group by a.flightid;

#19. Flight No: 2 have been delayed for 4 hrs due to fog. Display flight id , flight date and a new column “flight new date”, which displays the new timing.
select flightid,flightdate,flightdate + interval 4 hour as flight_new_date from flight where flightid=2;

#20. Display passenger name , date of birth sorted by the month of birth .(Jan ? Dec).
select passname,passdob from passenger order by month(passdob);