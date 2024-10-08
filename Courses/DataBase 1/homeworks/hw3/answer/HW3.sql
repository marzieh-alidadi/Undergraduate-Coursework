-- HOMEWORK 3
-- YOUR NAME: Marzieh Alidadi
-- YOUR STUDENT NUMBER: 9631983


---- Q1

create view q1 as
select product.name as ProductName, ProductNumber, productCategory.name as ProductCategory, 
	   productSubcategory.name as ProductSubCategory, TransactionID, ReferenceOrderID,
	   ReferenceOrderLineID, TransactionDate, TransactionType, Quantity, ActualCost 
from production.product as product inner join production.transactionHistory as transactionHistory
	 on (product.productID = transactionHistory.productID)
	 inner join production.productSubcategory as productSubcategory
	 on (product.productSubcategoryID = productSubcategory.productSubcategoryID)
	 inner join production.productCategory as productCategory
	 on productSubcategory.productCategoryID = productCategory.productCategoryID
where product.name like '%Bike%'

---- Q2

---- Q3

select P.productID, salesOrderID
from production.product as P left outer join sales.salesOrderDetail as S
	 on p.productID = S.productID

---- Q4

select P.productID, salesOrderID
from production.product as P left outer join sales.salesOrderDetail as S
	 on p.productID = S.productID
where salesOrderID is null

---- Q5

select S.salespersonid, P.salesYTD , S.salesOrderID
from sales.salesPerson as P right outer join sales.SalesOrderHeader as S
	 on P.BusinessEntityID = S.salespersonid

---- Q6

select S.salespersonid, P.salesYTD , S.salesOrderID , R.firstName
from sales.salesPerson as P right outer join sales.SalesOrderHeader as S
	 on P.BusinessEntityID = S.salespersonid
	 left outer join HumanResources.Employee as E
	 on (P.BusinessEntityID = E.BusinessEntityID)
	 left outer join person.person as R
	 on (E.BusinessEntityID = R.BusinessEntityID)

---- Q7

select T1.salesOrderID, T2.CurrencyRateID, T2.AverageRate, T4.ShipBase
from (sales.salesOrderHeader as T1 left outer join sales.CurrencyRate as T2
	  on (T1.currencyRateID = T2.currencyRateID))
	  full outer join
	  (sales.salesOrderHeader as T3 left outer join purchasing.ShipMethod T4
	  on (T3.shipMethodID = T4.shipMethodID))
	  on T1.salesOrderID = T3.salesOrderID

---- Q8

select T4.BusinessEntityID, T1.productID
from production.product as T1 full outer join sales.salesOrderDetail T2
	 on T1.productID = T2.productID
   	 full outer join sales.salesOrderHeader as T3
 	 on (T2.salesOrderID = T3.salesOrderID)
	 full outer join sales.salesPerson as T4
	 on (T3.salesPersonID = T4.BusinessEntityID)

---- Q9

select T5.firstName, T1.name
from production.product as T1 inner join sales.salesOrderDetail as T2
	 on (T1.productID = T2.productID)
	 inner join sales.salesOrderHeader as T3
	 on (T2.salesOrderId = T3.salesOrderId)
	 inner join sales.customer T4
	 on (T3.customerID = T4.customerID)
	 inner join person.person T5
	 on (T4.personID = T5.BusinessEntityID)

---- Q10

SELECT nspname as schemaName, relname as relationName, reltuples as recordsNubmer
FROM pg_class as C
LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
WHERE nspname NOT IN ('pg_catalog', 'information_schema') AND relkind='r' 
ORDER BY reltuples DESC;

---- Q11

select indexname, indexdef
from pg_indexes
where tablename = 'salesOrderDetail'

---- Q12

---- query12:
select * 
from sales.salesOrderDetail
where unitprice = 153.149

---- plan12:
explain select * 
from sales.salesOrderDetail
where unitprice = 153.149

---- Q13

---- query13:
select * 
from sales.salesOrderDetail
where unitprice < 153.149

---- plan13:
explain select * 
from sales.salesOrderDetail
where unitprice < 153.149

---- Q14

---- query14:
select * 
from sales.salesOrderDetail
where unitprice > 153.149

---- plan14:
explain select * 
from sales.salesOrderDetail
where unitprice > 153.149

---- ***INDEX generated for unitprice** :

create index index_salesOrderDetail_unitPrice
on sales.salesOrderDetail (unitPrice)

---- Q15

---- query15:
select * 
from sales.salesOrderDetail
where unitprice = 153.149

---- plan15:
explain select * 
from sales.salesOrderDetail
where unitprice = 153.149

---- Q16

---- query16:
select * 
from sales.salesOrderDetail
where unitprice < 153.149

---- plan16:
explain select * 
from sales.salesOrderDetail
where unitprice < 153.149

---- Q17

---- query17:
select * 
from sales.salesOrderDetail
where unitprice > 153.149

---- plan17:
explain select * 
from sales.salesOrderDetail
where unitprice > 153.149
