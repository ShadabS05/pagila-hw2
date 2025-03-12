/*
 * Select the titles of all films that the customer with customer_id=1 has rented more than 1 time.
 *
 * HINT:
 * It's possible to solve this problem both with and without subqueries.
 */
SELECT film.title
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM rental
	JOIN inventory USING (inventory_id)
	JOIN film USING (film_id)
	WHERE customer_id=1
	GROUP BY film_id
	HAVING COUNT(rental_id) > 1
);
