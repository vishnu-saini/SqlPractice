/*
Problem 1:  Develop a sql query which would retrieve the number of associates enrolled for 
modules on a specific date grouped by start date and display start date and total number of associates.
*/
select count(associate_id),start_date
from associate_status
group by start_date; 
/*
Problem 2:  Develop a sql query which would retrieve the number of associates enrolled 
for modules where trainer id is ‘F001’ grouped by start date and display start date and total 
number of associates.
*/
select count(associate_id),Start_Date
from associate_status
where trainer_id='F001'
group by start_date ;
/*
Problem 3: Develop a sql query which would retrieve the number of associates enrolled for 
modules where trainer id is ‘F001’ grouped by module start date and display module start date and 
total number of associates where the total number of associates > 2.
*/
select count(associate_id),start_date
from associate_status
where trainer_id='F001'
group by start_date having count(associate_id)>2 ; 
/*
Problem 4: Develop a SQL query which displays all the modules in increasing order of module duration.
*/
select Module_Name
from module_info
order by module_duration ;
/*
Problem 5: Develop a sql query which would retrieve and display the associates name, their 
module enrolled (module name and module id), base fees. Display the records ordering the 
base fees in descending order.
*/