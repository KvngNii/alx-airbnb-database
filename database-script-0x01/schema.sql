-- ================================================
-- AirBnB Database Schema - schema.sql
-- ================================================
-- Production-ready SQL schema for AirBnB platform
-- Version: 1.0
-- Database: PostgreSQL 12+ (adaptable to MySQL 8.0+)
-- ================================================

-- ================================================
-- EXTENSIONS AND SETUP
-- ================================================
-- Enable UUID extension (PostgreSQL)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Set timezone
SET timezone = 'UTC';

-- ================================================
-- CORE TABLES
-- ================================================

-- Users table: Core user management
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(20) NOT NULL DEFAULT 'guest' CHECK (role IN ('guest', 'host', 'admin')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Validation constraints
    CONSTRAINT chk_user_email_format CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT chk_user_names_not_empty CHECK (
        LENGTH(TRIM(first_name)) > 0 AND 
        LENGTH(TRIM(last_name)) > 0
    )
);

-- Properties table: Property listings
CREATE TABLE properties (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    host_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    CONSTRAINT fk_property_host FOREIGN KEY (host_id) 
        REFERENCES users(user_id) ON DELETE CASCADE,
    
    -- Validation constraints
    CONSTRAINT chk_property_price_positive CHECK (pricepernight > 0),
    CONSTRAINT chk_property_name_not_empty CHECK (LENGTH(TRIM(name)) > 0),
    CONSTRAINT chk_property_description_not_empty CHECK (LENGTH(TRIM(description)) > 0)
);

-- Bookings table: Reservation management
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(12, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) 
        REFERENCES properties(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) 
        REFERENCES users(user_id) ON DELETE CASCADE,
    
    -- Validation constraints
    CONSTRAINT chk_booking_dates CHECK (end_date > start_date),
    CONSTRAINT chk_booking_start_future CHECK (start_date >= CURRENT_DATE),
    CONSTRAINT chk_booking_total_positive CHECK (total_price > 0)
);

-- Payments table: Payment processing
CREATE TABLE payments (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID UNIQUE NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    payment_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')),
    
    -- Foreign key constraints
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) 
        REFERENCES bookings(booking_id) ON DELETE CASCADE,
    
    -- Validation constraints
    CONSTRAINT chk_payment_amount_positive CHECK (amount > 0)
);

-- Reviews table: Property reviews and ratings
CREATE TABLE reviews (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) 
        REFERENCES properties(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) 
        REFERENCES users(user_id) ON DELETE CASCADE,
    
    -- Validation constraints
    CONSTRAINT chk_review_rating_range CHECK (rating >= 1 AND rating <= 5),
    CONSTRAINT chk_review_comment_not_empty CHECK (LENGTH(TRIM(comment)) > 0),
    
    -- Unique constraint: one review per user per property
    CONSTRAINT uk_review_user_property UNIQUE (user_id, property_id)
);

-- Messages table: User communication
CREATE TABLE messages (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) 
        REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_message_recipient FOREIGN KEY (recipient_id) 
        REFERENCES users(user_id) ON DELETE CASCADE,
    
    -- Validation constraints
    CONSTRAINT chk_message_body_not_empty CHECK (LENGTH(TRIM(message_body)) > 0),
    CONSTRAINT chk_message_different_users CHECK (sender_id != recipient_id)
);

-- ================================================
-- PERFORMANCE INDEXES
-- ================================================

-- Users table indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_users_created_at ON users(created_at);

-- Properties table indexes
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(pricepernight);
CREATE INDEX idx_properties_created_at ON properties(created_at);

-- Bookings table indexes
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);

-- Composite index for booking conflicts
CREATE INDEX idx_bookings_property_dates ON bookings(property_id, start_date, end_date);

-- Payments table indexes
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_payments_date ON payments(payment_date);
CREATE INDEX idx_payments_method ON payments(payment_method);

-- Reviews table indexes
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);
CREATE INDEX idx_reviews_created_at ON reviews(created_at);

