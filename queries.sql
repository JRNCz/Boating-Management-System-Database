------------------------------------------
----- a)  (Esta query não dá a resposta à pergunta, apenas explicita o número de barcos
-- do owner com mais barcos em cada pais, mas não especifica quem é o owner)

SELECT T.iso_code, MAX(co)
FROM(
SELECT b.id_owner, b.iso_code, COUNT (*) as co
FROM boat b
GROUP BY (b.id_owner,b.iso_code)) as T
GROUP BY  T.iso_code;

------------------------------------------
----- b)

SELECT owner
FROM(
    SELECT b.id_owner as owner, COUNT(*) from boat b
    GROUP BY b.id_owner
    HAVING COUNT(*) > 1
) as t
WHERE ((SELECT COUNT( DISTINCT b2.iso_code) from boat b2 WHERE b2.id_owner= owner) > 1);

------------------------------------------
----- c)

SELECT DISTINCT t.id_sailor
FROM trip t
WHERE NOT EXISTS (
    SELECT l.latitude, l.longitude
    FROM location l JOIN country c on c.iso_code = l.iso_code
    WHERE c.name LIKE 'Portugal'
    EXCEPT
    SELECT t1.end_latitude, t1.end_longitude
    FROM trip t1
    WHERE t1.id_sailor=t.id_sailor
    );

-----------------------------------------
----- d)

SELECT *
FROM reservation r
WHERE r.id_sailor LIKE ( -- Descubro o ID do sailor(s) com mais viagens
    SELECT tr.id_sailor as sailors
    FROM trip tr
    group by tr.id_sailor
HAVING COUNT(*) >= -- Filtro a tabela para ter o maximo de viagens do sailor
    (SELECT max(counter) as max -- maximo de viagens que um ou mais sailors fizeram
    FROM(
    SELECT t.id_sailor , COUNT(*) as counter -- numero de viagens que os sailors fizeram
    FROM trip t
    group by id_sailor
    ) as t)
) ;

-----------------------------------------
----- e)

SELECT t.id_sailor, SUM(t.duration)
FROM trip t
GROUP BY (t.id_sailor,t.iso_code_sailor,t.cni,t.iso_code_boat,t.start_date, t.end_date)
HAVING SUM(t.duration) >= all (SELECT SUM(t.duration)
                                FROM trip t
                                GROUP BY (t.id_sailor,t.iso_code_sailor,t.cni,t.iso_code_boat,t.start_date, t.end_date));


