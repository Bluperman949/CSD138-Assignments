use my_guitar_shop;

# 1
SELECT category_name, product_name, list_price
FROM categories
JOIN products
ORDER BY category_name, product_name ASC;

# 2
# not sure what the last instruction, 'look at the columns...' means.
SELECT product_name, list_price, item_price, discount_amount
FROM products
INNER JOIN order_items ON products.product_id = order_items.product_id
WHERE product_name LIKE 'Washburn%';

# 3
SELECT product_name, list_price, item_price, discount_amount
FROM products
JOIN order_items USING (product_id)
WHERE discount_amount > 0;

# 4
SELECT order_date, product_name, category_name, item_price, discount_amount, quantity
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
JOIN categories ON products.category_id = categories.category_id
ORDER BY order_date DESC, product_name DESC, category_name DESC;

# 5
SELECT a1.line1, a1.line2, a1.city, a1.zip_code
FROM addresses AS a1
JOIN addresses AS a2
  ON a1.zip_code = a2.zip_code
  AND a1.address_id <> a2.address_id
ORDER BY line1 ASC;

# 6
SELECT product_name, list_price, item_id
FROM products
LEFT OUTER JOIN order_items USING (product_id)
WHERE item_id IS NULL;

# 7
SELECT 'DISCOUNTED' discount_status, product_name, discount_percent
FROM products
WHERE discount_percent > 0

UNION

SELECT 'FULL PRICE' discount_status, product_name, discount_percent
FROM products
WHERE discount_percent = 0

ORDER BY product_name;