-- TASK 1
-- Вывести страны, в которые не продано ни одного тура

SELECT name, language from countries LEFT OUTER JOIN countries_tour
    ON countries.id = countries_tour.country_id
    WHERE country_id IS NULL;

-- TASK 2
-- Вывести туры, с указанием общего числа клиентов, его купивших,
-- если тур не покупался, то написать «не едут»

-- select tour.name as tour_name,
--        case count(tour_id)
--         when 0 then cast('Билеты не проданы' as CHAR(15))
--         else cast(count(tour_id) as CHAR(15))
--         end as count
--     from tour FULL OUTER JOIN clients_tour ON clients_tour.tour_id = tour.id
--     group by tour.name;

select tour.name as tour_name, cast(tour_id as Char(15))
    from tour JOIN clients_tour ON clients_tour.tour_id = tour.id
    group by tour.name, tour_id
UNION
select tour.name as tour_name, ('Не продано') as tour_id
    from tour FULL JOIN clients_tour ON clients_tour.tour_id = tour.id
    where tour_id is null
    group by tour.name, tour_id;
-- TASK 3
-- Определить фирмы с указанием количества туристов, которых они
-- отправили в любой из туров 4.05.2020

select travel_agency.name, count(client_id)
from tour JOIN clients_tour ON tour.id = clients_tour.tour_id
          JOIN travel_agency ON tour.travel_agency_id = travel_agency.id
where start_date = '2020-05-04'
group by travel_agency_id, travel_agency.name;
