create table usc_geometries(id serial primary key, name varchar, point geometry);

insert into usc_geometries(name, point) values ('Leavey Library', ST_GeomFromText('POINT(-118.2827902 34.0217186)', 4326));
insert into usc_geometries(name, point) values ('VKC Library', ST_GeomFromText('POINT(-118.2840025 34.0212585)', 4326));
insert into usc_geometries(name, point) values ('Doheny Library', ST_GeomFromText('POINT(-118.2837366 34.020144)', 4326));
insert into usc_geometries(name, point) values ('Law Library', ST_GeomFromText('POINT(-118.2842727 34.0186751)', 4326));
insert into usc_geometries(name, point) values ('Hoose Library', ST_GeomFromText('POINT(-118.2866056 34.0186917)', 4326));
insert into usc_geometries(name, point) values ('SGM', ST_GeomFromText('POINT(-118.2890292 34.0214385)', 4326));
insert into usc_geometries(name, point) values ('THH', ST_GeomFromText('POINT(-118.2845619 34.0222316)', 4326));
insert into usc_geometries(name, point) values ('SLH', ST_GeomFromText('POINT(-118.2875815 34.0195725)', 4326));
insert into usc_geometries(name, point) values ('SAL', ST_GeomFromText('POINT(-118.2894739 34.019476)', 4326));
insert into usc_geometries(name, point) values ('OHE', ST_GeomFromText('POINT(-118.2896937 34.0206254)', 4326));
insert into usc_geometries(name, point) values ('Lyon Center', ST_GeomFromText('POINT(-118.2884284 34.0244047)', 4326));
insert into usc_geometries(name, point) values ('PED Building', ST_GeomFromText('POINT(-118.286324 34.0212992)', 4326));
insert into usc_geometries(name, point) values ('Cromwell Field', ST_GeomFromText('POINT(-118.2884515 34.0225474)', 4326));
insert into usc_geometries(name, point) values ('Village Gym', ST_GeomFromText('POINT(-118.285942 34.0248299)', 4326));
insert into usc_geometries(name, point) values ('Dedeaux Field', ST_GeomFromText('POINT(-118.2898526 34.0237627)', 4326));







-- convex hull
SELECT ST_AsText(ST_ConvexHull(ST_Collect(point::geometry))) FROM usc_geometries;
--                                                                                                  st_astext
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  POLYGON((-118.2842727 34.0186751,-118.2866056 34.0186917,-118.2894739 34.019476,-118.2896937 34.0206254,-118.2898526 34.0237627,-118.2884284 34.0244047,-118.285942 34.0248299,-118.2827902 34.0217186,-118.2842727 34.0186751))








--4 nearest neighbours to PED Building
SELECT name, ST_AsText(point), ST_Distance(point, 'SRID=4326;POINT(-118.286324 34.0212992)'::geometry) as distance FROM usc_geometries ORDER BY distance limit 5;

--       name      |           st_astext            |       distance
-- ----------------+--------------------------------+-----------------------
--  PED Building   | POINT(-118.286324 34.0212992)  |                     0
--  THH            | POINT(-118.2845619 34.0222316) | 0.0019935812423801914
--  SLH            | POINT(-118.2875815 34.0195725) | 0.0021360709585632786
--  VKC Library    | POINT(-118.2840025 34.0212585) | 0.0023218567440672286
--  Cromwell Field | POINT(-118.2884515 34.0225474) | 0.0024666291756157968
-- (5 rows)