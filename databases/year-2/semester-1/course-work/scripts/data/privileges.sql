create role "manager"
with login
encrypted password '977ef10c-938f-4e5a-a4d2-02c21bb4db0f';

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public to "manager";
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO "manager";

create role "viewer"
with login
encrypted password '01bd6962-2f39-4a10-ab95-5a66ed9168ad';

GRANT SELECT ON ALL TABLES IN SCHEMA public to "viewer";
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO "viewer";

select * from information_schema.table_privileges
where grantee = 'manager';

select * from information_schema.table_privileges
where grantee = 'viewer';

select * from pg_roles where rolname not ilike 'pg_%';
