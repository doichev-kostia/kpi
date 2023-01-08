-- get_events_on_date

create or replace function get_events_on_date(
    search_date date
)
returns table (
    event_id uuid,
    movie_id uuid,
    movie_name varchar(120),
    starts_at timestamp
               )
language plpgsql
as
    $$
    begin
        return query
        select
            e.id as event_id,
            e.movie_id,
            m.title as movie_name,
            e.starts_at
        from
            public.event e
        join
            public.movie m
        on
            e.movie_id = m.id
        where
            e.starts_at::date = search_date;
    end;
    $$;


select * from get_events_on_date('2023-01-12');

-- get_events_today

create or replace function get_events_today()
returns table (
    event_id uuid,
    movie_id uuid,
    movie_name varchar(120),
    starts_at timestamp
               )
language plpgsql
as
    $$
    begin
        return query
        select
            e.id as event_id,
            e.movie_id,
            m.title as movie_name,
            e.starts_at
        from
            public.event e
        join
            public.movie m
        on
            e.movie_id = m.id
        where
            e.starts_at::date = current_date;
    end;
    $$;


select * from get_events_today();

-- apply discount to the specific ticket

create or replace procedure apply_discount_for_ticket(
    ticket_id uuid, discount int
    )
    language plpgsql
as
$$
begin
    update ticket
    set price = price - (price * discount / 100)
    where id = ticket_id;
end;
$$;

-- order item with price details
create or replace view detailed_order_item as
select o.id, o.order_id, o.quantity, coalesce(p.price, 0) as product_price, coalesce(t.price, 0) as ticket_price
from public.order_item as "o"
         left join "product" as "p" on "p".id = "o".product_id
         left join "ticket" t on o.ticket_id = t.id;

-- calculate order total

create or replace function calculate_order_total(ordr_id uuid, discount int default 0) returns int
    language plpgsql as
$$
declare
    total           int := 0;
    ordr_item       record;
begin
    for ordr_item in select * from detailed_order_item where order_id = ordr_id
        loop
            total := total + (ordr_item.quantity * ordr_item.product_price) + (ordr_item.quantity * ordr_item.ticket_price);
        end loop;

    return total - (total * discount / 100);
end;
$$;

-- on cinema details change
create or replace function handle_cinema_details_change()
    returns trigger
    as $$
    begin
        raise notice 'Do not forget to update the website with the new cinema details';
        return new;
    end;
    $$
    language plpgsql;

create trigger cinema_details_change
    after update or insert or delete or truncate
    on cinema
    for each statement
    execute procedure handle_cinema_details_change();

-- get cinema rooms count
select cinema.name, count(r.id)
from cinema
inner join room r on cinema.id = r.cinema_id
group by cinema.name
order by cinema.name;

-- get ticket details
create or replace view ticket_information as
select t.id as "ticket_id",
       t.price as "ticket_price",
       m.title as "movie_title",
       s.row as "seat_row",
       s.number as "seat_number",
       r.name as "room_name",
       to_char(e.starts_at, 'dd.mm.yyyyThh:mm') as "event_starts_at",
       (m.duration / 60.0 / 60)::numeric(3,1) as "movie_duration"
    from ticket as t
inner join event as e on e.id = t.event_id
inner join seat as s on t.seat_id = s.id
inner join movie as m on e.movie_id = m.id
inner join room r on e.room_id = r.id;

select * from ticket_information where ticket_id = 'd76b814e-0807-4c45-a98b-758d1d18e793';

-- cinema location
select "c".name, "a".city, "a".street, "a".house_number
    from "cinema" as "c"
inner join address as "a" on "a".id = c.address_id;


-- average bill
select c.id, concat(c.first_name, ' ', c.last_name) as "name", avg(calculate_order_total(o.id))::int as "avg_order_total"

    from "customer" as "c"
inner join "order" as "o" on "o".customer_id = c.id
group by c.id, "name"
order by "name";

-- event info
select "m".title, "r".name, "c".name, event.starts_at::date
from "event"
         inner join movie m on event.movie_id = m.id
         inner join room r on r.id = event.room_id
         inner join cinema c on r.cinema_id = c.id
where event.id = '2ee806a4-f705-46f1-84de-ee09b97f035f';
