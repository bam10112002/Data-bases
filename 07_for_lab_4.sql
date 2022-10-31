-- lab4/1
-- Определить клиентов, максимальная стоимость туров которых меньше
-- средней стоимости

-- средняя стоимость всех туров
select avg(price) from tour;

-- максимальная стоимость туров для каждого клиента
select firstname, max(price)
    from clients, tour, clients_tour
    where clients_tour.client_id = clients.id and clients_tour.tour_id = tour.id
    group by firstname, clients.id
    ORDER by clients.id;

-- решение:
select firstname, foo.max
from (select firstname, max(price)
    from clients, tour, clients_tour
    where clients_tour.client_id = clients.id and clients_tour.tour_id = tour.id
    group by firstname, clients.id
    ORDER by clients.id) as foo
where foo.max < (select avg(price) from tour);


-- lab4/2
-- Определить страны, средняя стоимость тура в которую, меньше средней
-- стоимости всех проданных туров
-- решение:
select foo.name, foo.avg
from (select countries.name, avg(price)
    from countries, tour, countries_tour
    where countries_tour.country_id = countries.id and countries_tour.tour_id = tour.id
    group by countries.name, countries.id
    ORDER by countries.id) as foo
where foo.avg < (select avg(price) from tour);


-- lab4/3
-- Увеличить размер скидки на 2% клиентам, продолжительность туров
-- которых больше средней

-- средняя продолжительность тура
select avg(flight_time) from tour;

select clients_tour.client_id, flight_time from tour, clients_tour where tour.id = clients_tour.tour_id;

--решение:
update clients_tour
set discount = discount + 2
where (select(flight_time) from tour where tour.id = clients_tour.tour_id) >
      (select avg(flight_time) from tour);

-- проверка полученных изменений
select * from clients_tour;