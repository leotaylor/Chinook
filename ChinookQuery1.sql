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

 -- brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. 
 -- The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT 
	FullName = FirstName + ' ' + LastName,
	InvoiceId,
	InvoiceDate,
	BillingCountry
FROM Invoice I
left join Customer c
on I.CustomerId = C.CustomerId
WHERE BillingCountry = 'Brazil'
