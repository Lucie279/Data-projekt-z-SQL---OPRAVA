-- OTÁZKA 2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
WITH prumerne_mzdy AS (
    SELECT 
        rok,
        AVG(prumerna_mzda)::numeric AS prumerna_mzda
    FROM t_lucie_mendlikova_project_sql_primary_final
    GROUP BY rok
),

ceny_chleba AS (
    SELECT 
        rok,
        AVG(prumerna_cena)::numeric AS cena_chleba
    FROM t_lucie_mendlikova_project_sql_primary_final
    WHERE potravina ILIKE '%chléb%'
    GROUP BY rok
),

ceny_mleka AS (
    SELECT 
        rok,
        AVG(prumerna_cena)::numeric AS cena_mleka
    FROM t_lucie_mendlikova_project_sql_primary_final
    WHERE potravina ILIKE '%mléko%'
    GROUP BY rok
),

slouceno AS (
    SELECT
        m.rok,
        m.prumerna_mzda,
        c.cena_chleba,
        ml.cena_mleka
    FROM prumerne_mzdy m
    JOIN ceny_chleba c USING (rok)
    JOIN ceny_mleka ml USING (rok)
)

SELECT
    rok,
    ROUND(prumerna_mzda, 0) AS prumerna_mzda,
    ROUND(cena_chleba, 2) AS cena_chleba,
    ROUND(cena_mleka, 2) AS cena_mleka,

    -- Kupní síla průměrné mzdy
    ROUND(prumerna_mzda / cena_chleba, 0) AS kg_chleba,
    ROUND(prumerna_mzda / cena_mleka, 0) AS litry_mleka

FROM slouceno
WHERE rok IN (
    (SELECT MIN(rok) FROM slouceno),
    (SELECT MAX(rok) FROM slouceno)
)
ORDER BY rok;