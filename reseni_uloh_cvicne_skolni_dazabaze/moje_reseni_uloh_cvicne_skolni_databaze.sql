--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
  (CC) BY-NC-ND 3.0 CZ | Lubomír Štěpánek | listopad 2017
  
  _______________________________________________________________
  Moje řešení oficiálních příkladů z dokumentu
  
      "4IT218_Jazyk_SQL_-_Zadani_prikladu_pro_prikaz_SELECT.docx"
  
  v rámci předmětu 4IT218 Databáze.
  _______________________________________________________________
  
*/


--------------------------------------------------------------------------------
-- 1. Zjistěte, zda obsah všech tří tabulek koresponduje
-- s opisem tabulek v kapitole 2.

SELECT *
FROM ZAM;     -- tabulka 38 x 7

SELECT *
FROM UKOLY;   -- tabulka 14 x 4

SELECT *
FROM ODDEL;   -- tabulka 8 x 3


--------------------------------------------------------------------------------
-- 2. Vypište jména a funkce všech zaměstnanců.

SELECT jmeno, fce
FROM ZAM;


--------------------------------------------------------------------------------
-- 3. Jaké se vyskytují tituly u zaměstnanců? (Vypište je tak,
-- aby se tituly ve výpisu neopakovaly).

SELECT DISTINCT titul
FROM ZAM;


--------------------------------------------------------------------------------
-- 4. Vypište pro každého zaměstnance stávající výši platu
-- a výši platu v případě 20% valorizace.
-- Vypočtený sloupec pojmenujte "Valorizovaný plat".

SELECT plat AS "stavajici_plat",
       1.20 * plat AS "valorizovany_plat"
FROM ZAM;


--------------------------------------------------------------------------------
-- 5. Vypište obsah tabulky zaměstnanců tak, aby měl následující formu:
-- "Pan TITUL. JMENO pracuje v oddělení č. CIS_ODD".

SELECT CASE
           WHEN titul IS NULL
               THEN 'Pan'
               ELSE 'Pan '
       END
       ||titul||
       CASE
           WHEN titul IS NULL
               THEN ' '
               ELSE '. '
       END
       ||jmeno||' pracuje v oddělení č. '||cis_odd AS "kdo_kde_pracuje"
from ZAM;


--------------------------------------------------------------------------------
-- 6. Vypište popisy všech uložených úkolů.

SELECT popis
FROM UKOLY;


--------------------------------------------------------------------------------
-- 7. Vypište, v jakých možných funkcích pracují zaměstnanci dané firmy
-- (vypište tak, aby se funkce ve výpisu neopakovaly).

SELECT DISTINCT fce
FROM ZAM;


--------------------------------------------------------------------------------
-- 8. Pro všechny zaměstnance vypište výši denní mzdy
-- (počítejte s 22 pracovními dny).

SELECT os_cis, jmeno, round(plat / 22.0, 2)
FROM ZAM;


--------------------------------------------------------------------------------
-- 9. Vypište výši ročního platu každého ze zaměstnanců v případě,
-- že dostane 13. plat ve výši 5000,- Kč.

SELECT os_cis, jmeno, plat * 12.0 + 5000 AS "rocni_plat"
FROM ZAM;


--------------------------------------------------------------------------------
-- 10. Vypište popisy úkolů, které byly přiděleny pracovníkovi č. 1.

SELECT popis
FROM UKOLY
WHERE OS_CIS = 1;


--------------------------------------------------------------------------------
-- 11. Ve kterém oddělení (číslo) a jako co (funkce) pracuje pracovník
-- se jménem STRNAD?

SELECT cis_odd, fce
FROM ZAM
WHERE jmeno = 'STRNAD';


--------------------------------------------------------------------------------
-- 12. Vypište jména a platy zaměstnanců, kteří mají titul.

SELECT jmeno, plat
FROM ZAM
WHERE titul IS NOT NULL;


--------------------------------------------------------------------------------
-- 13. Vypište jména a platy zaměstnanců, kteří nemají titul.

SELECT jmeno, plat
FROM ZAM
WHERE titul IS NULL;


--------------------------------------------------------------------------------
-- 14. Vypište, jakou funkci zastávají zaměstnanci s příjmením končícím
-- na "OVA".

