use lms;
/*
Problem # 1:
Write a query to display the member id, member name, city and membership status who are all having life time 
membership. Hint: Life time membership status is “Permanent”.
*/
select member_id,member_name,city,membership_status from lms_members
where membership_status='Permanent';

/*
Problem # 2:
Write a query to display the book code, publication, price and supplier name of the book witch is taken frequently.

*/
SELECT BD.BOOK_CODE,BD.PUBLICATION,BD.PRICE,SD.SUPPLIER_NAME FROM lms_book_details BD
JOIN LMS_BOOK_ISSUE BI ON BI.BOOK_CODE=BD.BOOK_CODE
JOIN LMS_SUPPLIERS_DETAILS SD ON SD.SUPPLIER_ID=BD.SUPPLIER_ID
GROUP BY  BD.BOOK_CODE HAVING COUNT(BD.BOOK_CODE)=(SELECT MAX(BOOK_COUNT) FROM 
(SELECT COUNT(BOOK_CODE) AS BOOK_COUNT FROM LMS_BOOK_ISSUE GROUP BY BOOK_CODE)TEMP);

/*
Problem # 3:
Write a query to display the member id, member name who have taken the book with book code 'BL000002'. 
*/
select m.MEMBER_ID,m.MEMBER_NAME from lms_members m
join lms_book_issue bi on bi.member_id=m.member_id
where bi.book_code='BL000002';

/*
Problem # 4:
Write a query to display the book code, book title and author of the books whose author name begins with 'P'.
*/
select BOOK_CODE,BOOK_TITLE,AUTHOR from lms_book_details
where AUTHOR like 'P%';

/*
Problem # 5:
Write a query to display the total number of Java books available in library with alias name ‘NO_OF_BOOKS’. 
*/
select count(book_code) as NO_OF_BOOKS from lms_book_details where CATEGORY='Java';

/*
Problem # 6:
Write a query to list the category and number of books in each category with alias name ‘NO_OF_BOOKS’.
*/

SELECT CATEGORY,COUNT(BOOK_CODE) AS NO_OF_BOOKS FROM lms_book_details
GROUP BY CATEGORY;

/*
Problem # 7:
Write a query to display the number of books published by "Prentice Hall” with the alias name “NO_OF_BOOKS”.
*/
SELECT COUNT(BOOK_CODE) AS NO_OF_BOOKS FROM lms_book_details
WHERE PUBLICATION='PRENTICE HALL';

/*
Problem # 8:
Write a query to display the book code, book title of the books which are issued on the date "1st April 2012".
*/
SELECT BD.BOOK_CODE,BD.BOOK_TITLE FROM lms_book_details BD
JOIN lms_book_issue BI ON BI.BOOK_CODE=BD.BOOK_CODE
WHERE BI.DATE_ISSUE LIKE '2012-04-01%';

/*
Problem # 9:
Write a query to display the member id, member name, date of registration and expiry date of the members whose
 membership expiry date is before APR 2013.
*/
SELECT MEMBER_ID,MEMBER_NAME,DATE_REGISTER,DATE_EXPIRE FROM LMS_MEMBERS
WHERE DATE_EXPIRE< '2013-04-01';

/*
Problem # 10:
write a query to display the member id, member name, date of registration, membership status of 
the members who registered before  "March 2012" and membership status is "Temporary" 
*/
SELECT MEMBER_ID,MEMBER_NAME,DATE_REGISTER,MEMBERSHIP_STATUS FROM lms_members
WHERE DATE_REGISTER<'2012-03-%' AND MEMBERSHIP_STATUS='TEMPORARY';

/*
Problem #11:
Write a query to display the member id, member name who’s City is CHENNAI or DELHI. Hint: Display the member 
name in title case with alias name 'Name'. 
*/

SELECT MEMBER_ID,MEMBER_NAME FROM LMS_MEMBERS
WHERE CITY='CHENNAI' OR CITY='DELHI'; 

/*
Problem #12:
Write a query to concatenate book title, author and display in the following format.
Book_Title_is_written_by_Author
Example:  Let Us C_is_written_by_Yashavant Kanetkar
Hint: display unique books. Use “BOOK_WRITTEN_BY” as alias name. 
*/
SELECT distinct CONCAT(BOOK_TITLE,'_IS WRITTEN BY_',AUTHOR) AS BOOK_WRITTEN_BY FROM lms_book_details;

/*
Problem #13:
Write a query to display the average price of books which is belonging to ‘JAVA’ category with alias 
name “AVERAGEPRICE”.
*/

SELECT AVG(PRICE) AS AVERAGEPRICE FROM lms_book_details
WHERE CATEGORY='JAVA';

/*
Problem #14:
Write a query to display the supplier id, supplier name and email of the suppliers who are all having gmail
 account.
*/
SELECT SUPPLIER_ID,SUPPLIER_NAME,EMAIL FROM lms_suppliers_details
WHERE EMAIL LIKE '%GMAIL.COM';

/*
Problem#15:
Write a query to display the supplier id, supplier name and contact details. Contact details can be either 
phone number or email or address with alias name “CONTACTDETAILS”. If phone number is null then display email,
 even if email also null then display the address of the supplier. Hint: Use Coalesce function. 
*/
select SUPPLIER_ID,SUPPLIER_NAME,coalesce(contact,EMAIL,ADDRESS) as CONTACTDETAILS from lms_suppliers_details;

/*
Problem#16:
Write a query to display the supplier id, supplier name and contact.  If phone number is null then display 
‘No’ else display ‘Yes’ with alias name “PHONENUMAVAILABLE”. Hint: Use ISNULL.
*/
SELECT SUPPLIER_ID,SUPPLIER_NAME,IF(CONTACT is not null,'YES','NO') AS PHONENUMAVAILABLE 
FROM lms_suppliers_details;

/*
Problem#17:
Write a query to display the member id, member name, city and member status of members with 
the total fine paid by them with alias name “Fine”.
*/
SELECT M.MEMBER_ID,M.MEMBER_NAME,M.CITY,M.MEMBERSHIP_STATUS,SUM(FD.FINE_AMOUNT) AS Fine
FROM lms_members M
JOIN lms_book_issue BI ON BI.MEMBER_ID=M.MEMBER_ID
JOIN lms_fine_details FD ON FD.FINE_RANGE=FD.FINE_RANGE
GROUP BY M.MEMBER_ID;