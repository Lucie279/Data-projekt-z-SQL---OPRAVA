-- OTÁZKA 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
-- projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
WITH hdp_yoy AS (
    SELECT
        rok,
        hdp,
        LAG(hdp) OVER (ORDER BY rok) AS prev_hdp,
        ROUND(
            (
                (hdp - LAG(hdp) OVER (ORDER BY rok))
                / NULLIF(LAG(hdp) OVER (ORDER BY rok), 0)
            )::numeric * 100
        , 2) AS rust_hdp_pct
    FROM t_lucie_mendlikova_project_sql_secondary_final
    WHERE stat = 'Czech Republic'
),

mzdy AS (
    SELECT
        rok,
        AVG(prumerna_mzda)::numeric AS avg_mzda
    FROM t_lucie_mendlikova_project_sql_primary_final
    GROUP BY rok
),

mzdy_yoy AS (
    SELECT
        rok,
        avg_mzda,
        LAG(avg_mzda) OVER (ORDER BY rok) AS prev_mzda,
        ROUND(
            (
                (avg_mzda - LAG(avg_mzda) OVER (ORDER BY rok))
                / NULLIF(LAG(avg_mzda) OVER (ORDER BY rok), 0)
            )::numeric * 100
        , 2) AS rust_mzdy_pct
    FROM mzdy
),

ceny AS (
    SELECT
        rok,
        AVG(prumerna_cena)::numeric AS avg_cena
    FROM t_lucie_mendlikova_project_sql_primary_final
    GROUP BY rok
),

ceny_yoy AS (
    SELECT
        rok,
        avg_cena,
        LAG(avg_cena) OVER (ORDER BY rok) AS prev_cena,
        ROUND(
            (
                (avg_cena - LAG(avg_cena) OVER (ORDER BY rok))
                / NULLIF(LAG(avg_cena) OVER (ORDER BY rok), 0)
            )::numeric * 100
        , 2) AS rust_cen_pct
    FROM ceny
)

SELECT
    h.rok,
    h.rust_hdp_pct,
    m.rust_mzdy_pct,
    c.rust_cen_pct
FROM hdp_yoy h
LEFT JOIN mzdy_yoy m USING (rok)
LEFT JOIN ceny_yoy c USING (rok)
ORDER BY rok;