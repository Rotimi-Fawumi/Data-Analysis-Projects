 USE hicounselor;
 
 SELECT * FROM nodes;
 SELECT * FROM transaction;
 SELECT * FROM regions;
 
 
 # TASK 1 List all regions along with all users assigned to each region

SELECT nodes.consumer_id,regions.region_name 
FROM nodes
JOIN regions 
ON nodes.region_id=regions.region_id;


# TASK 2 Find the user who made the largest deposit amount and the transaction type for that deposit

SELECT consumer_id, transaction_type, transaction_amount 
FROM transaction
ORDER BY  transaction_amount DESC LIMIT 1;

select max(transaction_amount) from transaction;
    
    
 # TASK 3 Calculate the total amount deposited for each user in the "Europe" region

SELECT 
	nodes.consumer_id,nodes.region_id,regions.region_name,
    SUM(transaction.transaction_amount) AS Total_amount,
    transaction.transaction_type 
FROM regions 
RIGHT JOIN nodes ON regions.region_id=nodes.region_id 
INNER JOIN transaction 
ON transaction.consumer_id=nodes.consumer_id
WHERE transaction_type='deposit' AND region_name='Europe'
GROUP BY consumer_id;

SELECT r.region_name,n.consumer_id,t.transaction_type,sum(t.transaction_amount) as Total_amount from regions as r 
right join nodes as n using (region_id)
join transaction as t using (consumer_id) 
group by consumer_id
having r.region_name = 'Europe' and t.transaction_type = 'deposit';

SELECT r.region_name, n.consumer_id, t.transaction_type, SUM(t.transaction_amount) as Total_amount
FROM nodes AS n
LEFT JOIN regions AS r ON n.region_id = r.region_id
JOIN transaction AS t ON n.consumer_id = t.consumer_id
WHERE r.region_name = 'Europe' AND t.transaction_type = 'deposit'
GROUP BY n.consumer_id;

set sql_safe_updates = 0;
delete from transaction where transaction_date = 'transaction_date';


# TASK 4 Calculate the total number of transaction made by user in the "United States" region
  
SELECT nodes.consumer_id, regions.region_name,  count(transaction.transaction_type) AS number_transaction
FROM transaction
JOIN  nodes 
ON transaction.consumer_id=nodes.consumer_id 
LEFT JOIN regions 
ON  regions.region_id=nodes.region_id 
group by consumer_id
Having region_name='United States';

  
# TASK 5 Calculate the total Number of users who made more than 5 transactions

SELECT consumer_id,count(consumer_id) AS transaction_count 
FROM transaction
GROUP BY consumer_id
HAVING count(consumer_id) >5;
  
  
  
# TASK 6 Region with the highest number of nodes assigned to them
  
SELECT DISTINCT nodes.node_id,nodes.region_id,regions.region_name 
FROM nodes
LEFT JOIN regions 
ON nodes.region_id=regions.region_id
ORDER BY node_id DESC LIMIT 10;

SELECT n.region_id,r.region_name,count(n.node_id) as Total_Nodes
from nodes as n 
left join regions as r using(region_id)
group by region_name
order by Total_Nodes DESC LIMIT 1;
  
  
# TASK 7 Find the user who made the highest deposit amount in the Australia region
  
SELECT  nodes.consumer_id,regions.region_name ,transaction.transaction_type,sum(transaction.transaction_amount) AS highest_deposit_amount
FROM transaction 
JOIN nodes 
ON transaction.consumer_id=nodes.consumer_id
LEFT JOIN regions
ON nodes.region_id=regions.region_id
GROUP BY consumer_id
HAVING region_name='Australia' AND transaction_type='deposit'
ORDER BY highest_deposit_amount DESC LIMIT 1;
  

# TASK 8 Calculate the total amount deposited by each user in each region 

SELECT
	regions.region_name, transaction.transaction_type, 
    sum(transaction.transaction_amount) AS Total_amount_deposited 
FROM transaction
JOIN nodes 
ON transaction.consumer_id=nodes.consumer_id
LEFT JOIN regions on nodes.region_id=regions.region_id
GROUP BY region_name
HAVING transaction_type = 'deposit'
ORDER BY Total_amount_deposited;
    

# TASK 9 Retrieve the total number of transaction for each region

SELECT regions.region_name, count(transaction.transaction_type) AS Total_transaction 
FROM transaction
INNER JOIN nodes 
ON transaction.consumer_id=nodes.consumer_id
LEFT JOIN regions on nodes.region_id=regions.region_id
GROUP BY region_name;


# TASK 10 Find the total deposit amount for each region (region_name) in the user_transaction
table. #Consider only those transactions where the consumer_id is associated with a valid region in the
#user_nodes table.

 
SELECT regions.region_name,
    sum(transaction.transaction_amount) AS total_amount,
    transaction.transaction_type 
FROM nodes 
INNER JOIN transaction 
ON nodes.consumer_id=transaction.consumer_id 
LEFT JOIN regions 
ON nodes.region_id=regions.region_id
GROUP BY region_name
HAVING transaction_type='deposit';
   

/*TASK 11 Find the top 5 consumers who have made the highest total transaction amount (sum of all their deposit transactions) 
in the user_transaction table.*/
 
SELECT
	consumer_id, transaction_type, 
    sum(transaction_amount) AS total_transaction_amount 
FROM transaction
GROUP BY consumer_id
HAVING transaction_type='deposit'
ORDER BY total_transaction_amount DESC LIMIT 5;
 
# TASK 12 How many consumers are allocated to each region?

SELECT 
	regions.region_name,
	count(nodes.consumer_id) AS Number_of_consumer 
FROM nodes 
LEFT JOIN regions 
ON regions.region_id=nodes.region_id
GROUP BY region_name;

# TASK 13 What is the unique count and total amount for each transaction type?

SELECT transaction_type,sum(transaction_amount) AS total_transaction 
FROM transaction
GROUP BY transaction_type;

/* TASK 14 What are the average deposit counts and amounts for each transaction type ('deposit') 
across all customers, grouped by transaction type?*/

SELECT 
	transaction_type,avg(transaction_amount) AS total_transaction_amount, 
    count(transaction_type) AS number_transaction_type
FROM transaction
WHERE transaction_type='deposit' 
GROUP BY transaction_type;

# OR

SELECT 
	transaction_type,avg(transaction_amount) AS total_transaction_amount, 
    count(transaction_type) AS number_transaction_type
FROM transaction
GROUP BY transaction_type
HAVING transaction_type='deposit';

# TASK 15 How many transactions were made by consumers from each region?
  
SELECT 
regions.region_name,count(transaction.consumer_id) as Total_Consumers
FROM transaction 
INNER JOIN nodes 
ON transaction.consumer_id=nodes.consumer_id
LEFT JOIN regions 
ON regions.region_id=nodes.region_id
Group by region_name;

  
 
 
 SELECT * FROM nodes;
 SELECT * FROM transaction;
 SELECT * FROM regions;