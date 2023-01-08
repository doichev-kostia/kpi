create type "public"."seat_type" as enum ('standard', 'premium', 'luxury');

create table if not exists "address" (
    "id" uuid primary key default gen_random_uuid(),
    "country" varchar(70) not null,
    "city" varchar(90) not null,
    "street" varchar(120) not null,
    "house_number" varchar(20) not null,
    "index" varchar(15) not null
);

create table if not exists "cinema" (
    "id" uuid primary key default gen_random_uuid(),
    "name" varchar(120) not null,
    "address_id" uuid not null,
    "phone_number" varchar(20) not null,
    "email" varchar(120) not null
);

alter table "cinema" add constraint "fk_cinema_address" foreign key ("address_id") references "address" ("id");

create table if not exists "room" (
    "id" uuid primary key default gen_random_uuid(),
    "cinema_id" uuid not null,
    "name" varchar(120) not null
);

alter table "room" add constraint "fk_room_cinema" foreign key ("cinema_id") references "cinema" ("id");

create table if not exists "seat" (
    "id" uuid primary key default gen_random_uuid(),
    "room_id" uuid not null,
    "row" int not null,
    "number" int not null,
    "type" seat_type not null
);

alter table "seat" add constraint "fk_seat_room" foreign key ("room_id") references "room" ("id");

create table if not exists "movie" (
    "id" uuid primary key default gen_random_uuid(),
    "title" varchar(120) not null,
    "description" text not null,
    "duration" int not null,
    "release_date" date not null,
    "rating" real not null,
    "genres" text not null,
    "directors" text not null,
    "actors" text not null,
    "poster_url" text not null
);

create table if not exists "price" (
    "id" uuid primary key default gen_random_uuid(),
    "movie_id" uuid not null,
    "seat_type" seat_type not null,
    "price" int not null,
    -- ISO 4217 currency code
    "currency" varchar(3) not null
);

alter table "price" add constraint "fk_price_movie" foreign key ("movie_id") references "movie" ("id");

create table if not exists "event" (
    "id" uuid primary key default gen_random_uuid(),
    "movie_id" uuid not null,
    "room_id" uuid not null,
    "starts_at" timestamp not null,
    "ends_at" timestamp not null
);

alter table "event" add constraint "fk_event_movie" foreign key ("movie_id") references "movie" ("id");
alter table "event" add constraint "fk_event_room" foreign key ("room_id") references "room" ("id");

create table if not exists "ticket" (
    "id" uuid primary key default gen_random_uuid(),
    "event_id" uuid not null,
    "seat_id" uuid not null,
    "price" int not null
);

alter table "ticket" add constraint "fk_ticket_event" foreign key ("event_id") references "event" ("id");
alter table "ticket" add constraint "fk_ticket_seat" foreign key ("seat_id") references "seat" ("id");

create table if not exists "product" (
    "id" uuid primary key default gen_random_uuid(),
    "name" varchar(120) not null,
    "price" int not null
);

create table if not exists "customer" (
    "id" uuid primary key default gen_random_uuid(),
    "first_name" varchar(80) not null,
    "last_name" varchar(80) not null,
    "phone_number" varchar(20) not null,
    "email" varchar(120) not null,
    "password" varchar(120) not null,
    constraint "user_email" unique ("email")
);

create table if not exists "order" (
    "id" uuid primary key default gen_random_uuid(),
    "customer_id" uuid,
    "price" int not null
);

alter table "order" add constraint "fk_order_customer" foreign key ("customer_id") references "customer" ("id");

create table if not exists "order_item" (
    "id" uuid primary key default gen_random_uuid(),
    "order_id" uuid not null,
    "product_id" uuid,
    "ticket_id" uuid,
    "quantity" int not null
);

alter table "order_item" add constraint "fk_order_item_order" foreign key ("order_id") references "order" ("id");
alter table "order_item" add constraint "fk_order_item_product" foreign key ("product_id") references "product" ("id");
alter table "order_item" add constraint "fk_order_item_ticket" foreign key ("ticket_id") references "ticket" ("id");
