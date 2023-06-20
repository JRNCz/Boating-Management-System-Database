DROP VIEW IF EXISTS trip_info;

CREATE VIEW trip_info(
country_iso_origin, country_name_origin,
country_iso_dest, country_name_dest,
loc_name_origin,
loc_name_dest,
cni_boat,
country_iso_boat, country_name_boat,
trip_start_date)
AS
SELECT c.iso_code, c.name, c1.iso_code, c1.name, l.name, l1.name, b.cni, b.iso_code, c2.name, t.date
FROM trip t JOIN location l1 on l1.latitude = t.end_latitude and l1.longitude = t.end_longitude
    JOIN location l on t.start_latitude = l.latitude and t.start_longitude = l.longitude
    JOIN country c on c.iso_code = l.iso_code
    JOIN country c1 on c1.iso_code = l1.iso_code
    Join reservation r on t.cni = r.cni and t.iso_code_boat = r.iso_code_boat and t.id_sailor = r.id_sailor and t.iso_code_sailor = r.iso_code_sailor and t.start_date = r.start_date and t.end_date = r.end_date
    JOIN boat b on b.cni = r.cni and b.iso_code = r.iso_code_boat
    JOIN country c2 on c2.iso_code = b.iso_code;

