select * from account_info;
select * from bank_info;
select * from customer_personal_info;
select * from customer_reference_info;

select a.Customer_ID, a.account_type, a.account_no, b.bank_name from account_info a
join bank_info b on(a.ifsc_code = b.ifsc_code);

select Customer_ID, account_type, account_no from account_info a
join bank_info b on(a.ifsc_code = b.ifsc_code) where b.bank_name = 'HDFC' 
and registration_date between '2012-01-12' and '2012-04-04';

select a.Customer_ID, c.Customer_Name, a.account_no, a.account_type, b.bank_name from account_info a
join bank_info b on(a.ifsc_code = b.ifsc_code)
join customer_personal_info c on(a.customer_id = c.customer_id);

select Customer_ID, Customer_Name, gender, marital_status, concat(customer_name,'_',gender,'_',marital_status)
UNIQUE_REF_STRING from customer_personal_info;

select account_no, customer_id, registration_date, initial_deposit from account_info
where initial_deposit between 15000 and 25000;

select Customer_ID, Customer_Name, date_of_birth, guardian_name from customer_personal_info
where guardian_name like 'j%';

select Customer_ID, account_no, concat(substr(customer_id,3,5),substr(account_no,14,16)) passcode
from account_info;

select Customer_ID, Customer_Name, date_of_birth, marital_status, gender, guardian_name,
contact_no, mail_id from customer_personal_info where gender = 'm' and marital_status = 'married';

select c.customer_id, c.Customer_Name, c.guardian_name, r.reference_acc_name from customer_personal_info c
join customer_reference_info r on(c.customer_id = r.customer_id)
where relation = 'friend';

select customer_id, account_no, concat('$',round(interest)) INTEREST_AMT from account_info
group by interest;

select i.Customer_ID, i.Customer_Name, a.account_no, a.account_type, a.activation_date, b.bank_name
from customer_personal_info i join account_info a on(i.customer_id = a.customer_id)
join bank_info b on(a.ifsc_code = b.ifsc_code)
where a.activation_date = '2012-04-10';

select a.account_no, a.customer_id, c.customer_name, b.bank_name, b.branch_name, b.ifsc_code, 
c.citizenship, a.interest, a.initial_deposit from account_info a
join bank_info b on(a.ifsc_code = b.ifsc_code)
join customer_personal_info c on(a.customer_id = c.customer_id);

select a.customer_id, a.customer_name, a.date_of_birth, a.guardian_name, a.contact_no, a.mail_id,
b.reference_acc_name from customer_personal_info a join customer_reference_info b
on(a.customer_id = b.customer_id) where a.identification_doc_type = 'passport';

select b.customer_id, a.customer_name, b.account_no, b.account_type, b.initial_deposit, b.interest 
from customer_personal_info a join account_info b on(a.customer_id = b.customer_id)
where b.initial_deposit = (select max(initial_deposit) from account_info);

select b.customer_id, a.customer_name, b.account_no, b.account_type, b.interest,c.bank_name,b.initial_deposit
from account_info b join customer_personal_info a on(a.customer_id = b.customer_id)
join bank_info c on(b.ifsc_code = c.ifsc_code)
where b.interest = (select max(interest) from account_info);

select a.Customer_ID, a.customer_name, b.account_no, c.bank_name, a.contact_no, a.mail_id from customer_personal_info a
join account_info b on(a.customer_id = b.customer_id)
join bank_info c on(b.ifsc_code = c.ifsc_code)
where a.address like '%bangalore';

select b.customer_id, a.bank_name, a.branch_name, a.ifsc_code, b.registration_date, b.activation_date 
from bank_info a join account_info b on(a.ifsc_code = b.ifsc_code)
where b.activation_date like '%-03-%';

select a.customer_id, a.customer_name, b.account_no, b.account_type, b.interest, b.initial_deposit,
((b.interest/100)*b.initial_deposit) interest_amt from customer_personal_info a join account_info b on(a.customer_id = b.customer_id)

