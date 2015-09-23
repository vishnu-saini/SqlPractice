/*
Problem # 1:  
Write a query to display student information such as name, branch in capital letters.
*/
select ucase(student_name),ucase(branch),ucase(contact_number),ucase(date_of_birth),
ucase(date_of_joining),ucase(address),ucase(email_id) 
from student_info;
/*
Problem # 2:  
Write a query to displays all details in subject_master in small letters.
*/
select lcase(subject_code),lcase(SUBJECT_NAME),lcase(WEIGHTAGE) 
from subject_master;
/*
Problem # 3:  
Write two separate queries to display the registration number date of birth of all the students in the following formats
•	2011/07/23
•	July 23, 2011
*/
select reg_number,DATE_FORMAT(date_of_birth, '%Y-%m-%d') 
from student_info;
select reg_number,DATE_FORMAT(date_of_birth, '%b%d,%Y') 
from student_info;
/*
Problem # 4:  
Write a query to display age of each student along with name, contact number and email id.
Age = Number of months between DOB and current date /12.
*/
select timestampdiff(month,date_of_birth,current_date)/12,
student_name,contact_number,email_id 
from student_info;
/*
Problem # 5:  
Write a query to display the registration number, student name and 
average marks secured by students in each semester.
*/

select si.reg_number,si.student_name,avg(sm.marks)
from student_info as si 
join student_marks as sm on si.reg_number= sm.reg_number 
group by si.reg_number,sm.semester;


/*
Problem # 6:  
Pick the maximum mark from the students_marks and display the student registration number and
 name of those students who have secured the maximum mark.
*/
select si.reg_number,sum(sm.marks), si.student_name from student_info si
join student_marks sm on sm.reg_number=si.reg_number 
group by sm.reg_number having sum(sm.marks) =(

	select max(mar) 
	from (
		select sum(marks) as mar 
		from student_marks 
		group by reg_number
	)	temp
);
/*
Problem # 7:  
Pick the maximum marks secured in the subject “ EI05IP” and display the student name and registration number of 
the student who has secured it.
*/
select student_info.student_name,student_info.reg_number
from student_info 
join student_marks on student_marks.reg_number=student_info.reg_number
where student_marks.subject_code='EI05IP' 
and student_marks.reg_number in(
	select student_marks.reg_number from student_marks
	having student_marks.marks=(
		select max(marks) from student_marks where subject_code ='EI05IP'
	)
);
/*
Problem # 8: 
Write a query to display the average GPA for each semester. Display the semester number and the average. 
Hint: Average = Total GPA of all students in a semester/total number of students in a semester
Rule: Use AVG function
*/
select semester,avg(gpa) from student_result group by semester;
/*
Problem # 9:
Write a query which will display all the student records, if the student email id is null it should be displayed as “no valid email address”.
*/
select reg_number,student_name,branch,contact_number,date_of_birth,date_of_joining,
address,
if(email_id is null,'no valid email address',email_id) from student_info;
/*
Problem # 10:
Write a query which will display the student name, branch, registration number, semester number and result. Display the full name of EEE as well as ECE branch as mentioned below,
If EEE then ‘Electrical and Electronic Engineering’
If ECE then Electronics and Communication Engineering.
*/

select si.student_name,
case when si.branch='EEE' then 'Electrical and Electronic Engineering'
when si.branch='ECE'then'Electronics and Communication Engineering'
else si.branch end
,si.reg_number,sr.semester,sr.gpa
from 
student_info si join student_result sr on si.reg_number=sr.reg_number;