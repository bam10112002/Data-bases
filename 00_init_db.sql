create table if not exists countries (
    id serial primary key,
    name varchar(255) not null unique,
    language varchar(255) not null
);

create table if not exists countries_tour(
    country_id serial,
    tour_id serial,
    PRIMARY KEY (country_id, tour_id)
                                         );

create table if not exists clients_tour(
    client_id serial not null,
    tour_id serial not null,
    discount int default 0,
    PRIMARY KEY (client_id, tour_id)
);

create table if not exists travel_agency (
    id serial not null primary key,
    name varchar(255) not null unique,
    inn varchar(255) not null unique
);

create table if not exists tour (
    id serial not null primary key,
    name varchar(255) not null unique,
    price integer not null,
    description text,
    start_date date not null,
    flight_time integer not null,
    travel_agency_id integer references travel_agency (id)
);

create table if not exists clients (
    id serial not null primary key,
    firstname varchar(255) not null,
    passport varchar(255)
);
