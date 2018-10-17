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

-- total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?

SELECT
	Year2009 = Count(InvoiceId)
FROM Invoice
Where Year(InvoiceDate) = 2009

SELECT
	Year2011 = Count(InvoiceId)
FROM Invoice
Where Year(InvoiceDate) = 2011


-- total_sales_{year}.sql: What are the respective total sales for each of those years?

SELECT 
	Sales2009 = SUM(Total)
FROM Invoice
WHERE YEAR(InvoiceDate) = 2009 

SELECT 
	Sales2011 = SUM(Total)
FROM Invoice
WHERE YEAR(InvoiceDate) = 2011 

-- invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT 
	LineItems = Count(InvoiceLineId)
FROM InvoiceLine
WHERE InvoiceId = 37

-- line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

SELECT 
	LineItems = Count(InvoiceLineId)
FROM InvoiceLine
Group By InvoiceId
