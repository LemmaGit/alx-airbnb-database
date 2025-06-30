### Entities and Attributes:

- **User**

  - user_id (PK, UUID)
  - first_name, last_name (NOT NULL)
  - email (UNIQUE, NOT NULL)
  - password_hash (NOT NULL)
  - phone_number (nullable)
  - role (ENUM: guest, host, admin)
  - created_at (timestamp)

- **Property**

  - property_id (PK, UUID)
  - host_id (FK → User.user_id)
  - name, description, location (NOT NULL)
  - pricepernight (DECIMAL, NOT NULL)
  - created_at, updated_at (timestamps)

- **Booking**

  - booking_id (PK, UUID)
  - property_id (FK → Property.property_id)
  - user_id (FK → User.user_id)
  - start_date, end_date (NOT NULL)
  - total_price (DECIMAL, NOT NULL)
  - status (ENUM: pending, confirmed, canceled)
  - created_at (timestamp)

- **Payment**

  - payment_id (PK, UUID)
  - booking_id (FK → Booking.booking_id)
  - amount (DECIMAL, NOT NULL)
  - payment_date (timestamp)
  - payment_method (ENUM: credit_card, paypal, stripe)

- **Review**

  - review_id (PK, UUID)
  - property_id (FK → Property.property_id)
  - user_id (FK → User.user_id)
  - rating (INTEGER, 1–5)
  - comment (TEXT)
  - created_at (timestamp)

- **Message**

  - message_id (PK, UUID)
  - sender_id (FK → User.user_id)
  - recipient_id (FK → User.user_id)
  - message_body (TEXT)
  - sent_at (timestamp)

---

### Relationships:

- User **hosts** Properties (1-to-many)
- User **books** Bookings (1-to-many)
- Property **has** Bookings (1-to-many)
- Booking **has** Payment (1-to-1 or 1-to-many if partial payments)
- User **writes** Reviews for Properties (many-to-many via Review)
- User **sends/receives** Messages (many-to-many self-relationship)

---

### Constraints & Indexing:

- Unique email on User
- Non-null on required fields
- Foreign keys ensure referential integrity
- Enum constraints on role, status, payment_method
- Index on email, property_id, booking_id for fast queries
