/*1Q. Write a query to display profile id of passenger who booked minimum number of tickets.*/
select profile_id from air_ticket_info group by profile_id having count(ticket_id)<=all
(select count(ticket_id) from air_ticket_info group by profile_id);

/* Write a query to intimate the passengers who are boarding Chennai to Hyderabad Flight on
6th May 2013 stating the delay of 1hr in the departure time.
The Query should display the passenger’s profile_id, first_name,last_name, flight_id, flight_departure_date,
actual departure time as "Actual_Departure_Time", actual arrival time as "Actual_Arrival_Time", 
delayed departure time as "Delayed_Departure_time", delayed arrival time as "Delayed_Arrival_Time"
Hint: Distinct  Profile ID should be displayed irrespective of multiple tickets booked by the same profile.*/

select distinct app.profile_id,app.first_name,app.last_name,af.flight_id,ati.flight_departure_date,af.departure_time as Actual_departure_time,
af.arrival_time as Actual_Arrival_time,addtime(af.departure_time,'01:00:00') as Delayed_departure_time,
addtime(af.arrival_time,'01:00:00') as Delayed_arival_time from air_flight af join air_ticket_info ati on 
ati.flight_id=af.flight_id join air_passenger_profile app on ati.profile_id=app.profile_id
where af.from_location='Chennai' and af.to_location='Hyderabad' and ati.flight_departure_date='2013-05-06';



/*3Q. Write a query to display number of flights between 6.00 AM and 6.00 PM from chennai. Hint Use FLIGHT_COUNT as alias name*/

select count(flight_id) from air_flight where from_location='chennai' and departure_time between '06:00:00' and '18:00:00';

/*4Q. Write a query to display flight id,departure date,flight type of all flights. 
Flight type can be identified if ticket price is less than 3000 then 'AIR PASSENGER',
ticket price between 3000 and less than 4000 'AIR BUS' and ticket price between 4000 
and greater than 4000 then 'EXECUTIVE PASSENGER'. Hint use FLIGHT_TYPE as alias name.*/


select flight_id,flight_departure_date,
case 
when price<3000 then 'AIR PASSENGER'
when price between 3000 and 4000 then 'AIR BUS'
when price between 4000 and 5000 then 'EXECUTIVE PASSENGER'
end as flight_type
from air_flight_details;

/*5Q. Write a query to display flight id,from location, to location and price of flights whose departure is in the month of april*/

select af.flight_id,af.from_location,af.to_location,afd.price from air_flight af join air_flight_details afd on
af.flight_id=afd.flight_id where month(flight_departure_date)=5;

/*6Q. Write a query to display the Flight_Id, Flight_Departure_Date, From_Location,To_Location 
and Duration which has duration of travel less than 1 Hour, 10 Minutes*/

select afd.flight_id,afd.flight_departure_date,af.from_location,af.to_location,af.duration from air_flight af join air_flight_details afd
on af.flight_id=afd.flight_id where af.duration<'01:10:00';

/*7Q. Write a query to display the credit card type and no of credit cards used on the same type.
Hint: Use CARD_COUNT AS Alias name for no of cards.*/
select card_type,count(card_number) from air_credit_card_details group by card_type;

/*9Q. Write a query to display profile id of passenger who booked maximum number of tickets*/
select profile_id from air_ticket_info group by profile_id having count(ticket_id)
in(select max(d.c) from (select count(ticket_id)c from air_ticket_info group by profile_id)d);

select profile_id from air_ticket_info group by profile_id having count(ticket_id)
>=all(select count(ticket_id)c from air_ticket_info group by profile_id);

/*10Q. Write a query to display unique passenger profile id,first name,mobile number and 
email address of passengers who booked ticket to travel from HYDERABAD to CHENNAI.*/

select distinct app.profile_id,app.first_name,app.last_name,app.mobile_number,app.email_id
from air_passenger_profile app join air_flight af join air_ticket_info ati
on af.flight_id=ati.flight_id and ati.profile_id=app.profile_id
where af.to_location like 'Hyderabad' and af.from_location like 'Chennai';


/*11. Write a query to find the number of tickets as “No_of_Tickets” (alias name) booked by Kochi Customers.
The Query should display the Profile_Id, First_Name, Base_Location and number of tickets booked.
Hint: Use String functions to get the base location of customer from their Address and give alias name as “Base_Location”
*/

select app.profile_id,app.first_name,substring_index(substring_index(app.address,'-',-2),'-',1) as Base_location,count(ati.ticket_id)
from newfms.air_passenger_profile app join newfms.air_ticket_info ati on ati.profile_id=app.profile_id 
where substring_index(substring_index(app.address,'-',-2),'-',1)='Kochi' group by profile_id;

