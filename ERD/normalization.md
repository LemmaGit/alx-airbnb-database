# **Database Normalization Review & Optimization to 3NF**

**For: Airbnb-like Database (ALX Project)**

## **1. Current Schema Overview**

### **Entities & Attributes**

| Table      | Key Fields                           | Potential Issues                            |
| ---------- | ------------------------------------ | ------------------------------------------- |
| `User`     | `user_id (PK)`, `email`, `role`      | None                                        |
| `Property` | `property_id (PK)`, `host_id (FK)`   | None                                        |
| `Booking`  | `booking_id (PK)`, `total_price`     | **Redundancy** (derivable from dates/price) |
| `Payment`  | `payment_id (PK)`, `booking_id (FK)` | None                                        |
| `Review`   | `review_id (PK)`, `property_id (FK)` | None                                        |
| `Message`  | `message_id (PK)`, `sender_id (FK)`  | None                                        |

### **Relationships**

- **1:M**: User → Properties, User → Bookings, Property → Bookings
- **1:1**: Booking → Payment
- **M:M**: User ↔ Reviews (via `Review`), User ↔ User (via `Message`)

---

## **2. Normalization Review**

### **First Normal Form (1NF)**

✅ **Compliant**: All tables have atomic values and no repeating groups.

### **Second Normal Form (2NF)**

✅ **Compliant**: All non-key attributes depend on the **full primary key** (no partial dependencies).

### **Third Normal Form (3NF)**

🔍 **Potential Issue**:

- **`Booking.total_price`** violates 3NF because it can be derived from:
  ```
  total_price = Property.pricepernight * (Booking.end_date - Booking.start_date)
  ```
  **This is redundant** and risks inconsistency if `pricepernight` changes.

---

## **3. Adjustments for 3NF Compliance**

### **Change 1: Remove `total_price` from `Booking`**

**Reason**: Eliminate transitive dependency (derived from `Property.pricepernight` and dates).

**Application Logic**:  
Compute `total_price` dynamically in queries:

```sql
SELECT
    b.booking_id,
    p.pricepernight * (b.end_date - b.start_date) AS total_price
FROM Booking b
JOIN Property p ON b.property_id = p.property_id;
```

## **5. Final 3NF-Compliant Schema**

### **Entities in 3NF**

| Table      | Key Changes               |
| ---------- | ------------------------- |
| `User`     | Unchanged                 |
| `Property` | Unchanged                 |
| `Booking`  | **Removed `total_price`** |
| `Payment`  | Unchanged                 |
| `Review`   | Unchanged                 |
| `Message`  | Unchanged                 |

### **Relationships (Unchanged)**

- **User → Property**: 1-to-M (Host owns properties)
- **Booking → Payment**: 1-to-1 (Each booking has one payment)

---

## **6. Normalization Summary**

| Normal Form | Status   | Action Taken                            |
| ----------- | -------- | --------------------------------------- |
| **1NF**     | ✅ Valid | No changes                              |
| **2NF**     | ✅ Valid | No changes                              |
| **3NF**     | ✅ Fixed | Removed redundant `Booking.total_price` |
