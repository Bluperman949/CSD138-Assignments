USE my_guitar_shop;

# 1
INSERT INTO categories (category_name)
VALUES ('Brass');

# 2
UPDATE categories
SET category_name = 'Tambourines'
WHERE category_id = 3;

# 3
DELETE FROM categories
WHERE category_name = 'Brass';

# 4
INSERT INTO administrators (email_address, password, first_name, last_name)
VALUES ('admin@guitar.com', 'abc1272321abcd823', 'John', 'Admin');

# 5
UPDATE administrators
SET last_name = 'Jordan'
WHERE email_address = 'admin@guitar.com';

# 6
INSERT INTO orders (customer_id, order_date, ship_amount, tax_amount, ship_date, ship_address_id, card_type, card_number, card_expires, billing_address_id)
VALUES (2, '2020-05-05 11:11:11', 5, 10, '2020-05-06', 1, 'Visa', '4111111111111111', '04/2022', 2);

# 7
# I had to look this up, not sure if @@identity is the right way to do this
UPDATE orders
SET card_number = '1234567890', card_type = 'MasterCard'
WHERE order_id = @@identity;

# 8
UPDATE orders
SET ship_amount = 15
WHERE order_date > '2015-03-30 15:22:31';

/* REFLECTION
The main focus of this assignment was the basic syntax of INSERT, UPDATE and DELETE
statements. The problems obviously build on the WHERE syntax we learned while writing
SELECT statements in the previous assignments.alter

As for "what this assignment covered", that's the same as the "main learning points". I don't
know what I'm supposed to say. And for what I learned, nothing. This is all review for me.

For the Midterm Group Project, I don't see how the subject of this assignment *couldn't* be
relevant. Modification of tables is a basic part of using SQL, so we obviously need to make use
of these features on the Project: inserting fake data, deleting data during tests, etc.
*/