SELECT DISTINCT fce
FROM (
    SELECT jmeno, fce
    FROM ZAM
    WHERE jmeno LIKE '%OVA'
);


--------------------------------------------------------------------------------
-- 15. Vypište jména zaměstnanců z oddělení 2, 4, 6, 8, 10.

SELECT jmeno
FROM ZAM
WHERE CIS_ODD IN (2, 4, 6, 8, 10);


--------------------------------------------------------------------------------
-- 16. Vypište jména zaměstnanců ze 3. oddělení s platem nad 6000,-.

SELECT jmeno
FROM ZAM
WHERE CIS_ODD = 3 AND plat > 6000;


--------------------------------------------------------------------------------
-- 17. Vypište přehled všech zaměstnanců, kteří nezastávají funkci BOSS.

SELECT *
FROM ZAM
WHERE fce <> 'BOSS';
-- WHERE fce NOT LIKE 'BOSS';


--------------------------------------------------------------------------------
-- 18. Vypište jména zaměstnanců s titulem 'ING' ze 2. a nebo 6. oddělení.

SELECT jmeno
FROM ZAM
WHERE titul = 'ING' AND cis_odd IN (2, 6);
-- WHERE titul LIKE 'ING' AND cis_odd IN (2, 6);


--------------------------------------------------------------------------------
-- 19. Vypište jména a funkce zaměstnanců s platem
-- v rozmezí 9000 až 12000,- Kč.

SELECT jmeno, fce
FROM ZAM
WHERE plat >= 9000 AND plat <= 12000;


--------------------------------------------------------------------------------
-- 20. Vypišt čísla pracovníků, kterým byl přidělen nějaký úkol související
-- s "programem".

SELECT DISTINCT os_cis
FROM UKOLY
WHERE popis LIKE '%PROGRAM%'
ORDER BY os_cis;
-- ORDER BY 1;


--------------------------------------------------------------------------------
-- 21. Vypište jména zaměstnanců, jejichž roční plat bude
-- po 10% valorizaci vyšší než 90000,-.

SELECT jmeno
FROM ZAM
WHERE 12 * 1.10 * plat > 90000;


--------------------------------------------------------------------------------
-- 22. Vypište pro každého zaměstnance název oddělení, ve kterém pracuje.

SELECT ZAM.os_cis, ZAM.jmeno, ODDEL.nazev
FROM ZAM
LEFT JOIN ODDEL
ON (ZAM.cis_odd = ODDEL.cis_odd);
-- USING (cis_odd);


--------------------------------------------------------------------------------
-- 23. Vypište jména zaměstnanců, kteří mají uložený nějaký úkol.

SELECT DISTINCT ZAM.jmeno
FROM UKOLY
INNER JOIN ZAM
ON (UKOLY.os_cis = ZAM.os_cis);
-- USING (os_cis);


--------------------------------------------------------------------------------
-- 24. Vypište pro každý úkol jméno zaměstnance, kterému byl uložen,
-- včetně čísla oddělení, ve kterém tento zaměstnanec pracuje.

SELECT UKOLY.cis_uk,
       UKOLY.popis,
       ZAM.jmeno,
       ZAM.cis_odd
FROM UKOLY
LEFT JOIN ZAM
ON (UKOLY.os_cis = ZAM.os_cis);
-- USING (os_cis);


--------------------------------------------------------------------------------
-- 25. Vypište pro každé oddělení jméno jeho vedoucího (šéfa).

SELECT ODDEL.cis_odd,
       ODDEL.nazev,
       ZAM.os_cis,
       ZAM.jmeno
FROM ODDEL
LEFT JOIN ZAM
ON (ODDEL.sef = ZAM.os_cis);


--------------------------------------------------------------------------------
-- 26. Vypište pro každého zaměstnance popisy úkolů, které mu byly zadány.

SELECT ZAM.os_cis,
       ZAM.jmeno,
       UKOLY.popis
FROM ZAM
LEFT JOIN UKOLY
ON (ZAM.os_cis = UKOLY.os_cis);


--------------------------------------------------------------------------------
-- 27. Vypište pro každé oddělení (název) popisy úkolů, které byly
-- uloženy jeho zaměstnancům.

