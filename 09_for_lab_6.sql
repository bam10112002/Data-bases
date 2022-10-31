-- Task 0
CREATE VIEW foo as SELECT id, name, price, start_date, flight_time, travel_agency_id from tour;
insert into foo (id, name, price, start_date, flight_time, travel_agency_id) values
(6, 'Some dfgdftour', 38457,'2020-05-04', 1, 2);
select * from foo;
select * from tour;
drop VIEW foo;


-- Task 1:
-- Создать представление по турам с указанием названия страны и
-- тур-фирмы, которая организовала тур
CREATE VIEW travel_v AS SELECT tour.name as name , price, countries.name as country, travel_agency.name as travel_agency
    from tour, countries_tour, countries, travel_agency
    where countries_tour.tour_id = tour.id and countries_tour.country_id = countries.id
            and tour.travel_agency_id = travel_agency.id and price > 1000;

Select * from travel_v;

Drop VIEW travel_v;

-- Task 2:
-- Создать представление по тур-фирмам с указанием числа
-- различных туров, клиентов, средней стоимости тура
CREATE VIEW v3 as SELECT  name, count(tour_id), sum(clients), avg(price) from (
SELECT travel_agency.name, tour.id as tour_id, count(ct.client_id) as clients, price
     from travel_agency
              JOIN tour ON tour.travel_agency_id = travel_agency.id
              FULL JOIN clients_tour as ct on tour.id = ct.tour_id
     group by travel_agency.name, tour.id) as foo2
group by name;

SELECT * from v3;
