
create Table theater_bmt (id int, name varchar, description varchar, cinemaId int, location varchar)
create table seat_bmt (id int, name varchar, description varchar,percent int, theaterId int, location varchar)
create table schedule_date_bmt (id int,date varchar,percent int, location varchar)
create table schedule_time_bmt (id int, time varchar, price int, theaterId int, scheduleDateId int, movieId int, location varchar)
create table ticket_bmt (id int, price int, seatId int, scheduleTimeId int, customerId int, location int)

