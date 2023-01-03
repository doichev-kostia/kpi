-- Task 1

-- a
select count(id) as "Number of books"
from "book"

-- b
select sum(credits) as "Total credits"
from "subject"

-- c upper
select upper(first_name) as "Uppercase name"
from "user"

-- c lower
select lower(first_name) as "Lowercase name"
from "user"

-- d
select name, (extract('year' from now()::date) - published_at) as "age"
from book;

-- e
select "class"."name", count("role".id)
from "role"
inner join "class" on "class".id = "role".class_id
group by "class"."name"
order by "class"."name";

-- f
select "class"."name", count("role".id)
from "role"
inner join "class" on "class".id = "role".class_id
group by "class"."name"
having count("role".id) > 5
order by "class"."name";

-- g
select sum(credits)
from subject
having sum(credits) > 10

-- h
-- order students by their full names in a class
select "class"."name",
       concat("u".first_name, ' ', "u".last_name) as "full_name",
        row_number() over (
            partition by "class".name order by concat("u".first_name, ' ', "u".last_name)
        ) as "student position"
from "role"
inner join "class" on "class".id = "role".class_id
inner join "user" u on u.id = role.user_id;

-- i
select "book".name, "book".published_at, concat("author"."first_name", ' ', "author"."last_name") as author_name
from "book"
inner join "author" on book.author_id = author.id
order by "book".published_at desc


-- Task 2

-- a
create or replace view role_with_teacher as
select "role".id, "user".first_name, "user".last_name, "teacher".id as "class_teacher_id"
from "role"
         inner join "user" on "user".id = "role".user_id
         left join "role" as "teacher"
                   on ("teacher"."class_id" = "role"."class_id" and "teacher"."type" = 'teacher');

select concat("roles".first_name, ' ', roles.last_name) as "Role", concat(r.first_name, ' ', r.last_name) as "Teacher"
from role_with_teacher as "roles"

inner join role_with_teacher as "r"

on "roles".class_teacher_id = "r".id;

-- b
create or replace view class_teacher as
select "class".name, concat("user".first_name, ' ', "user".last_name) as "Teacher"
from "class"
         inner join "role" on "role".class_id = "class".id
         inner join "role_with_teacher" on "role".id = "role_with_teacher".class_teacher_id
         inner join "user" on "user".id = "role".user_id
where "role".type = 'teacher'
order by name;

-- c
create or replace view students as
select u.first_name, u.last_name
from "user" as "u"
         inner join "role" as "r" on "u".id = "r".user_id
where r.type = 'student';

-- ALTER VIEW changes various auxiliary properties of a view. (If you want to modify the view's defining query, use CREATE OR REPLACE VIEW.)
-- https://www.postgresql.org/docs/current/sql-alterview.html
alter view students rename to all_students;

-- d
select * from pg_views where schemaname = 'public';
