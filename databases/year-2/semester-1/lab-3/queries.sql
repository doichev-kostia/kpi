-- Task 1

-- a
select concat(first_name, ' ', last_name) as "Full name"
from "user"
where first_name = 'Barbette';

-- b
select name, credits
from subject
where credits > 60;

-- c AND
select *
from address
where country = 'China' and house_number = '999';

-- c OR
select *
from address
where country = 'Morocco' or country = 'Brazil';

-- C NOT
select *
from address
where not country = 'China';

-- d
select *
from address
where (country = 'China' or country = 'Germany') and street = 'Trailsway';

-- e average
select avg(credits) as "Average credits"
from subject;

-- e modify column
select concat(first_name, ' ', last_name) as "Students"
from "user"
left join role on role.user_id = "user".id
where role.type = 'student';


-- f IN ()
select * from "role"
where class_id in ('96a42758-13b9-42fc-a307-f4e4a1b90a93', 'b643bfc9-a0f3-405b-ad67-3c9045d65f2a');

-- f between
select * from subject
where credits between 40 and 80;

-- f like/ilike
select *
from "user"
where first_name ilike '_arb%';

-- f in not null
select *
from address
where "zip_code" is not null;



-- Task 2

-- a column
select concat(first_name, ' ', last_name) as "Full name",
(select type from "role" where "role".user_id = "user".id ) as "Roles"
from "user"
where "user".first_name ilike 'b%';


-- a from
select detailed_books.name, detailed_books.author_name
from (
        select book.name, concat(author.first_name, ' ', author.last_name) as author_name
        from author, book
        where book.author_id = author.id
    ) as detailed_books
order by detailed_books.name;

-- b exists
-- select users that have a classroom attached to their class

select "user".first_name, "user".last_name
from "role"
inner join "user" on "user".id = "role".user_id
inner join "class" on "class".id = "role".class_id
where exists(
    select *
    from "classroom"
    where "class".classroom_id = "classroom".id
          );

-- b in
-- users that belong to school with a specific id
select concat("user".first_name, ' ', "user".last_name) as "Full name"
from "role"
inner join "user" on "user".id = "role".user_id
where class_id in (
    select id from "class"
    where "class".school_id = '386852c4-2c2e-4097-ba86-4f24f03726c7'
    );


