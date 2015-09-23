show databases;
use lms_db;
/*
Complex Questions:
Problem # 1:
Write a query to display the book code, book title and supplier name of the supplier who has supplied maximum number of books. For example, 
if “ABC Store” supplied 3 books, “LM Store” has supplied 2 books and “XYZ Store” has supplied 1 book. So “ABC Store” has supplied maximum number 
of books, hence display the details as mentioned below. 
Example:
BOOK_CODE	BOOK_TITLE	SUPPLIER_NAME
BL000008	Easy Reference for Java   	ABC STORE
BL000001	Easy Reference for C     	ABC STORE
BL000003	Easy Reference for VB    	ABC STORE
*/

SELECT lbd.book_code, lbd.book_title, lsd.supplier_name
FROM lms_book_details AS lbd
JOIN lms_suppliers_details AS lsd ON lsd.supplier_id = lbd.supplier_id
WHERE lbd.supplier_id in ( 
	SELECT supplier_id  
	FROM (
		SELECT supplier_id,COUNT( book_code ) AS book_count
		FROM lms_book_details
		GROUP BY supplier_id 
	) AS temp 
    where temp.book_count = (
		SELECT max( temp1.book_count ) 
		FROM (

		SELECT COUNT( book_code ) AS book_count
		FROM lms_book_details
		GROUP BY supplier_id 
		
		) AS temp1
    
    )
);


/*
Problem # 2:
Write a query to display the member id, member name and number of remaining books he/she can take with “REMAININGBOOKS” as alias name.
 Hint:  Assuming a member can take maximum 3 books.  For example, Ramesh has already taken 2 books; he can take only one book now. 
 Hence display the remaining books as 1 in below format. 
Example: 
MEMBER_ID             MEMBER_NAME           REMAININGBOOKS
LM001                        RAMESH	                    1
LM002                        MOHAN	                    3
*/

select lm.member_id,member_name,(3-count(book_issue_no)) as "REMAININGBOOKS"
from lms_members as lm
join lms_book_issue as lbi on lbi.member_id = lm.member_id 
where date_returned is null
group by lbi.member_id
union
select member_id,member_name,3 as "REMAININGBOOKS"
from lms_members
where member_id not in (
 select member_id from lms_book_issue where date_returned is null
);

/*
Problem # 3 
Write a query to display the supplier id and supplier name of the supplier who has supplied minimum number of books. For example,
 if “ABC Store” supplied 3 books, “LM Store” has supplied 2 books and “XYZ Store” has supplied 1 book.
 So “XYZ Store” has supplied minimum number of books, hence display the details as mentioned below. 
Example:
SUPPLIER_ID	SUPPLIER_NAME
S04	               XYZ STORE
*/

select supplier_id,supplier_name 
from lms_suppliers_details
where supplier_id in (

	SELECT supplier_id  
	FROM (

	SELECT supplier_id,COUNT( book_code ) AS book_count
	FROM lms_book_details
	GROUP BY supplier_id 
	
	) AS temp 
    where temp.book_count = (
		SELECT min( temp1.book_count ) 
		FROM (

		SELECT COUNT( book_code ) AS book_count
		FROM lms_book_details
		GROUP BY supplier_id 
		
		) AS temp1
    
    )
);
	
