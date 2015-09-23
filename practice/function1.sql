use idp;
show tables;

/*
Problem 1: Develop a query which will display the module name and module Infra fees of the entire module.
 The infra fee should be rounded to 2 decimal point.
*/
select module_name 
from module_info;
/*
Problem 2: Develop a query which will list all the module id and module names in Module_Info   
table where in the first letter should be capital letter.
*/
select Module_Id,Module_Name 
from module_info 
where substr(module_name,1,1)>='A' and substr(module_name,1,1)<='Z';
/*
Problem 3: Develop a query which will display the module id and the number of days between 
the current date and module start date in associate_status   table 
*/
select Module_Id,timestampdiff(day,start_date,current_date) 
from associate_status;
/*
Problem 4: Develop a query which will concatenate the Module Name and Module id in the following 
format and display all the modules in the module_info  table. 
	“< Module Name><Module id>”
*/
select concat('<',module_name,'>','<',module_id,'>') 
from module_info;
/*
Problem 5: Develop a query which will display all the Module Name in upper case.
*/
select ucase(module_name) 
from module_info;
/*
Problem 6: Develop a query which will display all the characters between 1 and 3 of the Module name 
column for all the modules in the Module_Info table. 
*/
select substr(Module_Name,2,1) 
from module_info;
/*
Problem 7: Develop a query calculate average of all the module base fees, any records whose base fee is null needs to be considered as zero.
*/

/*
Problem 8: 
Write a query which will convert Trainer_Info’s Trainer_Id to Number and add 100000 and display it for 
all the trainers in the Trainer_Info table. 
*/
select cast(substr(trainer_id,2) as decimal)+10000 
from trainer_info;
/*
Problem 9: 
Write a query which will convert Base_Fees into Varchar from the Module_info table. 
And display in the following format
‘The Base Fees Amount for the module name’ <Module Name>’ is ’<Base Fees>
*/

/*
Problem 10: Write a query which will display the total number of records in Module_Info table.
*/
select count(*) 
from module_info;
/*
Problem 11: Develop a query which will give the sum of all base fees of all modules in the Module_Fees   table.
*/

/*
Problem 12:  Display the minimum and maximum base fees of the modules. 
*/

