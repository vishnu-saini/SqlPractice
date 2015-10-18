select custid,fname,dob from customer order by year(dob),fname;
select custid,concat(fname,' ',ifnull(mname,ltname)) as cust_name from customer;
select a.acnumber,c.custid,c.fname,c.ltname,a.aod from customer c join account a on c.custid=a.custid;
select count(custid) cust_count from customer where city='delhi';
select c.custid,c.fname,a.acnumber from customer c join account a on c.custid=a.custid where day(aod)>15;
select c.fname,c.city,a.acnumber from customer c join account a on a.custid=c.custid
where c.occupation not in('Business','Service','Student');
select bcity,count(bid) from branch  group by bcity;
select a.acnumber,c.fname,c.ltname from account a join customer c on c.custid=a.custid where a.astatus='active';
select c.custid,c.fname,c.ltname,l.bid from customer c join loan l on c.custid=l.custid;
select c.custid,c.fname,a.acnumber from customer c join account a on c.custid=a.custid where a.astatus='terminated';

select transaction_type,count(t.transaction_type) as Trans_Count from trandetails t join account a on a.acnumber=t.acnumber where t.transaction_type in('Withdrawal','Deposit')
and a.custid='C00001' group by t.transaction_type;

select c.custid,c.fname,c.city,b.bcity from customer c join account a on c.custid=a.custid join branch b on b.bid=a.bid
where c.city!=b.bcity;

select c.custid,c.fname,c.ltname from customer c join loan l on c.custid=l.custid group by l.custid having count(l.bid)>1;  

select count(c.custid) as count from customer c where
c.custid not in (select a.custid from account a) and c.custid in (select l.custid from loan l);

select a.acnumber,a.opening_balance+sum(t.transaction_amount) Deposit_Amount from account a join trandetails t on a.acnumber=t.acnumber
where t.transaction_type='deposit' group by a.custid;

select count(c.custid) count_customer from customer c where c.custid not in (select a.custid from account a);


select b.bcity,b.bname,count(a.acnumber) from account a right join branch b on b.bid=a.bid group by b.bcity,b.bname;

select c.fname from customer c join account a on c.custid=a.custid group by c.custid having count(a.acnumber)>1;

select c.fname from customer c join account a on c.custid=a.custid join branch b on b.bid=a.bid group by c.custid 
having count(a.acnumber)>1 and count(b.bid)>=2;

select c.custid,c.fname,a.acnumber,count(t.tnumber) count_trans from customer c join account a on c.custid=a.custid join trandetails t on
t.acnumber=a.acnumber group by c.custid,t.acnumber;


SELECT acnumber, transaction_amount, MAX(c) 
FROM (SELECT acnumber, transaction_amount, count(acnumber) c FROM trandetails 
GROUP BY acnumber)a;


select acnumber,count(tnumber) from trandetails group by acnumber 
having count(tnumber)>=all(select count(tnumber) from trandetails group by acnumber);


select b.bname,b.bcity,count(a.custid) from branch b join account a on b.bid=a.bid group by a.bid 
having count(a.custid)>=all(select count(a.custid) from account a group by a.bid);


select  (select opening_balance from account where acnumber='A00001') +c.s1-d.s2 from
(select sum(transaction_amount) s1 from trandetails t where t.transaction_type='deposit' and t.acnumber='A00001')c,
(select sum(transaction_amount) s2 from trandetails t where t.transaction_type='withdrawal' and t.acnumber='A00001')d;






select acnumber from accont ,de;

select a.acnumber,st1.cn1 as deposit,st2.cn2 as withd from account a,
(select acnumber,sum(transaction_amount)cn1 from trandetails  where transaction_type='deposit'  group by acnumber)st1
,(select acnumber ,sum(transaction_amount)cn2 from trandetails where transaction_type='withdrawal'  group by acnumber)st2 where st1.acnumber=a.acnumber and 
a.acnumber=st2.acnumber  and cn2 > cn1;


select c.custid,c.fname,c.ltname from customer c join loan l on c.custid=l.custid group by l.custid having sum(loan_amount)>=all
(select sum(loan_amount)from loan l group by l.custid) and count(l.bid)>2;






















