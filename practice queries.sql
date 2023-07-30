use testing
go
select * from artist
select *from album
select * from customer

/* que1: Who is the senior most employee based on job title */

select top 1*  FROM employee
order by levels desc 

/* que2: Who is the second senior most employee based on job title */

select * from employee 
where levels = (select max(levels) from employee where levels <(select max(levels) from employee))

/* que3: Retrieve all the employees who are from Calgary */

select * from employee
where city = 'Calgary'

/* que4: Join the first and last name column to form single column without replacing the existing columns */

select *, concat(first_name,' ', last_name) as Name
from employee

/* que5: Join the first and last name column to form single column replacing the existing columns */

update employee
set Name = replace(Name, last_name, concat(first_name, ' ', last_name))

 /* que6: Retieve all employees hired in 2017 */

 select * from employee where hire_date like '2017%' 


  /* que7: Which country have the most invoices? */

  select count(*) as Counts,billing_country 
  from invoice
  group by billing_country
  order by Counts  desc
  

   /* que8: Which city has the best customers? We would like to throw a promotional music festival in the city we made the most money
   Write a query that returns one city that has the highest sum of invoice totals. Return both the city name and sum of all invoice totals */

   select sum(total) as invoice_total, billing_city
   from invoice 
   group by billing_city
   order by invoice_total desc


   /* que9: Who is the best customer, the customer who has spent the most money will be declared the best customer.
   Write a query that returns the person who has spent the most money*/

 select SUM(Total) as invoice_total from invoice
 select  customer_id, first_name, last_name
 from customer
 
 join invoice on customer.customer_id = invoice.customer_id
 group by customer.customer_id
 order by total desc

 select * from invoice



  /* que10: What are the top 3 values of total invoice? */

  select top 3* from invoice
  order by total desc

  /* que11: Write a query to return email, first name, last name and genre of all rock music listner.
  Reurn your list alphabetically by email starting with A*/

  select distinct email, first_name, last_name
  from customer
  join invoice on customer.customer_id = invoice.customer_id
  join invoice_line on invoice.invoice_id = invoice_line.invoice_id
  where track_id in(
		select track_id from track
		join genre on track.genre_id = genre.genre_id
		where genre.name like 'rock'
		)
	order by email

	 /* que12: Let's invite the artists who have written the most rock music in our dataset 
	 Write a query that returns the artist name and total track count of the top 10 rock bands*/

	 select artist_id, name, count(artist_id) as no_of_songs from artist