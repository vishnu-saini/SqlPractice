/*
Problem # 1:  
Write a query which displays the student name, registration number and their GPA in descending order of GPA.
*/
select si.student_name,sr.reg_number,sr.gpa
from student_info si,student_result sr
where si.reg_number=sr.reg_number
order by sr.gpa desc ;  
/*
Problem # 2:  
Write a query which displays the student information in ascending order of the student’s name.
*/
select * from student_info
order by student_name; 
/*
Problem # 3:  
Write a query which displays the information of students in ascending order of their age.
*/
select * from student_info
order by date_of_birth desc;
/*
Problem # 4:  
Write a query to display the registration number, student name, semester number and GPA of students such 
that students with high GPA are displayed on top.
*/
select si.reg_number,si.student_name,sr.semester,sr.gpa
from student_info si 
join student_result sr on si.reg_number=sr.reg_number
order by gpa desc ; 
/*
Problem # 5:  
Write a query to display the registration number and GPA of each student in such a way that the 
students who are eligible for scholarship are displayed first.
*/
select reg_number,gpa 
from student_result
order by is_eligible_scholarship desc ; 
/*
Problem # 6:  
Write a query to display the registration number and GPA of each student in such a way that the students who are eligible for scholarship are displayed first.
*/



/*
Problem # 7:  
Write a query to display the details of students who have secured maximum GPA in each semester. Hint: Use GROUPBY
*/
select * 
from student_info si
join (

	select b.reg_number,b.semester from student_result b
	join ( 
			select semester,max(gpa) as maxgpa from student_result
			group by semester

		) a on a.maxgpa=b.gpa and a.semester = b.semester

) c on c.reg_number = si.reg_number ;
/*
Problem # 8: 
Write a query to display the details of students who have secured mimimum GPA in each semester. Hint: Use GROUPBY
*/
select * 
from student_info si
join (

	select b.reg_number,b.semester from student_result b
	join ( 
			select semester,min(gpa) as mingpa from student_result
			group by semester

		) a on a.mingpa=b.gpa and a.semester = b.semester

) c on c.reg_number = si.reg_number ;