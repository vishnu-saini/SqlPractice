-- 1.count the members who has gold cards
select count(customer_id) from customer_card_details where card_id in
(select card_id from library_card_master where descrition like 'gold');

-- display the name of member who issued movie and the count of the 
-- movies issued and display 0 for the member who have not issued any movie
select cm.customer_name,count(cd.issue_id)count
from customer_master cm,customer_issue_details cd
where cm.customer_id=cd.customer_id
group by cd.customer_id
union
select customer_name,0 as count from  customer_master 
where customer_id not in (select customer_id from customer_issue_details);

select cm.Customer_Name,if(count(cid.movie_id),count(cid.movie_id),0)as count
from customer_master cm left outer join customer_issue_details cid 
on cm.customer_id=cid.customer_id group by customer_name;

-- 3.display the name of the customer starting with letter 'r' and category is 
-- 'comedy'
select c.customer_name
from customer_master c join customer_issue_details ci on c.customer_id=ci.customer_id
join movies_master m on ci.movie_id=m.movie_id
where c.customer_name like 'r%' and m.movie_category like 'comedy';

select customer_name from customer_master where customer_id in
(select ci.customer_id
from customer_master c, customer_issue_details ci,movies_master m 
where c.customer_id=ci.customer_id and
ci.movie_id=m.movie_id and
 c.customer_name like 'r%' and m.movie_category like 'comedy');



-- display id,name & total rent of customers for movie issued
select c.customer_id,c.customer_name,(count(d.movie_id)*m.rent_cost)total_rent
from customer_master c,customer_issue_details d,movies_master m where
c.customer_id=d.customer_id and d.movie_id=m.movie_id
group by d.customer_id;
-- 5.display id,name,card id,amount in $(amount/54.42) upto 0 decimals
select cm.CUSTOMER_ID,cm.customer_name,cd.card_id,round(lc.amount/54.42)
from customer_master cm,customer_card_details cd,library_card_master lc
where cm.customer_id=cd.customer_id and cd.card_id=lc.card_id;


-- 6.display id,name of customers who dont have library card but still have issued the movie
select customer_id,customer_name from customer_master where customer_id not in
(select customer_id from customer_card_details) and customer_id in
(select customer_id from customer_issue_details);


-- 7.display the no.of customers with first letter 'r' and have paid fine
-- i.e actual return date is greater than return date
select count(distinct cd.customer_id) from customer_issue_details cd,customer_master cm
where cd.ACTUAL_DATE_RETURN>cd.RETURN_DATE and cm.CUSTOMER_NAME like 'r%'
and cd.CUSTOMER_ID=cm.CUSTOMER_ID;


select count(distinct customer_id) from customer_issue_details
where ACTUAL_DATE_RETURN>RETURN_DATE and CUSTOMER_ID in
(select customer_id from customer_master where customer_name like 'r%');

-- 8.display customer name,customer id who have issued max and min no.of 
-- movies issued
select CUSTOMER_NAME,CUSTOMER_ID from customer_master 
where CUSTOMER_ID in
(select customer_id from customer_issue_details group by customer_id 
having count(issue_id)>=all (select count(issue_id) from customer_issue_details
group by customer_id)) union 
select CUSTOMER_NAME,CUSTOMER_ID from customer_master 
where CUSTOMER_ID in
(select customer_id from customer_issue_details group by customer_id 
having count(issue_id)<=all (select count(issue_id) from customer_issue_details
group by customer_id));

-- 9.display id,name,mobile num and description of all customers.if 
-- mobile num is not available then display address as alias contact,for 
-- those who does't have library cards display null as description
select CUSTOMER_ID,CUSTOMER_NAME,COALESCE(contact_no,contact_add) CONTACT 
from customer_master where CUSTOMER_ID not in
(select customer_id from customer_card_details); 

-- 10.display customer details and movie id for those who issued same  movie 
-- more than one time OR//dislay customer details who watched same movie more than once
select CUSTOMER_ID,customer_name from customer_master
where customer_id in
(select customer_id from customer_issue_details
group by customer_id,MOVIE_ID having count(ISSUE_ID)>1);