SELECT ODDEL.cis_odd,
       ODDEL.nazev,
       UKOLY.popis       
FROM ZAM
RIGHT JOIN UKOLY
ON (ZAM.os_cis = UKOLY.os_cis)
RIGHT JOIN ODDEL
ON (ZAM.cis_odd = ODDEL.cis_odd);


--------------------------------------------------------------------------------
-- 28. Vypište pro každý úkol název oddělení, jehož zaměstnanci byl zadán.

SELECT UKOLY.cis_uk,
       UKOLY.popis,
       ODDEL.cis_odd,
       ODDEL.nazev
FROM UKOLY
LEFT JOIN ZAM
ON (UKOLY.os_cis = ZAM.os_cis)
LEFT JOIN ODDEL
ON (ZAM.cis_odd = ODDEL.cis_odd);


--------------------------------------------------------------------------------
-- 29. Vypište pro každý uložený úkol jméno zaměstnance, jemuž byl
-- uložen, a název oddělení, ve kterém zaměstnanec pracuje.

SELECT UKOLY.cis_uk,
       UKOLY.popis,
       ZAM.os_cis,
       ZAM.jmeno,
       ODDEL.cis_odd,
       ODDEL.nazev
FROM UKOLY
LEFT JOIN ZAM
ON (UKOLY.os_cis = ZAM.os_cis)
LEFT JOIN ODDEL
ON (ZAM.cis_odd = ODDEL.cis_odd)
ORDER BY UKOLY.cis_uk;


--------------------------------------------------------------------------------
-- 30. Vypište názvy oddělení, do kterých byl přidělen nějaký úkol.

SELECT DISTINCT ODDEL.nazev
FROM ZAM
JOIN UKOLY
ON (ZAM.os_cis = UKOLY.os_cis)
JOIN ODDEL
ON (ZAM.cis_odd = ODDEL.cis_odd);


--------------------------------------------------------------------------------
-- 31. Vypište popisy úkolů, které byly přiděleny zaměstnancům s titulem.

SELECT UKOLY.cis_uk,
       UKOLY.popis,
       ZAM.titul
FROM UKOLY
JOIN ZAM
ON (UKOLY.os_cis = ZAM.os_cis)
WHERE ZAM.titul IS NOT NULL;


--------------------------------------------------------------------------------
-- 32. Vypište jména zaměstnanců z oddělení PROGRAMOVANI,
-- kterým byl přidělen nějaký úkol.

SELECT ZAM.os_cis,
       ZAM.jmeno,
       UKOLY.cis_uk,
       UKOLY.popis,
       ODDEL.nazev
FROM ZAM
JOIN UKOLY
ON (ZAM.os_cis = UKOLY.os_cis)
LEFT JOIN ODDEL
ON (ZAM.cis_odd = ODDEL.cis_odd)
WHERE ODDEL.nazev = 'PROGRAMOVANI';


--------------------------------------------------------------------------------
-- 33. Vypište jméno vedoucího oddělení PROVOZ POCITACE.

SELECT ZAM.jmeno
FROM ZAM
RIGHT JOIN ODDEL
ON (ZAM.os_cis = ODDEL.sef)
WHERE ODDEL.nazev = 'PROVOZ POCITACE';


--------------------------------------------------------------------------------
-- 34. Pořiďte přehled zaměstnanců seřazených abecedně podle jména.

SELECT *
FROM ZAM
ORDER BY ZAM.jmeno ASC;  -- DESC


--------------------------------------------------------------------------------
-- 35. Pořiďte přehled zaměstnanců (osobní číslo, jméno, titul)
-- seřazených dle titulů.

SELECT ZAM.os_cis,
       ZAM.jmeno,
       ZAM.titul
FROM ZAM
ORDER BY ZAM.titul ASC;  -- DESC


--------------------------------------------------------------------------------
-- 36. Pořiďte přehled zaměstnanců (číslo oddělení, plat, jméno)
-- seřazených podle oddělení vzestupně a v rámci oddělení dle platu sestupně.

SELECT ZAM.cis_odd,
       ZAM.plat,
       ZAM.jmeno
