/*	Question Set 1*/

/* Q1: Who is the senior most employee based on job title? */

SELECT Top 1 title, last_name, first_name 
FROM [dbo].[music-employee]
ORDER BY levels DESC

/* Q2: Which countries have the most Invoices? */

SELECT COUNT(*) AS c, billing_country 
FROM [dbo].[music-invoice]
GROUP BY billing_country
ORDER BY c DESC

/* Q3: What are top 3 values of total invoice? */

SELECT Top 3 total 
FROM [dbo].[music-invoice]
ORDER BY total DESC

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

SELECT Top 1 billing_city,SUM(total) AS InvoiceTotal
FROM [dbo].[music-invoice]
GROUP BY billing_city
ORDER BY InvoiceTotal DESC

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

SELECT Top 1 [dbo].[music-customer].customer_id, [dbo].[music-customer].first_name, [dbo].[music-customer].last_name, SUM(total) AS total_spending
FROM [dbo].[music-customer]
JOIN [dbo].[music-invoice] ON [dbo].[music-customer].customer_id = [dbo].[music-invoice].customer_id
GROUP BY [dbo].[music-customer].customer_id, [dbo].[music-customer].first_name, [dbo].[music-customer].last_name
ORDER BY total_spending DESC

/* Question Set 2 */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT email,first_name, last_name
FROM [dbo].[music-customer]
JOIN [dbo].[music-invoice] ON [dbo].[music-customer].customer_id = [dbo].[music-invoice].customer_id
JOIN [dbo].[music-invoice_line] ON [dbo].[music-invoice].invoice_id = [dbo].[music-invoice_line].invoice_id
WHERE track_id IN(
	SELECT track_id FROM [dbo].[music-track]
	JOIN [dbo].[music-genre] ON [dbo].[music-track].genre_id = [dbo].[music-genre].genre_id
	WHERE[dbo].[music-genre].genre_name LIKE 'Rock'
)
ORDER BY email;

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT TOP 10 [dbo].[music-artist].artist_id, [dbo].[music-artist].artist_name, COUNT([dbo].[music-artist].artist_id) AS number_of_songs
FROM [dbo].[music-track]
JOIN [dbo].[music-album] ON [dbo].[music-album].album_id = [dbo].[music-track].album_id
JOIN [dbo].[music-artist] ON [dbo].[music-artist].artist_id = [dbo].[music-album].artist_id
JOIN [dbo].[music-genre] ON [dbo].[music-genre].genre_id = [dbo].[music-track].genre_id
WHERE [dbo].[music-genre].genre_name LIKE 'Rock'
GROUP BY [dbo].[music-artist].artist_id, [dbo].[music-artist].artist_name
ORDER BY number_of_songs DESC;

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT track_name,milliseconds
FROM [dbo].[music-track]
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM [dbo].[music-track])
ORDER BY milliseconds DESC;

/* Question Set 3*/

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

WITH best_selling_artist AS (
	SELECT TOP 1 [dbo].[music-artist].artist_id, [dbo].[music-artist].artist_name, SUM([dbo].[music-invoice_line].unit_price * [dbo].[music-invoice_line].quantity) AS total_sales
	FROM [dbo].[music-invoice_line]
	JOIN [dbo].[music-track] ON [dbo].[music-track].track_id = [dbo].[music-invoice_line].track_id
	JOIN [dbo].[music-album] ON [dbo].[music-album].album_id = [dbo].[music-track].album_id
	JOIN [dbo].[music-artist] ON [dbo].[music-artist].artist_id = [dbo].[music-album].artist_id
	GROUP BY [dbo].[music-artist].artist_id, [dbo].[music-artist].artist_name
	ORDER BY total_sales DESC
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price * il.quantity) AS amount_spent
FROM [dbo].[music-invoice] i
JOIN [dbo].[music-customer] c ON c.customer_id = i.customer_id
JOIN [dbo].[music-invoice_line] il ON il.invoice_id = i.invoice_id
JOIN [dbo].[music-track] t ON t.track_id = il.track_id
JOIN [dbo].[music-album] alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, bsa.artist_name
ORDER BY amount_spent DESC;

/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */

WITH popular_genre AS 
(
    SELECT 
        COUNT([dbo].[music-invoice_line].quantity) AS purchases, 
        [dbo].[music-customer].country, 
        [dbo].[music-genre].genre_name AS genre_name, 
        [dbo].[music-genre].genre_id, 
        ROW_NUMBER() OVER(PARTITION BY [dbo].[music-customer].country ORDER BY COUNT([dbo].[music-invoice_line].quantity) DESC) AS RowNo 
    FROM [dbo].[music-invoice_line] 
    JOIN [dbo].[music-invoice] ON [dbo].[music-invoice].invoice_id = [dbo].[music-invoice_line].invoice_id
    JOIN [dbo].[music-customer] ON [dbo].[music-customer].customer_id = [dbo].[music-invoice].customer_id
    JOIN [dbo].[music-track] ON [dbo].[music-track].track_id = [dbo].[music-invoice_line].track_id
    JOIN [dbo].[music-genre] ON [dbo].[music-genre].genre_id = [dbo].[music-track].genre_id
    GROUP BY [dbo].[music-customer].country, [dbo].[music-genre].genre_name, [dbo].[music-genre].genre_id
)
SELECT * 
FROM popular_genre 
WHERE RowNo <= 1
ORDER BY country ASC, purchases DESC;

/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

WITH Customer_with_country AS (
    SELECT 
        [dbo].[music-customer].customer_id,
        first_name,
        last_name,
        billing_country,
        SUM(total) AS total_spending,
        ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
    FROM [dbo].[music-invoice]
    JOIN [dbo].[music-customer] ON [dbo].[music-customer].customer_id = [dbo].[music-invoice].customer_id
    GROUP BY [dbo].[music-customer].customer_id, first_name, last_name, billing_country
)
SELECT * 
FROM Customer_with_country 
WHERE RowNo <= 1
ORDER BY billing_country ASC, total_spending DESC;
