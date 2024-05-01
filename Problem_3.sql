--Tree Node

SELECT id, 'Root' As type FROM Tree where p_id IS NULL
UNION
SELECT id, 'Inner' AS type FROM Tree WHERE id IN(
    SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL
)AND p_id IS NOT NULL
UNION
SELECT id, 'Leaf' AS type FROM Tree WHERE id NOT IN (
    SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL
)AND p_id IS NOT NULL;

--flow control statement method

SELECT id,(
    CASE 
        WHEN p_id IS null THEN 'Root'
        WHEN id NOT IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END
) AS 'type' FROM Tree ORDER BY id;

--Using If statement

SELECT atree.id, 
    IF(ISNULL(atree.p_id), 'Root',
        IF(atree.id IN (SELECT DISTINCT p_id FROM tree WHERE p_id IS NOT NULL), 'Inner', 'Leaf')
    ) AS 'type'
FROM tree AS atree;