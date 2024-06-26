CREATE TABLE finance1 (
    id int,loan_amnt int, funded_amnt int, term varchar(50), int_rate int, installment int,
    grade varchar(50), sub_grade varchar(50), home_onwnership varchar(100),annual_inc int,
    verification_status varchar(100), issue_d date,loan_status varchar(100), addr_state varchar(100), dti int);
    
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/finance1sql.csv" into table finance1 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 lines;

create table finance2 (
id int, open_acc int, revol_bal int, revol_unit numeric(5,2),total_acc int, total_pymnt int, recoveries int, 
collection_recovery_fee int, last_pymnt_d date, last_pymnt_amnt int);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/finance2sql.csv" into table finance2 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 lines;

use project;

alter table finance2 add column year int;
update finance2 set year= extract(year from last_pymnt_d);

alter table finance1 add column month int;
update finance1 set month= extract(month from issue_d);
#kpi1
select finance2.year, SUM(finance1.loan_amnt) as total_loan_amnt
from finance1
left join finance2 on finance2.id = finance1.id
group by finance2.year
order by finance2.year;

#kpi2
select f1.grade,f1.sub_grade,sum(f2.revol_bal) as revol_bal from finance1 f1 left join finance2 f2
on f1.id=f2.id group by grade,sub_grade
order by grade,sub_grade;
set sql_mode=" ";

#kpi3
Select f1.verification_status,sum(f2.total_pymnt) from finance1 f1 left outer join finance2 f2
on f1.id=f2.id group by f1.verification_status;

#kpi4
Select addr_state,month,loan_status from finance1  order by addr_state,month;

#kpi5
select f1.id,f1.home_onwnership,f2.last_pymnt_d from Finance1 f1 left outer join finance2 f2
on f1.id=f2.id


CREATE TABLE finance1 (
    id int,loan_amnt int, funded_amnt int, term varchar(50), int_rate int, installment int,
    grade varchar(50), sub_grade varchar(50), home_onwnership varchar(100),annual_inc int,
    verification_status varchar(100), issue_d date,loan_status varchar(100), addr_state varchar(100), dti int);
    
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/finance1sql.csv" into table finance1 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 lines;

create table finance2 (
id int, open_acc int, revol_bal int, revol_unit numeric(5,2),total_acc int, total_pymnt int, recoveries int, 
collection_recovery_fee int, last_pymnt_d date, last_pymnt_amnt int);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/finance2sql.csv" into table finance2 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 lines;