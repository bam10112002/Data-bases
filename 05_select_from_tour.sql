select * from tour where price < 2000;
select * from tour where price >= 2000;
select * from tour where flight_time > 24;
select * from tour where flight_time <= 10;

select * from clients where id between 2 and 4;
select * from tour where flight_time between 9 and 12;
select * from tour where price between 2000 and 4500;

select * from clients where passport in('456274','223142');
select * from travel_agency where inn in('324653232');
select * from clients where firstname in('Artem');

select * from clients where clients.firstname like 'L%';
select * from clients where passport like '22';
select * from travel_agency where inn like '32';

select  * from clients where passport not null;
select  * from tour where description not null;
