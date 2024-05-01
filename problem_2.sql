--Exchange seats 
-- Flow control method
SELECT (
    CASE
        WHEN MOD(id, 2) != 0 AND id != cnts THEN id + 1
        WHEN MOD(id, 2) != 0 AND id = cnts THEN id
        ELSE id - 1
    END
) AS id, student
FROM Seat,(SELECT COUNT(*) AS cnts FROM Seat) AS seat_counts
ORDER BY id;

--Bitwise expression
SELECT s1.id, COALESCE(s2.student, s1.student) AS student 
FROM Seat s1 
LEFT JOIN Seat s2 ON (s1.id + 1) ^ 1 - 1 = s2.id  -- using (x + 1) ^ 1 - 1
ORDER BY s1.id;
