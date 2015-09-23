/*Exercise 1
Problem Statement:
Write a query to display trainer_id and batch_id details in such a way that we get all possible combinations of trainer IDs and batch IDs. 
Hint: Use Trainer_Info and Batch_Info tables.

Deliverables Expected:
All combinations of trainer_id and batch_id are displayed.
*/

select t.trainer_id,b.batch_id 
from trainer_info as t
join batch_info as b;



/*
Exercise 2	
Problem Statement:
Write a query to display the records from all columns of tables associate_status and batch_info,
 wherever the batch_id in the two tables matches.

Deliverables Expected:
Records are displayed based on the condition specified.
*/

select a.*,b.* 
from associate_status as a 
join batch_info as b on a.batch_id=b.batch_id;
/*
Exercise 3

Problem Statement:
Write a query to display the associate IDs of the associates tagged to trainers and all the trainer IDs 
irrespective of whether there are any associates tagged to them or not. 
Hint: Use associate_status and trainer_info tables
Note: Use Right Outer Join

Deliverables Expected:
Records are displayed based on the condition specified.
*/
select a.associate_id,t.trainer_id 
from associate_status as a
right join trainer_info as t on a.trainer_id=t.trainer_id;
/*
Exercise 4

Problem Statement:
Write a query to display the associate IDs of the associates tagged to trainers and all 
the trainer IDs irrespective of whether there are any associates tagged to them or not. 
Hint: Use associate_status and trainer_info tables.
Note: Use Left Outer Join

Deliverables Expected:
Records are displayed based on the condition specified.
*/

select a.associate_id,t.trainer_id 
from trainer_info  as t
left join associate_status as a on a.trainer_id=t.trainer_id;

/*
Exercise 5
	

Problem Statement:
Write a query to display the associate IDs of all the associates and trainer IDs of all trainers irrespective 
of whether any associate is mapped to a trainer ID and vice versa. 
Hint: Use associate_status and trainer_info tables.
(NOTE: ANSI syntax for Full Outer Join is supported by SQL Server, Not Supported by MySQL, Oracle, and Sybase)
Prerequisite: Add an associate_id which is not mapped to any trainer ID. Take care of the alteration in constraints to the other tables in order to achieve this.

Deliverables Expected:
Records are displayed based on the condition specified.
*/

select a.associate_id,t.trainer_id 
from trainer_info as t
right join associate_status as a on a.trainer_id=t.trainer_id 

union

select a.associate_id,t.trainer_id 
from trainer_info as t
left join associate_status as a on t.trainer_id=a.trainer_id;