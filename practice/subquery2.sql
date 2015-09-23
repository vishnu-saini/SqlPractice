/*Exercise 1

Problem Statement:
Write a query to pick up the maximum marks from students marks table and display the student 
registration number and name of those students who have secured the maximum marks.
Deliverables Expected:
Student registration number and Student names displayed as per the condition applicable.
*/
select distinct reg_number,student_name 
from student_info 
where reg_number in(
	select reg_number 
	from student_marks 
	where marks in( 
		select max(marks) 
		from student_marks
	)
);

/*
Exercise 2

	
Problem Statement:
Write a query to pick up the maximum marks secured in the subject “EI05IP” and display the 
student name and registration number of the student who has secured it. 

Deliverables Expected:
Student registration number and Student names displayed as per the condition applicable.
*/
select reg_number,student_name 
from student_info 
where reg_number in(
	select reg_number 
	from student_marks 
	where marks in(
		select max(marks) 
		from student_marks 
		where subject_code='EI05IP'
	) and subject_code = 'EI05IP'
);


/* 
Exercise 3
	
Problem Statement:
Write a query to display the student name and registration number of the student
 who has secured second highest marks in the subject El05lP subject.

Deliverables Expected:
Student registration number and Student names displayed as per the condition applicable.
*/
select reg_number,student_name 
from student_info 
where reg_number in(
	select c.reg_number
	from student_marks c
	where marks =(
		select max(b.marks)
		from student_marks b 
		where marks not in(
			select max(a.marks) 
			from student_marks as a 
			where a.subject_code='EI05IP'
		) and b.subject_code = 'EI05IP'
	) and subject_code='EI05IP'
);


/*
Exercise 4
Problem Statement:
Write a query to display registration numbers of those students who scored more than the average score 
scored by students in the subject El05lP.

Deliverables Expected:
Student registration number displayed as per the condition applicable.
*/

select reg_number 
from student_marks c 
where marks in(
	select b.marks 
	from student_marks b
	where marks> (
		select avg(a.marks) 
		from student_marks a 
		where a.subject_code='EI05IP'
	) and b.subject_code='EI05IP'
) and c.subject_code='EI05IP';


