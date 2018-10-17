-- non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) 
-- who are not in the US.

SELECT 
	FullName = FirstName + ' ' + LastName,
	CustomerId,
	Country
from Customer
WHERE Country != 'USA'

-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.

Select * 
 from Customer
 WHERE Country = 'Brazil';