use idp

/*Problem # 1: 
Write a query which fetches and displays all the trainers who don’t have an email.*/

select trainer_name from trainer_info where trainer_email is null;

/*Problem # 2: 
Write a query which displays the id, name, track and location of all trainers who has Experience   > 4 years.*/

select trainer_id,trainer_name,trainer_track,trainer_location from trainer_info where trainer_experiance > 4; 

/*Problem # 3:  Select all the modules whose duration > 200.*/

select module_name from module_info where module_duration > 200;

/*Problem # 4:  
Display the trainer Id, trainer name whose trainer qualification is not ‘Bachelor of Technology’. 
*/

select trainer_id,trainer_name from trainer_info where trainer_qualification!='Bachelor of Technology';

/*
Problem # 5:  
Select all the modules whose duration is in the range 200 and 300.*/

select module_name from module_info where module_duration between 200 and 300; 

/*
Problem # 6:  
Display the trainer Id, trainer name whose first name starts with ‘M’
*/
select trainer_id,trainer_name from trainer_info where trainer_name like 'M%';

/*
Problem # 7:  
Display the trainer Id, trainer name whose first name has a character ‘O’
*/

select trainer_id,trainer_name from trainer_info where SUBSTRING_INDEX(trainer_name, ' ', 1) like '%o%';

/*
Problem # 8: 
Display the names of all the modules where the module name is not null. 
*/
select module_name from module_info where module_name is not null;


