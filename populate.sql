INSERT INTO country (name, iso_code, flag) VALUES ('Portugal',62,'https://en.wikipedia.org/wiki/File:Flag_of_Portugal.svg') ;
INSERT INTO country (name, iso_code, flag) VALUES ('Espanha',72,'https://en.wikipedia.org/wiki/File:Bandera_de_Espa%C3%B1a.svg') ;
INSERT INTO country (name, iso_code, flag) VALUES ('South Africa',71,'https://en.wikipedia.org/wiki/File:Flag_of_South_Africa.svg') ;
INSERT INTO country (name, iso_code, flag) VALUES ('Italia',38,'https://en.wikipedia.org/wiki/File:Flag_of_Italy.svg');
INSERT INTO country (name, iso_code, flag) VALUES ('Alemanha',50,'aa') ;

INSERT INTO person (name, id, iso_code) VALUES ('Joao', 12345678,62);
INSERT INTO person (name, id, iso_code) VALUES ('Miguel', 14785236,72);
INSERT INTO person (name, id, iso_code) VALUES ('Rendeiro', 15689741,62);
INSERT INTO person (name, id, iso_code) VALUES ('Molini', 17895214,38);
INSERT INTO person (name, id, iso_code) VALUES ('Ze', 14785215,62);
INSERT INTO person (name, id, iso_code) VALUES ('Perini', 15963248,38);
INSERT INTO person (name, id, iso_code) VALUES ('Jolick', 26548973,50);

INSERT INTO owner (id, iso_code, birthdate) VALUES (12345678,62,'2000-09-02');
INSERT INTO owner (id, iso_code, birthdate) VALUES (14785236,72,'2000-11-07');
INSERT INTO owner (id, iso_code, birthdate) VALUES (15689741,62,'1955-07-17');
INSERT INTO owner (id, iso_code, birthdate) VALUES (15963248,38,'1959-09-17');
INSERT INTO owner (id, iso_code, birthdate) VALUES (26548973,50,'1975-07-12');

INSERT INTO sailor (id, iso_code) VALUES (17895214,38);
INSERT INTO sailor (id, iso_code) VALUES (15689741,62);
INSERT INTO sailor (id, iso_code) VALUES (14785215,62);
INSERT INTO sailor (id, iso_code) VALUES (26548973,50);


START TRANSACTION;
SET CONSTRAINTS ALL DEFERRED;

INSERT INTO location (name, latitude, longitude, iso_code)  VALUES ('Lisboa',38.736946,-9.142685,62);
INSERT INTO location (name, latitude, longitude, iso_code)  VALUES ('Porto',68.736946,-19.142685,62);
INSERT INTO location (name, latitude, longitude, iso_code)  VALUES ('Madrid',40.416775,-3.703790,72);
INSERT INTO location (name, latitude, longitude, iso_code)  VALUES ('Durban',-29.883333,31.049999,71);
INSERT INTO location (name, latitude, longitude, iso_code)  VALUES ('Roma',	41.902782,12.496366,38);
INSERT INTO location (name, latitude, longitude, iso_code)  VALUES ('Bremen',34.958982,23.789654,50);
INSERT INTO location (name, latitude, longitude, iso_code)  VALUES ('Faro',	12.256986,-5.258685,62);



INSERT INTO marina (latitude, longitude) VALUES (38.736946,-9.142685);
INSERT INTO marina (latitude, longitude) VALUES (-29.883333,31.049999);
INSERT INTO wharf (latitude, longitude) VALUES (40.416775,-3.703790);
INSERT INTO Port (latitude, longitude) VALUES (41.902782,12.496366);
INSERT INTO Port (latitude, longitude) VALUES (68.736946,-19.142685);
INSERT INTO marina (latitude, longitude) VALUES (34.958982,23.789654);
INSERT INTO wharf (latitude, longitude) VALUES (12.256986,-5.258685);
--INSERT INTO marina (latitude, longitude) VALUES (41.902782,12.496366); --see trigger works, apenas quando os dados são introduzidos todos de seguida

COMMIT; -- trigger will be fired here

INSERT INTO boat (iso_code, cni, year, name, iso_code_owner, id_owner) VALUES (62,1234,2019,'Bolero',62,12345678);
INSERT INTO boat (iso_code, cni, year, name, iso_code_owner, id_owner) VALUES (72,1245,2015,'Tikitaka',72,14785236);
INSERT INTO boat (iso_code, cni, year, name, iso_code_owner, id_owner) VALUES (71,5648,2021,'BPP',62,15689741);
INSERT INTO boat (iso_code, cni, year, name, iso_code_owner, id_owner) VALUES (62,9999,2021,'Bola',62,12345678);
INSERT INTO boat (iso_code, cni, year, name, iso_code_owner, id_owner) VALUES (62,2589,2018,'Stella',62,15689741);
INSERT INTO boat (iso_code, cni, year, name, iso_code_owner, id_owner) VALUES (50,1111,2022,'Mafarrico',62,12345678);
INSERT INTO boat (iso_code, cni, year, name, iso_code_owner, id_owner) VALUES (38,9123,2015,'Jojasboat',38,15963248);
INSERT INTO boat (iso_code, cni, year, name, iso_code_owner, id_owner) VALUES (71,1231,2010,'Millenium',72,14785236);
INSERT INTO boat (iso_code, cni, year, name, iso_code_owner, id_owner) VALUES (72,1919,2018,'Nemii',50,26548973);