select a.customer_id, a.customer_name, a.date_of_birth, a.guardian_name, a.contact_no, a.mail_id, b.reference_acc_name
from customer_personal_info a join customer_reference_info b on(a.customer_id = b.customer_id)
where reference_acc_name = 'raghul';

select Customer_ID, Customer_Name, concat('+91-',substr(contact_no,1,3),'-',substr(contact_no,4,3),'-',substr(contact_no,7,4)) CONTACT_ISD from customer_personal_info;

select a.ACCOUNT_NO, a.ACCOUNT_TYPE, a.CUSTOMER_ID, b.CUSTOMER_NAME, b.DATE_OF_BIRTH, b.GUARDIAN_NAME,
b.CONTACT_NO, b.MAIL_ID, b.GENDER, c.REFERENCE_ACC_NAME, c.REFERENCE_ACC_NO, a.REGISTRATION_DATE, a.ACTIVATION_DATE,
d.BANK_NAME, d.BRANCH_NAME, a.INITIAL_DEPOSIT, (a.ACTIVATION_DATE-a.REGISTRATION_DATE) NoOfDaysForActivation from account_info a 
join customer_personal_info b on(a.customer_id = b.customer_id)
join bank_info d on(a.ifsc_code = d.ifsc_code)
join customer_reference_info c on(b.customer_id = c.customer_id);

select a.CUSTOMER_ID, a.CUSTOMER_NAME, a.GUARDIAN_NAME, a.IDENTIFICATION_DOC_TYPE, b.REFERENCE_ACC_NAME,
c.ACCOUNT_TYPE, c.IFSC_CODE, d.BANK_NAME, round(c.initial_deposit+((c.interest/100)*c.initial_deposit)) current_balance from customer_personal_info a
join customer_reference_info b on(b.customer_id = a.customer_id)
join account_info c on(a.customer_id = c.customer_id)
join bank_info d on(c.ifsc_code = d.ifsc_code);

select a.CUSTOMER_ID, b.CUSTOMER_NAME, a.ACCOUNT_NO, a.ACCOUNT_TYPE, a.INTEREST, CASE WHEN INITIAL_DEPOSIT = 20000 then 'high' 
WHEN INITIAL_DEPOSIT = 16000 then 'moderate' WHEN INITIAL_DEPOSIT = 10000 THEN 'average'
when INITIAL_DEPOSIT = 5000 then 'low' when initial_deposit = 0 then 'very low'
 END as Deposit_Status from account_info a
join customer_personal_info b on(a.customer_id = b.customer_id);

select a.CUSTOMER_ID, b.CUSTOMER_NAME, a.ACCOUNT_NO, a.ACCOUNT_TYPE, c.BANK_NAME, c.IFSC_CODE,
a.INITIAL_DEPOSIT, if(ACCOUNT_TYPE = 'savings', round(a.interest+(a.interest*(a.interest/100)),2), a.interest) as NEW_INTEREST
 from account_info a join customer_personal_info b on(a.customer_id = b.customer_id)
join bank_info c on(a.ifsc_code = c.ifsc_code) 
where CUSTOMER_NAME like 'j%';

select a.CUSTOMER_ID, b.customer_name, a.account_no, a.INITIAL_DEPOSIT,
case
when a.INITIAL_DEPOSIT = 0 then '0%'
when a.INITIAL_DEPOSIT <= 10000 then '3%'
when a.INITIAL_DEPOSIT > 10000 && a.INITIAL_DEPOSIT <= 20000 then '5%'
when a.INITIAL_DEPOSIT > 20000 && a.INITIAL_DEPOSIT <= 30000 then '7%'
when a.INITIAL_DEPOSIT > 30000 then '10%'
END as taxPercentage from account_info a
join customer_personal_info b on(a.customer_id = b.customer_id);

