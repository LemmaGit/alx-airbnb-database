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

# SQL Subqueries Practice for Airbnb-like Database

This repository contains SQL queries demonstrating both correlated and non-correlated subqueries using an Airbnb-like database schema.

## Queries Included

### 1. Non-correlated Subquery

Finds all properties where the average rating is greater than 4.0.

- Uses a subquery in the WHERE clause to calculate average ratings
- Returns property details along with their average rating
- Only includes properties meeting the rating threshold

### 2. Correlated Subquery

Identifies users who have made more than 3 bookings.

- Correlates the subquery with the outer query (references outer table)
- Counts bookings for each user
- Returns user information along with booking count
- Filters for users with more than 3 bookings

## Key Concepts Demonstrated

**Non-correlated Subquery:**

- Executes independently of the outer query
- Can run by itself
- Typically executes once for the entire query

**Correlated Subquery:**

- References columns from the outer query
- Executes once for each row processed by the outer query
- Used for row-by-row comparisons

## How to Use

1. Execute the database schema and sample data scripts first
2. Run the queries in `subqueries.sql` to see the results
3. Experiment with modifying the queries to understand subquery behavior

## Learning Outcomes

- When to use subqueries vs joins
- Performance implications of different subquery types
- How to structure complex filtering conditions
- Techniques for aggregating data in subqueries

# SQL Aggregation and Window Functions Practice

This repository demonstrates data analysis techniques using aggregation functions and window functions with an Airbnb-like database schema.

## Queries Included

### 1. Basic Aggregation (GROUP BY)

- Calculates the total number of bookings per user
- Includes total amount spent by each user
- Uses LEFT JOIN to include users with no bookings
- Ordered by most frequent bookers first

### 2. Window Functions (RANK, DENSE_RANK, ROW_NUMBER)

- Ranks properties by number of bookings received
- Demonstrates three different ranking methods:
  - RANK(): Leaves gaps in ranking for ties
  - DENSE_RANK(): No gaps in ranking
  - ROW_NUMBER(): Simple sequential numbering
- Includes property details and booking counts

### 3. Advanced Window Function (LAG)

- Shows monthly booking trends
- Calculates month-over-month:
  - Booking growth (absolute count)
  - Revenue growth (percentage)
- Uses LAG() to compare with previous period

## Key Concepts Demonstrated

**Aggregation Functions:**

- COUNT() for tallying records
- SUM() for calculating totals
- GROUP BY for grouping data

**Window Functions:**

- RANK(), DENSE_RANK(), ROW_NUMBER() for ranking
- LAG() for period-over-period comparisons
- OVER() clause to define window frames
- ORDER BY within window functions

## How to Use

1. Execute the database schema and sample data scripts first
2. Run the queries in `aggregation_window.sql`
3. Compare the different ranking methods in query #2
4. Analyze the monthly trends in query #3

## Learning Outcomes

- When to use aggregation vs window functions
- How different ranking methods behave with ties
- Techniques for period-over-period analysis
- Calculating growth rates with window functions
