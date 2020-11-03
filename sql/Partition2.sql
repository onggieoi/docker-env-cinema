
create Table theater_hn (id int, name varchar, description varchar, cinemaId int, location varchar)
create table seat_hn (id int, name varchar, description varchar,percent int, theaterId int, location varchar)
create table schedule_date_hn (id int,date varchar,percent int, location varchar)
create table schedule_time_hn (id int, time varchar, price int, theaterId int, scheduleDateId int, movieId int, location varchar)
create table ticket_hn (id int, price int, seatId int, scheduleTimeId int, customerId int, location int)

