-- HOMEWORK 5
-- Marzieh Alidadi


--Q13
with costomer_orders(customerID, order_count) as 
	(select sales.customer.customerID, count(salesOrderID)  
     from sales.customer left outer join sales.salesorderheader using(customerID)
	 group by sales.customer.customerID)
select order_count, count(*) as costomer_count 
from costomer_orders 
group by order_count 
order by costomer_count DESC, order_count DESC;