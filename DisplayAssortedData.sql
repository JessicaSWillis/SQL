--1
SELECT userid FROM userbase
MINUS
SELECT userid FROM orders;
--2
SELECT 
    u.*,
    CASE 
        WHEN MONTHS_BETWEEN(SYSDATE, birthday) / 12 >= 18 THEN 'Adult'
        ELSE 'Minor'
    END AS age_classification
FROM 
    userbase u;
--3
SELECT 
    p.*,
    CASE 
        WHEN price <= 20.00 THEN 'On Sale'
        ELSE 'Base Price'
    END AS price_status
FROM 
    productlist p;

--4
SELECT productcode FROM wishlist 
WHERE position IN (1, 2)

INTERSECT

SELECT productcode FROM reviews 
WHERE rating >= 3;

--5
SELECT 
    ul.*, 
    wl.*
FROM 
    userlibrary ul
CROSS JOIN 
    wishlist wl;

--6
SELECT 
    TO_CHAR(userid) AS object_id, 
    username AS object_name, 
    'User Record' AS structural_type 
FROM 
    userbase

UNION ALL

SELECT 
    productcode AS object_id, 
    productname AS object_name, 
    'Product Record' AS structural_type 
FROM 
    productlist;

--7
SELECT 
    cr.*,
    CASE 
        WHEN severitypoint >= 10 THEN 'Bannable'
        ELSE 'Appealable'
    END AS policy_status
FROM 
    communityrules cr;
--8
SELECT 
    us.*,
    CASE 
        WHEN UPPER(status) <> 'CLOSED' AND dateupdated <= (SYSDATE - 7) THEN 'High Priority'
        ELSE 'Standard Priority'
    END AS priority_tier
FROM 
    usersupport us;
--9
SELECT 
    us.*, 
    inf.*
FROM 
    usersupport us
CROSS JOIN 
    infractions inf;
--10
SELECT 
    TO_CHAR(userid) AS account_identifier, 
    username AS user_detail, 
    'Account Profile' AS activity_marker 
FROM 
    userbase

UNION ALL

SELECT 
    TO_CHAR(userid) AS account_identifier, 
    penalty AS user_detail, 
    'Safety Infraction Log' AS activity_marker 
FROM 
    infractions;