/*Exercise 1
	
	
Hands-on Exercise Objective
After completing the hands-on exercises, you will be able to:
Use different types of joins on tables.
	

Problem Statement:
Write a query to display student names along with the subject codes and corresponding marks of the students.
Hint: Use Student_Marks and Student_Info tables.

Deliverables Expected:
Records are fetched based on the condition specified.
*/
select si.student_name,sm.subject_code,sm.marks 
from student_info as si
join student_marks as sm on si.reg_number=sm.reg_number;


/*
Exercise 2	
	

Problem Statement:
Write a query to display student names along with the subject codes and corresponding marks of the students,
 for all students who have scored greater than or equal to 65 marks in all subjects.
Hint: Use Student_Marks and Student_Info tables.

Deliverables Expected:
Records are displayed based on the condition specified.
*/
select si.student_name,sm.subject_code, sm.marks 
from student_info si
join student_marks sm on sm.reg_number=si.reg_number
where si.reg_number not in(
	select reg_number from student_marks where marks <65
);

/*
Exercise 3

Problem Statement:
Write a query to display the reg number, student name, CGPA for the student with highest CGPA.
Hint: Use Student_Results and Student_Info tables.



Deliverables Expected:
Records are displayed based on the condition specified.
*/

select si.reg_number,si.student_name,avg(sr.gpa) as cgpa 
from student_info as si
join student_result as sr on si.reg_number=sr.reg_number
group by si.reg_number 
having cgpa = (
	select max(cgpa) from (
		(
		select avg(gpa) as cgpa 
		from student_result 
		group by reg_number
		)temp
	)
);



/*
Exercise 4
i.	Create Backup_Student_Info<employee_id> table – This table is used for storing the student personal 
information.
a.	Reg_Number – Primary Key – Varchar – Foreign Key to Student_Info<employee_id> table
b.	Student_Name -  Varchar(30)  not null
c.	Branch – Varchar
d.	Contact_Number – Varchar
e.	Date_of_Birth-Date, not null
f.	Date_of_Joining-Date – Default value system date.
g.	Address-Varchar(250)
h.	Email_id-Varchar(250)

Copy all records of Student_Info<employee_id> into Backup_Student_Info<employee_id>

Insert few records into Student_Info<employee_id> These records should not exist in 
Backup_Student_Info<employee_id>.

Problem Statement:
Write a query to display all columns of Student_Info<employee_id> table irrespective of whether there is a
 match in Backup_Student_Info<employee_id> or not.
Note: Use Left outer  Join

Deliverables Expected:
Records are displayed based on the condition specified.
*/

Create table Bachup_Student_Info_493705(
reg_number varchar(10) primary key references student_info(reg_number),
student_name varchar(30) not null,
branch varchar(15),
contact_number varchar(12),
date_of_birth date not null,
date_of_joining timestamp default current_timestamp,
address varchar(250),
email_id varchar(250)
);

INSERT Backup_Student_Info_493705 SELECT * FROM student_info;

insert into student_info values("a001","Vishnu","IT","9667670302","1992-01-31","2014-04-03","Jaipur","vishnu@gmail.com");
insert into student_info values("a002","Satya","IT","9667670302","1992-01-31","2014-04-03","Jaipur","vishnu@gmail.com");
insert into student_info values("a003","Pankaj","IT","9667670302","1992-01-31","2014-04-03","Jaipur","vishnu@gmail.com");

select si.*,bsi.*
from student_info as si
left join Backup_Student_Info_493705 as bsi
on si.reg_number=bsi.reg_number;


/*
CREATE TABLE Backup_Student_Info_493705 LIKE student_info;
drop table Backup_Student_Info_493705;
DELETE FROM student_info where reg_number in ("a001","a002","a003");
Create table Bachup_Student_Info_493705(
reg_number varchar(10) primary key references student_info(reg_number),
student_name varchar(30) not null,
branch varchar(15),
contact_number varchar(12),
date_of_birth date not null,
date_of_joining timestamp default current_timestamp,
address varchar(250),
email_id varchar(250)
);
desc Backup_Student_Info_493705;
INSERT Backup_Student_Info_493705 SELECT * FROM student_info;
insert into student_info values("a001","Vishnu","IT","9667670302","1992-01-31","2014-04-03","Jaipur","vishnu@gmail.com");
insert into student_info values("a002","Satya","IT","9667670302","1992-01-31","2014-04-03","Jaipur","vishnu@gmail.com");
insert into student_info values("a003","Pankaj","IT","9667670302","1992-01-31","2014-04-03","Jaipur","vishnu@gmail.com");

insert into Backup_Student_Info_493705 (reg_number,student_name,branch,contact_number,date_of_birth,address,email_id) 
values("a002","Vishnu","IT","9667670302","1992-01-31","Jaipur","vishnu@gmail.com");
select * from Backup_Student_Info_493705;
select si.*,bsi.*
from student_info as si
left join Backup_Student_Info_493705 as bsi
on si.reg_number=bsi.reg_number;
*/


/*
Exercise 5
	

Problem Statement:
Solve the problem statement in Exercise 4 using Right Outer Join.
Deliverables Expected:
Records are displayed based on the condition specified.

*/

select si.*,bsi.*
from Backup_Student_Info_493705 as bsi
right join student_info  as si
on si.reg_number=bsi.reg_number;
