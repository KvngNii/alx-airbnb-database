# AirBnB Database Schema

A comprehensive PostgreSQL database schema for an AirBnB-style rental platform, supporting user management, property listings, bookings, payments, reviews, and messaging.

## 📋 Table of Contents

- [Overview](#overview)
- [Database Design](#database-design)
- [Installation](#installation)
- [Schema Structure](#schema-structure)
- [Relationships](#relationships)
- [Constraints and Validation](#constraints-and-validation)
- [Performance Features](#performance-features)
- [Usage Examples](#usage-examples)
- [Maintenance](#maintenance)
- [Security Considerations](#security-considerations)

## 🎯 Overview

This database schema implements a complete rental platform system with the following core functionalities:

- **User Management**: Support for guests, hosts, and administrators
- **Property Listings**: Comprehensive property information and pricing
- **Booking System**: Date-based reservations with conflict prevention
- **Payment Processing**: Transaction records with multiple payment methods
- **Review System**: Property ratings and feedback from users
- **Messaging**: Communication system between users

## 🏗️ Database Design

### Architecture Principles

- **UUID Primary Keys**: Globally unique identifiers for all entities
- **Referential Integrity**: Complete foreign key relationships with cascading deletes
- **Data Validation**: Comprehensive check constraints for business rules
- **Performance Optimization**: Strategic indexing for common queries
- **Audit Trail**: Timestamp tracking for all entities

### Supported Database Systems

- **Primary**: PostgreSQL 12+
- **Compatible**: MySQL 8.0+ (with minor modifications)
- **Adaptable**: Other SQL databases with UUID support

## 🚀 Installation

### Prerequisites

- PostgreSQL 12+ or MySQL 8.0+
- Database admin privileges
- `uuid-ossp` extension (PostgreSQL)

### Setup Instructions

1. **Create Database**
   ```sql
   CREATE DATABASE airbnb_db;
   \c airbnb_db;
   ```

2. **Run Schema Script**
   ```bash
   psql -U username -d airbnb_db -f schema.sql
   ```

3. **Verify Installation**
   ```sql
   \dt  -- List all tables
   \di  -- List all indexes
   ```

### Docker Setup (Optional)

```bash
# Start PostgreSQL container
docker run --name airbnb-postgres \
  -e POSTGRES_DB=airbnb_db \
  -e POSTGRES_USER=airbnb_user \
  -e POSTGRES_PASSWORD=your_password \
  -p 5432:5432 -d postgres:14

# Apply schema
docker exec -i airbnb-postgres psql -U airbnb_user -d airbnb_db < schema.sql
```

## 📊 Schema Structure

### Core Tables

| Table | Purpose | Key Features |
|-------|---------|-------------|
| `users` | User accounts and authentication | Role-based access, email validation |
| `properties` | Property listings | Host relationships, pricing, location |
| `bookings` | Reservation management | Date validation, conflict prevention |
| `payments` | Transaction records | Multiple payment methods, amount validation |
| `reviews` | Property feedback | 1-5 star ratings, unique per user/property |
| `messages` | User communication | Sender/recipient relationships |

### Entity Details

#### Users Table
```sql
users (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(20) DEFAULT 'guest', -- guest, host, admin
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE
)
```

#### Properties Table
```sql
properties (
    property_id UUID PRIMARY KEY,
    host_id UUID REFERENCES users(user_id),
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE
)
```

#### Bookings Table
```sql
bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID REFERENCES properties(property_id),
    user_id UUID REFERENCES users(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(12,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending', -- pending, confirmed, canceled
    created_at TIMESTAMP WITH TIME ZONE
)
```

## 🔗 Relationships

### Entity Relationship Diagram

```
users (1) ──────── (M) properties
  │                      │
  │                      │
  │ (1)              (1) │
  │                      │
  └────── (M) bookings (M)┘
              │
              │ (1)
              │
              ▼ (1)
           payments

users (1) ──── (M) reviews ──── (M) properties
  │                                    
  │ (M)                               
  │                                  
  └────── (M) messages (M) ──── users
```

### Relationship Types

- **User → Property** (1:M): Hosts can own multiple properties
- **User → Booking** (1:M): Users can make multiple bookings
- **Property → Booking** (1:M): Properties can have multiple bookings
- **Booking → Payment** (1:1): Each booking has exactly one payment
- **User → Review** (1:M): Users can write multiple reviews
- **Property → Review** (1:M): Properties can receive multiple reviews
- **User → Message** (M:M): Users can send/receive multiple messages

## ✅ Constraints and Validation

### Business Rules Enforced

1. **User Constraints**
   - Email must be unique and properly formatted
   - Names cannot be empty
   - Role must be 'guest', 'host', or 'admin'

2. **Property Constraints**
   - Price per night must be positive
   - All text fields must not be empty
   - Must have a valid host

3. **Booking Constraints**
   - End date must be after start date
   - Start date cannot be in the past
   - Total price must be positive
   - Users cannot book their own properties

4. **Payment Constraints**
   - Amount must be positive
   - One payment per booking
   - Valid payment methods only

5. **Review Constraints**
   - Rating must be between 1 and 5
   - One review per user per property
   - Comment cannot be empty

6. **Message Constraints**
   - Users cannot message themselves
   - Message body cannot be empty

## ⚡ Performance Features

### Indexing Strategy

```sql
-- Primary Indexes (automatic)
- All UUID primary keys

-- Query Optimization Indexes
- users.email (login queries)
- properties.host_id (host properties)
- bookings.property_id, user_id (user/property bookings)
- bookings.start_date, end_date (date range queries)

-- Composite Indexes
- bookings(property_id, start_date, end_date) -- conflict checking
- messages(sender_id, recipient_id, sent_at) -- conversations
```

### Utility Views

- **`property_listings`**: Properties with host info and ratings
- **`booking_details`**: Complete booking information with related data

### Stored Functions

- **`check_booking_availability()`**: Validates booking date conflicts
- **`calculate_booking_price()`**: Computes total booking cost

## 💡 Usage Examples

### Basic Queries

```sql
-- Find available properties
SELECT * FROM property_listings 
WHERE property_id NOT IN (
    SELECT property_id FROM bookings 
    WHERE status = 'confirmed' 
    AND start_date <= '2024-12-31' 
    AND end_date > '2024-12-01'
);

-- Get user's booking history
SELECT * FROM booking_details 
WHERE guest_email = 'user@example.com'
ORDER BY created_at DESC;

-- Check property availability
SELECT check_booking_availability(
    'property-uuid-here',
    '2024-12-01',
    '2024-12-07'
);
```

### Insert Operations

```sql
-- Create new user
INSERT INTO users (first_name, last_name, email, password_hash, role)
VALUES ('John', 'Doe', 'john@example.com', 'hashed_password', 'guest');

-- Create property listing
INSERT INTO properties (host_id, name, description, location, pricepernight)
VALUES (
    'host-uuid-here',
    'Cozy Downtown Apartment',
    'Beautiful 2-bedroom apartment in city center',
    'New York, NY',
    150.00
);

-- Make a booking
INSERT INTO bookings (property_id, user_id, start_date, end_date, total_price, status)
VALUES (
    'property-uuid-here',
    'user-uuid-here',
    '2024-12-01',
    '2024-12-07',
    900.00,
    'pending'
);
```

## 🔧 Maintenance

### Regular Maintenance Tasks

```sql
-- Update table statistics
ANALYZE users, properties, bookings, payments, reviews, messages;

-- Check table sizes
SELECT 
    schemaname,
    tablename,
    attname,
    n_distinct,
    most_common_vals
FROM pg_stats 
WHERE schemaname = 'public';

-- Monitor index usage
SELECT 
    indexrelname,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes;
```

### Backup and Recovery

```bash
# Full database backup
pg_dump airbnb_db > airbnb_backup_$(date +%Y%m%d).sql

# Schema-only backup
pg_dump -s airbnb_db > airbnb_schema_backup.sql

# Restore from backup
psql airbnb_db < airbnb_backup.sql
```

### Performance Monitoring

```sql
-- Slow query monitoring
SELECT query, mean_time, calls, total_time
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;

-- Table bloat check
SELECT 
    tablename,
    pg_size_pretty(pg_total_relation_size(tablename::regclass)) as size
FROM pg_tables 
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(tablename::regclass) DESC;
```

## 🔒 Security Considerations

### Data Protection

- **Password Storage**: Passwords must be hashed (use bcrypt, Argon2)
- **Input Validation**: All constraints prevent SQL injection
- **Sensitive Data**: Consider encrypting PII fields
- **Audit Logging**: Implement application-level audit trails

### Access Control

```sql
-- Create application roles
CREATE ROLE airbnb_app_user LOGIN PASSWORD 'secure_password';
CREATE ROLE airbnb_readonly LOGIN PASSWORD 'readonly_password';

-- Grant appropriate permissions
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO airbnb_app_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO airbnb_readonly;
```

### Connection Security

- Use SSL/TLS for database connections
- Implement connection pooling
- Regular password rotation
- Network-level access restrictions

## 📈 Scaling Considerations

### Horizontal Scaling

- **Read Replicas**: For read-heavy workloads
- **Partitioning**: Consider date-based partitioning for bookings
- **Caching**: Implement Redis for frequently accessed data

### Vertical Scaling

- **Memory**: Increase `shared_buffers` for large datasets
- **Storage**: Use SSD storage for better I/O performance
- **CPU**: Scale based on concurrent user load

## 🐛 Troubleshooting

### Common Issues

1. **UUID Extension Missing**
   ```sql
   CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
   ```

2. **Constraint Violations**
   - Check foreign key relationships
   - Verify data types and formats
   - Review business rule constraints

3. **Performance Issues**
   - Run `ANALYZE` on tables
   - Check index usage with `EXPLAIN PLAN`
   - Monitor slow query log

## 📞 Support

- **Issues**: Report bugs in the project repository
- **Documentation**: Check PostgreSQL official documentation
- **Community**: Stack Overflow for general SQL questions

## 📄 License

This database schema is provided as-is for educational and commercial use. Please ensure compliance with your organization's data governance policies.

---

**Version**: 1.0  
**Last Updated**: 2024  
**Compatibility**: PostgreSQL 12+, MySQL 8.0+
