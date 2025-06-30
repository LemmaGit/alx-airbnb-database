# **SQL Sample Data Population for Airbnb-like Database**

Here are the SQL `INSERT` statements to populate your database with realistic sample data that demonstrates all relationships.

## **1. Insert Users**
```sql
-- Admins
INSERT INTO User (user_id, first_name, last_name, email, password_hash, role) VALUES
('11111111-1111-1111-1111-111111111111', 'Admin', 'One', 'admin1@example.com', '$2a$10$hashhashhashhashhashhashe', 'admin');

-- Hosts
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('22222222-2222-2222-2222-222222222222', 'Sarah', 'Johnson', 'sarah@example.com', '$2a$10$hashhashhashhashhashhashe', '+1234567890', 'host'),
('33333333-3333-3333-3333-333333333333', 'Mike', 'Williams', 'mike@example.com', '$2a$10$hashhashhashhashhashhashe', '+1987654321', 'host');

-- Guests
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('44444444-4444-4444-4444-444444444444', 'Emma', 'Davis', 'emma@example.com', '$2a$10$hashhashhashhashhashhashe', '+1122334455', 'guest'),
('55555555-5555-5555-5555-555555555555', 'James', 'Brown', 'james@example.com', '$2a$10$hashhashhashhashhashhashe', '+1567890123', 'guest');
```

## **2. Insert Properties**
```sql
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight) VALUES
('aaaa1111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Beachfront Villa', 'Luxury villa with ocean view', 'Malibu, CA', 350.00),
('bbbb2222-2222-2222-2222-222222222222', '22222222-2222-2222-2222-222222222222', 'Downtown Loft', 'Modern apartment in city center', 'New York, NY', 200.00),
('cccc3333-3333-3333-3333-333333333333', '33333333-3333-3333-3333-333333333333', 'Mountain Cabin', 'Cozy wooden cabin with hot tub', 'Aspen, CO', 180.00);
```

## **3. Insert Bookings**
```sql
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status) VALUES
('dddd1111-1111-1111-1111-111111111111', 'aaaa1111-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444', '2023-07-15', '2023-07-20', 'confirmed'),
('eeee2222-2222-2222-2222-222222222222', 'bbbb2222-2222-2222-2222-222222222222', '55555555-5555-5555-5555-555555555555', '2023-08-01', '2023-08-05', 'confirmed'),
('ffff3333-3333-3333-3333-333333333333', 'cccc3333-3333-3333-3333-333333333333', '44444444-4444-4444-4444-444444444444', '2023-09-10', '2023-09-15', 'pending');
```

## **4. Insert Payments**
```sql
INSERT INTO Payment (payment_id, booking_id, amount, payment_method) VALUES
('gggg1111-1111-1111-1111-111111111111', 'dddd1111-1111-1111-1111-111111111111', 1750.00, 'credit_card'),
('hhhh2222-2222-2222-2222-222222222222', 'eeee2222-2222-2222-2222-222222222222', 800.00, 'paypal');
```

## **5. Insert Reviews**
```sql
INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
('iiii1111-1111-1111-1111-111111111111', 'aaaa1111-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444', 5, 'Absolutely stunning views!'),
('jjjj2222-2222-2222-2222-222222222222', 'bbbb2222-2222-2222-2222-222222222222', '55555555-5555-5555-5555-555555555555', 4, 'Great location, would stay again');
```

## **6. Insert Messages**
```sql
INSERT INTO Message (message_id, sender_id, recipient_id, message_body) VALUES
('kkkk1111-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 'Hi Sarah, is the villa pet-friendly?'),
('llll2222-2222-2222-2222-222222222222', '22222222-2222-2222-2222-222222222222', '44444444-4444-4444-4444-444444444444', 'Yes Emma, we allow small dogs!');
```

## **Verification Queries**
```sql
-- Check all users and their roles
SELECT user_id, first_name, last_name, role FROM User;

-- List all properties with host info
SELECT p.property_id, p.name, u.first_name AS host_name, p.pricepernight 
FROM Property p JOIN User u ON p.host_id = u.user_id;

-- View bookings with calculated prices
SELECT 
    b.booking_id,
    p.name AS property,
    CONCAT(u.first_name, ' ', u.last_name) AS guest,
    b.start_date,
    b.end_date,
    p.pricepernight * DATEDIFF(b.end_date, b.start_date) AS total_price,
    b.status
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
JOIN User u ON b.user_id = u.user_id;
```

