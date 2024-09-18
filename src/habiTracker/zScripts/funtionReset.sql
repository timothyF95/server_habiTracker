DROP FUNCTION IF EXISTS get_tracker_habits(UUID, TIMESTAMP);

CREATE OR REPLACE FUNCTION get_tracker_habits(
    p_user_id UUID,
    p_current_date TIMESTAMP
)
RETURNS TABLE (
    created_date TIMESTAMP,
    short_name VARCHAR,
    long_name VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        ht.created_date,
        hh.short_name,
        hh.long_name
    FROM h_tracker ht
    INNER JOIN h_habit hh ON ht.habit_id = hh.id
    WHERE ht.user_id = p_user_id
    AND EXTRACT(MONTH FROM ht.created_date) = EXTRACT(MONTH FROM p_current_date)
    AND EXTRACT(YEAR FROM ht.created_date) = EXTRACT(YEAR FROM p_current_date)
    AND ht.active_yn = TRUE
    ORDER BY ht.created_date;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_tracker_habits(
    '9b2db878-88cc-4100-87c8-65eac1a74003',
    '2024-09-18 20:25:54.280475'
);


DROP FUNCTION IF EXISTS insert_tracker_record(UUID, UUID, UUID, BOOLEAN);


CREATE OR REPLACE FUNCTION insert_tracker_record(
    p_user_id UUID,
    p_habit_id UUID,
    p_created_by UUID,
    p_active_yn BOOLEAN
)
RETURNS VOID AS $$
BEGIN
    
    IF NOT EXISTS (
        SELECT 1
        FROM h_tracker
        WHERE user_id = p_user_id
        AND habit_id = p_habit_id
        AND created_date::date = CURRENT_DATE 
    ) THEN
        INSERT INTO h_tracker (
            user_id,
            habit_id,
            created_date,
            updated_date,
            created_by,
            active_yn
        ) 
        VALUES (
            p_user_id,
            p_habit_id,
            CURRENT_TIMESTAMP, 
            CURRENT_TIMESTAMP, 
            p_created_by,
            p_active_yn
        );
    END IF;
END;
$$ LANGUAGE plpgsql;



-- SELECT insert_tracker_record(
--     '9b2db878-88cc-4100-87c8-65eac1a74003',
--     '6dc10476-b936-4aba-abcf-00148618e4d4',
--     '2024-09-18 20:25:54',
--     'd9bd9d74-6a32-404a-9339-ffd2ad0627ab',
--     TRUE
-- );