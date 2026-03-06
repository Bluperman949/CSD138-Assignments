use my_guitar_shop;

# 1
SELECT COUNT(*) AS product_count, AVG(list_price) AS average_price
FROM products;

# 2
SELECT 
    category_name,
    COUNT(product_id) AS product_count,
    MIN(list_price) AS cheapest_price
FROM categories
JOIN products USING (category_id)
GROUP BY category_name
ORDER BY product_count DESC;

# 3
SELECT 
    category_name,
    COUNT(DISTINCT product_id) AS product_count,
    SUM(item_price * quantity) AS item_price_total,
    SUM(discount_amount * quantity) AS total_discount
FROM categories
JOIN products USING (category_id)
JOIN order_items USING (product_id)
GROUP BY category_name
ORDER BY item_price_total DESC;

# 4
# I don't know if HAVING is the right way to do this. I couldn't get WHERE to work.
# UPDATE: I'm on problem #6 now. Yes, we *are* supposed to use HAVING.
SELECT
	first_name,
    COUNT(order_id) AS order_count,
    MAX(item_price) AS highest_priced_item
FROM orders
JOIN order_items USING (order_id)
JOIN customers USING (customer_id)
GROUP BY first_name
HAVING order_count > 1
ORDER BY highest_priced_item DESC;

# 5
# Not sure what I was supposed to do here. Just a WHERE clause?
SELECT
	first_name,
    COUNT(order_id) AS order_count,
    MAX(item_price) AS highest_priced_item
FROM orders
JOIN order_items USING (order_id)
JOIN customers USING (customer_id)
WHERE item_price > 300
GROUP BY first_name
HAVING order_count > 1
ORDER BY highest_priced_item DESC;

# 6
SELECT
	email_address,
    COUNT(order_id) AS order_count,
    SUM(ship_amount) AS total_ship_amount
FROM orders
JOIN customers USING (customer_id)
GROUP BY email_address WITH ROLLUP
HAVING total_ship_amount > 5;

# 7
SELECT
	product_name,
    COUNT(item_id) AS order_item_count,
    COUNT(DISTINCT customer_id) AS distinct_customer_count
FROM order_items
JOIN orders USING (order_id)
JOIN products USING (product_id)
GROUP BY product_name
HAVING distinct_customer_count > 1;