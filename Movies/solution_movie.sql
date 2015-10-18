create database movie_database;
use movie_database;

Create table CUSTOMER_MASTER
(
	CUSTOMER_ID Varchar(10),
	CUSTOMER_NAME Varchar(30) NOT NULL,
	CONTACT_NO BIGINT(10),
	CONTACT_ADD Varchar(20),
	DATE_OF_REGISTRATION Date NOT NULL,
	AGE Varchar(15)NOT NULL,
	Constraint MT_cts1 PRIMARY KEY(CUSTOMER_ID)
);

Create table LIBRARY_CARD_MASTER
(
	CARD_ID Varchar(10),
	DESCRIPTION Varchar(30) NOT NULL,
	AMOUNT	BIGINT(50),
	NUMBER_OF_YEARS bigint(10) NOT NULL,
	Constraint MT_cts2 PRIMARY KEY(CARD_ID)
);


Create table MOVIES_MASTER
(
	MOVIE_ID Varchar(10),	
	MOVIE_NAME Varchar(50) NOT NULL,
	RELEASE_DATE Varchar(30) NOT NULL,
	LANGUAGE Varchar(30),
	RATING int(2),
	DURATION VARCHAR(10) NOT NULL,	
	MOVIE_TYPE Varchar(3),
	MOVIE_CATEGORY VARCHAR(20) NOT NULL,
	DIRECTOR VARCHAR(20) NOT NULL,		
	LEAD_ROLE_1 Varchar(30) NOT NULL,
	LEAD_ROLE_2 VARCHAR(30) NOT NULL,
	RENT_COST BIGINT(10),
	Constraint MT_cts4 PRIMARY KEY(MOVIE_ID)	
);

Create table CUSTOMER_CARD_DETAILS
(
	CUSTOMER_ID Varchar(10),
	CARD_ID VARCHAR(10),
	ISSUE_DATE DATE NOT NULL,
	Constraint MT_cts3 PRIMARY KEY(CUSTOMER_ID),
	Constraint MT_CTS41 FOREIGN KEY(CUSTOMER_ID) References CUSTOMER_MASTER(CUSTOMER_ID),
        Constraint MT_CTS42 FOREIGN KEY(CARD_ID) References LIBRARY_CARD_MASTER(CARD_ID)
);

Create table CUSTOMER_ISSUE_DETAILS
(
	ISSUE_ID Varchar(10) NOT NULL,
	CUSTOMER_ID Varchar(10) NOT NULL,
	MOVIE_ID VARCHAR(10),	
	ISSUE_DATE Date NOT NULL,
	RETURN_DATE Date NOT NULL,
        ACTUAL_DATE_RETURN Date NOT NULL,
	Constraint MT_cts5 PRIMARY KEY(ISSUE_ID),
        Constraint MT_Mem FOREIGN KEY(CUSTOMER_ID) References CUSTOMER_MASTER(CUSTOMER_ID),
        Constraint MT_Mem1 FOREIGN KEY(MOVIE_ID) References MOVIES_MASTER(MOVIE_ID)

);

Insert into CUSTOMER_MASTER Values('CUS001', 'Rajiv',
9876543210,'ADD1', '2012-02-12', '21');
Insert into CUSTOMER_MASTER Values('CUS002', 'Raghav',
8765432109,'ADD2', '2012-02-12', '21');
Insert into CUSTOMER_MASTER Values('CUS003', 'T ramachandran',
7654321098,'ADD3', '2012-02-12', '21');
Insert into CUSTOMER_MASTER Values('CUS004', 'RADHA',
6543210987,'ADD4', '2012-02-12', '21');
Insert into CUSTOMER_MASTER Values('CUS005', 'GURU', NULL,'ADD5',
'2012-02-12', '21');
Insert into CUSTOMER_MASTER Values('CUS006', 'Moti',
4321098765,'ADD6', '2012-02-12', '21');
Insert into CUSTOMER_MASTER Values('CUS007', 'Zunaid',
3210987654,'ADD7', '2012-02-12', '21');
Insert into CUSTOMER_MASTER Values('CUS008', 'Zoya',
2109876543,'ADD8', '2013-02-12', '21');
Insert into CUSTOMER_MASTER Values('CUS009', 'Reddy', NULL,'ADD9',
'2013-02-12', '21');
Insert into CUSTOMER_MASTER Values('CUS010', 'Rohan',
9934567890,'ADD10', '2013-02-12', '21');
Insert into CUSTOMER_MASTER Values('CUS011', 'Simran',
9875678910,'ADD11', '2013-02-12', '21');

