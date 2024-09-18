

-- Enable extension for UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Drop tables if they exist
DROP TABLE IF EXISTS h_tracker;
DROP TABLE IF EXISTS h_habit;

-- Create table: h_habit
CREATE TABLE h_habit (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), 
    user_id UUID NOT NULL, 
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    created_by UUID NOT NULL, 
    active_yn BOOLEAN DEFAULT TRUE,  
    short_name VARCHAR(100) NOT NULL,  
    long_name VARCHAR(255)  
);

-- Insert sample data into h_habit for user_id: 9b2db878-88cc-4100-87c8-65eac1a74003

INSERT INTO h_habit (id, user_id, created_date, updated_date, created_by, active_yn, short_name, long_name)
VALUES
    (gen_random_uuid(), '9b2db878-88cc-4100-87c8-65eac1a74003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE, 'Exercise', 'Daily workout to stay fit'),
    (gen_random_uuid(), '9b2db878-88cc-4100-87c8-65eac1a74003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE, 'Reading', 'Read 30 minutes a day'),
    (gen_random_uuid(), '9b2db878-88cc-4100-87c8-65eac1a74003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE, 'Meditation', '10-minute morning meditation'),
    (gen_random_uuid(), '9b2db878-88cc-4100-87c8-65eac1a74003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE, 'Coding', 'Work on side projects for 1 hour daily'),
    (gen_random_uuid(), '9b2db878-88cc-4100-87c8-65eac1a74003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE, 'Sleep', 'Get 8 hours of sleep every night');

-- Create table: h_tracker
CREATE TABLE h_tracker (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), 
    user_id UUID NOT NULL,  
    habit_id UUID NOT NULL,  
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    created_by  UUID NOT NULL, 
    active_yn BOOLEAN DEFAULT TRUE  
);

-- Insert multiple rows into h_tracker for a specific user_id and varying habit_ids

-- Sample date range

INSERT INTO h_tracker (user_id, habit_id, created_date, updated_date, created_by, active_yn) VALUES
-- Date: 2024-09-14
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Exercise'), '2024-09-14', '2024-09-14', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Reading'), '2024-09-14', '2024-09-14', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Meditation'), '2024-09-14', '2024-09-14', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Coding'), '2024-09-14', '2024-09-14', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Sleep'), '2024-09-14', '2024-09-14', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),

-- Date: 2024-09-15
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Exercise'), '2024-09-15', '2024-09-15', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Reading'), '2024-09-15', '2024-09-15', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Meditation'), '2024-09-15', '2024-09-15', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Coding'), '2024-09-15', '2024-09-15', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Sleep'), '2024-09-15', '2024-09-15', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),

-- Date: 2024-09-16
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Exercise'), '2024-09-16', '2024-09-16', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Reading'), '2024-09-16', '2024-09-16', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Meditation'), '2024-09-16', '2024-09-16', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Coding'), '2024-09-16', '2024-09-16', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Sleep'), '2024-09-16', '2024-09-16', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),

-- Date: 2024-09-17
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Exercise'), '2024-09-17', '2024-09-17', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Reading'), '2024-09-17', '2024-09-17', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Meditation'), '2024-09-17', '2024-09-17', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Coding'), '2024-09-17', '2024-09-17', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE),
('9b2db878-88cc-4100-87c8-65eac1a74003', (SELECT id FROM h_habit WHERE short_name = 'Sleep'), '2024-09-17', '2024-09-17', 'd9bd9d74-6a32-404a-9339-ffd2ad0627ab', TRUE);


SELECT * FROM h_user;
SELECT * FROM h_habit;
SELECT * FROM h_tracker;