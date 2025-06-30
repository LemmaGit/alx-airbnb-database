-- 1. Aggregation with GROUP BY: Number of bookings per user
SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    COUNT(b.booking_id) AS total_bookings,
    SUM(p.pricepernight * DATEDIFF(b.end_date, b.start_date)) AS total_spent
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
LEFT JOIN 
    Property p ON b.property_id = p.property_id
GROUP BY 
    u.user_id, user_name
ORDER BY 
    total_bookings DESC;

-- 2. Window function: Rank properties by booking count
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank,
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS dense_booking_rank,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_num
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.location
ORDER BY 
    total_bookings DESC;

-- 3. Advanced window function: Monthly booking trends
SELECT 
    DATE_FORMAT(b.start_date, '%Y-%m') AS month,
    COUNT(b.booking_id) AS monthly_bookings,
    SUM(p.pricepernight * DATEDIFF(b.end_date, b.start_date)) AS monthly_revenue,
    COUNT(b.booking_id) - LAG(COUNT(b.booking_id), 1) OVER (ORDER BY DATE_FORMAT(b.start_date, '%Y-%m')) AS booking_growth,
    ROUND(
        (SUM(p.pricepernight * DATEDIFF(b.end_date, b.start_date)) - 
        LAG(SUM(p.pricepernight * DATEDIFF(b.end_date, b.start_date)), 1) OVER (ORDER BY DATE_FORMAT(b.start_date, '%Y-%m')) /
        LAG(SUM(p.pricepernight * DATEDIFF(b.end_date, b.start_date)), 1) OVER (ORDER BY DATE_FORMAT(b.start_date, '%Y-%m')) * 100, 
    2) AS revenue_growth_pct
FROM 
    Booking b
JOIN 
    Property p ON b.property_id = p.property_id
GROUP BY 
    month
ORDER BY 
    month;