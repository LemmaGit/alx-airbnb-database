-- 1. INNER JOIN: All bookings with their respective users
SELECT 
    b.booking_id,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    u.email AS guest_email,
    b.start_date,
    b.end_date,
    b.status
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
ORDER BY 
    b.start_date DESC;

-- 2. LEFT JOIN: All properties with their reviews (including properties with no reviews)
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    r.rating,
    r.comment,
    CONCAT(u.first_name, ' ', u.last_name) AS reviewer_name
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
LEFT JOIN 
    User u ON r.user_id = u.user_id
ORDER BY 
    p.name, r.rating DESC;

-- 3. FULL OUTER JOIN simulation (MySQL doesn't support FULL OUTER JOIN directly)
-- Using UNION of LEFT and RIGHT joins to achieve the same result
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM 
    User u
RIGHT JOIN 
    Booking b ON u.user_id = b.user_id
WHERE 
    u.user_id IS NULL
ORDER BY 
    user_name, start_date;