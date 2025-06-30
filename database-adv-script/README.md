# SQL Joins Practice for Airbnb-like Database

This repository contains SQL queries demonstrating different types of joins using an Airbnb-like database schema.

## Queries Included

### 1. INNER JOIN

Retrieves all bookings along with the user information of who made each booking.

- Shows only bookings that have associated users
- Includes booking details and user information

### 2. LEFT JOIN

Retrieves all properties and their reviews, including properties that have no reviews.

- Ensures all properties are listed
- Shows review information when available
- Maintains property data even without reviews

### 3. FULL OUTER JOIN Simulation

Retrieves all users and all bookings, including:

- Users with no bookings
- Bookings not linked to any user (orphaned bookings)
- Note: MySQL doesn't support FULL OUTER JOIN directly, so we simulate it with a UNION of LEFT and RIGHT joins

## How to Use

1. Execute the database schema and sample data scripts first
2. Run the queries in `joins_queries.sql` to see the results
3. Experiment with modifying the queries to understand different join behaviors

## Key Learnings

- INNER JOIN returns only matching records from both tables
- LEFT JOIN returns all records from the left table with matching right table records
- FULL OUTER JOIN returns all records from both tables (simulated in MySQL)
- Proper join selection depends on what data you need to retrieve

Try adding WHERE clauses to these queries to filter the results further!