-- display customer information those who has library cards
select CUSTOMER_ID,CUSTOMER_NAME,CONTACT_NO,CONTACT_ADD
from customer_master where CUSTOMER_ID in
(select customer_id from customer_card_details);
-- .display the members who watch the movie but doesnt have card
select CUSTOMER_ID,CUSTOMER_NAME from customer_master 
where CUSTOMER_ID not in(select customer_id from customer_card_details)
and 
CUSTOMER_ID in(select customer_id from customer_issue_details);
-- 13.display sr no as 2 digits of issue id,emp id,movie watched,video id 
-- and sort by sr no
select substring(issue_id,1,4) sr_no,customer_id,movie_id,issue_id
from customer_issue_details
order by sr_no;
-- *14.display total revenue spent on videos by each customer
select count(ci.movie_id)*mm.rent_cost
from customer_issue_details ci,movies_master mm
where ci.movie_id=mm.movie_id
group by ci.CUSTOMER_ID;
-- 15.display customer name in perfect order
-- i.e 1st letter in ucase remaining lcase
select concat(upper(substring(customer_name,1,1)),
lower(substring(customer_name,2,length(customer_name))))
from customer_master;

-- 16.count how many times a movie issued and arrange them in desc order 
-- and display 0 for the movie not issued
select if(count(issue_id)>=1,count(issue_id),0) Times_issued
from customer_issue_details group by movie_id
order by Times_issued desc;

-- 17.waq to display cus id and cus name and address as if phone num 
-- presents display phone num otherwise address
select CUSTOMER_ID,CUSTOMER_NAME,coalesce(contact_no,contact_add)
from customer_master;

-- 18.waq that num of customers registered in 2012 year and provided  contact num
-- use NO_OF_CUSTOMERS as alias name.
select count(customer_id) from customer_master
where (year(DATE_OF_REGISTRATION)='2012') and contact_no is not null;

-- 19.display customer id, cus name,year of registration,library card  id,
-- card issue date alias name registered_year for year of registration
select cm.customer_id,cm.CUSTOMER_NAME,year(cm.DATE_OF_REGISTRATION) year_of_registration,
cc.CARD_ID,cc.ISSUE_DATE
from customer_master cm ,customer_card_details cc
where cm.CUSTOMER_ID=cc.CUSTOMER_ID;

-- 20. (***REPEATED)waq to display movie name and num of times movie issued to 
-- customers..in case of no movie issued
-- to customers display 0.. use alias name as NO_OF_TIMES
select MOVIE_ID,if(count(issue_id),count(ISSUE_ID),0) no_of_times
from customer_issue_details
group by MOVIE_ID;

-- *21.waq to display customer id and customer name ,num of times movie  issued \
-- to customer in comedy movie categorydisplay only customers who has 
-- issude more than once
select cm.CUSTOMER_ID,cm.CUSTOMER_NAME,
if(count(ci.issue_id)>1,count(ci.ISSUE_ID),0) no_of_times
from customer_master cm,customer_issue_details ci,
movies_master mm
where cm.CUSTOMER_ID=ci.CUSTOMER_ID and ci.MOVIE_ID=mm.MOVIE_ID and
mm.MOVIE_CATEGORY like 'comedy'
group by ci.CUSTOMER_ID, mm.MOVIE_ID
having no_of_times>1;

-- 22.(***REPEATED)waq to display customerid and total rent paid by them.
-- use alias name as total_cost.
select ci.CUSTOMER_ID,count(ci.issue_id)*mm.RENT_COST Total_Cost
from customer_issue_details ci,movies_master mm
where ci.MOVIE_ID=mm.MOVIE_ID
group by CUSTOMER_ID;

-- *23.waq to display customerid,cusname,contactno,num of movies issued to  
-- customer based on category and category display the customer who has issude 
-- for more than one movie from that  caregory.
-- display phone num as "+91-987-654-3210".
select cm.CUSTOMER_ID,cm.CUSTOMER_NAME,
concat("+91-",substring(cm.contact_no,1,3),"-",
substring(cm.contact_no,4,3),"-",substring(cm.contact_no,7)),(count( distinct ci.movie_id)),
mm.MOVIE_CATEGORY
from customer_master cm,customer_issue_details ci,movies_master mm
where cm.CUSTOMER_ID=ci.CUSTOMER_ID and ci.MOVIE_ID=mm.MOVIE_ID
group by ci.CUSTOMER_ID,mm.MOVIE_CATEGORY
having count(distinct ci.movie_id)>1;