Insert into LIBRARY_CARD_MASTER Values('CR001', 'GOLD', 200, 5);
Insert into LIBRARY_CARD_MASTER Values('CR002', 'SILVER', 400, 9);
Insert into LIBRARY_CARD_MASTER Values('CR003', 'PLATINUM', 600, 8);
Insert into LIBRARY_CARD_MASTER Values('CR004', 'BRONZE', 800, 7);
Insert into LIBRARY_CARD_MASTER Values('CR005', 'GOLD', 1200, 6);

Insert into MOVIES_MASTER Values('MV001', 'DIEHARD',
'2012-05-13','ENGLISH', 4 , '2HRS', 'U/A','ACTION','Christopher
nolan','Leonardo di caprio','sohran',100);
Insert into MOVIES_MASTER Values('MV002', 'THE MATRIX',
'2012-05-13','ENGLISH', 4 , '3HRS', 'A','ACTION','DIR2','jason
statham','srk',100);
Insert into MOVIES_MASTER Values('MV003', 'INCEPTION',
'2012-05-13','ENGLISH', 4 , '2HRS', 'U/A','ACTION','DIR3','leonardo di
caprio','hrithik',100);
Insert into MOVIES_MASTER Values('MV004', 'DARK KNIGHT',
'2012-05-13','ENGLISH', 4 , '5HRS', 'A','ACTION','Christopher
nolan','brad pitt','pitbull',100);
Insert into MOVIES_MASTER Values('MV005', 'OFFICE S',
'2012-05-13','ENGLISH', 4 , '2HRS', 'U/A','COMEDY','DIR5','lucas
black','vivek',100);
Insert into MOVIES_MASTER Values('MV006', 'SHAWN OF DEAD',
'2012-05-13','ENGLISH', 4 , '2HRS', 'U/A','COMEDY','DIR6','vin
diesel','aamir',100);
Insert into MOVIES_MASTER Values('MV007', 'YOUNG FRANKEN',
'2012-05-13','ENGLISH', 4 , '3HRS', 'U/A','COMEDY','DIR7','vin
diesel','imran',100);
Insert into MOVIES_MASTER Values('MV008', 'IRONMAN',
'2012-05-13','ENGLISH', 4 , '1HRS', 'A','ROMANCE','DIR8','salman
khan','irfaan',100);
Insert into MOVIES_MASTER Values('MV009', 'GIJOE',
'2012-05-13','ENGLISH', 4 , '2HRS', 'A','ROMANCE','DIR9','john
rambo','zayed',100);
Insert into MOVIES_MASTER Values('MV010', 'TITANIC',
'2012-05-13','ENGLISH', 4 , '3HRS', 'A','ROMANCE','DIR10','johny
depp','himesh',100);
Insert into MOVIES_MASTER Values('MV011', 'THE NOTE BOOK',
'2012-05-13','ENGLISH', 4 , '2HRS', 'A','ROMANCE','DIR11','tom
cruise','naveen',100);


Insert into CUSTOMER_CARD_DETAILS Values('CUS001', 'CR001', '2012-05-13');
Insert into CUSTOMER_CARD_DETAILS Values('CUS002', 'CR002', '2012-05-13');
Insert into CUSTOMER_CARD_DETAILS Values('CUS003', 'CR002', '2013-05-13');
Insert into CUSTOMER_CARD_DETAILS Values('CUS004', 'CR003', '2013-05-13');
Insert into CUSTOMER_CARD_DETAILS Values('CUS005', 'CR003', '2012-05-13');

Insert into CUSTOMER_ISSUE_DETAILS Values ('IS001', 'CUS001', 'MV001',
'2012-05-13', '2012-05-13','2012-05-13');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS002', 'CUS001', 'MV001',
'2012-05-01', '2012-05-16','2012-05-16');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS003', 'CUS002', 'MV004',
'2012-05-02', '2012-05-06','2012-05-16');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS004', 'CUS002', 'MV004',
'2012-04-03', '2012-04-16','2012-04-20');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS005', 'CUS002', 'MV009',
'2012-04-04', '2012-04-16','2012-04-20');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS006', 'CUS003', 'MV002',
'2012-03-30', '2012-04-15','2012-04-20');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS007', 'CUS003', 'MV003',
'2012-04-20', '2012-05-05','2012-05-05');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS008', 'CUS003', 'MV005',
'2012-04-21', '2012-05-07','2012-05-25');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS009', 'CUS003', 'MV001',
'2012-04-22', '2012-05-07','2012-05-25');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS010', 'CUS003', 'MV009',
'2012-04-22', '2012-05-07','2012-05-25');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS011', 'CUS003', 'MV010',
'2012-04-23', '2012-05-07','2012-05-25');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS012', 'CUS003', 'MV010',
'2012-04-24', '2012-05-07','2012-05-25');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS013', 'CUS003', 'MV008',
'2012-04-25', '2012-05-07','2012-05-25');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS014', 'CUS004', 'MV007',
'2012-04-26', '2012-05-07','2012-05-25');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS015', 'CUS004', 'MV006',
'2012-04-27', '2012-05-07','2012-05-25');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS016', 'CUS004', 'MV006',
'2012-04-28', '2012-05-07','2012-05-25');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS017', 'CUS004', 'MV001',
'2012-04-29', '2012-05-07','2012-05-25');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS018', 'CUS010', 'MV008',
'2012-04-24', '2012-05-07','2012-05-25');
Insert into CUSTOMER_ISSUE_DETAILS Values ('IS019', 'CUS011', 'MV009',
'2012-04-27', '2012-05-07','2012-05-25');


