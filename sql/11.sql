/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */
SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS "Actor Name"
FROM film
JOIN film_actor USING (film_id)
JOIN actor USING (actor_id)
WHERE film_id IN (
    SELECT film_id
    FROM film
    WHERE 'Behind the Scenes' = ANY(special_features)
)
GROUP BY actor.first_name, actor.last_name
ORDER BY "Actor Name";

