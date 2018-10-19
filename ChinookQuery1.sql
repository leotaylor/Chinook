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


-- line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.

SELECT 
	I.InvoiceLineId,
	T.Name
FROM InvoiceLine I
Join Track T
on I.TrackId = T.TrackId

-- line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.

Select 
	TrackName = Track.Name,
	Artist = Artist.Name,
	I.InvoiceLineId
From Track
Join Album
on Track.AlbumId = Album.AlbumId
Join Artist
on Artist.ArtistId = Album.ArtistId
Join InvoiceLine I 
on I.TrackId = Track.TrackId

-- country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY

SELECT
	BillingCountry,
	NumberPerCountry = Count(*)
FROM Invoice
Group BY BillingCountry

-- playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. 
-- The Playlist name should be include on the resulant table.

SELECT 
	PlaylistName = P.Name,
	NumberOfTracks = COUNT(PT.TrackId)
FROM PlaylistTrack PT
JOIN Playlist P
ON P.PlaylistId = PT.PlaylistId
GROUP BY P.Name

-- tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. 
-- The result should include the Album name, Media type and Genre.

SELECT
	TrackName = T.Name, 
	Album = A.Title,
	MediaType = M.Name,
	Genre = G.Name
FROM Track T
JOIN Album A
ON T.AlbumId = A.AlbumId
JOIN Genre G
ON T.GenreId = G.GenreId
JOIN MediaType M
ON T.MediaTypeId = M.MediaTypeId

-- invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT 
	Invoice = I.InvoiceId,
	LinesItems = Count(IL.InvoiceLineId)
FROM InvoiceLine IL
Join Invoice I
ON i.InvoiceId = il.InvoiceId
GROUP BY I.InvoiceId

-- sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent

SELECT 
	Employee = E.FirstName + ' ' + E.LastName,
	Total = SUM(I.Total)
FROM Employee E
JOIN Customer C
ON E.EmployeeId = C.SupportRepId
JOIN Invoice I
ON I.CustomerId = C.CustomerId
GROUP BY E.FirstName + ' ' + E.LastName

-- top_2009_agent.sql: Which sales agent made the most in sales in 2009?

SELECT TOP 1 
	Employee,
	Total = MAX(TotalsFor2009.Totals)
FROM (
	SELECT
		Employee = E.FirstName + ' ' + E.LastName,
		Totals = SUM(Total)
	FROM Invoice I
	JOIN Customer C
	ON C.CustomerId = I.CustomerId
	JOIN Employee E
	ON E.EmployeeId = C.SupportRepId
	WHERE YEAR(I.InvoiceDate) = '2009'
	GROUP BY E.FirstName + ' ' + E.LastName
	) as TotalsFor2009
GROUP BY Employee
ORDER BY Total DESC

-- top_agent.sql: Which sales agent made the most in sales over all?

SELECT TOP 1
	Employee = E.FirstName + ' ' + E.LastName,
	Total = SUM(I.Total)
FROM Employee E
JOIN Customer C
ON E.EmployeeId = C.SupportRepId
JOIN Invoice I
ON I.CustomerId = C.CustomerId
GROUP BY E.FirstName + ' ' + E.LastName
Order BY Total DESC

-- sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.

SELECT
	Employee = E.FirstName + ' ' + E.LastName,
	NumOfCustomer = Count(C.SupportRepId)
FROM Customer C
JOIN Employee E
ON C.SupportRepId = E.EmployeeId
GROUP BY E.FirstName + ' ' + E.LastName

-- sales_per_country.sql: Provide a query that shows the total sales per country.

SELECT
	BillingCountry,
	TotaSales = SUM(Total)
FROM Invoice
GROUP BY BillingCountry
ORDER BY SUM(Total) DESC

-- top_country.sql: Which country's customers spent the most?

SELECT TOP 1
	BillingCountry,
	TotaSales = SUM(Total)
FROM Invoice
GROUP BY BillingCountry
ORDER BY SUM(Total) DESC

-- top_2013_track.sql: Provide a query that shows the most purchased track of 2013.

SELECT TOP 15
	TopTrack = T.Name,
	NumberPurchased = SUM(IL.Quantity)
FROM InvoiceLine IL
JOIN Track T
ON IL.TrackId = T.TrackId
JOIN Invoice I 
ON I.InvoiceId = IL.InvoiceId
WHERE YEAR(I.InvoiceDate) = '2013'
GROUP BY T.Name
ORDER BY NumberPurchased DESC

-- top_5_tracks.sql: Provide a query that shows the top 5 most purchased songs.

SELECT TOP 5
	TopTrack = T.Name,
	NumberPurchased = SUM(IL.Quantity)
FROM InvoiceLine IL
JOIN Track T
ON IL.TrackId = T.TrackId
JOIN Invoice I 
ON I.InvoiceId = IL.InvoiceId
GROUP BY T.Name
ORDER BY NumberPurchased DESC

-- top_3_artists.sql: Provide a query that shows the top 3 best selling artists.


SELECT TOP 3
	Artist = AR.Name,
	NumberPurchased = SUM(IL.Quantity)
FROM InvoiceLine IL
JOIN Track T
ON IL.TrackId = T.TrackId
JOIN Invoice I 
ON I.InvoiceId = IL.InvoiceId
JOIN Album Al
ON Al.AlbumId = T.AlbumId
JOIN Artist AR
ON AR.ArtistId = AL.ArtistId
GROUP BY AR.Name
ORDER BY NumberPurchased DESC
