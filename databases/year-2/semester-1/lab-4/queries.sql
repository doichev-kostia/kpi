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
