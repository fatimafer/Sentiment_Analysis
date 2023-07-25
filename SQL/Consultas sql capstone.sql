SELECT * 
FROM amazon_review;

SELECT *
FROM amazon_sentiment;

SELECT *
FROM word_ranking;



# 1. Total de comentarios positivos, negativos y neutros en total
SELECT
    SUM(CASE WHEN RT LIKE 'Positive' THEN 1 ELSE 0 END) AS total_comentarios_positivos,
    SUM(CASE WHEN RT LIKE 'Negative' THEN 1 ELSE 0 END) AS total_comentarios_negativos,
    SUM(CASE WHEN RT LIKE 'Neutral' THEN 1 ELSE 0 END) AS total_comentarios_neutros
FROM amazon_review;


# 2. Total de comentarios positivos, negativos y neutros según la zona del cliente 
SELECT zone,
  SUM(CASE WHEN RT LIKE 'Positive' THEN 1 ELSE 0 END) AS total_comentarios_positivos,
  SUM(CASE WHEN RT LIKE 'Negative' THEN 1 ELSE 0 END) AS total_comentarios_negativos,
  SUM(CASE WHEN RT LIKE 'Neutral' THEN 1 ELSE 0 END) AS total_comentarios_neutros
FROM (
  SELECT RT, zone
  FROM amazon_review
) AS comentarios
GROUP by zone;


# 3. TOP5 de las palabras más repetidas
SELECT palabras, repeticiones
FROM word_ranking
ORDER BY repeticiones DESC
LIMIT 5;


# 4. TOP5 de las palabras menos repetidas
SELECT palabras, repeticiones
FROM word_ranking
ORDER BY repeticiones ASC
LIMIT 5;


# 5. Total comentarios según la estación del año
SELECT season, COUNT(*) AS total_comentarios
FROM amazon_review
GROUP BY season
ORDER BY total_comentarios DESC;


# 6. Tipo de comentario (positivo, negativo o neutro) según la estación del año en la que se escribió
SELECT season,
    SUM(CASE WHEN RT = 'Positive' THEN 1 ELSE 0 END) AS total_comentarios_positivos,
    SUM(CASE WHEN RT = 'Negative' THEN 1 ELSE 0 END) AS total_comentarios_negativos,
    SUM(CASE WHEN RT = 'Neutral' THEN 1 ELSE 0 END) AS total_comentarios_neutros
FROM amazon_review
GROUP BY season
ORDER BY season DESC;


# 7. TOP3 años con más comentarios
SELECT year, COUNT(*) AS total_comentarios
FROM amazon_review
GROUP BY year
ORDER BY total_comentarios DESC
LIMIT 3;


# 8. TOP3 años con menos comentarios
SELECT year, COUNT(*) AS total_comentarios
FROM amazon_review
GROUP BY year
ORDER BY total_comentarios ASC
LIMIT 3;


# 9. Del total de comentarios calificados como positivos, cuántos fueron útiles y cuántos no para otros clientes
SELECT
    SUM(CASE WHEN RT = 'Positive' THEN 1 ELSE 0 END) AS total_comentarios_positivos,
    SUM(CASE WHEN RT = 'Positive' AND found_helpful = 1 THEN 1 ELSE 0 END) AS positivos_encontrados_útiles,
    SUM(CASE WHEN RT = 'Positive' AND found_helpful = 0 THEN 1 ELSE 0 END) AS positivos_encontrados_no_útiles
FROM amazon_review;


# 10. Del total de comentarios calificados como negativos, cuántos fueron útiles y cuántos no para otros clientes
SELECT
    SUM(CASE WHEN RT = 'Negative' THEN 1 ELSE 0 END) AS total_comentarios_negativos,
    SUM(CASE WHEN RT = 'Negative' AND found_helpful = 1 THEN 1 ELSE 0 END) AS negativos_encontrados_útiles,
    SUM(CASE WHEN RT = 'Negative' AND found_helpful = 0 THEN 1 ELSE 0 END) AS negativos_encontrados_no_útiles
FROM amazon_review;