-- Messages table indexes
CREATE INDEX idx_messages_sender_id ON messages(sender_id);
CREATE INDEX idx_messages_recipient_id ON messages(recipient_id);
CREATE INDEX idx_messages_sent_at ON messages(sent_at);
CREATE INDEX idx_messages_conversation ON messages(sender_id, recipient_id, sent_at);

-- ================================================
-- TRIGGERS AND FUNCTIONS
-- ================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers for automatic timestamp updates
CREATE TRIGGER trigger_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trigger_properties_updated_at
    BEFORE UPDATE ON properties
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ================================================
-- UTILITY VIEWS
-- ================================================

-- Property listings with host and rating information
CREATE VIEW property_listings AS
SELECT 
    p.property_id,
    p.name,
    p.description,
    p.location,
    p.pricepernight,
    p.created_at,
    p.updated_at,
    u.first_name AS host_first_name,
    u.last_name AS host_last_name,
    u.email AS host_email,
    COALESCE(AVG(r.rating), 0) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM properties p
JOIN users u ON p.host_id = u.user_id
LEFT JOIN reviews r ON p.property_id = r.property_id
GROUP BY p.property_id, u.user_id, u.first_name, u.last_name, u.email;

-- Booking details with all related information
CREATE VIEW booking_details AS
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at,
    p.name AS property_name,
    p.location AS property_location,
    p.pricepernight,
    guest.first_name AS guest_first_name,
    guest.last_name AS guest_last_name,
    guest.email AS guest_email,
    host.first_name AS host_first_name,
    host.last_name AS host_last_name,
    host.email AS host_email,
    pay.payment_id,
    pay.payment_method,
    pay.payment_date
FROM bookings b
JOIN properties p ON b.property_id = p.property_id
JOIN users guest ON b.user_id = guest.user_id
JOIN users host ON p.host_id = host.user_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id;

-- ================================================
-- STORED PROCEDURES
-- ================================================

-- Function to check booking availability
CREATE OR REPLACE FUNCTION check_booking_availability(
    p_property_id UUID,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS BOOLEAN AS $$
DECLARE
    conflict_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO conflict_count
    FROM bookings
    WHERE property_id = p_property_id
    AND status IN ('confirmed', 'pending')
    AND (
        (start_date <= p_start_date AND end_date > p_start_date) OR
        (start_date < p_end_date AND end_date >= p_end_date) OR
        (start_date >= p_start_date AND end_date <= p_end_date)
    );
    
    RETURN (conflict_count = 0);
END;
$$ LANGUAGE plpgsql;

-- Function to calculate booking total price
CREATE OR REPLACE FUNCTION calculate_booking_price(
    p_property_id UUID,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS DECIMAL(12,2) AS $$
DECLARE
    nights INTEGER;
    price_per_night DECIMAL(10,2);
    total_price DECIMAL(12,2);
BEGIN
    -- Calculate number of nights
    nights := p_end_date - p_start_date;
    
    -- Get price per night
    SELECT pricepernight INTO price_per_night
    FROM properties
    WHERE property_id = p_property_id;
    
    -- Calculate total
    total_price := nights * price_per_night;
    
    RETURN total_price;
END;
$$ LANGUAGE plpgsql;

-- ================================================
-- COMMENTS FOR DOCUMENTATION
-- ================================================

COMMENT ON TABLE users IS 'User accounts for guests, hosts, and administrators';
COMMENT ON TABLE properties IS 'Property listings with details and pricing';
COMMENT ON TABLE bookings IS 'Booking reservations linking users and properties';
COMMENT ON TABLE payments IS 'Payment records for completed bookings';
COMMENT ON TABLE reviews IS 'User reviews and ratings for properties';
COMMENT ON TABLE messages IS 'Messages between users for communication';

COMMENT ON COLUMN users.role IS 'User role: guest, host, or admin';
COMMENT ON COLUMN bookings.status IS 'Booking status: pending, confirmed, or canceled';
COMMENT ON COLUMN payments.payment_method IS 'Payment method: credit_card, paypal, or stripe';
COMMENT ON COLUMN reviews.rating IS 'Rating from 1 to 5 stars';

-- ================================================
-- END OF SCHEMA
-- ================================================
