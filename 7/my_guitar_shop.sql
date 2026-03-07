USE my_guitar_shop;

# 1
CREATE VIEW problem_one_view AS
SELECT
	last_name, first_name, order_date, product_name,
	(item_price - discount_amount) AS price
FROM customers
JOIN orders USING (customer_id)
JOIN order_items USING (order_id)
JOIN products USING (product_id);

SELECT * FROM problem_one_view;

# 2
UPDATE problem_one_view
SET last_name = 'Doolittle'
WHERE first_name = 'Allan';
# This works because the specified column in this view maps perfectly
# back to a table - `last_name` is not DISTINCT, calculated AS, etc.

# 3
UPDATE problem_one_view
SET price = 123
WHERE first_name = 'Allan';
# This doesn't work because `price` is calculated AS. The column is generated upon
# querying this view, not permanently stored anywhere, so there's nothing to update.

# 4
CREATE VIEW problem_four_view AS
SELECT
	customer_id, email_address,
    (	SELECT SUM(ship_amount)
		FROM orders
        WHERE orders.customer_id = customers.customer_id
    )	AS total_ship_amount
FROM customers;

SELECT * FROM problem_four_view;

# 5
UPDATE problem_four_view
SET email_address = 'abc@gmail.com'
WHERE customer_id = 1;
# This does not work because the view contains a subquery.

# 6
CREATE VIEW problem_six_view AS
SELECT *
FROM products
WHERE discount_percent > 10
WITH CHECK OPTION;

UPDATE problem_six_view
SET discount_percent = 13.33
WHERE product_id = 1;
# This works because `13.33`, when checked by `CHECK OPTION`, passes the
# test defined in the WHERE clause: `WHERE discount_percent > 10`.

UPDATE problem_six_view
SET discount_percent = 8.99
WHERE product_id = 1;
# This does not work because `8.99` doesn't pass the test.

/* REFLECTION
I think the main learning points of this assignment are 1) the creation of views and 2) the
rules regarding UPDATE statements on views.

The only thing I learned from this assignment was the existence of `WITH CHECK OPTION`.
I think all of its use cases for the Final Group Project can be covered by constraints on the
tables themselves, but it's a good feature to keep in mind.
*/