FROM ZAM
ORDER BY ZAM.cis_odd ASC, ZAM.plat DESC;


--------------------------------------------------------------------------------
-- 37. Pořiďte přehled zaměstnanců (jméno, plat po 10% valorizaci)
-- z 3. oddělení seřazený podle valorizovaného platu sestupně.

SELECT ZAM.jmeno,
       ZAM.plat * 1.1 AS "valorizovany_plat"
FROM ZAM
WHERE ZAM.cis_odd = 3
ORDER BY ZAM.plat DESC;


--------------------------------------------------------------------------------
-- 38. Pořiďte přehled úkolů (číslo úkolu, popis, jméno zaměstnance)
-- seřazený dle názvů oddělení, do kterých byly přiděleny.

SELECT UKOLY.cis_uk,
       UKOLY.popis,
       ZAM.os_cis,
       ZAM.jmeno,
       ODDEL.cis_odd,
       ODDEL.nazev
FROM UKOLY
LEFT JOIN ZAM
ON (UKOLY.os_cis = ZAM.os_cis)
LEFT JOIN ODDEL
ON (ZAM.cis_odd = ODDEL.cis_odd)
ORDER BY ODDEL.nazev ASC;


--------------------------------------------------------------------------------
-- 39. Vypište maximální a minimální výši platu.

SELECT max(ZAM.plat) AS "maximalni_plat",
       min(ZAM.plat) AS "minimalni_plat"
FROM ZAM;


--------------------------------------------------------------------------------
-- 40. Vypište, kolik zaměstnanců vykonává funkci BOSS
-- a jaký je minimální plat v této funkci.

SELECT count(ZAM.plat) AS "kolik_bossu",
       min(ZAM.plat) AS "minimalni_plat_bosse"
FROM ZAM
WHERE ZAM.fce LIKE 'BOSS';


--------------------------------------------------------------------------------
-- 41. Vypište průměrný měsíční plat na jednoho zaměstnance.

SELECT round(avg(ZAM.plat), 2) AS "prumerny_plat"
FROM ZAM;


--------------------------------------------------------------------------------
-- 42. Vypište počet oddělení (pokuste se jednou zjistit z tabulky oddělení,
-- po druhé z tabulky zaměstnanců).

SELECT count(DISTINCT ODDEL.cis_odd) AS "pocet_oddeleni"
FROM ODDEL;   -- 8

SELECT count(DISTINCT ZAM.cis_odd) AS "pocet_oddeleni"
FROM ZAM;     -- 7


--------------------------------------------------------------------------------
-- 43. Vypište, kolik zaměstnanců má nějaký titul.

SELECT count(ZAM.os_cis) AS "kolik_zamestnancu_ma_titul"
FROM ZAM
WHERE ZAM.titul IS NOT NULL;


--------------------------------------------------------------------------------
-- 44. Vypište, kolik je zaměstnanců s příjmením začínajícím na písmeno "K".

SELECT count(ZAM.os_cis) AS "kolik_jmen_na_K"
FROM ZAM
WHERE ZAM.jmeno LIKE 'K%';


--------------------------------------------------------------------------------
-- 45. Vypište maximální plat ve 3. oddělení.

SELECT max(ZAM.plat) AS "maximalni_plat_ve_3_oddeleni"
FROM ZAM
WHERE ZAM.cis_odd = 3;


--------------------------------------------------------------------------------
-- 46. Vypište celkový počet zaměstnanců a celkovou částku vyplácenou
-- na platech měsíčně a ročně.

SELECT count(ZAM.os_cis) AS "pocet_zamestnancu",
       sum(ZAM.plat) AS "celkovy_mesicni_plat",
       sum(ZAM.plat) * 12.0 AS "celkovy_rocni_plat"
FROM ZAM;


--------------------------------------------------------------------------------
-- 47. Vypište počet zaměstnanců ve 2. oddělení a roční částku jim vyplácenou
-- po 10% valorizaci platů.

SELECT count(ZAM.os_cis) AS "pocet_zamestnancu_ve_2_oddel",
       sum(ZAM.plat) * 12.0 * 1.10 AS "jejich_celkovy_rocni_plat"
FROM ZAM
WHERE ZAM.cis_odd = 2;


