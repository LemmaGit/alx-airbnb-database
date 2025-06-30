# **Airbnb-like Database Schema**

This project defines a **3NF-compliant** database schema for an Airbnb-like platform. It includes tables for users, properties, bookings, payments, reviews, and messages, with proper relationships and constraints.

## **Features**

✅ **Normalized to 3NF** – Eliminates redundancy (e.g., no stored `total_price`).  
✅ **Optimized for Performance** – Indexes on frequently queried columns.  
✅ **Data Integrity** – Foreign keys, `NOT NULL`, `ENUM`, and `CHECK` constraints.  
✅ **Cascading Deletes** – Automatically cleans up related records.

## **Tables**

| Table      | Description                        |
| ---------- | ---------------------------------- |
| `User`     | Guests, hosts, and admins.         |
| `Property` | Listings with details and pricing. |
| `Booking`  | Reservations (dates, status).      |
| `Payment`  | Records of completed transactions. |
| `Review`   | Guest ratings and comments.        |
| `Message`  | Communication between users.       |

## **SQL Setup**

Run the provided SQL scripts to:

1. Create tables with constraints.
2. Add indexes for faster queries.

## **Example Query**

```sql
-- Get bookings with calculated total price
SELECT
    b.booking_id,
    p.pricepernight * (b.end_date - b.start_date) AS total_price
FROM Booking b
JOIN Property p ON b.property_id = p.property_id;
```
