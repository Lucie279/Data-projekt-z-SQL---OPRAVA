-- OTÁZKA 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
WITH ceny AS (
    SELECT
        rok,
        AVG(prumerna_cena)::numeric AS avg_cena
    FROM t_lucie_mendlikova_project_sql_primary_final
    GROUP BY rok
),

mzdy AS (
    SELECT
        rok,
        AVG(prumerna_mzda)::numeric AS avg_mzda
    FROM t_lucie_mendlikova_project_sql_primary_final
    GROUP BY rok
),

ceny_yoy AS (
    SELECT
        rok,
        avg_cena,
        LAG(avg_cena) OVER (ORDER BY rok) AS prev_cena,
        ((avg_cena - LAG(avg_cena) OVER (ORDER BY rok))
         / NULLIF(LAG(avg_cena) OVER (ORDER BY rok), 0)) * 100
            AS rust_cen_pct
    FROM ceny
),

mzdy_yoy AS (
    SELECT
        rok,
        avg_mzda,
        LAG(avg_mzda) OVER (ORDER BY rok) AS prev_mzda,
        ((avg_mzda - LAG(avg_mzda) OVER (ORDER BY rok))
         / NULLIF(LAG(avg_mzda) OVER (ORDER BY rok), 0)) * 100
            AS rust_mezd_pct
    FROM mzdy
),

spojene AS (
    SELECT
        c.rok,
        ROUND(c.rust_cen_pct, 2) AS rust_cen_pct,
        ROUND(m.rust_mezd_pct, 2) AS rust_mezd_pct,
        ROUND((c.rust_cen_pct - m.rust_mezd_pct)::numeric, 2) AS rozdil
    FROM ceny_yoy c
    JOIN mzdy_yoy m USING (rok)
)

SELECT
    rok,
    rust_cen_pct,
    rust_mezd_pct,
    rozdil
FROM spojene
ORDER BY rok;