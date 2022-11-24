CREATE TABLE IF NOT EXISTS journal_clients (
    id serial not null primary key,
    client_id serial not null,
    client_name varchar(255) not null,
    stamp timestamp NOT NULL,
    th_op varchar(10)
);

CREATE OR REPLACE FUNCTION journal_clients_funk()
RETURNS TRIGGER AS
$$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO journal_clients(client_id, client_name, th_op, stamp)
                VALUES (old.id, old.firstname, TG_OP, now());
            return new;
        else
            INSERT INTO journal_clients(client_id, client_name, th_op, stamp)
                VALUES (new.id, new.firstname, TG_OP, now());
            return old;
        end if;
    END
$$
LANGUAGE plpgsql;

CREATE TRIGGER my_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON clients FOR EACH ROW
    EXECUTE PROCEDURE journal_clients_funk();

CREATE TRIGGER my_trigger2
    BEFORE DELETE
    ON clients FOR EACH ROW
    EXECUTE PROCEDURE journal_clients_funk();




INSERT INTO clients (firstname, passport)
    VALUES ('Artem', '778321');
UPDATE clients SET firstname = 'NewArtemName' WHERE firstname = 'Artem';

SELECT * FROM journal_clients;
SELECT * FROM clients;

DELETE FROM clients WHERE clients.firstname = 'Artem' or clients.firstname = 'NewArtemName';

DROP TRIGGER my_trigger ON clients;
DROP TRIGGER my_trigger2 ON clients;
DROP FUNCTION journal_clients_funk();




-- Task 1
-- Разработать процедуру, формирующую расписание туров в заданном месяце
CREATE FUNCTION task1(start_ date, end_ date) RETURNS tour AS
 $BODY$
     SELECT * FROM tour WHERE tour.start_date >= start_ and tour.start_date <= end_;
$BODY$
    LANGUAGE  sql;

SELECT * from task1('2020-05-01', '2020-05-31');
drop FUNCTION task1(start_ date, end_ date);

-- TASK 2
-- Разработать триггер на добавление клиента,
-- добавить, если ему уже исполнилось 18 лет, в противном случае откатить транзакцию
CREATE OR REPLACE FUNCTION age_test()
RETURNS TRIGGER AS
$$
    BEGIN
        IF (new.age < 18) THEN
           RAISE EXCEPTION 'Age < 18';
        end if;
        return new;
    END
$$
LANGUAGE plpgsql;

CREATE TRIGGER clients_insert_trigger
    AFTER INSERT
    ON clients FOR EACH ROW
    EXECUTE PROCEDURE age_test();

insert into clients (firstname, passport, age)
values ('Artem', '712321', 11);

-- TASK 3
-- Разработать триггер на добавление тура,
-- обновляющая общее число различных туров для тур-фирмы
CREATE OR REPLACE FUNCTION increment_tour()
RETURNS TRIGGER AS
$$
    BEGIN
        UPDATE travel_agency SET  count_tours = count_tours + 1 WHERE travel_agency.id = new.travel_agency_id;
        return new;
    END
$$
LANGUAGE plpgsql;
CREATE TRIGGER tour_insert_trigger
    AFTER INSERT
    ON tour FOR EACH ROW
    EXECUTE PROCEDURE increment_tour();

INSERT into tour (id, name, price, description, start_date, flight_time, travel_agency_id)
values (6, 'Tour 4', 1020, 'lorem ipsum dolor sit amet, consectetur adip', '2008-5-11',9, 1);
INSERT into countries_tour (country_id, tour_id) values (4, 6);


select table_name, column_name, data_type
from information_schema.columns
where table_schema='public'
order by table_name;
