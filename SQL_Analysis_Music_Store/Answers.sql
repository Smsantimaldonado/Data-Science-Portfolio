--------------------------------- Beginner -----------------------------------------
-- 1.	Who is the most senior employee based on job title?
SELECT TOP 1 CONCAT(first_name, ' ', last_name) AS full_name,
		title
FROM Employee
ORDER BY levels DESC;


-- 2.	Which countries have the most Invoices?
SELECT billing_country,
		count(*) AS amount_invoices
FROM Invoice
GROUP BY billing_country
ORDER BY amount_invoices DESC;


-- 3.	What are top 3 values of total invoice?
SELECT TOP 3 total
FROM Invoice
ORDER BY total DESC;


/* 4.	Which city has the best customers? We would like to throw a promotional Music festival in the city that we made most money, 
		we need the city name sum of all invoice totals. */
SELECT TOP 1 billing_city AS City,
		SUM(total) AS Total
FROM Invoice
GROUP BY billing_city
ORDER BY Total DESC;


/* 5.	Who is the one of best customer? The customer who has spent the most money will be declared the best customer.
 		Write a query that returns the person who has spent the most money. */
SELECT TOP 1 c.customer_id AS ID,
		CONCAT(c.first_name, ' ', c.last_name) AS Full_name,
		SUM(i.total) AS Total
FROM Customer AS c
	 JOIN
	 Invoice AS i
	 ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY Total DESC;


-------------------------------- Intermediate --------------------------------------
/* 6.	Write query to return the email, first_name & last_name of all Rock Music listeners.
		Return your list ordered alphabetically by email starting with A. */
SELECT DISTINCT c.email AS Email,
		c.first_name, 
		c.last_name
FROM Customer AS c
	JOIN Invoice AS i
	ON c.customer_id = i.customer_id
	JOIN InvoiceLine AS il
	ON i.invoice_id = il.invoice_id
	JOIN Track AS t
	ON il.track_id = t.track_id
	JOIN Genre AS g
	ON t.genre_id = g.genre_id
WHERE g.genre_name LIKE 'Rock'
ORDER BY Email;


/* 7.	Let's invite the artists who have written the most rock music in our dataset.
		Write a query that returns the artist name and total track count of the top 10 rock bands. */
SELECT TOP 10 r.artist_name,
		COUNT(t.track_id) AS total_track_count
FROM Artist AS r 
	JOIN Album AS l ON r.artist_id = l.artist_id
	JOIN Track AS t ON l.album_id = t.album_id
	JOIN Genre AS g ON t.genre_id = g.genre_id
WHERE g.genre_name LIKE 'Rock'
GROUP BY r.artist_name
ORDER BY total_track_count DESC;


/* 8.	Return all the track names that have a song length longer than the  average song length.
		Return the Name and milliseconds for each track. Order by the song length with the longest songs listed first. */
SELECT track_name,
		milliseconds as song_length
FROM Track
WHERE milliseconds >
	(SELECT AVG(milliseconds)
	FROM Track)
ORDER BY milliseconds DESC;


--------------------------------- Advance ------------------------------------------
-- 9.	Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent.


/* 10.	We want to find out the most popular music Genre for each country.
		We determine the most popular genre as the genre with the highest amount of purchases.
		Write a query that returns each country along with the top Genre.
		For Countries where the maximum number of purchases is shared return all Genres. */


 /* 11.	Write a query that determines the customer that has spent the most on music for each country.
		Write a query that returns the country along with the top customer and how much they spent.
		For countries where the top amount spent is shared, provide all customers who spent this amount. */