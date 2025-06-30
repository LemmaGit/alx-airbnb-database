```markdown
# Database Index Optimization

This project demonstrates how to improve query performance through strategic index creation.

## Files Included

1. `database_indexes.sql` - Contains CREATE INDEX statements
2. `performance_analysis.md` - Shows before/after performance comparisons

## Key Indexes Created

- **User Table**: Email, role, and name indexes
- **Property Table**: Host, location, and price indexes
- **Booking Table**: User, property, date, and status indexes
- **Composite Indexes**: For common query patterns

## Performance Improvements

Typical performance gains:

- 10-25x faster for indexed queries
- Reduced full table scans
- Faster JOIN operations

## How to Use

1. Execute `database_indexes.sql` to create indexes
2. Run `EXPLAIN ANALYZE` on your queries
3. Monitor with `pg_stat_user_indexes`
4. Remove unused indexes

## Best Practices

- Index columns used in WHERE, JOIN, ORDER BY
- Create composite indexes for common query patterns
- Monitor and remove unused indexes
- Rebuild indexes periodically
```
