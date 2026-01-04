# Data-projekt-z-SQL---OPRAVA

**Lucie Mendlíková (Datová Akademie 5.11.2025)**

## Popis projektu

Tento projekt se zaměřuje na analýzu vývoje mezd a cen vybraných potravin v České republice pomocí SQL. Součástí projektu je vytvoření dvou hlavních tabulek – jedné pro data o mzdách a cenách potravin v ČR a druhé s doplňujícími informacemi o HDP, GINI koeficientu a populaci dalších evropských států. Pomocí SQL dotazů jsou vytvořeny hlavní a pomocná tabulka a zodpovězeny předem definované výzkumné otázky.

---

## Otázka 1  
**Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**

Z meziročního porovnání průměrných mezd v jednotlivých sledovaných odvětvích vyplývá, že mzdy ve většině případů v průběhu času rostou. Tento růst však není plynulý a v některých odvětvích se vyskytují i meziroční poklesy mezd.

Nejvýraznější poklesy mezd se objevily zejména v období let **2009–2013**, kdy k jejich snížení došlo současně ve více odvětvích. Ani v tomto období však nešlo o plošný pokles ve všech sledovaných odvětvích.

Celkově lze shrnout, že růst mezd v analyzovaných odvětvích není kontinuální, přesto však dlouhodobý trend vývoje mezd zůstává rostoucí.

---

## Otázka 2  
**Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**

V prvním srovnatelném roce **2006** činila průměrná mzda přibližně **20 342 Kč**. Pokud by byla celá tato částka vynaložena pouze na jeden typ potraviny, bylo by možné koupit zhruba **1 262 kg chleba** nebo přibližně **1 409 litrů mléka**. Tyto hodnoty tedy nepředstavují současný nákup obou potravin zároveň, ale dva samostatné modelové scénáře.

V posledním sledovaném roce **2018** dosahovala průměrná mzda přibližně **31 980 Kč**. Při stejném předpokladu by bylo možné za tuto mzdu koupit přibližně **1 319 kg chleba** nebo zhruba **1 614 litrů mléka**, opět nikoli současně, ale vždy pouze jednu z těchto potravin.

---

## Otázka 3  
**Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**

U jednotlivých potravin byl vypočten průměrný meziroční procentuální nárůst cen, přičemž byly zohledněny pouze kladné změny, tedy skutečné zdražování. Nejnižší průměrný nárůst cen byl zaznamenán u **jakostního bílého vína**, u kterého činil průměrný meziroční nárůst přibližně **2,7 %**, a tato kategorie tak zdražovala nejpomaleji.

---

## Otázka 4  
**Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**

Na základě porovnání meziročního růstu cen potravin a mezd nebyl ve sledovaném období identifikován žádný rok, ve kterém by růst cen potravin převýšil růst mezd o více než **10 %**.

Největší rozdíl mezi růstem cen potravin a růstem mezd byl zaznamenán v roce **2013**, kdy ceny potravin vzrostly přibližně o **5,10 %**, zatímco mzdy ve stejném roce klesly o **1,56 %**. Rozdíl mezi těmito hodnotami tak činil přibližně **6,66 %**, což představuje nejvýraznější sledovaný rozdíl, avšak stále pod hranicí 10 %.

---

## Otázka 5  
**Má výška HDP vliv na změny ve mzdách a cenách potravin?**

Z porovnání meziročního růstu HDP, mezd a cen potravin nevyplývá jednoznačná přímá závislost. V některých letech se vyšší růst HDP projevil současně i růstem mezd nebo cen potravin, v jiných letech však tento vztah patrný nebyl.

Například v roce **2007** vzrostlo HDP o **5,57 %**, přičemž mzdy rostly o **6,79 %** a ceny potravin o **6,76 %**. Naopak v roce **2013** HDP mírně kleslo o **0,05 %**, zatímco ceny potravin vzrostly o **5,10 %** a mzdy klesly o **1,56 %**, což ukazuje na rozdílný vývoj jednotlivých ukazatelů.

Výsledky tak naznačují, že vývoj mezd a cen potravin je ovlivněn i dalšími faktory, nikoli pouze změnami výše HDP, a vztah mezi těmito ukazateli nelze označit za jednoznačný.

---

## Chybějící hodnoty

První rok v každém ukazateli neobsahuje meziroční změnu, protože neexistuje předchozí hodnota, se kterou by bylo možné tuto změnu vypočítat. Proto se zde vyskytují chybějící hodnoty (`NULL`).

U některých států a let nejsou k dispozici úplná ekonomická data, což se projevuje chybějícími hodnotami u HDP a/nebo GINI koeficientu. Neúplnost dat vychází z původního datového zdroje. V některých případech chybí oba ukazatele (např. Gibraltar), zatímco jinde je dostupné pouze HDP nebo pouze GINI koeficient. Tyto záznamy byly v tabulce ponechány, avšak při analytických výstupech jsou zohledňovány pouze dostupné hodnoty.

---

## Odevzdané soubory

- `pripravaTAB2.sql` – vytvoření dvou hlavních tabulek a pomocné tabulky `spolecne_roky`  
- `OtazkaOPRAVA1-5.sql` – SQL dotazy pro zodpovězení výzkumných otázek 1–5  
- `t_lucie_mendlikova_project_sql_primary_final.csv` – primární tabulka  
- `t_lucie_mendlikova_project_sql_secondary_final.csv` – sekundární tabulka  
- `spolecne_roky.csv` – pomocná tabulka obsahující roky, ve kterých jsou dostupná data jak o mzdách, tak o cenách potravin, sloužící jako časový filtr pro zajištění srovnatelnosti dat
