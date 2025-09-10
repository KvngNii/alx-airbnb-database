-- This file contains complex queries using different types of joins
-- to demonstrate advanced SQL techniques for the AirBnB database

-- ================================================
-- 1. INNER JOIN: Retrieve all bookings with respective users
-- ================================================
-- Objective: Get all bookings along with the user information who made those bookings
-- This query will only return bookings that have a corresponding user (inner join)

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status as booking_status,
    b.created_at as booking_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
ORDER BY b.created_at DESC;

-- ================================================
-- 2. LEFT JOIN: Retrieve all properties and their reviews
-- ================================================
-- Objective: Get all properties along with their reviews, including properties with no reviews
-- This query will return all properties, even if they don't have any reviews

SELECT 
    p.property_id,
    p.name as property_name,
    p.location,
    p.pricepernight,
    p.description,
    host.first_name as host_first_name,
    host.last_name as host_last_name,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at as review_date,
    reviewer.first_name as reviewer_first_name,
    reviewer.last_name as reviewer_last_name
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id
LEFT JOIN users host ON p.host_id = host.user_id
LEFT JOIN users reviewer ON r.user_id = reviewer.user_id
ORDER BY p.property_id, r.created_at DESC;

-- ================================================
-- 3. FULL OUTER JOIN: Retrieve all users and all bookings
-- ================================================
-- Objective: Get all users and all bookings, even if a user has no bookings 
-- or a booking is not linked to a user (orphaned data)
-- Note: PostgreSQL supports FULL OUTER JOIN, but this scenario is rare in practice
-- due to foreign key constraints

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    u.created_at as user_registered_date,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status as booking_status,
    b.created_at as booking_date
FROM users u
FULL OUTER JOIN bookings b ON u.user_id = b.user_id
ORDER BY u.user_id, b.created_at DESC;
