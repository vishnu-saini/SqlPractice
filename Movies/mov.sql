use mt_db;

select m.customer_name,count(d.movie_id) 
from customer_issue_details d
right outer join
customer_master m
on d.customer_id=m.customer_id
group by m.customer_id;

/*3.display the name of the person starting with letter 'r' and category 
is 'comedy'*/
select m.customer_name
from
customer_master m
inner join
customer_issue_details d
on m.customer_id=d.customer_id
inner join
movies_master mm
on d.movie_id=mm.movie_id
where mm.movie_category='comedy'
and m.customer_name like'r%'
group by m.customer_id;

select * from customer_issue_details;
select * from customer_master;
select * from movies_master;


/*4.display id,name & total rent of customers for movie issued*/

select m.customer_id,m.customer_name, sum(mm.rent_cost)
from customer_master m
inner join
customer_issue_details d
on m.customer_id=d.customer_id
inner join
movies_master mm
on mm.movie_id=d.movie_id
group by d.customer_id;

/*5.display id,name,card id,amount in $(amount/54.42) upto 0 decimals*/

select m.customer_id,m.customer_name,d.card_id,concat("$",convert(round(l.amount/54.42),char(20)))
from customer_master m
inner join
customer_card_details d
on m.customer_id=d.customer_id
inner join
library_card_master l
on d.card_id=l.card_id;


/*6.display id,name of customers who dont have library card but still 
have issued the movie*/

select customer_id,customer_name from customer_master;

select m.customer_id,m.customer_name
from 
customer_master m
inner join
customer_issue_details d
on m.customer_id=d.customer_id
where d.customer_id not in (select customer_id from customer_card_details);



/*8display the no.of customers with first letter 'r' and have paid fine
i.e actual return date is greater than return date*/
select count(distinct d.CUSTOMER_ID),m.customer_name
from customer_master m
inner join customer_issue_details d
on m.customer_id =d.customer_id
where d.ACTUAL_DATE_RETURN > d.RETURN_DATE and m.customer_name like 'r%'
group by m.customer_name,m.customer_id;


/* 8.display customer name,customer id who have issued max and min no.of 
movies issued
*/

select customer_name,a.customer_id
from customer_issue_details  a,customer_master b
where a.customer_id=b.customer_id
group by  a.customer_id 
having count(a.movie_id)=(
select min(a.count) min from  (select customer_id,count(movie_id) count 
from customer_issue_details 
group by customer_id) a) 
or count(a.movie_id)=(
select max(b.count) min  from (select customer_id,count(movie_id) count 
from  customer_issue_details 
group by customer_id) b);

/*9.display id,name,mobile num and description of all customers.if 
mobile num is not available then display address as alias contact,for 
those who does't have library cards display null as description*/

select cm.customer_id,cm.customer_name,coalesce(convert(contact_no,char(10)) ,contact_add),ifnull(description,null)
from customer_card_details ccd
inner join library_card_master lcd
on ccd.card_id=lcd.card_id
right outer join customer_master cm
on cm.customer_id=ccd.customer_id;

/* 10.display customer details and movie id for those who issued same  movie more than one time. */

select m.customer_id,d.movie_id  as ct
from customer_master m
inner join
customer_issue_details d
on m.customer_id=d.customer_id
group by d.customer_id,d.movie_id
having count(ct)>1;

/* 11.display customer information those who has library cards */




