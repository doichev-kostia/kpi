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
