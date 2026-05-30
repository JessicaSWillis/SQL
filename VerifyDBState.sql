SELECT user_id, username, created, password_change_date FROM user_users

SELECT * FROM user_tables

DESC orders
DESC productlist
DESC reviews
DESC storefront
DESC userbase
DESC userlibrary

SELECT * FROM orders
SELECT * FROM productlist
SELECT * FROM reviews
SELECT * FROM storefront
SELECT * FROM userbase
SELECT * FROM userlibrary

SELECT table_name, constraint_name, constraint_type, status 
FROM user_constraints

SELECT view_name, text FROM user_views

SELECT username FROM userbase
ORDER BY username

SELECT firstname, lastname, username, password, email FROM userbase
WHERE email LIKE '%yahoo%'

SELECT username, birthday, walletfunds FROM userbase
WHERE (walletfunds < 25)

SELECT userid, productcode FROM userlibrary
WHERE (hoursplayed > 100)

SELECT productcode FROM userlibrary
WHERE (hoursplayed < 10)

SELECT publisher from productlist

SELECT productname, releasedate, publisher, genre FROM productlist
ORDER BY genre

SELECT productcode, publisher FROM productlist
WHERE genre LIKE 'Strategy'

SELECT productcode, description, price from storefront
WHERE (price > 25)
ORDER BY price DESC

SELECT inventoryid, price FROM storefront
ORDER BY price

SELECT productcode, review FROM reviews
WHERE rating LIKE '1'

SELECT productcode, review FROM reviews
WHERE (rating >= 4)

SELECT userid FROM orders
GROUP BY userid

SELECT * FROM orders
ORDER BY purchasedate
