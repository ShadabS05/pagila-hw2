/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT film.title
FROM film
JOIN inventory USING (film_id)
LEFT JOIN (
    SELECT DISTINCT film_id, country
    FROM inventory
    JOIN rental USING (inventory_id)
    JOIN customer USING (customer_id)
    JOIN address USING (address_id)
    JOIN city USING (city_id)
    JOIN country USING (country_id)
    WHERE country.country = 'United States'
) AS DANNY USING (film_id)
WHERE DANNY.country IS NULL
GROUP BY film.title
ORDER BY film.title;