/*12 Q. Write a query to display the flight_id, from_location, to_location,
number of Services as “No_of_Services” (alias name) offered in the month of May.
Hint:The number of services can be calculated from the number of scheduled departure dates of the flight*/

select af.flight_id,af.from_location,af.to_location,count(af.flight_id) from air_flight af join air_flight_details afd
on af.flight_id=afd.flight_id where month(afd.flight_departure_date)=5 group by afd.flight_id;

/*13Q. Write a query to display unique profile id,first name , email address 
and contact number of passengers who traveled on flight with id 3148.*/
select distinct app.profile_id,app.first_name,app.email_id,app.mobile_number from newfms.air_passenger_profile app join
newfms.air_ticket_info ati on ati.profile_id=app.profile_id where ati.flight_id=3180;

/*14Q. Write a query to find the no of services offered by each flight and the total price of the services.
The Query should display flight_id, number of services as “No_of_Services” (alias name);
and the cost as “Total_Price” (alias name).
Order the result by Highest Total Price
Hint:The number of services can be calculated from the number of scheduled departure dates of the flight*/

select afd.flight_id,count(afd.flight_id) as 'No_of_services',sum(afd.price) from air_flight_details afd join air_ticket_info ati
on afd.flight_id=ati.flight_id
group by afd.flight_id order by sum(afd.price) desc;



select f.flight_id,count(fd.flight_departure_date) as no_of_services,sum(price) as total_price 
from air_flight f,air_flight_details fd,air_ticket_info t
where fd.flight_id=f.flight_id and fd.flight_id=t.flight_id and status='on time' group by f.flight_id order by price desc;

/*15Q. Write a query to find the number of passengers traveled in each flight in each scheduled date.
The Query should display flight_id, flight_departure_date and the number of passengers as “No_of_Passengers” (alias name).
Hint: The Number of passengers inclusive of all the tickets booked with single profile id.*/


select flight_id,flight_departure_date,count(ticket_id) from air_ticket_info where status='on time'
group by flight_id,flight_departure_date;


/*16Q. Write a query to find the customer who has booked the ticket with the From_Location different from their Base_Location.
The Query should display flight_id,profile_id,customer_name,base_location and from_location
Hint: Use string functions to get the  city value as Base_location from customer address.
Use alias name as “Base_Location”.Combine First Name and Last Name with a comma in between and give alias name as “Customer_Name”.
Use distinct to display unique records*/
select af.flight_id,app.profile_id,concat(app.first_name,',',last_name) as customer_name,
substring_index(substring_index(app.address,'-',-2),'-',1) as Base_location,af.from_location from newfms.air_passenger_profile app join
newfms.air_ticket_info ati on app.profile_id=ati.profile_id join newfms.air_flight af on af.flight_id=ati.flight_id
where substring_index(substring_index(app.address,'-',-2),'-',1)!=af.from_location;

/*18 Q. Write a query to find the number of flights flying from each location.
The Query should display the starting location as "Location", number of flights to other locations as “No_of_Flights”.
Hint: Get the distinct starting location from the From_Location; To_Location.*/


select distinct from_location as Location,count(flight_id) from air_flight group by from_location;

/*19Q. Write a query to find the average cost of the tickets in each flight on all scheduled dates.
The query should display flight_id, from_location, to_location and Average price as “Price” (alias name).*/


select af.flight_id,af.from_location,af.to_location,round(avg(afd.price)) as Price from air_flight af join air_flight_details afd
on af.flight_id=afd.flight_id group by af.flight_id;

/*20Q. Write a query to find the customers who have booked tickets from Chennai to Hyderabad.
The query should display profile_id, customer_name (combine first_name,last_name with comma in b/w), 
address of the customer.customer_name" as alias name for displaying customer_name.
Hint: Query should fetch unique customers irrespective of multiple tickets booked*/


select distinct app.profile_id,concat(app.first_name,',',app.last_name) as customer_name from air_passenger_profile app 
join air_ticket_info ati on app.profile_id=ati.profile_id join air_flight af on af.flight_id=ati.flight_id 
where af.from_location='Chennai' and af.to_location='Hyderabad';


/*21Q. Write a query to find the customers who has booked maximum number of tickets in ABC Airlines.
The Query should display profile_id, customer's first_name, Address and Number of tickets booked as “No_of_Tickets”(alias name).*/

