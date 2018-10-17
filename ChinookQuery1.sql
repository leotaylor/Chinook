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

-- sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.

SELECT 
	FullName = FirstName + ' ' + LastName
FROM Employee
Where Title = 'Sales Support Agent'


-- unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.

SELECT DISTINCT BillingCountry
FROM Invoice

-- sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. 
-- The resultant table should include the Sales Agent's full name.

SELECT 
	Agent = E.FirstName + ' ' + E.LastName,
	InvoiceId
FROM Employee E
Join Customer C
On E.EmployeeId = C.SupportRepId
Join Invoice I 
On I.CustomerId = C.CustomerId
WHERE E.Title = 'Sales Support Agent'

-- invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT 
 InvoiceTotal = I.Total,
 CustomerName = C.FirstName + ' ' + C.LastName,
 C.Country,
 Agent = E.FirstName + ' ' + E.LastName
FROM Customer C
Join Employee E
on C.SupportRepId = E.EmployeeId
Join Invoice I 
on I.CustomerId = C.CustomerId