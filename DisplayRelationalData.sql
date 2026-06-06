--1
SELECT 
    u.username, 
    MIN(r.rating) AS lowest_rating
FROM 
    userbase u
JOIN 
    reviews r ON u.userid = r.userid 
GROUP BY 
    u.username;

--2
SELECT 
    u.email, 
    q.question, 
    q.answer
FROM 
    userbase u
JOIN 
    securityquestion q ON u.userid = q.userid;

--3
SELECT 
    u.firstname, 
    u.email, 
    u.walletfunds
FROM 
    userbase u
LEFT JOIN 
    wishlist w ON u.userid = w.userid
WHERE 
    w.userid IS NULL;

--4
SELECT 
    u.username, 
    COUNT(o.productcode) AS total_products_ordered
FROM 
    userbase u
LEFT JOIN 
    orders o ON u.userid = o.userid
GROUP BY 
    u.username
ORDER BY 
    total_products_ordered DESC;

--5
SELECT DISTINCT
    u.username,
    TRUNC(MONTHS_BETWEEN(SYSDATE, u.birthday) / 12) AS age
FROM 
    userbase u
JOIN 
    orders o ON u.userid = o.userid
WHERE 
    o.purchasedate >= ADD_MONTHS(SYSDATE, -6)
ORDER BY 
    age DESC;

--6
SELECT *
FROM (SELECT 
        u.username, 
        u.birthday,
        COUNT(f.friendid) AS friend_count
    FROM 
        userbase u
    LEFT JOIN 
        friendslist f ON u.userid = f.userid
    GROUP BY 
        u.username, 
        u.birthday
    ORDER BY 
        friend_count DESC
)
WHERE ROWNUM = 1;

--7
SELECT DISTINCT
    p.productname, 
    p.releasedate, 
    p.price, 
    p.description
FROM 
    productlist p
JOIN 
    wishlist w ON p.productcode = w.productcode;

--8
SELECT 
    p.productname,
    MAX(r.rating) AS highest_rating,
    COUNT(r.productcode) AS total_reviews
FROM 
    productlist p
JOIN 
    reviews r ON p.productcode = r.productcode
GROUP BY 
    p.productcode,
    p.productname
ORDER BY 
    highest_rating DESC;

--9
CREATE OR REPLACE VIEW v_extreme_rated_products AS
SELECT 
    p.productname,
    p.genre,
    r.rating
FROM 
    productlist p
JOIN 
    reviews r ON p.productcode = r.productcode
WHERE 
    r.rating = 1 
    OR r.rating = 5;

--10
SELECT 
    p.genre, 
    COUNT(o.productcode) AS total_ordered
FROM 
    productlist p
JOIN 
    orders o ON p.productcode = o.productcode
GROUP BY 
    p.genre
ORDER BY 
    p.genre ASC;

--11
CREATE OR REPLACE VIEW v_publisher_performance AS
SELECT 
    p.publisher,
    ROUND(AVG(p.price), 2) AS average_price,
    SUM(s.hoursplayed) AS total_hours_played
FROM 
    productlist p
JOIN 
    userlibrary s ON p.productcode = s.productcode
GROUP BY 
    p.publisher;

--12
SELECT 
    p.publisher,
    SUM(o.price) AS total_money_spent
FROM 
    orders o
JOIN 
    productlist p ON o.productcode = p.productcode
GROUP BY 
    p.publisher
ORDER BY 
    total_money_spent DESC;

--13
SELECT 
    t.ticketid, 
    u.username, 
    u.email, 
    t.issue
FROM 
    usersupport t
JOIN 
    userbase u ON t.email = u.email
WHERE 
    t.status IN ('NEW', 'IN PROGRESS')
ORDER BY 
    t.dateupdated DESC;

--14
SELECT 
    u.username, 
    COUNT(t.ticketid) AS total_tickets_submitted
FROM 
    userbase u
LEFT JOIN 
    usersupport t ON u.email = t.email
GROUP BY 
    u.username
ORDER BY 
    total_tickets_submitted DESC, 
    u.username ASC;

--15
SELECT DISTINCT
    u.userid,
    u.email
FROM 
    userbase u
JOIN 
    usersupport t ON u.email = t.email
WHERE 
    LOWER(u.email) LIKE '%' || LOWER(u.firstname) || '%'
    OR LOWER(u.email) LIKE '%' || LOWER(u.lastname) || '%'
    OR LOWER(u.email) LIKE '%' || LOWER(u.firstname) || LOWER(u.lastname) || '%';

--16
SELECT DISTINCT 
    t.email
FROM 
    usersupport t
WHERE 
    t.status IN ('NEW', 'IN PROGRESS')
    AND t.email NOT IN (
        SELECT email 
        FROM userbase 
        WHERE email IS NOT NULL
    );

--17
SELECT 
    t.ticketid, 
    u.firstname, 
    u.lastname, 
    u.username
FROM 
    usersupport t
JOIN 
    userbase u ON LOWER(t.issue) LIKE '%' || LOWER(u.username) || '%';

--18
SELECT DISTINCT
    t.email,
    u.username,
    u.userid
FROM 
    usersupport t
JOIN 
    userbase u ON t.email = u.email;

--19
CREATE OR REPLACE VIEW v_recent_user_penalties AS
SELECT 
    u.username,
    i.dateassigned,
    i.penalty
FROM 
    users u
JOIN 
    infractions i ON u.user_id = i.user_id -- Match on your actual table/column names
WHERE 
    i.penalty IS NOT NULL
    AND i.dateassigned >= ADD_MONTHS(SYSDATE, -1);

--20
SELECT DISTINCT
    u.username,
    u.email
FROM 
    userbase u
LEFT JOIN 
    infractions i ON u.userid = i.userid 
                  AND i.dateassigned >= ADD_MONTHS(SYSDATE, -4)
WHERE 
    TRUNC(MONTHS_BETWEEN(SYSDATE, u.birthday) / 12) >= 18
    AND i.userid IS NULL;

--21
SELECT 
    u.username,
    i.dateassigned,
    r.rulenum || ' ' || r.title AS full_guideline_name
FROM 
    userbase u
JOIN 
    infractions i ON u.userid = i.userid
JOIN 
    communityrules r ON i.rulenum = r.rulenum
ORDER BY 
    i.dateassigned DESC;

--22
SELECT 
    u.userid, 
    u.username, 
    u.email, 
    SUM(COALESCE(r.severitypoint, 0)) AS total_severity_points
FROM 
    userbase u
LEFT JOIN 
    infractions i ON u.userid = i.userid
LEFT JOIN 
    communityrules r ON i.rulenum = r.rulenum
GROUP BY 
    u.userid, 
    u.username, 
    u.email
ORDER BY 
    total_severity_points DESC;

--23
SELECT 
    r.title, 
    r.description, 
    i.penalty
FROM 
    infractions i
JOIN 
    communityrules r ON i.rulenum = r.rulenum;

--24
SELECT 
    u.username, 
    COUNT(i.infractionid) AS total_infractions
FROM 
    userbase u
JOIN 
    infractions i ON u.userid = i.userid
GROUP BY 
    u.username
HAVING 
    COUNT(i.infractionid) >= 15
ORDER BY 
    total_infractions DESC;