select app.profile_id,app.first_name,app.address,count(ati.ticket_id) from newfms.air_passenger_profile app join newfms.air_ticket_info ati
on app.profile_id=ati.profile_id join newfms.air_flight af on af.flight_id=ati.flight_id where af.airline_name='abc' and 
ati.ticket_id>=all(select count(ati.ticket_id) from newfms.air_passenger_profile app join newfms.air_ticket_info ati
on app.profile_id=ati.profile_id join newfms.air_flight af on af.flight_id=ati.flight_id group by ati.ticket_id );

/*24Q. Write a query to find the number of passengers traveled on each flight on each scheduled date and 
total price of the tickets booked. The Query should display flight_id, from_location, to_location,flight_departure_date,
number of passengers as “No_of_Passengers”&nbsp;(alias name),
Total Price of the tickets booked as “Total_Price”&nbsp;(alias name). 
Hint: The Number of passengers inclusive of all the tickets booked with single profile id.
"Total_Price" should be calculated as (No_of_Passengers * price of single ticket*/

select af.flight_id,af.from_location,af.to_location,afd.flight_departure_date,count(ticket_id) as 'No_of_Passengers',
price*count(ticket_id) from newfms.air_flight af join newfms.air_flight_details afd on afd.flight_id=af.flight_id join
newfms.air_ticket_info ati on ati.flight_id=afd.flight_id where ati.status='on time' group by af.flight_id;



/*25Q. Write a query to find the customers who are travelling together on the same flight.
The Query should display profile_id, first_name,last_name,flight_id, flight_departure_date ,from_location and to_location.
The result should be sorted based on the flight id and flight departure date. */


select distinct app.profile_id,app.first_name,app.last_name,af.flight_id,ati.flight_departure_date,
af.from_location,af.to_location from
newfms.air_passenger_profile app join newfms.air_ticket_info ati on ati.profile_id=app.profile_id join newfms.air_flight af on
af.flight_id=ati.flight_id and exists
(select ati1.profile_id from newfms.air_ticket_info ati1 where ati1.profile_id!=ati.profile_id and ati1.flight_departure_date=ati.flight_departure_date 
and ati1.flight_id=ati.flight_id group by ati1.profile_id)
group by app.profile_id order by ati.flight_id,ati.flight_departure_date;


select distinct(TI.profile_id), first_name, last_name, TI.flight_id, TI.flight_departure_date, from_location, to_location 
from air_ticket_info TI, air_passenger_profile PP, air_flight F 
where F.flight_id=TI.flight_id AND PP.profile_id=TI.profile_id AND 
EXISTS(select profile_id from air_ticket_info 
where TI.profile_id<>profile_id AND TI.flight_departure_date=flight_departure_date AND TI.flight_id=flight_id) 
order by TI.flight_id, TI.flight_departure_date;

/*26Q. Write a query to find the flights available in Morning, After Noon, Evening &amp; Night.
The Query should display the Flight_Id, From_Location, To_Location , Departure_Time, time of service as "Time_of_Service".
Time of Service should be calculated as: From 05:00:01 Hrs to 12:00:00 Hrs -  Morning, 12:00:01 to 18:00:00 Hrs -Afternoon,
18:00:01 to 24:00:00 - Evening and 00:00:01 to 05:00:00 – Night*/

select flight_id,from_location,to_location,departure_time,
 case  when departure_time between '5:00:01' and '12:00:00' then 'morning' 
    when departure_time between '12:00:01' and '18:00:00' then 'afternoon'
    when departure_time between '18:00:01' and '24:00:00' then 'evening' 
    else 'n/a' 
    end 'time_of_service'
from air_flight;

/*27.Write a query to find the flight which has least number of services in the month of May.
The Query should fetch flight_id, from_location, to_location, least number of Services as “No_of_Services”
Hint: Number of services offered can be calculated from the number of scheduled departure dates of a flight*/

select af.flight_id,af.from_location,af.to_location,count(af.flight_id) from air_flight af join air_ticket_info ati on
ati.flight_id=af.flight_id where month(ati.flight_departure_date)=5 and status='on time' group by af.flight_id 
having count(af.flight_id) in(select min(n.m) from (select count(af.flight_id)m from air_flight af join air_ticket_info ati on
ati.flight_id=af.flight_id where month(ati.flight_departure_date)=5 and status='on time' group by af.flight_id)n);

select f.flight_id,from_location,to_location,count(flight_departure_date) as no_of_services 
from air_flight f,air_ticket_info t where t.flight_id=f.flight_id  and month(flight_departure_date)=5 
and status='on time'group by flight_id having count(flight_departure_date) <=ALL(select count(flight_departure_date)  from air_ticket_info where month(flight_departure_date)=5 group by flight_id);