set session sql_mode='only_full_group_by';

select * from customer_card_details;
select * from customer_issue_details;
select * from customer_master;
select * from library_card_master;
select * from movies_master;

select count(customer_id)as bull from customer_card_details where card_id in 
(select card_id from library_card_master where description='gold');

/*display the name of member who issued movie and the count of the 
movies issued and display 0 for the member who have not issued any 
movie*/

select cm.customer_name,x.count from customer_master cm inner join
(select customer_id,count(movie_id)as count from customer_issue_details group by customer_id)x on cm.customer_id=x.customer_id
union
select customer_name, 0 as count from customer_master where customer_id not in
(select customer_id from customer_issue_details);

/*3.display the name of the person starting with letter 'r' and category 
is 'comedy'*/

select distinct a.customer_name 
from customer_master  a,customer_issue_details b,movies_master c
where  a.customer_id=b.customer_id and b.movie_id=c.movie_id and  c.movie_category='comedy'
and a.customer_name like 'r%';

/*display id,name & total rent of customers for movie issued*/

select x.customer_id,m1.customer_name,x.total from customer_master m1,(select c.customer_id,sum(m.rent_cost)as total from customer_issue_details c, movies_master m
where c.movie_id=m.movie_id group by c.customer_id)x where m1.customer_id=x.customer_id order by total asc;

/*display id,name,card id,amount in $(amount/54.42) upto 0 decimals*/

select cd.customer_id, m.customer_name,id.card_id, round(amount/54.42,4) as $ 
from customer_master m, library_card_master id, customer_card_details cd
where m.customer_id=cd.customer_id and cd.card_id=id.card_id;

/*display id,name of customers who dont have library card but still 
have issued the movie*/

select customer_id, customer_name from customer_master where customer_id 
not in (select customer_id from customer_card_details) 
and customer_id in(select customer_id from customer_issue_details);

/*display the no.of customers with first letter 'r' and have paid fine
i.e actual return date is greater than return date
*/

select count(distinct id.customer_id) as guldo from customer_master m, customer_issue_details id where
id.customer_id=m.customer_id and m.customer_name like 'r%' and id.actual_date_return>id.return_date;


/*8.display customer name,customer id who have issued max and min no.of 
movies issued
*/



select cm.customer_name,x.customer_id,x.count 
from customer_master cm 
inner join
(select customer_id,count(movie_id)'count' from customer_issue_details group by customer_id)x
on cm.customer_id=x.customer_id where
x.count=(select  max(count) from 
(select customer_id,count(movie_id)'count' from customer_issue_details group by customer_id)x)
union
select cm.customer_name,x.customer_id,x.count 
from customer_master cm 
inner join
(select customer_id,count(movie_id)'count' from customer_issue_details group by customer_id)x
on cm.customer_id=x.customer_id where
x.count=(select  min(count) from 
(select customer_id,count(movie_id)'count' from customer_issue_details group by customer_id)x);



