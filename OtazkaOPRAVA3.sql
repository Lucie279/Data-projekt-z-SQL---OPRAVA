-- OTÁZKA 3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
WITH ceny AS (
    SELECT 
        potravina,
        rok,
        AVG(prumerna_cena)::numeric AS cena
    FROM t_lucie_mendlikova_project_sql_primary_final
    GROUP BY potravina, rok
),

mezizmena AS (
    SELECT
        potravina,
        rok,
        cena,
        LAG(cena) OVER (PARTITION BY potravina ORDER BY rok) AS cena_pred,
        (
            (cena - LAG(cena) OVER (PARTITION BY potravina ORDER BY rok))
            / NULLIF(LAG(cena) OVER (PARTITION BY potravina ORDER BY rok), 0)
        ) * 100 AS pct_zmena
    FROM ceny
)

SELECT 
    potravina,
    ROUND(AVG(pct_zmena)::numeric, 2) AS prumerny_percentualni_rust
FROM mezizmena
WHERE pct_zmena > 0              -- jen zdražování
GROUP BY potravina
ORDER BY prumerny_percentualni_rust ASC
LIMIT 1;