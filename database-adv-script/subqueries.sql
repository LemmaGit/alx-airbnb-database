-- 1. Non-correlated subquery: Properties with average rating > 4.0
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    (SELECT AVG(r.rating) 
     FROM Review r 
     WHERE r.property_id = p.property_id) AS avg_rating
FROM 
    Property p
WHERE 
    (SELECT AVG(r.rating) 
    FROM Review r 
    WHERE r.property_id = p.property_id) > 4.0
ORDER BY 
    avg_rating DESC;

-- 2. Correlated subquery: Users with more than 3 bookings
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    u.email,
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) AS booking_count
FROM 
    User u
WHERE 
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) > 3
ORDER BY 
    booking_count DESC;