INSERT INTO schedule (start_date, end_date) VALUES ('2021-12-20','2021-12-22');
INSERT INTO schedule (start_date, end_date) VALUES ('2021-12-15','2021-12-31');
INSERT INTO schedule (start_date, end_date) VALUES ('2021-12-25','2021-12-29');
INSERT INTO schedule (start_date, end_date) VALUES ('2022-01-01','2022-01-20');
INSERT INTO schedule (start_date, end_date) VALUES ('2022-01-10','2022-01-17');
INSERT INTO schedule (start_date, end_date) VALUES ('2022-01-23','2022-01-30');
--INSERT INTO schedule (start_date, end_date) VALUES ('2021-12-22','2021-12-26'); Data para ver trigger 1 a funcionar
--DELETE FROM schedule WHERE start_date='2021-12-22';

INSERT INTO reservation (iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date) VALUES (62,1234,17895214,38,'2021-12-20','2021-12-22');
INSERT INTO reservation (iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date) VALUES (72,1245,17895214,38,'2021-12-15','2021-12-31');
INSERT INTO reservation (iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date) VALUES (71,5648,15689741,62,'2021-12-25','2021-12-29');
INSERT INTO reservation (iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date) VALUES (62,9999,14785215,62,'2022-01-01','2022-01-20');
INSERT INTO reservation (iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date) VALUES (62,2589,14785215,62,'2022-01-10','2022-01-17');
INSERT INTO reservation (iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date) VALUES (71,5648,26548973,50,'2022-01-23','2022-01-30');
--INSERT INTO reservation (iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date) VALUES (71,5648,15689741,62,'2021-12-22','2021-12-26'); -- Data para ver trigger 1 a funcionar
--DELETE FROM reservation WHERE start_date='2021-12-22';

INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2021-12-20',2,62,1234,17895214,38,'2021-12-20','2021-12-22',38.736946,-9.142685,40.416775,-3.703790);
INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2021-12-16',4,72,1245,17895214,38,'2021-12-15','2021-12-31',38.736946,-9.142685,41.902782,12.496366);
INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2021-12-26',3,71,5648,15689741,62,'2021-12-25','2021-12-29',-29.883333,31.049999,38.736946,-9.142685);
INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2021-12-22',2,72,1245,17895214,38,'2021-12-15','2021-12-31',41.902782,12.496366,-29.883333,31.049999);

INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2022-01-02',3,62,9999,14785215,62,'2022-01-01','2022-01-20',34.958982,23.789654,40.416775,-3.703790);
INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2022-01-11',2,62,2589,14785215,62,'2022-01-10','2022-01-17',38.736946,-9.142685,34.958982,23.789654);
INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2022-01-14',1,62,2589,14785215,62,'2022-01-10','2022-01-17',34.958982,23.789654,38.736946,-9.142685);
INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2022-01-16',1,62,2589,14785215,62,'2022-01-10','2022-01-17',41.902782,12.496366,34.958982,23.789654);

INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2022-01-23',5,71,5648,26548973,50,'2022-01-23','2022-01-30',12.256986,-5.258685,40.416775,-3.703790);
INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2022-01-28',1,71,5648,26548973,50,'2022-01-23','2022-01-30',38.736946,-9.142685,12.256986,-5.258685);
INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2022-01-06',8,62,9999,14785215,62,'2022-01-01','2022-01-20',-29.883333,31.049999,38.736946,-9.142685);
INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2022-01-29',1,71,5648,26548973,50,'2022-01-23','2022-01-30',41.902782,12.496366,12.256986,-5.258685);
INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2022-01-15',2,62,9999,14785215,62,'2022-01-01','2022-01-20',34.958982,23.789654,68.736946,-19.142685);
INSERT INTO trip (date, duration, iso_code_boat, cni, id_sailor, iso_code_sailor, start_date, end_date, start_latitude, start_longitude, end_latitude, end_longitude) VALUES ('2022-01-18',2,62,9999,14785215,62,'2022-01-01','2022-01-20',68.736946,-19.142685,12.256986,-5.258685);


INSERT INTO boat_vhf (iso_code, cni, mmsi) VALUES (71,5648,123456789)