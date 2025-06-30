-- partitioning.sql
-- Booking table partitioning implementation

-- 1. Create the partitioned table structure
CREATE TABLE Booking_Partitioned (
    booking_id UUID,
    property_id UUID,
    user_id UUID,
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    created_at TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- 2. Create monthly partitions for current and future data
CREATE TABLE Booking_2023_Q1 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2023-04-01');

CREATE TABLE Booking_2023_Q2 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2023-04-01') TO ('2023-07-01');

CREATE TABLE Booking_2023_Q3 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2023-07-01') TO ('2023-10-01');

CREATE TABLE Booking_2023_Q4 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2023-10-01') TO ('2024-01-01');

CREATE TABLE Booking_2024_Q1 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

-- Default partition for future dates
CREATE TABLE Booking_Future PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2024-04-01') TO (MAXVALUE);

-- 3. Migrate data from original table
INSERT INTO Booking_Partitioned
SELECT * FROM Booking;

-- 4. Create indexes on partitioned table
CREATE INDEX idx_booking_partitioned_user ON Booking_Partitioned(user_id);
CREATE INDEX idx_booking_partitioned_property ON Booking_Partitioned(property_id);
CREATE INDEX idx_booking_partitioned_status ON Booking_Partitioned(status);

-- 5. Test query performance on partitioned table
EXPLAIN ANALYZE
SELECT * FROM Booking_Partitioned
WHERE start_date BETWEEN '2023-07-01' AND '2023-09-30'
AND status = 'confirmed';

-- 6. Compare with original table performance
EXPLAIN ANALYZE
SELECT * FROM Booking
WHERE start_date BETWEEN '2023-07-01' AND '2023-09-30'
AND status = 'confirmed';

-- 7. Create a function to automatically create new partitions
CREATE OR REPLACE FUNCTION create_booking_partitions()
RETURNS TRIGGER AS $$
BEGIN
    -- Create next quarter's partition if it doesn't exist
    EXECUTE format(
        'CREATE TABLE IF NOT EXISTS Booking_%s_Q%s PARTITION OF Booking_Partitioned FOR VALUES FROM (%L) TO (%L)',
        EXTRACT(YEAR FROM CURRENT_DATE + INTERVAL '3 months'),
        EXTRACT(QUARTER FROM CURRENT_DATE + INTERVAL '3 months'),
        DATE_TRUNC('quarter', CURRENT_DATE + INTERVAL '3 months'),
        DATE_TRUNC('quarter', CURRENT_DATE + INTERVAL '6 months')
    );
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- 8. Create trigger to check for new partitions
CREATE TRIGGER trg_booking_partition_maintenance
AFTER INSERT ON Booking_Partitioned
FOR EACH STATEMENT
EXECUTE FUNCTION create_booking_partitions();