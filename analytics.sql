SELECT EXTRACT(YEAR FROM t.trip_start_date) as year_date, EXTRACT(MONTH FROM t.trip_start_date) as month_date, t.trip_start_date AS date, COUNT(*)
FROM trip_info t
GROUP BY GROUPING SETS (year_date, month_date, date);


SELECT country_name_origin as country_origin, loc_name_origin as location_origin,  COUNT(*)
FROM trip_info
GROUP BY ROLLUP (country_origin, location_origin);

