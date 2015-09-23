/*Problem # 1:
Write a query to display the book code, book title and supplier name of the supplier who
 has supplied maximum number of books. 
For example, if “ABC Store” supplied 3 books, “LM Store” has supplied 2 books and 
“XYZ Store” has supplied 1 book. So “ABC Store” has supplied maximum number of books,
 hence display the details as mentioned below. 
Example:
BOOK_CODE	BOOK_TITLE	SUPPLIER_NAME
BL000008	Easy Reference for Java   	ABC STORE
BL000001	Easy Reference for C     	               ABC STORE
BL000003	Easy Reference for VB    	ABC STORE
*/

select lbd.BOOK_CODE,lbd.BOOK_TITLE,lsd.SUPPLIER_NAME
from lms_book_details as lbd
join lms_suppliers_details as lsd on lbd.SUPPLIER_ID = lsd.SUPPLIER_ID
group by lbd.SUPPLIER_ID having count(lbd.supplier_id) = (
	select max(TEMP.SUP_COUNT) from (
         SELECT COUNT(SUPPLIER_ID) SUP_COUNT FROM LMS_BOOK_DETAILS GROUP BY SUPPLIER_ID
) as temp 


);