select customer_id,customer_name from customer_master 
where customer_id in (select customer_id from customer_issue_details group by customer_id
having count(*)=(select  max(count) from 
(select count(movie_id)'count' from customer_issue_details group by customer_id)x) or
count(*)=(select  min(count) from 
(select count(movie_id)'count' from customer_issue_details group by customer_id)x));

select count(movie_id)'count' from customer_issue_details group by customer_id;

/*display id,name,mobile num and description of all customers.if 
mobile num is not available then display address as alias contact,for 
those who does't have library cards display null as description*/


select cm.customer_id,cm.customer_name,coalesce(cast(cm.contact_no as char),cm.contact_add)as c,
case when (lcm.description is null) then 'null'
else lcm.description end as d 
from 
customer_master cm,customer_card_details ccd, library_card_master lcm
where cm.customer_id=ccd.customer_id and ccd.card_id=lcm.card_id;

/*
display customer details and movie id for those who issued same  movie more than one time OR
//dislay customer details who watched same movie more than once

*/


select m.*, z.movie_id from customer_master m,(select customer_id, movie_id,count(movie_id) as count 
from customer_issue_details group by customer_id, movie_id)z where z.count>1 and m.customer_id=z.customer_id;


/*
.display customer information those who has library cards
*/

select * from customer_master where customer_id in 
(select customer_id from customer_card_details);

/*
display the members who watch the movie but doesnt have card
*/

select *from customer_master where customer_id in (select customer_id from customer_issue_details) 
or customer_id not in (select customer_id from customer_card_details);

/*
display sr no as 2 digits of issue id,emp id,movie watched,video id 
and sort by sr no
*/
select right(issue_id,2) sr_no,issue_id as  video_id,customer_id,movie_id 
from customer_issue_details order by sr_no;

/*display total revenue spent on videos by each customer*/

select customer_id, sum(rent_cost) from ( select cid.customer_id, cid.movie_id, mm.rent_cost from customer_issue_details cid, movies_master mm
where cid.movie_id=mm.movie_id) x group by customer_id;

/*display customer name in perfect order
i.e 1st letter in ucase remaining lcase
*/

select concat(upper(left(customer_name,1)),lower(substring(customer_name,2))) from customer_master;

/*count how many times a movie issued and arrange them in desc order 
and display 0 for the movie not issued*/

select movie_id, count(movie_id) as count from customer_issue_details group by movie_id 
union
select movie_id,0 as count from movies_master where movie_id not in
(select movie_id from customer_issue_details)order by count desc; 

/*.waq to display cus id and cus name and address as if phone num 
presents display phone num otherwise address.*/

select customer_id, customer_name, coalesce(cast(contact_no as char),contact_add) as c from customer_master;


/*waq that num of customers registered in 2012 year and provided  contact num
use NO_OF_CUSTOMERS as alias name.
*/


select count(customer_id) from customer_master where extract(year from date_of_registration)='2012' and contact_no is not null;


/*display customer id, cus name,year of registration,library card  id,card issue date
alias name registered_year for year of registration.
*/

select cm.customer_id, cm.customer_name, cm.date_of_registration as year,lcm.card_id,ccd.issue_date as registered
from customer_master cm,library_card_master lcm, customer_card_details ccd 
where ccd.customer_id=cm.customer_id and ccd.card_id=lcm.card_id; 

 
/*waq to display customer id and customer name ,num of times movie  issued to customer in comedy movie category
display only customers who has issude more than once
*/

select cm.customer_name, cm.customer_id,x.count 
from customer_master cm,
(select cid.customer_id, count(cid.movie_id)'count' from customer_issue_details cid, movies_master mm 
where mm.movie_id=cid.movie_id and mm.movie_category='comedy' group by customer_id having count(cid.movie_id)>1)x 
where cm.customer_id=x.customer_id;


/*waq to display customerid,cusname,contactno,num of movies issued to  customer based on category and category
display the customer who has issude for more than one movie from that  caregory.
display phone num as "+91-987-654-3210".
*/








select x.customer_id, cm.customer_name,concat('+91-',left(cast(cm.contact_no as char),3),'-',
substring(cast(cm.contact_no as char),4,3),'-',right(cast(cm.contact_no as char),4)), x.count,x.movie_category 
from customer_master cm,
(select cid.customer_id,mm.movie_category,count(mm.movie_id) 'count' 
from movies_master mm, customer_issue_details cid 
where mm.movie_id=cid.movie_id 
group by customer_id,mm.movie_category 
having count(mm.movie_id)>1)x where cm.customer_id=x.customer_id;











