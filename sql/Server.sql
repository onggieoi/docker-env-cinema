

create extension postgres_fdw;


----------------------------- partition1 - hcm ----------------------------------------------------

-------------- setup server -------------------------
create server partition1_server foreign data wrapper postgres_fdw options (host 'partition1', port '5432' , dbname 'partition1');
-- drop server master_server cascade

create user mapping for onggieoi server partition1_server options (user 'onggieoi', password 'onggieoi@123');

alter server partition1_server owner to onggieoi;

------- tables sharing ------------------------------
create foreign table theater_hcm (check(location='hochiminh')) inherits(theater ) server partition1_server;
create foreign table seat_hcm (check(location='hochiminh')) inherits(seat ) server partition1_server;
create foreign table schedule_date_hcm (check(location='hochiminh')) inherits(schedule_date ) server partition1_server;
create foreign table schedule_time_hcm (check(location='hochiminh')) inherits(schedule_time ) server partition1_server;
create foreign table ticket_hcm (check(location='hochiminh')) inherits(ticket ) server partition1_server;



-------------------------------------------------- partition2 - hn --------------------------------------------

create server partition2_server foreign data wrapper postgres_fdw options (host 'partition2', port '5432' , dbname 'partition2');

create user mapping for onggieoi server partition2_server options (user 'onggieoi', password 'onggieoi@123');

alter server partition2_server owner to onggieoi;

------- tables sharing ------------------------------
create foreign table theater_hn (check(location='hanoi')) inherits(theater) server partition2_server;
create foreign table seat_hn (check(location='hanoi')) inherits(seat ) server partition2_server;
create foreign table schedule_date_hn (check(location='hanoi')) inherits(schedule_date ) server partition2_server;
create foreign table schedule_time_hn (check(location='hanoi')) inherits(schedule_time ) server partition2_server;
create foreign table ticket_hn (check(location='hanoi')) inherits(ticket ) server partition2_server;




--------------------------------------------------- partition3 - bmt -------------------------------------------------

create server partition3_server foreign data wrapper postgres_fdw options (host 'partition3', port '5432' , dbname 'partition3');

create user mapping for onggieoi server partition3_server options (user 'onggieoi', password 'onggieoi@123');

alter server partition3_server owner to onggieoi;

------- theater ------------------------------
create foreign table theater_bmt (check(location='bmt')) inherits(theater) server partition3_server;
create foreign table seat_bmt (check(location='bmt')) inherits(seat ) server partition3_server;
create foreign table schedule_date_bmt (check(location='bmt')) inherits(schedule_date ) server partition3_server;
create foreign table schedule_time_bmt (check(location='bmt')) inherits(schedule_time ) server partition3_server;
create foreign table ticket_bmt (check(location='bmt')) inherits(ticket ) server partition3_server;



--------------------------------- Triggers ------------------------------------------------------------------------------

---------- theater triggers ----------------------------------
create or replace function theater_trigger_fn() returns trigger as
$$
begin

    if new.location = 'hochiminh' then
        insert into theater_hcm values(new.*);
    elsif new.location = 'hanoi' then
        insert into theater_hn values(new.*);
    elsif new.location = 'bmt' then
        insert into theater_bmt values(new.*);
    end if;

    return null;
end
$$
language plpgsql;

create trigger theater_trigger before insert on theater for each row execute procedure theater_trigger_fn();


---------- seat triggers ----------------------------------
create or replace function seat_trigger_fn() returns trigger as
$$
begin

    if new.location = 'hochiminh' then
        insert into seat_hcm values(new.*);
    elsif new.location = 'hanoi' then
        insert into seat_hn values(new.*);
    elsif new.location = 'bmt' then
        insert into seat_bmt values(new.*);
    end if;

    return null;
end
$$
language plpgsql;

create trigger seat_trigger before insert on seat for each row execute procedure seat_trigger_fn();



---------- schedule Date triggers ----------------------------------
create or replace function schedule_date_trigger_fn() returns trigger as
$$
begin

    if new.location = 'hochiminh' then
        insert into schedule_date_hcm values(new.*);
    elsif new.location = 'hanoi' then
        insert into schedule_date_hn values(new.*);
    elsif new.location = 'bmt' then
        insert into schedule_date_bmt values(new.*);
    end if;

    return null;
end
$$
language plpgsql;

create trigger schedule_date_trigger before insert on schedule_date for each row execute procedure schedule_date_trigger_fn();



---------- schedule time triggers ----------------------------------
create or replace function schedule_time_trigger_fn() returns trigger as
$$
begin

    if new.location = 'hochiminh' then
        insert into schedule_time_hcm values(new.*);
    elsif new.location = 'hanoi' then
        insert into schedule_time_hn values(new.*);
    elsif new.location = 'bmt' then
        insert into schedule_time_bmt values(new.*);
    end if;

    return null;
end
$$
language plpgsql;

create trigger schedule_time_trigger before insert on schedule_time for each row execute procedure schedule_time_trigger_fn();



---------- tickets triggers ----------------------------------
create or replace function ticket_trigger_fn() returns trigger as
$$
begin

    if new.location = 'hochiminh' then
        insert into ticket_hcm values(new.*);
    elsif new.location = 'hanoi' then
        insert into ticket_hn values(new.*);
    elsif new.location = 'bmt' then
        insert into ticket_bmt values(new.*);
    end if;

    return null;
end
$$
language plpgsql;

create trigger ticket_trigger before insert on ticket for each row execute procedure ticket_trigger_fn();






------------------------------------------------ Testing -----------------------------------------------------------
insert into theater("name", "description" , "cinemaId", "location" ) values ('test', 'this is a test', 1, 'hochiminh')





