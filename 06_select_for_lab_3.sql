-- Lab_3

-- не принят
-- select name, (select count(*) from countries_tour where countries_tour.country_id = countries.id) as countrys_count from countries;

-- рабочий запрос
select countries.name, count(countries_tour.tour_id) from countries_tour, countries
                                                     where country_id = countries.id
                                                     group by countries.name
                                                     order by countries.name;

-- не принят
-- select  name, avg_time from (select name, (select avg(flight_time) from tour where tour.travel_agency_id = travel_agency.id)
--     as avg_time from travel_agency) as foo where avg_time is not null;

-- рабочий запрос
select travel_agency.name, avg(tour.flight_time) as duration from tour, travel_agency
                                                 where tour.travel_agency_id = travel_agency.id
                                                 group by travel_agency.name
                                                 order by duration;

-- не принят
-- select name, (select min(price) from tour where
--      countries.id in (select country_id from countries_tour where tour_id = tour.id)
--         ) from countries order by name;

-- рабочий запрос
select countries.name, min(tour.price) as min_price
    from tour, countries_tour, countries where tour_id = tour.id and country_id = countries.id
                              group by countries.name
                              order by countries.name;

-- Lab_4
-- select avg(price) from tour;
--
-- select max(price) from tour
--         where tour.id in (select tour_id from clients_tour where clients_tour.client_id = 3);

-- не принят
select firstname from clients where (select max(price) from tour
        where tour.id in (select tour_id from clients_tour where clients_tour.client_id = clients.id)) <
                                    (select avg(price) from tour);
-- рабочий вариант
select clients.firstname from clients, clients_tour, tour
                         group by clients.firstname, clients_tour.client_id, clients.id, clients_tour.tour_id, tour.id
                         having clients.id = clients_tour.client_id and clients_tour.tour_id = tour.id and max(tour.price) < ( select avg(price) from tour);
-- and max(tour.price) < avg(tour.price);


-- -- Среднее время перелета
-- select avg(flight_time) from tour;
--
-- -- Среднее время полета у конкретного клиента
-- (select foo.avg from (select id, firstname, (select avg(flight_time) from  (select clients_tour.client_id, clients_tour.tour_id, tour.flight_time, clients.firstname from clients_tour
--     join tour on clients_tour.tour_id = tour.id) as foo where foo.client_id = clients.id) from clients) as foo where foo.id = 2);

update clients_tour
set discount = discount + 2
where (select foo.avg from (select id, firstname, (select avg(flight_time) from  (select clients_tour.client_id, clients_tour.tour_id, tour.flight_time, clients.firstname from clients_tour
    join tour on clients_tour.tour_id = tour.id) as foo where foo.client_id = clients.id) from clients) as foo where foo.id = clients_tour.client_id) < (select avg(flight_time) from tour);

-- проверка полученных изменений
select * from clients_tour;
