create type role_type as enum ('student', 'teacher', 'headmaster');

alter table role
alter column type type role_type using type::role_type;



alter table author
alter column first_name type varchar(50) using first_name::varchar(50),
alter column last_name type varchar(50) using first_name::varchar(50);



alter table address
add index int,
add zip_code int,
add test int;

alter table address
drop column test;



alter table event
add column book_id uuid,
add constraint fk_book foreign key (book_id) references book(id);



