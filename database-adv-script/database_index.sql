-- 1. Indexes for User table
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_role ON User(role);
CREATE INDEX idx_user_name ON User(first_name, last_name);

-- 2. Indexes for Property table
CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(pricepernight);
CREATE INDEX idx_property_dates ON Property(created_at, updated_at);

-- 3. Indexes for Booking table
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_user_property ON Booking(user_id, property_id);

-- 4. Composite index for frequent join operations
CREATE INDEX idx_booking_property_user_dates ON Booking(property_id, user_id, start_date, end_date);

-- 5. Index for Review table (frequently joined/queried)
CREATE INDEX idx_review_property ON Review(property_id);
CREATE INDEX idx_review_user ON Review(user_id);
CREATE INDEX idx_review_rating ON Review(rating);

-- 6. Index for Payment table
CREATE INDEX idx_payment_booking ON Payment(booking_id);