--------------------------------------------------------------------------------
-- 48. Vypište počet programátorů ve 3. oddělení.

SELECT count(ZAM.os_cis) AS "pocet_programatoru_ve_3_oddel"
FROM ZAM
WHERE ZAM.cis_odd = 3
AND ZAM.fce = 'PROGRAMATOR';


--------------------------------------------------------------------------------
-- 49. Vypište nejnižší plat v oddělení Projekce.

SELECT min(ZAM.plat) AS "minimalni_plat_oddel_projekce"
FROM ZAM
JOIN ODDEL
ON (ZAM.cis_odd = ODDEL.cis_odd);


--------------------------------------------------------------------------------
-- 50. Vypište pro každé oddělení (číslo) počet zaměstnanců.

SELECT ODDEL.cis_odd AS "cislo_oddeleni",
       ODDEL.nazev AS "nazev_oddeleni",
       count(ZAM.os_cis) AS "pocet_zamestnancu"
FROM ODDEL
LEFT JOIN ZAM
ON (ODDEL.cis_odd = ZAM.cis_odd)
GROUP BY ODDEL.cis_odd, ODDEL.nazev
ORDER BY ODDEL.cis_odd;


--------------------------------------------------------------------------------
-- 51. Vypište pro každé oddělení (číslo) průměrný měsíční a roční plat.

SELECT ODDEL.cis_odd AS "cislo_oddeleni",
       ODDEL.nazev AS "nazev_oddeleni",
       round(avg(ZAM.plat), 2) AS "prumerny_mesicni_plat",
       round(avg(ZAM.plat) * 12.0, 2) AS "prumerny_rocni_plat"
FROM ODDEL
LEFT JOIN ZAM
ON (ODDEL.cis_odd = ZAM.cis_odd)
GROUP BY ODDEL.cis_odd, ODDEL.nazev
ORDER BY ODDEL.cis_odd;


--------------------------------------------------------------------------------
-- 52. Vypište pro každé oddělení (číslo a název) počet inženýrů.

SELECT ODDEL.cis_odd AS "cislo_oddeleni",
       ODDEL.nazev AS "nazev_oddeleni",
       count(ZAM.os_cis) AS "pocet_inzenyru"
FROM ODDEL
LEFT JOIN ZAM
ON (ODDEL.cis_odd = ZAM.cis_odd)
AND ZAM.titul = 'ING'
GROUP BY ODDEL.cis_odd, ODDEL.nazev
ORDER BY ODDEL.cis_odd;


--------------------------------------------------------------------------------
-- 53. Vypište pro každé oddělení (číslo a název) počet zaměstnanců bez titulu.

SELECT ODDEL.cis_odd AS "cislo_oddeleni",
       ODDEL.nazev AS "nazev_oddeleni",
       count(ZAM.os_cis) AS "pocet_zamestnancu_bez_titulu"
FROM ODDEL
LEFT JOIN ZAM
ON (ODDEL.cis_odd = ZAM.cis_odd)
AND ZAM.titul IS NULL
GROUP BY ODDEL.cis_odd, ODDEL.nazev
ORDER BY ODDEL.cis_odd;


--------------------------------------------------------------------------------
-- 54. Vypište pro každé oddělení (číslo) počet zaměstnanců vykonávajících
-- jednotlivé funkce (ve výstupu vypište sloupce číslo oddělení, funkce,
-- počet zaměstnanců).

SELECT ODDEL.cis_odd AS "cislo_oddeleni",
       ODDEL.nazev AS "nazev_oddeleni",
       ZAM.fce AS "funkce",
       count(ZAM.os_cis) AS "pocet_zamestnancu_ve_funkci"
FROM ODDEL
LEFT JOIN ZAM
ON (ODDEL.cis_odd = ZAM.cis_odd)
GROUP BY ODDEL.cis_odd, ODDEL.nazev, ZAM.fce
ORDER BY ODDEL.cis_odd;


--------------------------------------------------------------------------------
-- 55. Vypište pro každé oddělení (vypište číslo, název) maximální plat.
-- Výstup seřaďte dle zjištěného maximálního platu sestupně.

