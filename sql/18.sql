/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
SELECT 
    sql.rank, 
    sql.title,
    sql.revenue,
    sql."total revenue", 
    TO_CHAR(
        100 * sql."total revenue" / grand_total.total_revenue, 
        'FM900.00'
    ) AS "percent revenue"
FROM (
    SELECT
        RANK() OVER (ORDER BY COALESCE(SUM(payment.amount), 0.00) DESC) AS rank,
        film.title,
        COALESCE(SUM(payment.amount), 0.00) AS revenue,
        SUM(COALESCE(SUM(payment.amount), 0.00)) OVER (ORDER BY COALESCE(SUM(payment.amount), 0.00) DESC) AS "total revenue"
    FROM
        film
    LEFT JOIN inventory USING (film_id)
    LEFT JOIN rental USING (inventory_id)
    LEFT JOIN payment USING (rental_id)
    GROUP BY
        film.title
    ORDER BY
        revenue DESC, film.title
) AS sql
CROSS JOIN (
    SELECT SUM(COALESCE(payment.amount, 0.00)) AS total_revenue
    FROM payment
) AS grand_total
GROUP BY 
    sql.rank, sql.title, sql.revenue, sql."total revenue", grand_total.total_revenue 
ORDER BY
    sql.rank, sql.title;
