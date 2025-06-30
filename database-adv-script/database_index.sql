-- Performance measurement before adding indexes
-- Save this output to compare with post-index results

-- Query 1: User bookings lookup
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE user_id = '44444444-4444-4444-4444-444444444444';

-- Query 2: Property location search
EXPLAIN ANALYZE
SELECT * FROM Property WHERE location LIKE 'New York%';

-- Query 3: Booking status report
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE status = 'confirmed';

-----------------------------------------
-- CREATE INDEX STATEMENTS
-----------------------------------------

-- 1. User Table Indexes
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);
CREATE INDEX idx_user_name ON User(first_name, last_name);

-- 2. Property Table Indexes
CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(pricepernight);
CREATE INDEX idx_property_dates ON Property(created_at, updated_at);

-- 3. Booking Table Indexes
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_user_property ON Booking(user_id, property_id);

-- 4. Composite index
CREATE INDEX idx_booking_property_user_dates ON Booking(property_id, user_id, start_date, end_date);

-- 5. Review Table Indexes
CREATE INDEX idx_review_property ON Review(property_id);
CREATE INDEX idx_review_user ON Review(user_id);
CREATE INDEX idx_review_rating ON Review(rating);

-- 6. Payment Table Index
CREATE INDEX idx_payment_booking ON Payment(booking_id);

-----------------------------------------
-- Performance measurement after adding indexes
-----------------------------------------

-- Query 1: User bookings lookup (with index)
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE user_id = '44444444-4444-4444-4444-444444444444';

-- Query 2: Property location search (with index)
EXPLAIN ANALYZE
SELECT * FROM Property WHERE location LIKE 'New York%';

-- Query 3: Booking status report (with index)
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE status = 'confirmed';