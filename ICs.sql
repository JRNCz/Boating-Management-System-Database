-- Trigger 1

CREATE OR REPLACE FUNCTION chk_date_interval()
RETURNS TRIGGER AS
$$
    DECLARE n integer DEFAULT 1;
    DECLARE cursor_reservation CURSOR FOR
        SELECT start_date, end_date, cni, iso_code_boat FROM reservation;
    DECLARE a integer DEFAULT (SELECT COUNT (*)
        FROM reservation);
    DECLARE start_date date;
    DECLARE end_date date;
    DECLARE cni VARCHAR(15);
    DECLARE iso_code_boat CHAR(2);
BEGIN
    OPEN cursor_reservation;
    WHILE n=1 LOOP
            FETCH cursor_reservation INTO start_date, end_date, cni, iso_code_boat;
            IF ((NEW.start_date <= end_date) AND (NEW.end_date>=start_date)) AND ((NEW.cni=cni) AND (NEW.iso_code_boat=iso_code_boat)) THEN
                n=2;
                RAISE EXCEPTION 'Reservation dates for the same boat can not intercept each other'
                USING HINT = 'Change the reservation date';
            ELSEIF a=0 THEN
                n=3;
            END IF;
            a=a-1;
    END LOOP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER chk_date
BEFORE UPDATE OR INSERT ON reservation
FOR EACH ROW EXECUTE PROCEDURE chk_date_interval();

DROP TRIGGER chk_date on reservation;

-- Trigger 2

CREATE OR REPLACE FUNCTION	chk_loc_entity()
RETURNS TRIGGER AS
$$
BEGIN
		IF EXISTS(
            SELECT w.latitude, w.longitude
            FROM WHARF as w
            WHERE (w.latitude = new.latitude and w.longitude = new.longitude)
        ) AND NOT EXISTS(
                SELECT m.latitude, m.longitude
                FROM MARINA as m
                WHERE (m.latitude = new.latitude and m.longitude = new.longitude)
            ) AND NOT EXISTS(
            SELECT m.latitude, m.longitude
            FROM PORT as m
            WHERE (m.latitude = new.latitude and m.longitude = new.longitude))
		    THEN
		ELSEIF EXISTS(
            SELECT w.latitude, w.longitude
            FROM MARINA as w
            WHERE (w.latitude = new.latitude and w.longitude = new.longitude)
        ) AND NOT EXISTS(
                SELECT m.latitude, m.longitude
                FROM WHARF as m
                WHERE (m.latitude = new.latitude and m.longitude = new.longitude)
            ) AND NOT EXISTS(
            SELECT m.latitude, m.longitude
            FROM PORT as m
            WHERE (m.latitude = new.latitude and m.longitude = new.longitude))
		    THEN
		ELSEIF EXISTS(
            SELECT w.latitude, w.longitude
            FROM PORT as w
            WHERE (w.latitude = new.latitude and w.longitude = new.longitude)
        ) AND NOT EXISTS(
                SELECT m.latitude, m.longitude
                FROM MARINA as m
                WHERE (m.latitude = new.latitude and m.longitude = new.longitude)
            ) AND NOT EXISTS(
            SELECT m.latitude, m.longitude
            FROM WHARF as m
            WHERE (m.latitude = new.latitude and m.longitude = new.longitude))
		    THEN
		ELSE
		            RAISE EXCEPTION  'Non existent wharf, marina or port for that location or location with two types'
                    USING HINT = 'Verify if every location has a type or if there´s a location with two types';
        END IF;
		RETURN NEW;
END;
$$	LANGUAGE	plpgsql;
--	Code	to	install	the	trigger	should	go	here…

CREATE CONSTRAINT TRIGGER	trigger_ex2
AFTER INSERT ON location DEFERRABLE
FOR EACH ROW EXECUTE PROCEDURE chk_loc_entity();

DROP TRIGGER trigger_ex2 on location;

-- Trigger 3

CREATE OR REPLACE FUNCTION	chk_boat_country_reg()
RETURNS TRIGGER AS
$$
BEGIN
		IF new.iso_code NOT IN (SELECT l.iso_code FROM LOCATION as l )
		THEN
            RAISE EXCEPTION  'Non existent location on boats country'
            USING HINT = 'Create location for the country specified database' ;
        END IF ;
		RETURN NEW;
END;
$$	LANGUAGE	plpgsql;
--	Code	to	install	the	trigger	should	go	here…

CREATE TRIGGER	trigger_ex3
BEFORE INSERT ON boat
FOR EACH ROW EXECUTE PROCEDURE chk_boat_country_reg();

DROP TRIGGER trigger_ex3 on boat;

