-- представление таблицы tour
CREATE VIEW tour_v as SELECT id, name, price, start_date, flight_time, travel_agency_id from tour;

-- Task 1
CREATE PROCEDURE insert_procedure(id int, name varchar(255), price integer, start_date date, flight_time integer, travel_agency_id integer )
    LANGUAGE SQL
    AS $$
        Insert INTO tour_v
         VALUES (id, name, price, start_date, flight_time, travel_agency_id);
    $$;

CALL insert_procedure (6, 'Some dfgdftour', 38457,'2020-05-04', 1, 2);

select * from tour;
drop VIEW tour_v;


-- Создать представление по тур-фирмам с указанием числа
-- различных туров, клиентов, средней стоимости тура
-- Получить результат, формируемый третьим представлением (предыдущего задания)
-- через выполнение нескольких запросов, объединённых в процедуру.


create table if not exists  t_func (
    id int,
    name varchar(255),
    tours_count int,
    clients_count int,
    avg_price int
);

CREATE FUNCTION func() RETURNS SETOF t_func AS
$$
DECLARE
    _result t_func;
    index int;
BEGIN
    index = 1;
    while (index < 5) LOOP
        _result.id = index;
        _result.name = (select name from travel_agency where travel_agency.id = index);
        _result.tours_count = (select count(tour.id) from travel_agency, tour
                               where travel_agency.id = tour.travel_agency_id and travel_agency.id = index);
        _result.clients_count = (select count(clients_tour.client_id) from clients_tour, tour, travel_agency
                                  where tour.travel_agency_id = travel_agency_id and clients_tour.tour_id = tour.id
                                                    and travel_agency.id = index and travel_agency_id = index );
        _result.avg_price = (select avg(tour.price) from travel_agency, tour
                               where travel_agency.id = tour.travel_agency_id and travel_agency.id = index);
        index = index + 1;
        return next _result;
    end loop;
end;
$$ LANGUAGE  plpgsql;

SELECT * from func();
drop FUNCTION func();


-- Task 3
-- Создать процедуру с параметром по умолчанию и выходным параметром.

CREATE FUNCTION getClientByFirstname(name varchar(255) default 'Bob') RETURNS clients AS
 $BODY$
    SELECT * FROM clients WHERE clients.firstname = name;
 $BODY$
LANGUAGE  sql;
ALTER FUNCTION getClientByFirstname(integer) OWNER TO postgres;

select * from getClientByFirstname('Livito');
DROP FUNCTION getClientByFirstname(varchar(255));