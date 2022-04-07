USE sakila;

-- 1 How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT COUNT(F.film_id) AS film_count, C.name
FROM sakila.film_category F, sakila.category C
WHERE F.category_id = C.category_id
GROUP BY C.category_id 
ORDER BY C.category_id;

-- 2 Display the total amount rung up by each staff member in August of 2005.
SELECT S.staff_id, SUM(P.amount) AS total_rental_amount, P.payment_date 
FROM sakila.payment P, sakila.staff S
WHERE P.staff_id = S.staff_id
	AND (P.payment_date BETWEEN '2005-08-01' AND '2005-08-31') AND P.payment_date IS NOT NULL 
GROUP BY S.staff_id
ORDER BY S.staff_id;

-- 3 Which actor has appeared in the most films?
SELECT a.actor_id, a.first_name, a.last_name, COUNT(af.film_id) AS movie_count
FROM sakila.actor a, sakila.film_actor af
WHERE a.actor_id = af.actor_id
GROUP BY actor_id
ORDER BY movie_count DESC
LIMIT 1;
    
-- 4 Most active customer (the customer that has rented the most number of films)
SELECT c.customer_id, COUNT(DISTINCT rental_id) AS rental_count ## We interpreted that the most active customer is the one who rented the most times, independently of the movie's title.
FROM sakila.customer c
JOIN sakila.payment p
	USING(customer_id)
GROUP BY customer_id
ORDER BY rental_count DESC
LIMIT 1;
 
-- 5 Display the first and last names, as well as the address, of each staff member.

SELECT s.first_name, s.last_name, a.address
FROM sakila.staff s
JOIN sakila.address a
	ON a.address_id = s.address_id;

-- 6 List each film and the number of actors who are listed for that film.
SELECT f.title, COUNT(fa.actor_id) AS actor_count
FROM sakila.film f
JOIN sakila.film_actor fa
	USING (film_id)
GROUP BY title
ORDER BY actor_count DESC;

-- 7 Using the tables payment and customer and the JOIN command,
# list the total paid by each customer. 
#List the customers alphabetically by last name.
SELECT DISTINCT c.last_name, SUM(p.amount) AS total_paid_amount
FROM sakila.payment p, sakila.customer c
WHERE p.customer_id = c.customer_id
GROUP BY c.customer_id;

-- 8 List number of films per category.
SELECT COUNT( F.film_id) AS film_count, C.name # Same as exercise 1.
FROM sakila.film_category F, sakila.category C
WHERE F.category_id = C.category_id
GROUP BY C.category_id 
ORDER BY C.category_id;