SELECT ODDEL.cis_odd AS "cislo_oddeleni",
       ODDEL.nazev AS "nazev_oddeleni",
       max(ZAM.plat) AS "vyse_maximalniho_platu"
FROM ODDEL
LEFT JOIN ZAM
ON (ODDEL.cis_odd = ZAM.cis_odd)
GROUP BY ODDEL.cis_odd, ODDEL.nazev
ORDER BY ODDEL.cis_odd, max(ZAM.plat) DESC;


--------------------------------------------------------------------------------
-- 56. Vypište průměrné platy v jednotlivých funkcích (vypište sloupce funkce,
-- průměrný plat). Seřaďte vzestupně dle průměrného platu.

SELECT ZAM.fce AS "funkce",
       round(avg(ZAM.plat), 2) AS "prumerny_plat"
FROM ZAM
GROUP BY ZAM.fce
ORDER BY avg(ZAM.plat) ASC;


--------------------------------------------------------------------------------
-- 57. Vypište pro každé oddělení (číslo) počet zaměstnanců s titulem,
-- kteří mají plat pod 12000,-. Přehled seřaďte dle zjištěného počtu sestupně.

SELECT ODDEL.cis_odd AS "cislo_oddeleni",
       ODDEL.nazev AS "nazev_oddeleni",
       count(ZAM.os_cis) AS "kolik_ma_titul_a_maly_plat"
FROM ODDEL
LEFT JOIN ZAM
ON (ODDEL.cis_odd = ZAM.cis_odd)
AND ZAM.titul IS NOT NULL
AND ZAM.plat < 12000
GROUP BY ODDEL.cis_odd, ODDEL.nazev
ORDER BY ODDEL.cis_odd, count(ZAM.os_cis) DESC;


--------------------------------------------------------------------------------
-- 58. Vypište pro každé oddělení (číslo) počet různých funkcí.

SELECT ODDEL.cis_odd AS "cislo_oddeleni",
       ODDEL.nazev AS "nazev_oddeleni",
       count(DISTINCT ZAM.fce) AS "pocet_ruznych_funkci"
FROM ODDEL
LEFT JOIN ZAM
ON (ODDEL.cis_odd = ZAM.cis_odd)
GROUP BY ODDEL.cis_odd, ODDEL.nazev
ORDER BY ODDEL.cis_odd;


--------------------------------------------------------------------------------
-- 59. Vypište průměrné platy pro jednotlivá oddělení (číslo, název,
-- průměrný plat). Výpis seřaďte dle výše průměrného platu sestupně.

SELECT ODDEL.cis_odd AS "cislo_oddeleni",
       ODDEL.nazev AS "nazev_oddeleni",
       round(avg(ZAM.plat), 2) AS "prumerny_plat_oddeleni"
FROM ODDEL
LEFT JOIN ZAM
ON (ODDEL.cis_odd = ZAM.cis_odd)
GROUP BY ODDEL.cis_odd, ODDEL.nazev
ORDER BY avg(ZAM.plat) DESC;


--------------------------------------------------------------------------------
-- 60. Vypište jména zaměstnanců s počtem přidělených úkolů. Seřaďte abecedně.

SELECT ZAM.os_cis AS "cislo_zamestnance",
       ZAM.jmeno AS "jmeno_zamestnance",
       count(UKOLY.os_cis) AS "pocet_ukolu"
FROM ZAM
LEFT JOIN UKOLY
ON (ZAM.os_cis = UKOLY.os_cis)
GROUP BY ZAM.os_cis, ZAM.jmeno
ORDER BY ZAM.jmeno ASC;


--------------------------------------------------------------------------------
-- 61. Vypište názvy oddělení s počtem přidělených úkolů.

SELECT ODDEL.cis_odd AS "cislo_oddeleni",
       ODDEL.nazev AS "nazev_oddeleni",
       count(UKOLY.cis_uk) AS "pocet_pridelenych_ukolu"
FROM ODDEL
LEFT JOIN ZAM
ON (ODDEL.cis_odd = ZAM.cis_odd)
LEFT JOIN UKOLY
ON (ZAM.os_cis = UKOLY.os_cis)
GROUP BY ODDEL.cis_odd, ODDEL.nazev
ORDER BY ODDEL.cis_odd ASC;













--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------




