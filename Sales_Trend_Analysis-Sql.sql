CREATE DATABASE DA_ASSESSMENT;
use da_assessment;

SELECT * from item;
SELECT * from invoice;

#Q1: Join the two tables together

select * from invoice join item on invoice.name =item.parent;

#Q2 Top 5 customers according to their respective net_amount

SELECT parent, net_amount from item
ORDER BY parent DESC LIMIT 5;

# Q3 Top 10 item groups according to quantities 
 
 SELECT item_group, quantity from item
ORDER BY quantity DESC LIMIT 10;

/* Q4 Number of customers in the table; 
assuming the customer column in the sales_invoice table 
represents the unique customer code given to each customer*/
 
 select count(customer) from invoice;
 
 SELECT * from item;
SELECT * from invoice;
 # Q5 Group the item_groups to an item_class of uniform and non uniform
 
select distinct item_group from item;
 
 #Q5a. Uniform_Item
 
 CREATE VIEW Uniform_Item_Class AS SELECT item_group FROM item
 WHERE item_group IN
 ('UNIFORM PINAFORE/DRESS',
'UNIFORM BLOUSE',
'UNIFORM SHORTS',
'UNIFORM SHIRT',
'UNIFORM CARDIGAN',
'UNIFORM SKIRT',
'UNIFORM POLO',
'UNIFORM TROUSER',
'UNIFORM BADGE',
'UNIFORM BLAZER',
'UNIFORM ELECTIVE',
'UNIFORM SKORT',
'CUSTOMIZED UNIFORM')
Group by item_group;

 CREATE VIEW Uniform_Item_Class_All AS SELECT * FROM item
 WHERE item_group IN
 ('UNIFORM PINAFORE/DRESS',
'UNIFORM BLOUSE',
'UNIFORM SHORTS',
'UNIFORM SHIRT',
'UNIFORM CARDIGAN',
'UNIFORM SKIRT',
'UNIFORM POLO',
'UNIFORM TROUSER',
'UNIFORM BADGE',
'UNIFORM BLAZER',
'UNIFORM ELECTIVE',
'UNIFORM SKORT',
'CUSTOMIZED UNIFORM')
Group by item_group;

# Q5b. Non_Uniform_Item

CREATE VIEW Non_Uniform_Item_View AS SELECT item_group FROM item
WHERE item_group in 
(# item_group
'FANCY DRESS',
'STATIONERY',
'BOARDING HOUSE ITEM',
'LIFESTYLE',
'BOOKS',
'EDUCATIONAL AIDS',
'FOOD AND CONSUMABLES',
'DRESS ACCESSORIES',
'LUNCH PACK',
'GIFT & TOYS',
'FOOT WEAR',
'SPORTSGEAR',
'BAG',
'OFFICE SUPPLIES',
'BALLET GEAR',
'PARTY SUPPLIES',
'ARTS & CRAFTS',
'MUSICAL INSTRUMENT',
'HYGIENE SUPPLIES',
'RAINWEAR',
'SPORTSWEAR',
'MONOGRAMMING',
'NON FOOD ITEM',
'Fashion Shirts')
GROUP BY item_group;

CREATE VIEW Non_Uniform_Item_View_All AS SELECT * FROM item
WHERE item_group in 
(# item_group
'FANCY DRESS',
'STATIONERY',
'BOARDING HOUSE ITEM',
'LIFESTYLE',
'BOOKS',
'EDUCATIONAL AIDS',
'FOOD AND CONSUMABLES',
'DRESS ACCESSORIES',
'LUNCH PACK',
'GIFT & TOYS',
'FOOT WEAR',
'SPORTSGEAR',
'BAG',
'OFFICE SUPPLIES',
'BALLET GEAR',
'PARTY SUPPLIES',
'ARTS & CRAFTS',
'MUSICAL INSTRUMENT',
'HYGIENE SUPPLIES',
'RAINWEAR',
'SPORTSWEAR',
'MONOGRAMMING',
'NON FOOD ITEM',
'Fashion Shirts')
GROUP BY item_group;

 
