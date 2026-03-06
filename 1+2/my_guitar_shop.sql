USE my_guitar_shop;

# 1
SELECT *
FROM customers;

# 2
SELECT first_name,email_address
FROM customers;

# 3
# ditto, order is ascending by default

# 4
SELECT first_name,email_address
FROM customers
LIMIT 5;

# 5
# This question is not clear. I assume it means, "do #4 but only for allan?"
# I'm not sure what the point is if we're selecting the two values we already know.
SELECT first_name,email_address
FROM customers
WHERE first_name='Allan' AND email_address='allan.sherwood@yahoo.com';

# 6
SELECT *
FROM order_items
WHERE item_price-discount_amount>1000;

# 7
# only product_name,product_id because * clogs the output with product_description's content
SELECT product_name,product_id
FROM products
WHERE product_name LIKE 'Gibson%' AND product_code='sg';

# 8
# "
SELECT product_name,product_id
FROM products
WHERE product_code IN ('strat', 'sg', 'washburn');

# 9
# "
SELECT product_name,product_id
FROM products
WHERE product_code NOT IN ('strat', 'sg', 'washburn');

# 10
SELECT *
FROM orders
WHERE ship_date IS NULL;

# 11
SELECT CONCAT(product_name, ': ', list_price) AS product_and_price
FROM products;

# 12
SELECT order_id,
	ROUND(ship_amount) AS ship_amount,
	ROUND(tax_amount) AS tax_amount
FROM orders
WHERE ship_amount>5 AND tax_amount<80;

# 13
WITH calcs AS (
	SELECT list_price * (discount_percent / 100) AS discount_amount
	FROM products
)
SELECT product_name, list_price, discount_percent, discount_amount,
	list_price - discount_amount AS discount_price
FROM products, calcs
WHERE list_price>200 AND list_price<800
ORDER BY product_name DESC;

# 14
WITH calcs AS (
    SELECT
		item_price * quantity AS price_total,
		discount_amount * quantity AS discount_total,
		(item_price - discount_amount) * quantity AS item_total
    FROM order_items
)
SELECT item_id, item_price, discount_amount, quantity, item_price, discount_total, item_total
FROM order_items, calcs
WHERE item_total>455
ORDER BY item_total DESC;

# 15
SELECT order_id, order_date,
	round(ship_amount, 1) AS ship_amount,
    ship_date
FROM orders
WHERE ship_date IS NOT NULL
LIMIT 5;

# 16
# This is neat, I didn't realize you could do this
SELECT
	now() AS today_unformatted,
    date_format(now(), '%m/%d/%Y') AS today_formatted;

# 17
# Doing this idiomatically in MySQL is impossible because you can't use aliases in calculations.
# So, redundancy it is. Just write the same number multiple times.
SELECT
	10 AS item_price,
    0.25 AS discount_percent,
	10 * 0.25 AS discount_amount,
    10 * (1 - 0.25) AS discount_percent;
# What's the point? This is a bunch of constants.