
/*Problem # 1:
Write a query to display the member id, member name of the members, 
book code and book title of the books taken by them.
*/
select m.member_id,m.member_name,bd.book_code,bd.book_title from
lms_members as m
join lms_book_issue as bi on m.member_id = bi.member_id
join lms_book_details as bd on bi.book_code = bd.book_code;

/*Problem # 2:
Write a query to display the total number of books available in the 
library with alias name “NO_OF_BOOKS_AVAILABLE” (Which is not issued). 
Hint: The issued books details are available in the LMS_BOOK_ISSUE 
table.
*/ 
select count(bd.book_code) as NO_OF_BOOKS_AVAILABLE from lms_book_issue as bi
where book_code not in (select book_code from lms_book_issue where date_returned is null );

/*
Problem # 3:
Write a query to display the member id, member name, fine range 
and fine amount of the members whose fine amount is less than 100. 
*/

select m.MEMBER_ID,m.MEMBER_NAME,fd.FINE_RANGE,fd.FINE_AMOUNT from lms_members as m
join lms_book_issue as bi on m.member_id = bi.MEMBER_ID
join lms_fine_details as fd on bi.fine_range = fd.fine_range
where fd.FINE_AMOUNT < 100;

/*
Problem # 4:
Write a query to display the book code, book title, publisher, edition,
price and year of publication and sort based on year of publication, 
publisher and edition.
*/
select BOOK_CODE,BOOK_TITLE,PUBLICATION,BOOK_EDITION,PRICE,year(PUBLISH_DATE)
from lms_book_details
order by year(publish_date),publication,book_edition;

/*
Problem # 5:
Write a query to display the book code, book title and rack number 
of the books which are placed in rack 'A1' and sort by 
book title in ascending order. 
*/

select book_code,book_title,rack_num from lms_book_details
where rack_num='A1'
order by book_title;

/*
Problem # 6:
Write a query to display the member id, member name, due date and 
date returned of the members who has returned the books after the 
due date. Hint: Date_return is due date and Date_returned is actual 
book return date. 
*/

select m.member_id,m.member_name,bi.date_return,bi.date_returned from lms_book_issue as bi
join lms_members as m on bi.member_id = m.member_id
where bi.date_returned > bi.date_return;

/*
Problem # 7:
Write a query to display the member id, member name and date of registration 
who have not taken any book. 

*/

select distinct member_id,member_name,DATE_REGISTER from lms_members
where member_id not in (select member_id from lms_book_issue);

/*
Problem # 8:
Write a Query to display the member id and member name of the members 
who has not paid any fine in the year 2012.
*/

select distinct bi.member_id,m.member_name from lms_members as m
join lms_book_issue as bi on m.member_id = bi.member_id
where year(bi.DATE_RETURN) <= 2012 and bi.date_returned like "2012-%-%" 
and (bi.date_return <= bi.date_returned);

/*
Problem # 9:
Write a query to display the date on which the maximum numbers of books 
were issued and the number of books issued with alias name “NOOFBOOKS”.
*/

select date_issue, count(book_code) as NOOFBOOKS from lms_book_issue
group by DATE_ISSUE
having count(book_code) = (
	select max(book_count) 
	from (
		select count(book_code) as book_count 
		from lms_book_issue
		group by book_code
	) temp
);

/*
Problem # 10:
Write a query to list the book title and supplier id for the books authored 
by “Herbert Schildt" and the book edition is 5 and supplied 
by supplier ‘S01’.
*/
select book_title,supplier_id from lms_book_details 
where author='Herbert Schildt' and book_edition='5' and
supplier_id ='S01';

/* 
Problem # 11:
Write a query to display the rack number and the number of books in 
each rack with alias name “NOOFBOOKS” and sort by rack number in 
ascending order.
*/
select RACK_NUM,count(book_code) as NOOFBOOKS from lms_book_details
group by RACK_NUM
order by RACK_NUM;

/*
Problem # 12:
Write a query to display book issue number, member name, date or registration,
date of expiry, book title, category author, price, date of issue, 
date of return, actual returned date, issue status, fine amount.
*/
select bi.book_issue_no,m.member_name,m.date_register,m.date_expire,bd.book_title,
bd.BOOK_TITLE,bd.author,bd.price,bi.date_issue,bi.date_return,bi.date_returned,fd.fine_amount from lms_book_details as bd
join lms_book_issue as bi on bd.book_code=bi.BOOK_CODE
join lms_members as m on bi.member_id = m.member_id
join lms_fine_details as fd on bi.fine_range = fd.fine_range;

/* 

Problem # 13:
Write a query to display the book code, title, publish date of the books 
which is been published in the month of December. */

select book_code,book_title,publish_date from lms_book_details
where month(publish_date) = '12';

/* 

Problem # 14:
Write a query to display the book code, book title ,supplier name and 
price of the book witch takes maximum price based on each supplier.
*/

select bd.book_code,bd.book_title,sd.supplier_name,sd.supplier_id,price 
from lms_book_details as bd
join lms_suppliers_details as sd on bd.supplier_id = sd.SUPPLIER_ID
join (
	select lbd.supplier_id,max(lbd.price)  as maxprice
	from lms_book_details as lbd
	group by lbd.supplier_id
) as temp on temp.supplier_id=sd.supplier_id and temp.maxprice=bd.price;



select bd.book_code,bd.book_title,sd.supplier_name,sd.supplier_id,price 
from lms_book_details as bd
join lms_suppliers_details as sd on bd.supplier_id = sd.SUPPLIER_ID
group by bd.supplier_id
having price in (
	select lbd.supplier_id,max(lbd.price)  as maxprice
	from lms_book_details as lbd
	group by lbd.supplier_id
) as temp on temp.supplier_id=sd.supplier_id and temp.maxprice=bd.price;



/*
Problem # 15:
Write a query to display book code, book name, and publisher, how old the 
book is. Sorted as older to newer.
*/

select book_code,book_title,publication,TIMESTAMPDIFF(YEAR, publish_date, CURDATE()) from lms_book_details
group by BOOK_CODE
ORDER BY publish_date;
