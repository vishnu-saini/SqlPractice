select gender,count(gender) as Count from employee_master group by gender;

select employee_id,employee_name from employee_master where year(date_of_joining)>2005;

select employee_id,employee_name,designation,department from employee_master where employee_id not in
(select employee_id from employee_issue_details);

select count(employee_id) as Count from employee_master where department='HR';

select item_category,count(item_category) as count from item_master group by item_category order by count desc;

select eid.issue_id,em.employee_id,em.employee_name from employee_master em join employee_issue_details eid on em.employee_id=eid.employee_id;

select count(issue_id) as Count from employee_issue_details where employee_id='E00001';

select count(item_id) as count,issue_status from item_master where item_category='furniture' group by issue_status;

select count(em.employee_id) from employee_master em join
employee_card_details ecd on ecd.employee_id=em.employee_id join loan_card_master lcm on lcm.loan_id=ecd.employee_id
where lcm.loan_type='stationary';



select em.employee_id,em.employee_name from employee_master em 
where em.employee_id not in(select employee_id from employee_card_details);


select distinct count(item_id)as count,item_category,item_description from item_master group by item_category,item_description;


select eid.issue_id,em.employee_id,em.employee_name,im.item_id,im.item_description,eid.issue_date from employee_master em join employee_issue_details eid
on eid.employee_id=em.employee_id join item_master im on eid.item_id=im.item_id order by year(issue_date) desc,month(issue_date);

select em.employee_id,em.employee_name,count(eid.issue_id) from employee_master em join employee_issue_details eid on eid.employee_id=em.employee_id
join item_master im on im.item_id=eid.item_id where im.issue_status='y' group by em.employee_id;


select em.employee_id,em.employee_name,sum(im.item_valuation) from employee_master em join employee_issue_details eid on eid.employee_id=em.employee_id
join item_master im on im.item_id=eid.item_id group by em.employee_id;

select em.employee_id,em.employee_name,count(eid.item_id) from employee_master em join employee_issue_details eid on eid.employee_id=em.employee_id
join item_master im on im.item_id=eid.item_id where im.item_category='furniture' group by em.employee_id having count(im.item_id)>1;


select em.employee_id,em.employee_name,count(im.item_category) as Count_category from employee_master em join employee_issue_details eid on em.employee_id=eid.employee_id join
item_master im on eid.item_id=im.item_id group by em.employee_id having count(distinct im.item_category)>=2;


select em.employee_id,em.employee_name,im.item_id,im.item_description from employee_master em join employee_issue_details eid on em.employee_id=eid.employee_id join
item_master im on eid.item_id=im.item_id where im.issue_status='y' and eid.issue_date like '2013-01%';

select im.item_id,im.item_description from item_master im where im.item_id not in (select eid.item_id from employee_issue_details eid);

select distinct em.employee_id,em.employee_name from employee_master em join employee_issue_details eid on em.employee_id=eid.employee_id
where datediff(eid.return_date,eid.issue_date)/365>1 group by eid.employee_id;

select em.employee_id,em.employee_name from employee_master em where em.employee_id not in (select eid.employee_id from employee_issue_details eid
where year(issue_date) like '2013%');

select cast(duration_in_years as date) from loan_card_master;

select distinct em.employee_id,em.employee_name,ecd.card_issue_date,date_add(ecd.card_issue_date,interval lcm.duration_in_years year)
from employee_master em join employee_card_details ecd on
em.employee_id=ecd.employee_id join loan_card_master lcm on lcm.loan_id=ecd.loan_id ;




select em.employee_id,em.employee_name from employee_master em join employee_issue_details eid on em.employee_id=eid.employee_id
join item_master im on im.item_id=eid.item_id where im.issue_status='y' and im.item_valuation=(select max(im.item_valuation) 
from item_master im);


select em.employee_id,em.employee_name from employee_master em join employee_issue_details eid on em.employee_id=eid.employee_id
join item_master im on im.item_id=eid.item_id where im.issue_status='y' group by em.employee_id having sum(im.item_valuation)>=all(select sum(im.item_valuation) 
from employee_master em join employee_issue_details eid on em.employee_id=eid.employee_id
join item_master im on im.item_id=eid.item_id where im.issue_status='y' group by em.employee_id);



select em.employee_id,em.employee_name from employee_master em join employee_issue_details eid on em.employee_id=eid.employee_id
join item_master im on im.item_id=eid.item_id where im.issue_status='y' group by em.employee_id having sum(im.item_valuation)<=all(select sum(im.item_valuation) 
from employee_master em join employee_issue_details eid on em.employee_id=eid.employee_id
join item_master im on im.item_id=eid.item_id where im.issue_status='y' group by em.employee_id);


select em.employee_id,em.employee_name from employee_master em join employee_issue_details eid on em.employee_id=eid.employee_id
join item_master im on im.item_id=eid.item_id  where im.issue_status='y' and im.item_valuation=(select min(im.item_valuation) 
from item_master im);

select min(im.item_valuation) from item_master im;






