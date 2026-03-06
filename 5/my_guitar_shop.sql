use my_guitar_shop;

# 1
SELECT DISTINCT product_name
FROM products
WHERE product_id IN (SELECT DISTINCT product_id FROM order_items)
ORDER BY product_name;

# 2
SELECT item_id, discount_amount
FROM order_items
WHERE discount_amount < (SELECT AVG(discount_amount) FROM order_items)
ORDER BY discount_amount DESC;

# 3
SELECT product_id, product_name
FROM products
WHERE NOT EXISTS (
	-- I was gonna `SELECT product_id`, but turns out it doesn't matter what get selected here
	SELECT 1
    FROM order_items
    WHERE products.product_id = order_items.product_id
);

# 4
# I feel like there's a simpler way to do this. Do we really need 2 queries?
SELECT order_id, card_type
FROM orders
WHERE card_type IN (
    SELECT card_type
    FROM orders
    GROUP BY card_type
    HAVING COUNT(*) = 1
)
ORDER BY card_type ASC;

# Not sure if I am supposed to use JOIN here, so I did it two ways:

# 5, no JOIN
SELECT
	product_name,
	(	SELECT category_name
        FROM categories
        WHERE products.category_id = categories.category_id
	) AS category_name,
    list_price
FROM products
WHERE list_price = (
	SELECT MIN(list_price) AS smallest_list_price
    FROM products AS p2
    WHERE products.category_id = p2.category_id
);

# 5, with JOIN
SELECT product_name, category_name, list_price
FROM products
JOIN categories USING (category_id)
WHERE list_price = (
	SELECT MIN(list_price) AS smallest_list_price
    FROM products AS p2
    WHERE products.category_id = p2.category_id
);

# 6
SELECT
	(	SELECT AVG(list_price)
        FROM products
        WHERE products.category_id = categories.category_id
	) AS average_list_price,
    category_name
FROM categories;