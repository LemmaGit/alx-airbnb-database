-- performance.sql
-- Query optimization demonstration for Airbnb-like database

-- 1. First, show the current indexes (for reference)
SELECT 
    tablename, 
    indexname, 
    indexdef 
FROM 
    pg_indexes 
WHERE 
    schemaname = 'public'
ORDER BY 
    tablename, indexname;

-- 2. Original inefficient query with EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date,
    (SELECT COUNT(*) FROM Review r WHERE r.property_id = p.property_id) AS review_count
FROM 
    Booking b
JOIN 
    User u ON b.user_id = u.user_id
JOIN 
    Property p ON b.property_id = p.property_id
LEFT JOIN 
    Payment pay ON b.booking_id = pay.booking_id
LEFT JOIN
    Review rv ON rv.property_id = p.property_id
WHERE
    u.role = 'guest'
    AND p.pricepernight > 100
ORDER BY 
    b.start_date DESC
LIMIT 100;

-- 3. Create recommended indexes (if they don't exist)
CREATE INDEX IF NOT EXISTS idx_booking_dates ON Booking(start_date);
CREATE INDEX IF NOT EXISTS idx_booking_user_property ON Booking(user_id, property_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking ON Payment(booking_id);
CREATE INDEX IF NOT EXISTS idx_user_role ON User(role);
CREATE INDEX IF NOT EXISTS idx_property_price ON Property(pricepernight);

-- 4. Optimized query with EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.amount,
    pay.payment_method,
    p.review_count
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id AND u.role = 'guest'
INNER JOIN 
    (SELECT 
        property_id, 
        name, 
        location,
        pricepernight,
        (SELECT COUNT(*) FROM Review r WHERE r.property_id = p.property_id) AS review_count
     FROM Property p
     WHERE pricepernight > 100) p 
    ON b.property_id = p.property_id
INNER JOIN 
    Payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.start_date >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY 
    b.start_date DESC
LIMIT 100;

-- 5. Performance comparison helper query
SELECT 
    'Original Query' AS query_type,
    pg_size_pretty(total_time::numeric) AS total_time,
    (total_time/1000)::numeric(10,2) AS seconds
FROM 
    (SELECT * FROM pg_stat_statements WHERE query LIKE '%Original inefficient query%' ORDER BY total_time DESC LIMIT 1) orig
UNION ALL
SELECT 
    'Optimized Query',
    pg_size_pretty(total_time::numeric),
    (total_time/1000)::numeric(10,2)
FROM 
    (SELECT * FROM pg_stat_statements WHERE query LIKE '%Optimized query%' ORDER BY total_time DESC LIMIT 1) opt;