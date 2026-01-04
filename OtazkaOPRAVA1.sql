-- OTÁZKA 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
WITH mzdy AS (
    SELECT 
        odvetvi,
        rok,
        AVG(prumerna_mzda) AS prumerna_mzda
    FROM t_lucie_mendlikova_project_sql_primary_final
   	 GROUP BY odvetvi, rok
),

zmeny AS (
    SELECT
        odvetvi,
        rok,
        prumerna_mzda,
        prumerna_mzda
            - LAG(prumerna_mzda) OVER (
                PARTITION BY odvetvi
                ORDER BY rok
            ) AS mezirocni_zmena
    FROM mzdy
)

-- Výstup omezený pouze na případy poklesu mezd
SELECT
    odvetvi,
    rok,
    ROUND(prumerna_mzda, 0) AS prumerna_mzda,
    ROUND(mezirocni_zmena, 0) AS mezirocni_zmena
FROM zmeny
WHERE mezirocni_zmena < 0
ORDER BY rok, odvetvi;