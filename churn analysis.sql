create DATABASE churnanalysis;
use churnanalysis;
CREATE TABLE churnnn (
    customerID TEXT,
    gender TEXT,
    SeniorCitizen INT,
    Partner TEXT,
    Dependents TEXT,
    tenure INT,
    PhoneService TEXT,
    MultipleLines TEXT,
    InternetService TEXT,
    OnlineSecurity TEXT,
    OnlineBackup TEXT,
    DeviceProtection TEXT,
    TechSupport TEXT,
    StreamingTV TEXT,
    StreamingMovies TEXT,
    Contract TEXT,
    PaperlessBilling TEXT,
    PaymentMethod TEXT,
    MonthlyCharges FLOAT,
    TotalCharges TEXT,
    Churn TEXT
);

SHOW VARIABLES LIKE 'secure_file_priv';

show tables;

describe churnnn;

select *from churnnn limit 10;

select count(*) from churnnn;

select distinct Churn from churnnn;

set sql_safe_updates=0; -- this is for turning of safety in sql

update churnnn -- we updated all of the churn cases to 1 or 0 
set Churn = case
 when Churn= 'Yes' then 1 
 when Churn='No' then  0 
end;

select TotalCharges-- this is because the data had some blank spaces 
from churnnn
WHERE TotalCharges = '' or TotalCharges=" " ;

update churnnn -- we kept the blank spaces null
set TotalCharges=NULL
where TotalCharges=" " or TotalCharges='';

alter table churnnn -- we updates that particular colum to null because the datatype was text before 
modify TotalCharges float;

select Churn , count(*)
from churnnn
group by Churn;

-- overall churn rate
select avg(Churn)*100 as churn_rate from churnnn;

-- churn by contract
select Contract , avg(Churn)*100 as churn_rate 
from churnnn
group by Contract;

-- churn by payment method
select PaymentMethod, avg(Churn)*100 as churn_rate
from churnnn
group by PaymentMethod;

-- high risk segment
select Contract, PaymentMethod, avg(Churn)*100 as churn_rate
from churnnn
group by Contract,PaymentMethod
order by churn_rate desc;

-- churn vs tenure
select Tenure , avg(Churn)*100 as churn_rate
from churnnn
group by Tenure;

-- revenue at risk 
select sum(MonthlyCharges)
from churnnn
where Churn=1;






