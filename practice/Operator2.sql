use idp2;
/*
Problem # 1:  
Write a query which fetches and displays all the students who have an email id.
*/

select student_name from student_info where email_id is not null;

/*
Problem # 2:  
Write a query which displays the marks and register number of all students who has scored marks > 50%.
*/
select marks,reg_number from student_marks where marks>50;
/*
Problem # 3:  
 Write a query which will retrieve the registration number, student name, subject name, semester # and the respective marks of the subject
*/

select si.reg_number,si.student_name,sm.subject_name,smk.semester,smk.marks 
from student_info as si
join student_marks as smk on si.reg_number=smk.reg_number
join subject_master as sm on smk.subject_code=sm.subject_code;

/*
Problem # 4:  
Write a query to display the student name, registration number, subject code, subject name, marks and semester # of all the students who 
have scored more than 50%. 
*/

select si.student_name,si.reg_number,sm.subject_code,sm.subject_name,smk.marks,smk.semester 
from student_info as si
join student_marks as smk on si.reg_number=smk.reg_number
join subject_master as sm on smk.subject_code=sm.subject_code
where smk.marks>50;

/*
Problem # 5:  
Write a query to display the registration number and GPA of each student in such a way that 
the students who are eligible for scholarship are displayed first.
*/

select si.reg_number,sr.gpa,sr.is_eligible_scholarship
from student_info as si
join student_result as sr on si.reg_number=sr.reg_number
order by sr.is_eligible_scholarship desc;

/*
Problem # 6:  
Write a query to display registration number, student name, the marks of the students, and the weighted marks.
Weighted Marks= marks * weightage %/100.
*/
select si.reg_number,si.student_name,smk.marks,(smk.marks*weightage/100)  as weighted_marks
from student_info as si
join student_marks as smk on si.reg_number=smk.reg_number
join subject_master as sm on smk.subject_code=sm.subject_code;

/*
Problem # 7:  
Write a query to display all the students whose name starts with “M”.
*/

select student_info from student_info
where student_name like 'm%';

/*
Problem # 8: 
Write a query which retrieves the student name, registration number and their respective marks in all semesters whose has an email address.
*/
select si.student_name,si.reg_number,m.marks,m.semester from student_info as si
join student_marks as m on si.reg_number=m.reg_number
where si.email_id is not null;

/*Problem # 9:
Write a query which retrieves student name, registration number and student marks whose mark is between 60 and 100.
*/

select si.student_name,si.reg_number,m.marks from student_info as si
join student_marks as m on si.reg_number=m.reg_number
where marks between 60 and 100;

/*
Problem # 10:
Write a query which retrieves student name, registration number and student marks whose name does not start with Character “J”.
*/

select si.student_name,si.reg.number,m.marks from student_info as si
join student_marks as m on si.reg_number=m.reg_number
where si.student_name not like'j%';

/*
Problem # 11:
Write a query which retrieves student name, registration number and marks of those subjects whose subject code is either EE01DCF or EC02MUP. 
Rule: Do not use OR operator
*/
select si.student_name,si.reg_number,m.marks from student_info as si
join student_marks as m on si.reg_number=m.reg_number
where m.subject_code in ('EE01DCF','EC02MUP');

/*
Problem # 12:
Write a query which retrieves all the students whose name ends with “on”.
*/
select student_name from student_info where student_name like '%on';

