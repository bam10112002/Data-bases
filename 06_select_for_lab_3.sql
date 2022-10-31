-- LAB 3
-- Опрелость сколько туров продано в каждую из стран.
select countries.name, count(countries_tour.tour_id) from countries_tour, countries
                                                     where country_id = countries.id
                                                     group by countries.name
                                                     order by countries.name;

-- Определить среднюю продолжительность тура для каждой из тур-фирм.
select travel_agency.name, avg(tour.flight_time) as duration from tour, travel_agency
                                                 where tour.travel_agency_id = travel_agency.id
                                                 group by travel_agency.name
                                                 order by duration;

-- Определить минимальную стоимость тура для каждой из стран.
select countries.name, min(tour.price) as min_price
    from tour, countries_tour, countries where tour_id = tour.id and country_id = countries.id
                              group by countries.name
                              order by countries.name;
