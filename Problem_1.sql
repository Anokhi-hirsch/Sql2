--Rank scores

-- Using window function DENSE_RANK()
SELECT S.Score, DENSE_RANK() OVER (ORDER BY S.Score DESC) AS 'rank'
FROM Scores S;


--Using correlated subquery
SELECT S1.score,(SELECT COUNT(DISTINCT S2.score)FROM Scores S2 WHERE S2.score >= S1.score) AS 'rank'
FROM Scores S1 ORDER BY S1.score DESC;

--Using inner join
SELECT S.score, COUNT(DISTINCT T.score) AS 'rank'
FROM Scores S
INNER JOIN Scores T ON S.score <= T.score
GROUP BY S.id, S.score
ORDER BY S.score DESC;
