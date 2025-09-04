-- ================================================
-- AirBnB Database Sample Data - seed.sql
-- ================================================
-- Comprehensive sample data for testing and development
-- Version: 1.0
-- ================================================

-- Clear existing data (optional - use with caution in production)
-- TRUNCATE TABLE messages, reviews, payments, bookings, properties, users RESTART IDENTITY CASCADE;

-- ================================================
-- USERS DATA
-- ================================================

-- Insert sample users (guests, hosts, and admin)
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES

-- Guests
('550e8400-e29b-41d4-a716-446655440001', 'Alice', 'Johnson', 'alice.johnson@email.com', '$2b$10$K5x9v1Q2m3N4o5P6r7S8t9U0v1W2x3Y4z5A6b7C8d9E0f1G2h3I4j5', '+1-555-0101', 'guest', '2024-01-15 10:30:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Bob', 'Smith', 'bob.smith@email.com', '$2b$10$L6y0w2R3n4O5p6Q7r8S9t0U1v2W3x4Y5z6A7b8C9d0E1f2G3h4I5j6', '+1-555-0102', 'guest', '2024-01-20 14:15:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Carol', 'Davis', 'carol.davis@email.com', '$2b$10$M7z1x3S4o5P6q7R8s9T0u1V2w3X4y5Z6a7B8c9D0e1F2g3H4i5J6k7', '+1-555-0103', 'guest', '2024-02-01 09:45:00'),
('550e8400-e29b-41d4-a716-446655440004', 'David', 'Wilson', 'david.wilson@email.com', '$2b$10$N8a2y4T5p6Q7r8S9t0U1v2W3x4Y5z6A7b8C9d0E1f2G3h4I5j6K7l8', '+1-555-0104', 'guest', '2024-02-10 16:20:00'),
('550e8400-e29b-41d4-a716-446655440005', 'Emma', 'Brown', 'emma.brown@email.com', '$2b$10$O9b3z5U6q7R8s9T0u1V2w3X4y5Z6a7B8c9D0e1F2g3H4i5J6k7L8m9', '+1-555-0105', 'guest', '2024-02-15 11:10:00'),

-- Hosts
('550e8400-e29b-41d4-a716-446655440010', 'Frank', 'Miller', 'frank.miller@email.com', '$2b$10$P0c4a6V7r8S9t0U1v2W3x4Y5z6A7b8C9d0E1f2G3h4I5j6K7l8M9n0', '+1-555-0110', 'host', '2023-12-01 08:00:00'),
('550e8400-e29b-41d4-a716-446655440011', 'Grace', 'Taylor', 'grace.taylor@email.com', '$2b$10$Q1d5b7W8s9T0u1V2w3X4y5Z6a7B8c9D0e1F2g3H4i5J6k7L8m9N0o1', '+1-555-0111', 'host', '2023-11-15 12:30:00'),
('550e8400-e29b-41d4-a716-446655440012', 'Henry', 'Anderson', 'henry.anderson@email.com', '$2b$10$R2e6c8X9t0U1v2W3x4Y5z6A7b8C9d0E1f2G3h4I5j6K7l8M9n0O1p2', '+1-555-0112', 'host', '2023-10-20 15:45:00'),
('550e8400-e29b-41d4-a716-446655440013', 'Isabella', 'Thomas', 'isabella.thomas@email.com', '$2b$10$S3f7d9Y0u1V2w3X4y5Z6a7B8c9D0e1F2g3H4i5J6k7L8m9N0o1P2q3', '+1-555-0113', 'host', '2023-09-10 13:20:00'),
('550e8400-e29b-41d4-a716-446655440014', 'Jack', 'Jackson', 'jack.jackson@email.com', '$2b$10$T4g8e0Z1v2W3x4Y5z6A7b8C9d0E1f2G3h4I5j6K7l8M9n0O1p2Q3r4', '+1-555-0114', 'host', '2023-08-25 10:15:00'),

