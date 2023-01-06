create role "school_admin" with
    login
    encrypted password 'admin_password';

grant all privileges on all tables in schema public to "school_admin";

create role "school_student"
    login
    encrypted password 'student_password';

grant select on "author" to "school_student";
grant select on "book" to "school_student";
grant select on "event" to "school_student";
grant select on "subject" to "school_student";


