-- pomocná tabulka: roky, ve kterých máme jak mzdy, tak ceny
DROP TABLE IF EXISTS spolecne_roky;

CREATE TABLE spolecne_roky AS
SELECT DISTINCT p.payroll_year AS rok
FROM czechia_payroll p
WHERE p.payroll_year IN (
    SELECT DISTINCT EXTRACT(YEAR FROM pr.date_from)::int
    FROM czechia_price pr
)
ORDER BY rok;

-- kontrola
SELECT * FROM spolecne_roky;


-- primární tabulka: mzdy + ceny potravin v jednom přehledu
DROP TABLE IF EXISTS t_lucie_mendlikova_project_sql_primary_final;

CREATE TABLE t_lucie_mendlikova_project_sql_primary_final AS
SELECT 
    p.payroll_year AS rok,
    ib.name AS odvetvi,
    AVG(p.value) AS prumerna_mzda,
    pc.name AS potravina,
    AVG(pr.value) AS prumerna_cena
FROM czechia_payroll p
JOIN czechia_payroll_industry_branch ib 
    ON p.industry_branch_code = ib.code
JOIN czechia_payroll_calculation calc 
    ON p.calculation_code = calc.code
JOIN czechia_payroll_value_type vt
    ON p.value_type_code = vt.code
JOIN czechia_price pr
    ON EXTRACT(YEAR FROM pr.date_from)::int = p.payroll_year
JOIN czechia_price_category pc 
    ON pr.category_code = pc.code
WHERE calc.code = 100
  AND p.value_type_code = 5958   -- průměrná hrubá mzda na zaměstnance
  AND p.payroll_year IN (SELECT rok FROM spolecne_roky)
GROUP BY 
    p.payroll_year,
    ib.name,
    pc.name
ORDER BY 
    rok, odvetvi, potravina;


-- kontrola
SELECT * FROM t_lucie_mendlikova_project_sql_primary_final;


-- sekundární tabulka: ekonomická data pro evropské státy ve stejném období jako ČR
DROP TABLE IF EXISTS t_lucie_mendlikova_project_sql_secondary_final;

CREATE TABLE t_lucie_mendlikova_project_sql_secondary_final AS
SELECT
    e.year AS rok,              -- rok
    c.country AS stat,          -- název státu
    e.gdp AS hdp,               -- HDP
    e.gini AS gini,             -- GINI koeficient
    e.population AS populace    -- počet obyvatel
FROM economies e
JOIN countries c
    ON e.country = c.country    -- spojení podle názvu státu
WHERE
    c.continent = 'Europe'      -- jen evropské státy
    AND e.year IN (SELECT rok FROM spolecne_roky)   -- jen společné roky jako ČR
ORDER BY
    rok,
    stat;

-- kontrola
SELECT * FROM t_lucie_mendlikova_project_sql_secondary_final;