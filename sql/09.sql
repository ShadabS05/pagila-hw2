/*
 * Count the number of movies that contain each type of special feature.
 * Order the results alphabetically be the special_feature.
 */
SELECT special_features, COUNT(*)
FROM (
    SELECT unnest(film.special_features) AS special_features
    FROM film
) AS unnested_films
GROUP BY special_features
ORDER BY special_features;
