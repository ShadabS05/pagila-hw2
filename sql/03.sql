/*
 * Management wants to send coupons to customers who have previously rented one of the top-5 most profitable movies.
 * Your task is to list these customers.
 *
 * HINT:
 * In problem 16 of pagila-hw1, you ordered the films by most profitable.
 * Modify this query so that it returns only the film_id of the top 5 most profitable films.
 * This will be your subquery.
 * 
 * Next, join the film, inventory, rental, and customer tables.
 * Use a where clause to restrict results to the subquery.
 */
SELECT customer.customer_id
FROM film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN customer using (customer_id)
WHERE film_id IN (
	SELECT film.film_id
	FROM payment
	JOIN rental ON payment.rental_id = rental.rental_id
	JOIN inventory ON rental.inventory_id = inventory.inventory_id
	JOIN film ON inventory.film_id = film.film_id
	GROUP BY film.film_id ORDER BY sum(payment.amount) DESC
	LIMIT 5
)
GROUP BY customer.customer_id;
