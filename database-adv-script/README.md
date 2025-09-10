Complex SQL Joins for AirBnB Database
This directory contains advanced SQL queries demonstrating different types of joins and complex query patterns for the AirBnB database system.
Files

joins_queries.sql - Complete collection of SQL join queries
README.md - This documentation file

Query Types Covered
1. INNER JOIN
Query 1: All bookings with respective users

Retrieves booking information along with the user details who made the booking
Only returns records where both booking and user exist
Useful for analyzing booking patterns with customer information

2. LEFT JOIN
Query 2: All properties and their reviews

Retrieves all properties along with their reviews
Includes properties that have no reviews (NULL values for review fields)
Essential for property analysis including unreviewed properties

3. FULL OUTER JOIN
Query 3: All users and all bookings

Retrieves all users and all bookings, regardless of relationships
Shows users without bookings and any orphaned bookings
Useful for data completeness analysis