-- 1.waq that num of customers registered in 2012 year and provided contact num
-- use NO_OF_CUSTOMERS as alias name.
select count(customer_id) from customer_master
where year(DATE_OF_REGISTRATION)='2012' and contact_no is not null;

-- List down the issue date and number of movies issued on the particular date
-- for all the customer having age greater than 20 and If count of issued movies is 
-- less than 3 for allthe english movies.Arrange d record in ascending
 

select ISSUE_DATE,count(movie_id) from customer_issue_details
where CUSTOMER_ID in 
(select customer_id from customer_master where age>20) and 
MOVIE_ID in (select movie_id from movies_master where language like 'english')
group by ISSUE_DATE;

-- List down the customer name,id,contact no,issue id,movie id,issue date
-- of all customers who have taken 2nd maximum no. of movie-cd's

select cm.CUSTOMER_NAME,cm.CUSTOMER_ID,ci.ISSUE_ID,ci.MOVIE_ID,ci.ISSUE_DATE
 from customer_issue_details ci, customer_master cm where cm.CUSTOMER_ID=ci.CUSTOMER_ID
group by customer_id having count(distinct movie_id) in
(select max(x) from (select count(distinct movie_id) x from customer_issue_details
group by customer_id having count(distinct movie_id) not in
(select max(y) from (select count(distinct movie_id) y from customer_issue_details
group by customer_id)tb))tb1);



-- List down the months and no.of movies issued in each month
select date_format(issue_date,"%M") months,count(movie_id) from customer_issue_details
group by months;

-- List down the movie_id,customer_id,issue_date,return_date,release year,
-- language,movie_type for all those having rating greater than 3 stars or movie 
-- category which has comedy
select ci.movie_id,ci.customer_id,ci.issue_date,ci.return_date,
year(m.release_date),m.language,m.MOVIE_TYPE 
from customer_issue_details ci join movies_master m
on ci.MOVIE_ID=m.MOVIE_ID
where RATING>3 and MOVIE_CATEGORY like 'comedy'
;



-- WAQ to disply id,name,age,contact_no,of customer whose age is greater than 25
-- and registered in the year 2012 
-- contact no in "+91-xxx-xxx-xxxx" format and use alias name as contact_ISD .
-- if contact no is null then display "N/A" sort record in ascending based on age




-- WAQ to display customer name,contact no,library_card _id,card description of 
-- all customers.If customer is not holding card then show null.If contact no is 
-- not available then display his address
select cm.CUSTOMER_NAME,coalesce(cm.contact_no,cm.contact_add),
if(cc.CARD_ID is not null ,cc.CARD_ID,null),l.DESCRIPTION

from customer_master cm left outer join customer_card_details cc
on cm.CUSTOMER_ID=cc.CUSTOMER_ID left outer join library_card_master l on cc.card_id=l.card_id;

-- display actor_name as firstname & lastname

-- display member_id who have not issued any movie and exctract serial no.
-- from issue_id
select c.CUSTOMER_ID,substring(ci.ISSUE_ID,4,2)
from customer_master c,customer_issue_details ci
where c.CUSTOMER_ID=ci.CUSTOMER_ID;

-- q-select the no of movies that lead actor 1  watched more that once in the 
-- category of comedy movie

select count(movie_id) from movies_master 
where movie_category='comedy'
group by lead_role_1
;


/* select count(movie_id) from movie master where lead actor 1 
in(select lead actor1 from movie master group by lead actor1having 
count(movie_id)>1 group by movie_id  where category=comedy group by category);
*/
-- display movies of actor who have acted in max no. of movies
select MOVIE_NAME from movies_master group by lead_role_1
having count(movie_id)>= all
(select count(movie_id) from movies_master group by lead_role_1);