-- Admin
('550e8400-e29b-41d4-a716-446655440020', 'Admin', 'User', 'admin@airbnb.com', '$2b$10$U5h9f1A2w3X4y5Z6a7B8c9D0e1F2g3H4i5J6k7L8m9N0o1P2q3R4s5', '+1-555-0120', 'admin', '2023-01-01 00:00:00');

-- ================================================
-- PROPERTIES DATA
-- ================================================

INSERT INTO properties (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES

-- Frank Miller's properties
('660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Cozy Downtown Loft', 'Modern 1-bedroom loft in the heart of downtown. Perfect for business travelers and couples. Features exposed brick walls, high ceilings, and a fully equipped kitchen. Walking distance to restaurants, cafes, and public transportation.', 'New York, NY', 185.00, '2023-12-05 10:00:00', '2024-01-10 14:30:00'),

('660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440010', 'Sunny Garden Apartment', 'Bright and airy 2-bedroom apartment with a private garden. Ideal for families or groups of friends. Includes parking, WiFi, and a barbecue area. Located in a quiet residential neighborhood with easy access to downtown.', 'Brooklyn, NY', 125.00, '2023-12-10 15:20:00', '2024-02-05 11:15:00'),

-- Grace Taylor's properties
('660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440011', 'Beachfront Villa', 'Luxurious 4-bedroom villa with stunning ocean views. Private beach access, infinity pool, and outdoor dining area. Perfect for special occasions and group vacations. Fully staffed with daily housekeeping and concierge service.', 'Miami Beach, FL', 450.00, '2023-11-20 09:30:00', '2024-01-15 16:45:00'),

('660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440011', 'Mountain Cabin Retreat', 'Rustic log cabin nestled in the mountains. 3 bedrooms, fireplace, and hot tub on the deck. Great for hiking enthusiasts and nature lovers. Fully equipped kitchen and game room for family entertainment.', 'Aspen, CO', 275.00, '2023-11-25 12:00:00', '2024-02-20 09:20:00'),

-- Henry Anderson's properties
('660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440012', 'Historic Townhouse', 'Beautiful Victorian townhouse in historic district. 3 bedrooms, original hardwood floors, and period furnishings. Walking distance to museums, galleries, and fine dining. Perfect blend of historic charm and modern amenities.', 'San Francisco, CA', 220.00, '2023-10-25 14:15:00', '2024-01-30 10:40:00'),

('660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440012', 'Modern City Studio', 'Sleek studio apartment in trendy neighborhood. Floor-to-ceiling windows, contemporary design, and rooftop access. Ideal for solo travelers and digital nomads. High-speed internet and co-working space available.', 'Seattle, WA', 95.00, '2023-11-01 11:30:00', '2024-02-10 13:25:00'),

-- Isabella Thomas's properties
('660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440013', 'Lakeside Cottage', 'Charming cottage on private lake. 2 bedrooms, dock access, and canoe included. Peaceful retreat surrounded by nature. Perfect for fishing, swimming, and relaxation. Fire pit and outdoor seating for evening gatherings.', 'Lake Tahoe, CA', 180.00, '2023-09-15 08:45:00', '2024-01-20 15:10:00'),

-- Jack Jackson's properties
('660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440014', 'Urban Penthouse', 'Luxury penthouse with panoramic city views. 2 bedrooms, 2 bathrooms, and private terrace. Premium location in financial district. Concierge service, gym access, and valet parking included. Perfect for executive stays.', 'Chicago, IL', 350.00, '2023-08-30 16:20:00', '2024-02-25 12:05:00'),

('660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440014', 'Cozy Suburban Home', 'Family-friendly 3-bedroom house in quiet suburb. Large backyard, playground nearby, and excellent schools. Perfect for families visiting the area. Full kitchen, laundry facilities, and parking for two cars.', 'Austin, TX', 140.00, '2023-09-05 13:40:00', '2024-02-15 14:55:00');

-- ================================================
-- BOOKINGS DATA
-- ================================================

INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES

-- Confirmed bookings (past and current)
('770e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '2024-03-01', '2024-03-05', 740.00, 'confirmed', '2024-02-15 09:30:00'),
('770e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', '2024-02-20', '2024-02-25', 2250.00, 'confirmed', '2024-02-05 14:20:00'),
('770e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', '2024-01-15', '2024-01-20', 1100.00, 'confirmed', '2024-01-01 10:15:00'),
('770e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004', '2024-02-10', '2024-02-14', 720.00, 'confirmed', '2024-01-25 16:45:00'),
('770e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440005', '2024-03-10', '2024-03-17', 875.00, 'confirmed', '2024-02-20 11:30:00'),

-- Pending bookings (future)
('770e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440001', '2024-12-15', '2024-12-18', 1050.00, 'pending', '2024-11-20 13:25:00'),
('770e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', '2024-12-20', '2024-12-27', 1925.00, 'pending', '2024-11-15 09:40:00'),
('770e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', '2024-12-01', '2024-12-08', 665.00, 'pending', '2024-11-10 15:10:00'),

-- Cancelled bookings
('770e8400-e29b-41d4-a716-446655440009', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440004', '2024-02-01', '2024-02-03', 370.00, 'canceled', '2024-01-20 12:00:00'),
('770e8400-e29b-41d4-a716-446655440010', '660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440005', '2024-01-25', '2024-01-30', 700.00, 'canceled', '2024-01-10 14:30:00'),

-- Additional confirmed bookings for more realistic data
('770e8400-e29b-41d4-a716-446655440011', '660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', '2024-01-05', '2024-01-12', 665.00, 'confirmed', '2023-12-20 10:45:00'),
('770e8400-e29b-41d4-a716-446655440012', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', '2024-02-28', '2024-03-03', 1050.00, 'confirmed', '2024-02-10 08:20:00'),
('770e8400-e29b-41d4-a716-446655440013', '660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440002', '2024-03-20', '2024-03-25', 700.00, 'confirmed', '2024-03-05 16:15:00');

-- ================================================
-- PAYMENTS DATA
-- ================================================

INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method) VALUES

-- Payments for confirmed bookings only
('880e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440001', 740.00, '2024-02-15 09:45:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440002', 2250.00, '2024-02-05 14:35:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440003', 1100.00, '2024-01-01 10:30:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440004', 720.00, '2024-01-25 17:00:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440005', 875.00, '2024-02-20 11:45:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440011', '770e8400-e29b-41d4-a716-446655440011', 665.00, '2023-12-20 11:00:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440012', '770e8400-e29b-41d4-a716-446655440012', 1050.00, '2024-02-10 08:35:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440013', '770e8400-e29b-41d4-a716-446655440013', 700.00, '2024-03-05 16:30:00', 'stripe');

-- ================================================
-- REVIEWS DATA
-- ================================================

INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at) VALUES

-- Reviews for completed stays
('990e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 5, 'Amazing downtown loft! The location was perfect for exploring the city. Frank was an excellent host - very responsive and helpful. The apartment was exactly as described, clean, and well-equipped. Would definitely stay again!', '2024-03-06 14:20:00'),

('990e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 5, 'Absolutely stunning beachfront villa! The ocean views were breathtaking and the private beach access was incredible. Grace thought of everything - the place was luxurious and the service was top-notch. Perfect for our anniversary celebration!', '2024-02-26 10:15:00'),

('990e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', 4, 'Beautiful historic townhouse with so much character! The Victorian architecture and period furnishings were delightful. Location in the historic district was perfect for sightseeing. Only minor issue was the WiFi could be faster, but overall excellent stay.', '2024-01-21 16:30:00'),

('990e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004', 5, 'The lakeside cottage was a perfect peaceful retreat! Waking up to the lake view every morning was magical. The canoe was a nice touch and we enjoyed fishing from the dock. Isabella was very welcoming and the cottage had everything we needed.', '2024-02-15 09:45:00'),

('990e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440005', 4, 'Great family-friendly apartment! The private garden was perfect for our kids to play, and the neighborhood was quiet and safe. The barbecue area was well-maintained and we enjoyed cooking outdoors. Frank was very accommodating with our late check-in.', '2024-03-18 12:10:00'),

('990e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 4, 'Clean and modern studio in a great location! Perfect for my business trip. The rooftop access was a nice bonus for morning coffee. Henry provided excellent local recommendations. The only downside was some street noise at night, but overall very satisfied.', '2024-01-13 18:25:00'),

('990e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', 5, 'Luxury penthouse exceeded all expectations! The city views from the terrace were spectacular, especially at sunset. Jack was an attentive host and the concierge service was excellent. Perfect location for business meetings downtown. Highly recommended!', '2024-03-04 20:00:00'),

('990e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440002', 4, 'Wonderful family home in a great neighborhood! The kids loved the big backyard and the playground nearby was very convenient. The house was spacious and well-equipped. Jack was responsive to all our questions. Would be perfect for future family visits.', '2024-03-26 11:40:00'),

-- Additional reviews for properties with multiple stays
('990e8400-e29b-41d4-a716-446655440009', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440003', 4, 'Second time staying at this loft and it continues to impress! Great location for exploring downtown and the space is very comfortable. Frank maintains the property well and communication is always excellent. Minor suggestion: could use a coffee machine upgrade.', '2024-01-22 15:50:00'),

('990e8400-e29b-41d4-a716-446655440010', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440002', 3, 'Nice penthouse but had some issues with the heating during our stay. The views are amazing and Jack was quick to respond to our concerns. The location is unbeatable for business travelers. Would consider staying again if the heating issue is resolved.', '2024-01-15 13:30:00');

-- ================================================
-- MESSAGES DATA
-- ================================================

INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at) VALUES

-- Pre-booking inquiries and host responses
('aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Hi Frank! I''m interested in booking your downtown loft for March 1-5. Is it available? Also, is there parking available nearby?', '2024-02-14 16:30:00'),

('aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'Hello Alice! Yes, the loft is available for those dates. There''s a parking garage just 2 blocks away with daily rates around $25. The loft is perfect for exploring downtown - you''ll love it! Feel free to book anytime.', '2024-02-14 17:15:00'),

('aa0e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Perfect! Just booked. Could you send me the check-in instructions? Also, any restaurant recommendations in the area?', '2024-02-15 09:45:00'),

('aa0e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'Great! I''ll send check-in details closer to your arrival. For restaurants, I highly recommend Tony''s Italian (2 blocks north) and Sunset Rooftop Bar (amazing city views). Welcome to the neighborhood!', '2024-02-15 10:20:00'),

-- Guest-host communication during stay
('aa0e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', 'Hi Grace! We just arrived at the villa and it''s absolutely gorgeous! Quick question - how do we turn on the pool lights for the evening?', '2024-02-20 19:30:00'),

('aa0e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440002', 'So happy you love it! The pool light switch is in the outdoor kitchen area, near the barbecue. There''s also a remote control on the coffee table in the living room. Enjoy your evening!', '2024-02-20 19:45:00'),

-- Post-stay follow-up
('aa0e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'Hi Alice! Hope you had a wonderful stay at the loft. Would love to hear about your experience. Thanks for being such a considerate guest!', '2024-03-06 10:00:00'),

('aa0e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Thank you Frank! We had an amazing time. Just left a 5-star review. Your place is perfect and you''re a fantastic host. Will definitely recommend to friends!', '2024-03-06 14:30:00'),

-- Booking inquiries for future dates
('aa0e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440012', 'Hello Henry! I''m planning a work trip to Seattle in December. Is your city studio available Dec 1-8? I need good WiFi for video calls.', '2024-11-10 14:45:00'),

('aa0e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440003', 'Hi Carol! The studio is available for those dates. It has high-speed fiber internet (100+ Mbps) perfect for video calls. The workspace is set up for remote work. Would you like to book?', '2024-11-10 15:20:00'),

-- Host-to-host communication (referrals)
('aa0e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440011', 'Hey Grace! I have a guest looking for a luxury beachfront property in Miami for their anniversary. Thought of your villa - can I refer them to you?', '2024-01-30 11:15:00'),

('aa0e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440010', 'Absolutely Frank! I''d love the referral. The villa is perfect for special occasions. Have them mention your referral and I''ll give them a welcome basket. Thanks!', '2024-01-30 12:00:00'),

-- Customer service inquiries to admin
('aa0e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440020', 'Hi Admin, I had a booking that was cancelled due to a property emergency. Can you help me find an alternative property for the same dates? My booking was #770e8400-e29b-41d4-a716-446655440009.', '2024-01-21 09:30:00'),

('aa0e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440004', 'Hello David, I''m sorry about the cancellation. I''ve reviewed your original booking and found 3 similar properties available for Feb 1-3. I''ll send you the options via email with a 15% discount for the inconvenience. Our customer success team will follow up within 2 hours.', '2024-01-21 10:15:00'),

-- Support request from host
('aa0e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440020', 'Hello, I need help updating my property photos and description. The current images don''t show the recent renovations I completed. Can someone from the support team assist me?', '2024-02-15 13:45:00'),

('aa0e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440013', 'Hi Isabella! I''d be happy to help you update your listing. Our property specialist will contact you within 24 hours to schedule a photo session and review your description updates. Updated listings typically see 25% more bookings!', '2024-02-15 14:30:00'),

-- Guest inquiry about amenities
('aa0e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440014', 'Hi Jack! I''m interested in your penthouse for a business trip. Does it have a dedicated workspace and printer? Also, is room service available from the building?', '2024-11-18 08:20:00'),

('aa0e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440005', 'Hello Emma! Yes, the penthouse has a dedicated office space with a printer/scanner combo. Room service is available 24/7 through the building concierge - I''ll provide the menu upon booking. Perfect setup for business travelers!', '2024-11-18 09:10:00'),

-- Thank you message after positive experience
('aa0e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', 'Grace, we''re back home now but still dreaming about that incredible villa! Thank you for making our anniversary so special. The sunset views from the infinity pool were unforgettable. You''re an amazing host!', '2024-02-27 20:00:00'),

('aa0e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440002', 'Bob, your message absolutely made my day! It brings me so much joy to know the villa helped create beautiful memories for you both. Congratulations again on your anniversary, and please consider the villa your home away from home anytime!', '2024-02-27 21:15:00');

-- ================================================
-- ADDITIONAL SAMPLE DATA FOR TESTING
-- ================================================

-- More bookings for December 2024 (future bookings for testing availability)
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('770e8400-e29b-41d4-a716-446655440014', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440004', '2024-12-01', '2024-12-05', 740.00, 'pending', '2024-11-15 14:20:00'),
('770e8400-e29b-41d4-a716-446655440015', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440005', '2024-12-10', '2024-12-15', 1100.00, 'confirmed', '2024-11-01 10:30:00'),
('770e8400-e29b-41d4-a716-446655440016', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', '2024-12-22', '2024-12-28', 2700.00, 'pending', '2024-11-20 16:45:00');

-- Payments for additional confirmed bookings
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('880e8400-e29b-41d4-a716-446655440014', '770e8400-e29b-41d4-a716-446655440015', 1100.00, '2024-11-01 10:45:00', 'credit_card');



SELECT 'Sample data insertion completed successfully!' as status;
