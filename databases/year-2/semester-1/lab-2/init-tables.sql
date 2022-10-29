create table if not exists address (
    id uuid primary key default gen_random_uuid(),
    country varchar(70) not null,
    city varchar(90) not null,
    street varchar(120) not null,
    house_number varchar(20) not null,
    flat_number varchar(20)
);

create table if not exists school (
    id uuid primary key default gen_random_uuid(),
    "name" varchar(100) not null,
    address_id uuid not null,
    constraint fk_address
        foreign key(address_id)
            references address(id)
);

create table if not exists author (
    id uuid primary key default gen_random_uuid(),
    first_name text not null,
    last_name text not null
);

create table if not exists book (
    id uuid primary key default gen_random_uuid(),
    "name" varchar(120) not null,
    published_at smallint not null,
    author_id uuid not null,
    constraint fk_author
        foreign key(author_id)
            references author(id)
);

create table if not exists classroom (
    id uuid primary key default gen_random_uuid(),
    "name" varchar(50) not null,
    number int not null,
    school_id uuid not null,
    constraint fk_school
        foreign key(school_id)
            references school(id)
);

create table if not exists class (
    id uuid primary key default gen_random_uuid(),
    "name" varchar(50) not null,
    classroom_id uuid,
    school_id uuid not null,
    constraint fk_classroom
        foreign key(classroom_id)
            references classroom(id),
    constraint fk_school
        foreign key(school_id)
            references school(id)
);

create table if not exists "user" (
    id uuid primary key default gen_random_uuid(),
    first_name varchar(60) not null,
    last_name varchar(60) not null
);



create table if not exists role (
    id uuid primary key default gen_random_uuid(),
    type varchar(50) not null,
    user_id uuid not null,
    school_id uuid not null,
    class_id uuid,
    constraint fk_user
        foreign key(user_id)
            references "user"(id),
    constraint fk_school
        foreign key(school_id)
            references school(id),
    constraint fk_class
        foreign key(class_id)
            references class(id)
);

create table if not exists subject (
    id uuid primary key default gen_random_uuid(),
    credits real not null,
    "name" varchar(100) not null,
    role_id uuid not null,
    book_id uuid not null,
    constraint fk_role
        foreign key(role_id)
            references role(id),
    constraint fk_book
        foreign key(book_id)
            references book(id)
);

create table if not exists event (
    id uuid primary key default gen_random_uuid(),
    class_id uuid,
    role_id uuid,
    classroom_id uuid,
    subject_id uuid,
    constraint fk_class
        foreign key(class_id)
            references class(id),
    constraint fk_role
        foreign key(role_id)
            references role(id),
    constraint fk_classroom
        foreign key(classroom_id)
            references classroom(id),
    constraint fk_subject
        foreign key(subject_id)
            references subject(id)
);
