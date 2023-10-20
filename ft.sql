create table fraudulent(
step int,	
type varchar(20), 
amount float,
nameorig varchar(50), 
oldbalanceorg float,
newbalanceorig float,	
nameDest varchar(50),	
oldbalancedest float,
newbalancedest float,
isfraud int,
isflaggedfraud int
)

copy public.fraudulent
from '/Users/toluwanijacobs/Desktop/Data Science/Case Study/Fraudulent Transactions.csv'
delimiter ',' csv header

select * from fraudulent;

-- How many transactions occurred per transaction type?
select distinct type 
from fraudulent;

select type, count(*) as transaction_count
from fraudulent
group by type
order by count(*) desc;

-- Which Transaction Type has the highest number of Fraudulent Transactions?
select type, count(*) as fraudulent_transaction_count
from fraudulent
where isfraud = 1
group by type
order by fraudulent_transaction_count desc;

select type, count(*) as fraudulent_transaction_count
from fraudulent
where isfraud = 1
group by type
order by fraudulent_transaction_count desc
limit 1;


-- what is the average fraudulent transaction amount?
select * from fraudulent;

select round(avg(amount),3) as average_fraud_amt
from fraudulent
where isfraud = 1;

-- the issue was the data type, you can either remove the number completely
-- :: is used as a converter
-- it was a conversion to numeric which can also be done from properties

SELECT ROUND(AVG(amount::numeric), 2) AS average_fraudulent_amount
FROM fraudulent
WHERE isFraud = 1;

-- What is the Maximum fraudulent transaction amount?
select max(amount) as max_amount
from fraudulent
where isfraud = 1;

-- What is the Minimum fraudulent transaction amount?
select min(amount) as min_fraud_amount
from fraudulent
where isfraud = 1;

-- Who are the Top 10 customers with the highest amount defrauded?
select * from fraudulent;

select namedest, sum(amount) as total_defrauded_amt
from fraudulent
where isfraud = 1
group by namedest
order by total_defrauded_amt desc
limit 10;

-- How effective is the bank in flagging fraud?
-- had no idea chatgpt helped
SELECT
    COUNT(*) AS total_fraudulent_transactions,
    SUM(isFlaggedFraud) AS flagged_fraudulent_transactions,
    ROUND(SUM(isFlaggedFraud) * 100.0 / COUNT(*), 2) AS fraud_flagging_rate
FROM fraudulent
WHERE isFraud = 1;

-- Who are the Top 20 Fraudsters
select * from fraudulent;

select nameorig, sum(amount) as total_defraud_amt
from fraudulent 
where isfraud = 1
group by nameorig
order by total_defraud_amt desc
limit 20;
