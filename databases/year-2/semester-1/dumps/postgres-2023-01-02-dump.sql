--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0 (Debian 15.0-1.pgdg110+1)
-- Dumped by pg_dump version 15.0 (Debian 15.0-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: role_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.role_type AS ENUM (
    'student',
    'teacher',
    'headmaster'
);


ALTER TYPE public.role_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    country character varying(70) NOT NULL,
    city character varying(90) NOT NULL,
    street character varying(120) NOT NULL,
    house_number character varying(20) NOT NULL,
    flat_number character varying(20),
    index integer,
    zip_code integer
);


ALTER TABLE public.address OWNER TO postgres;

--
-- Name: author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL
);


ALTER TABLE public.author OWNER TO postgres;

--
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(120) NOT NULL,
    published_at smallint NOT NULL,
    author_id uuid NOT NULL
);


ALTER TABLE public.book OWNER TO postgres;

--
-- Name: class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.class (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(50) NOT NULL,
    classroom_id uuid,
    school_id uuid NOT NULL
);


ALTER TABLE public.class OWNER TO postgres;

--
-- Name: classroom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classroom (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(50) NOT NULL,
    number integer NOT NULL,
    school_id uuid NOT NULL
);


ALTER TABLE public.classroom OWNER TO postgres;

--
-- Name: event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    class_id uuid,
    role_id uuid,
    classroom_id uuid,
    subject_id uuid,
    book_id uuid
);


ALTER TABLE public.event OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    type public.role_type NOT NULL,
    user_id uuid NOT NULL,
    school_id uuid NOT NULL,
    class_id uuid,
    subject_id uuid
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: school; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.school (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    address_id uuid NOT NULL
);


ALTER TABLE public.school OWNER TO postgres;

--
-- Name: subject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subject (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    credits real NOT NULL,
    name character varying(100) NOT NULL,
    book_id uuid NOT NULL
);


ALTER TABLE public.subject OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name character varying(60) NOT NULL,
    last_name character varying(60) NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address (id, country, city, street, house_number, flat_number, index, zip_code) FROM stdin;
536d59c0-44a4-4576-94a3-4e06e5d93c13	China	Erdao	Valley Edge	40691	\N	71	\N
60583926-a342-4d19-948a-7ac899a83421	Indonesia	Jamban	Muir	9	\N	\N	\N
0ec1794d-bc82-4151-b0f5-0f85b7e32a8b	Germany	Augsburg	Trailsway	004	125	81	\N
4fbf1c26-d6fa-4055-aed9-54f77a5ca419	China	Songshan	Kensington	332	\N	50	\N
c02c3d52-3bd1-4626-b867-ade091614071	Brazil	Matriz de Camaragibe	Dwight	3001	307	49	\N
65762a9d-6ab5-4b5b-b688-2589cfa753fc	Philippines	Luna	Stephen	0	\N	37	\N
7a2535be-4241-461a-8bbe-e2e9c3df3c5c	Philippines	Nagpandayan	Schmedeman	783	\N	57	72
8860fe9b-3de4-49a0-b3aa-d2abbb6362f2	Portugal	Vila Verde	Fairview	89	\N	67	99
88735e52-9cb8-4f9d-9e4a-b65d7afd4f78	China	Dicun	Manley	072	\N	41	78
e666488b-2f9c-4836-98bf-a63e213518f6	China	Xiaoxiang	Packers	754	\N	38	\N
fa40b67e-afe2-468c-a4ff-9dd31d653618	China	Jinniu	Alpine	999	90	7	\N
08086ba1-c06c-43a7-a286-c6cbee132481	Ukraine	Merefa	Londonderry	65	238	78	54
207e05c5-beb9-4e1c-932d-d24b21d3fc67	Philippines	Giawang	Southridge	8596	153	\N	68
8439b6eb-8046-4d7d-9531-9479ee17c0ca	New Zealand	Timaru	Fieldstone	1	\N	99	\N
73b8d1e8-064d-4ac4-97ac-8bd7e53a1c86	Japan	Uozu	Pleasure	150	590	25	\N
8d017ce9-4c3c-4360-a89b-ee5aacd040aa	China	Fendou	Del Sol	56822	\N	23	1
379e9279-2406-4ef4-9027-b1dcdba288f0	Slovenia	Kostel	Express	5	836	45	\N
ada7f707-2e91-46c6-b141-d9ead9ea64b3	China	Nyinqug	Sommers	3233	\N	9	7
e5ba1d69-4772-4dac-833d-62249d5c1c28	China	Hougaoshizhuang	Lillian	3	742	76	48
a74eb7d2-6d07-40a2-9741-3aa3e61276f6	Morocco	Tanalt	Springs	16465	\N	26	\N
\.


--
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.author (id, first_name, last_name) FROM stdin;
4383bcdb-5360-4bcb-9c78-d3d1452aadb4	Emmy	Hessentaler
64db93d2-52d7-4509-b0bd-c4692db46053	Wallis	Liverock
476922ea-08e8-4601-bbf7-50bc08c95ef0	Kittie	Sandison
c6f9cae2-c187-4f10-b1f5-c75fde1d066b	Ola	Fryett
03e88852-7fbf-4b0e-98cf-786e85824ab4	Annis	Beeck
7f59d002-d700-416e-a121-d918ddf48090	Tully	Vickerman
fc357bce-25f5-4b21-b4de-64715a6fda1b	Fania	Mollen
d28e1dcd-b5de-4531-a45e-80d63425970e	Flore	Feaks
9d0a4675-9d41-489b-a88d-3d2043dc4aac	Temp	Ditchfield
c0e4b907-4345-4b6d-aad8-2b3b4e70529b	Doralin	O' Byrne
22830915-05c9-4335-ac91-03579434d2e0	Tomasina	Bentzen
e427dea1-2069-48e6-82f4-c40b164987eb	Codie	Setterfield
3a893132-251b-4488-a23d-b25d76e2258f	Freida	Sargant
6699998e-5bcf-4a5c-9cb7-ebd62b43b54c	Thibaut	Garrud
eb8f8df1-992f-41f0-9283-842887ce420d	Bord	Kilian
a9d64909-2745-41e2-915f-c70df66932a7	Meridith	Upchurch
c3f0435a-d834-4c20-92c9-9cceb38d86a3	Nevsa	Maiklem
7985d128-6d0f-4898-a854-5b5d37ff5919	Sasha	Scarf
2cdde854-b33f-4532-9773-7b33daf6f58c	Seana	Poultney
b7185d26-0a16-4ce6-9105-11dbad0473fc	Gerda	Ellor
\.


--
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book (id, name, published_at, author_id) FROM stdin;
78351623-63b0-4cbe-84de-b8638cab8c13	Chronicle of the Years of Fire (Chronique des années de braise)	1993	4383bcdb-5360-4bcb-9c78-d3d1452aadb4
1c732db7-de81-476e-82e7-4ac87dc91d89	Rat Pfink a Boo Boo	1999	64db93d2-52d7-4509-b0bd-c4692db46053
ad103f84-4276-4bf1-b27d-a7e3e6a1ea62	Backbeat	2002	476922ea-08e8-4601-bbf7-50bc08c95ef0
867e8e15-1222-4ff2-913b-5423edff9b0d	Hugo Pool	2002	c6f9cae2-c187-4f10-b1f5-c75fde1d066b
20f88e02-d0a5-4d13-83b4-17a92f8d4756	Lot Like Love, A	1973	03e88852-7fbf-4b0e-98cf-786e85824ab4
e365fe79-70dc-4bb3-8646-1ccd007440a7	That's Black Entertainment	1992	7f59d002-d700-416e-a121-d918ddf48090
ba10cf38-757b-48c4-a506-14320b5273d3	Thieves' Highway	1997	fc357bce-25f5-4b21-b4de-64715a6fda1b
31498a0c-08f8-4345-a237-a25d2aaf3e7e	All Things Fair (Lust och fägring stor)	1992	d28e1dcd-b5de-4531-a45e-80d63425970e
8e3a5e26-9125-4447-84a0-143c29cec712	Busting	1998	9d0a4675-9d41-489b-a88d-3d2043dc4aac
25a7ab98-9994-421a-8e82-558ef5f1deda	Gasland Part II	1989	c0e4b907-4345-4b6d-aad8-2b3b4e70529b
96a0072c-6e05-4dbf-ade1-789042042637	Tol'able David	2000	22830915-05c9-4335-ac91-03579434d2e0
228c446a-01ca-4462-bcc5-0f41d9fa7aa9	Look Who's Talking Too	2006	e427dea1-2069-48e6-82f4-c40b164987eb
fd5596ef-d765-4c96-8348-f2a2b589513a	My Mother (Ma mère)	2004	3a893132-251b-4488-a23d-b25d76e2258f
918b30f9-9562-4191-b004-80950cd3ba61	Story Written with Water, A (Mizu de kakareta monogatari)	2008	6699998e-5bcf-4a5c-9cb7-ebd62b43b54c
f3a82432-7e7f-4932-9b81-332d8c333749	Village, The	2004	eb8f8df1-992f-41f0-9283-842887ce420d
a73a6aed-8c10-4ffd-b35c-5095eb177901	Miracle Woman, The	1999	a9d64909-2745-41e2-915f-c70df66932a7
7c5a9092-8701-4509-bdb4-456940058115	Way of the Dragon, The (a.k.a. Return of the Dragon) (Meng long guo jiang)	1968	c3f0435a-d834-4c20-92c9-9cceb38d86a3
c6800f9e-3077-4355-b91c-c12333b9ebf6	Breaking the Girls 	2001	7985d128-6d0f-4898-a854-5b5d37ff5919
29ffbc5e-7275-40e3-b227-ec2fcf7bd072	Revolution	2006	2cdde854-b33f-4532-9773-7b33daf6f58c
ba14c948-cc86-43d5-b319-c4339cd5db62	Misérables, Les	1995	b7185d26-0a16-4ce6-9105-11dbad0473fc
\.


--
-- Data for Name: class; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.class (id, name, classroom_id, school_id) FROM stdin;
96a42758-13b9-42fc-a307-f4e4a1b90a93	Renner LLC	408096c0-a630-495b-bdf0-5d0a35e0767e	386852c4-2c2e-4097-ba86-4f24f03726c7
b643bfc9-a0f3-405b-ad67-3c9045d65f2a	Zboncak-Schiller	cdeb8c99-7a79-433b-9475-3339652f7850	9e557ce0-57f5-4418-84c7-30875b55d6bd
dd55cba1-f847-4f12-af57-a440f1d65b07	Beier-Collins	7eaf15e0-090d-4b7c-b590-c11e8fc7fb08	0836cffb-2846-4ade-a032-b799e1cfa34d
67efdb78-7331-403e-9dde-e8e38137d389	Kulas and Sons	be52b4ef-b38c-48e1-8b8f-5d33cc811489	35cb6bb4-04e1-42c0-ab9c-fe70d3ac8522
e2333865-3c94-44b4-b836-7fe3d75af139	Sporer LLC	717648a6-a9b0-4d18-8ae3-7b217ed4dd62	ebc73228-b241-4262-b865-11c9b507184f
56a5bf5b-d646-415d-8b72-27f3352a3ae7	Hickle LLC	4f6a9791-1078-438e-bf3c-a5cb62770840	d1fd9ae9-41bd-46b6-bb8b-bdcac6c52092
96ded43e-98c4-46eb-a08f-8862408a874e	Koelpin-Rogahn	6055683d-d135-4689-8c24-a23675f7eff6	40e4ab4c-a90b-4f8d-8366-24337d15b69d
98fd3383-465f-4136-8893-be172c70119d	Stroman, Ryan and Greenholt	00075d47-e411-450b-9c40-7f77864a0d60	b9756995-a82e-4046-88a6-6f1676c32c47
c18f1299-aa6f-4f0e-b3a7-00727a86d94a	Stamm, Brown and Waelchi	c5bd49fa-bea9-40f8-863d-c90be8d75c37	f8d41962-e36c-40b7-8852-86af2afce85f
c3b651bd-4ac6-4b2a-a914-e170dc960dfc	Fadel and Sons	632caf99-616d-4c6c-a635-e3c56c0d45ee	d1089f3a-ef6a-4c5f-90fa-8190a855e36b
c264b6f9-c989-45ba-b16d-430ff7830e1b	Rohan, Gibson and Borer	\N	386852c4-2c2e-4097-ba86-4f24f03726c7
ba3956e8-fdaa-461e-b230-7f24d7d7e147	Ryan-Casper	\N	9e557ce0-57f5-4418-84c7-30875b55d6bd
1e575b36-ee6d-4057-9dc5-429b1027d07e	Roberts, Rowe and Hyatt	\N	0836cffb-2846-4ade-a032-b799e1cfa34d
e3ccd79c-3ba5-4546-80d7-416f49885daa	Cormier Group	\N	35cb6bb4-04e1-42c0-ab9c-fe70d3ac8522
4849a850-8f61-4c77-8047-35275f6dddc7	Schaden, Schinner and Bauch	\N	ebc73228-b241-4262-b865-11c9b507184f
f4ab0bbb-c077-4827-bc28-c24a258276d0	Smitham, Durgan and Cremin	\N	d1fd9ae9-41bd-46b6-bb8b-bdcac6c52092
73a34bdc-98c9-4f8f-9955-d3764c1335a6	Gerlach-Wuckert	\N	40e4ab4c-a90b-4f8d-8366-24337d15b69d
9261119d-0160-4a05-93e4-4483c8c93387	Hyatt, Franecki and Beer	\N	b9756995-a82e-4046-88a6-6f1676c32c47
74330f34-d740-4fa9-b9af-f47c56b873db	Kub Group	\N	f8d41962-e36c-40b7-8852-86af2afce85f
ca031c1c-d39e-4d8e-8d8e-952d7e9b57c3	Price Group	\N	d1089f3a-ef6a-4c5f-90fa-8190a855e36b
\.


--
-- Data for Name: classroom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classroom (id, name, number, school_id) FROM stdin;
408096c0-a630-495b-bdf0-5d0a35e0767e	Turner-White	123	386852c4-2c2e-4097-ba86-4f24f03726c7
147fb12c-2b6a-49f8-a02f-f9e740b8d7b6	Fritsch LLC	382	9e557ce0-57f5-4418-84c7-30875b55d6bd
6603fe62-2cf6-444c-8db3-e19ccbdf761c	McLaughlin and Sons	946	0836cffb-2846-4ade-a032-b799e1cfa34d
be52b4ef-b38c-48e1-8b8f-5d33cc811489	Hills-Torphy	383	35cb6bb4-04e1-42c0-ab9c-fe70d3ac8522
7c1420a0-e3bd-4e63-b6c1-ac77ad71bafb	Boyle, Kemmer and Schamberger	195	ebc73228-b241-4262-b865-11c9b507184f
4f6a9791-1078-438e-bf3c-a5cb62770840	Hodkiewicz, Dickens and Stehr	722	d1fd9ae9-41bd-46b6-bb8b-bdcac6c52092
4b194044-db63-41ef-b816-67915019ccc9	Rath Group	64	40e4ab4c-a90b-4f8d-8366-24337d15b69d
00075d47-e411-450b-9c40-7f77864a0d60	Bahringer, Hansen and Ledner	246	b9756995-a82e-4046-88a6-6f1676c32c47
c5bd49fa-bea9-40f8-863d-c90be8d75c37	Zboncak Inc	786	f8d41962-e36c-40b7-8852-86af2afce85f
4eaeceab-6676-4600-8996-4a20fe586412	Schamberger, Denesik and Emard	83	d1089f3a-ef6a-4c5f-90fa-8190a855e36b
90961900-f9ba-46f5-b42f-57a27ae2bd28	Swift-Osinski	924	386852c4-2c2e-4097-ba86-4f24f03726c7
cdeb8c99-7a79-433b-9475-3339652f7850	Kunze-Braun	860	9e557ce0-57f5-4418-84c7-30875b55d6bd
7eaf15e0-090d-4b7c-b590-c11e8fc7fb08	Cruickshank, Halvorson and Morar	777	0836cffb-2846-4ade-a032-b799e1cfa34d
079c698f-408c-4359-a8b0-32e3d03b914b	Bode-Collier	124	35cb6bb4-04e1-42c0-ab9c-fe70d3ac8522
717648a6-a9b0-4d18-8ae3-7b217ed4dd62	Hintz-Morissette	40	ebc73228-b241-4262-b865-11c9b507184f
47994497-66b5-4aa5-9f9e-c630099205cd	Conn LLC	936	d1fd9ae9-41bd-46b6-bb8b-bdcac6c52092
6055683d-d135-4689-8c24-a23675f7eff6	Russel-Rau	335	40e4ab4c-a90b-4f8d-8366-24337d15b69d
eeede664-a849-499c-9d94-2ed0fcf061fb	Streich-Berge	178	b9756995-a82e-4046-88a6-6f1676c32c47
d8d4be5a-c19a-4a32-addb-e1797ff7f00e	Steuber-Lowe	713	f8d41962-e36c-40b7-8852-86af2afce85f
632caf99-616d-4c6c-a635-e3c56c0d45ee	Dietrich-Murphy	187	d1089f3a-ef6a-4c5f-90fa-8190a855e36b
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event (id, class_id, role_id, classroom_id, subject_id, book_id) FROM stdin;
e5a8e62f-0f12-4a66-956e-8a3f1836390e	96a42758-13b9-42fc-a307-f4e4a1b90a93	cdde6fcb-6b99-4809-b634-cd20f324c2ee	90961900-f9ba-46f5-b42f-57a27ae2bd28	fb257f25-03e4-4339-be7c-bd1df01a4a86	\N
1ffac42c-6111-44d3-8bea-c1914345514a	96a42758-13b9-42fc-a307-f4e4a1b90a93	cdde6fcb-6b99-4809-b634-cd20f324c2ee	408096c0-a630-495b-bdf0-5d0a35e0767e	a364ba9c-9078-4679-b098-bd151bb86afa	\N
f35cf563-98a6-4ca3-874c-06d36eee7289	96a42758-13b9-42fc-a307-f4e4a1b90a93	d8c15d4d-5c94-4b2c-ae54-7ae01bb7a6d2	90961900-f9ba-46f5-b42f-57a27ae2bd28	53f03d14-b63c-49c6-a626-754650f03667	\N
c40e09e2-17f7-4434-af23-0e231c28da1a	96a42758-13b9-42fc-a307-f4e4a1b90a93	402e28d8-9723-4507-9ac6-847830d13b8b	408096c0-a630-495b-bdf0-5d0a35e0767e	fac2890e-87b4-4e5b-8324-e7bca27465af	\N
9580a14b-513f-47de-ad42-0f64dd78cdf4	96a42758-13b9-42fc-a307-f4e4a1b90a93	2d4d4cc6-f6ed-48c6-aa4b-8085dbe86079	90961900-f9ba-46f5-b42f-57a27ae2bd28	2dfab516-dc73-490a-9cc0-fad8ca08f367	\N
ed717557-dadd-4013-b79c-4ad9040afbbd	b643bfc9-a0f3-405b-ad67-3c9045d65f2a	2d4d4cc6-f6ed-48c6-aa4b-8085dbe86079	\N	6ca986ba-ba22-448b-8273-449091cdb5f0	\N
12264a87-ff7b-467b-bd78-02bfea651bf1	b643bfc9-a0f3-405b-ad67-3c9045d65f2a	2d4d4cc6-f6ed-48c6-aa4b-8085dbe86079	147fb12c-2b6a-49f8-a02f-f9e740b8d7b6	0b6b0a20-4551-4200-bfec-eb4c713650ec	\N
78ceaaa9-f9c9-421c-98da-897268879f32	b643bfc9-a0f3-405b-ad67-3c9045d65f2a	42b99918-2718-4270-ac84-4c773c9d20ab	cdeb8c99-7a79-433b-9475-3339652f7850	7c505172-571a-48b2-b9e9-062665c404d7	\N
a6951c9c-76bd-406c-bcde-840ce4b356ed	b643bfc9-a0f3-405b-ad67-3c9045d65f2a	8161d53c-9839-4014-b221-d33971d623ee	147fb12c-2b6a-49f8-a02f-f9e740b8d7b6	3cfe6079-ab35-4604-9838-89e251d117ce	\N
c3865328-2007-4016-9ef9-4d2b807a9958	b643bfc9-a0f3-405b-ad67-3c9045d65f2a	d7bae4d4-fd2a-4e10-8db1-b671c0940361	\N	26d03e5e-31e2-4734-b564-65c26c52f39b	\N
bfee891c-a3b4-45a2-8486-65e3d585e0b2	b643bfc9-a0f3-405b-ad67-3c9045d65f2a	2d4d4cc6-f6ed-48c6-aa4b-8085dbe86079	\N	26d03e5e-31e2-4734-b564-65c26c52f39b	\N
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id, type, user_id, school_id, class_id, subject_id) FROM stdin;
6dd8d0ba-b15b-46af-a4d4-2ecd641ff778	student	dc37e6d8-173c-418b-a306-52146839bf52	386852c4-2c2e-4097-ba86-4f24f03726c7	96a42758-13b9-42fc-a307-f4e4a1b90a93	\N
73b7e254-7c9f-4951-a91b-354742864e67	student	e642905e-8d2a-462e-a53a-4e71abe6dc25	386852c4-2c2e-4097-ba86-4f24f03726c7	96a42758-13b9-42fc-a307-f4e4a1b90a93	\N
70d49cd3-db6e-4f89-9813-52bad54cb696	student	b0acbec0-4d97-4cc7-920b-8684341aabe8	386852c4-2c2e-4097-ba86-4f24f03726c7	96a42758-13b9-42fc-a307-f4e4a1b90a93	\N
04a26366-160a-4153-a517-d00fa55d194d	student	469a373a-22b8-463e-be0e-bac081b1824b	386852c4-2c2e-4097-ba86-4f24f03726c7	96a42758-13b9-42fc-a307-f4e4a1b90a93	\N
3058b5dc-ba9d-4a50-b965-093425d356f0	student	eb987d6e-8eea-4cd5-a266-c0e47908a126	386852c4-2c2e-4097-ba86-4f24f03726c7	96a42758-13b9-42fc-a307-f4e4a1b90a93	\N
e3aaa3da-83e2-46b8-aa11-944e66d60929	student	10bc048e-1fc8-482d-98c1-ebf90bb2f4c0	9e557ce0-57f5-4418-84c7-30875b55d6bd	b643bfc9-a0f3-405b-ad67-3c9045d65f2a	\N
197161b1-47fe-4f1e-a477-029778e92450	student	3b03354c-15a2-4c7a-974e-1807cb158363	9e557ce0-57f5-4418-84c7-30875b55d6bd	b643bfc9-a0f3-405b-ad67-3c9045d65f2a	\N
0b39e35c-ca15-4fe6-ae65-ad918f54e905	student	e8aaba53-c145-499e-b826-7b60c6236d46	9e557ce0-57f5-4418-84c7-30875b55d6bd	b643bfc9-a0f3-405b-ad67-3c9045d65f2a	\N
4b88b840-2c36-4ee8-981f-cf79d550ae5a	student	8e1f8e82-fc49-4e28-996b-ff31718f2ba1	9e557ce0-57f5-4418-84c7-30875b55d6bd	b643bfc9-a0f3-405b-ad67-3c9045d65f2a	\N
4de37463-1769-44e3-af16-27620f943cf0	teacher	bf251ba8-f20e-49c4-9770-972065512781	386852c4-2c2e-4097-ba86-4f24f03726c7	96a42758-13b9-42fc-a307-f4e4a1b90a93	fb257f25-03e4-4339-be7c-bd1df01a4a86
cdde6fcb-6b99-4809-b634-cd20f324c2ee	teacher	7277eff6-e51a-46e1-a038-3179340eafc8	386852c4-2c2e-4097-ba86-4f24f03726c7	\N	fb257f25-03e4-4339-be7c-bd1df01a4a86
d8c15d4d-5c94-4b2c-ae54-7ae01bb7a6d2	teacher	7e013e54-a2e0-4528-99c2-6d3a488f1dbd	386852c4-2c2e-4097-ba86-4f24f03726c7	\N	6ca986ba-ba22-448b-8273-449091cdb5f0
402e28d8-9723-4507-9ac6-847830d13b8b	teacher	281921cf-bbdd-4130-b009-4364ba8b01cd	386852c4-2c2e-4097-ba86-4f24f03726c7	\N	f31dce9e-36f8-4184-b692-dfad03c83816
20a9e921-45b1-4d2e-b4a9-3e6035eb9b2d	teacher	60610b8b-0940-45b3-a788-4cf8a4a4db98	386852c4-2c2e-4097-ba86-4f24f03726c7	\N	5144a134-4d66-4081-951b-fa00f498e490
2d4d4cc6-f6ed-48c6-aa4b-8085dbe86079	teacher	11a181f3-b50b-4b88-8575-bbcdc3994c9a	9e557ce0-57f5-4418-84c7-30875b55d6bd	b643bfc9-a0f3-405b-ad67-3c9045d65f2a	fac2890e-87b4-4e5b-8324-e7bca27465af
42b99918-2718-4270-ac84-4c773c9d20ab	teacher	6cd7205c-04dc-4901-88c0-6428400e067e	9e557ce0-57f5-4418-84c7-30875b55d6bd	\N	fac2890e-87b4-4e5b-8324-e7bca27465af
8161d53c-9839-4014-b221-d33971d623ee	teacher	153469cd-2364-47d0-8e17-f0881173db53	9e557ce0-57f5-4418-84c7-30875b55d6bd	\N	2dfab516-dc73-490a-9cc0-fad8ca08f367
d7bae4d4-fd2a-4e10-8db1-b671c0940361	teacher	f11ea9d6-1ffe-4ac8-915d-824bb12121c1	9e557ce0-57f5-4418-84c7-30875b55d6bd	\N	284adc94-1c89-40d2-8af6-f3c1aae13efd
feaf4c3a-418b-45b0-aa76-52982e775f05	headmaster	508ca451-01a1-4f60-b3c0-1140f0b2e8f4	386852c4-2c2e-4097-ba86-4f24f03726c7	\N	\N
8c2314ef-3d43-4994-950e-4f55ecdc1371	headmaster	7c1367d7-8375-4eb7-a6c0-7da8682c1986	9e557ce0-57f5-4418-84c7-30875b55d6bd	\N	\N
\.


--
-- Data for Name: school; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.school (id, name, address_id) FROM stdin;
386852c4-2c2e-4097-ba86-4f24f03726c7	Heathcote-Lind	536d59c0-44a4-4576-94a3-4e06e5d93c13
9e557ce0-57f5-4418-84c7-30875b55d6bd	Farrell-Strosin	60583926-a342-4d19-948a-7ac899a83421
0836cffb-2846-4ade-a032-b799e1cfa34d	Sporer-Thompson	0ec1794d-bc82-4151-b0f5-0f85b7e32a8b
35cb6bb4-04e1-42c0-ab9c-fe70d3ac8522	Pacocha-Kirlin	4fbf1c26-d6fa-4055-aed9-54f77a5ca419
ebc73228-b241-4262-b865-11c9b507184f	Hayes Inc	c02c3d52-3bd1-4626-b867-ade091614071
d1fd9ae9-41bd-46b6-bb8b-bdcac6c52092	Kuvalis, Friesen and Veum	65762a9d-6ab5-4b5b-b688-2589cfa753fc
40e4ab4c-a90b-4f8d-8366-24337d15b69d	Crona, Connelly and Hand	7a2535be-4241-461a-8bbe-e2e9c3df3c5c
b9756995-a82e-4046-88a6-6f1676c32c47	Kunde Group	8860fe9b-3de4-49a0-b3aa-d2abbb6362f2
f8d41962-e36c-40b7-8852-86af2afce85f	Torp-Willms	88735e52-9cb8-4f9d-9e4a-b65d7afd4f78
d1089f3a-ef6a-4c5f-90fa-8190a855e36b	Welch, Connelly and Dicki	e666488b-2f9c-4836-98bf-a63e213518f6
d88d486d-9f1e-48a1-93e0-217547d2ca67	Hermann-Jast	fa40b67e-afe2-468c-a4ff-9dd31d653618
\.


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subject (id, credits, name, book_id) FROM stdin;
fb257f25-03e4-4339-be7c-bd1df01a4a86	97.6	Mort	78351623-63b0-4cbe-84de-b8638cab8c13
6ca986ba-ba22-448b-8273-449091cdb5f0	97	Tiena	1c732db7-de81-476e-82e7-4ac87dc91d89
f31dce9e-36f8-4184-b692-dfad03c83816	93.3	Merline	ad103f84-4276-4bf1-b27d-a7e3e6a1ea62
5144a134-4d66-4081-951b-fa00f498e490	83.9	Adele	867e8e15-1222-4ff2-913b-5423edff9b0d
c80d4996-2bb4-48c5-b88d-b933108ffa02	30.3	Hewe	20f88e02-d0a5-4d13-83b4-17a92f8d4756
80e4c4ff-347c-4714-aecd-61a2b8ae5945	14.9	Wilbur	e365fe79-70dc-4bb3-8646-1ccd007440a7
a364ba9c-9078-4679-b098-bd151bb86afa	55.2	Sanders	ba10cf38-757b-48c4-a506-14320b5273d3
53f03d14-b63c-49c6-a626-754650f03667	61.8	Rea	31498a0c-08f8-4345-a237-a25d2aaf3e7e
fac2890e-87b4-4e5b-8324-e7bca27465af	5.2	Iseabal	8e3a5e26-9125-4447-84a0-143c29cec712
2dfab516-dc73-490a-9cc0-fad8ca08f367	51.3	Goran	25a7ab98-9994-421a-8e82-558ef5f1deda
284adc94-1c89-40d2-8af6-f3c1aae13efd	61	Ralph	96a0072c-6e05-4dbf-ade1-789042042637
815155d5-c901-4a25-ba8d-e2c30b7c8441	35.8	Abey	228c446a-01ca-4462-bcc5-0f41d9fa7aa9
63ec8791-e2b3-43b3-bca3-e43193a8d052	41.5	Gal	fd5596ef-d765-4c96-8348-f2a2b589513a
a6388b00-af6f-483c-b891-cd6181adad3b	89.4	Geno	918b30f9-9562-4191-b004-80950cd3ba61
57eea28e-47e2-4113-8193-a3e9f60d16f7	2	Cecily	f3a82432-7e7f-4932-9b81-332d8c333749
c4e51a55-22cf-4930-82c8-4a2b3534cd2e	17.1	Johannes	a73a6aed-8c10-4ffd-b35c-5095eb177901
0b6b0a20-4551-4200-bfec-eb4c713650ec	40	Madelon	7c5a9092-8701-4509-bdb4-456940058115
7c505172-571a-48b2-b9e9-062665c404d7	36.2	Vivian	c6800f9e-3077-4355-b91c-c12333b9ebf6
3cfe6079-ab35-4604-9838-89e251d117ce	23.6	Federica	29ffbc5e-7275-40e3-b227-ec2fcf7bd072
26d03e5e-31e2-4734-b564-65c26c52f39b	20	Lira	ba14c948-cc86-43d5-b319-c4339cd5db62
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, first_name, last_name) FROM stdin;
dc37e6d8-173c-418b-a306-52146839bf52	Barbette	Pawlick
e642905e-8d2a-462e-a53a-4e71abe6dc25	Maison	McManus
b0acbec0-4d97-4cc7-920b-8684341aabe8	Kath	Davidou
469a373a-22b8-463e-be0e-bac081b1824b	Wynn	Freezor
eb987d6e-8eea-4cd5-a266-c0e47908a126	Dew	Okey
10bc048e-1fc8-482d-98c1-ebf90bb2f4c0	Trenna	Handes
3b03354c-15a2-4c7a-974e-1807cb158363	Tabatha	Medina
e8aaba53-c145-499e-b826-7b60c6236d46	Wyatan	Castiglioni
8e1f8e82-fc49-4e28-996b-ff31718f2ba1	Ajay	Nairn
bf251ba8-f20e-49c4-9770-972065512781	Alfie	Jennison
7277eff6-e51a-46e1-a038-3179340eafc8	Franklin	Adamek
7e013e54-a2e0-4528-99c2-6d3a488f1dbd	Nikolia	Blaisdale
281921cf-bbdd-4130-b009-4364ba8b01cd	Lenci	Moneti
60610b8b-0940-45b3-a788-4cf8a4a4db98	Antonio	Redholes
11a181f3-b50b-4b88-8575-bbcdc3994c9a	Kippie	Ponsford
6cd7205c-04dc-4901-88c0-6428400e067e	Carlin	Haggar
153469cd-2364-47d0-8e17-f0881173db53	Constance	Massie
f11ea9d6-1ffe-4ac8-915d-824bb12121c1	Timmie	Kilfedder
508ca451-01a1-4f60-b3c0-1140f0b2e8f4	Kyrstin	Degan
7c1367d7-8375-4eb7-a6c0-7da8682c1986	Joanna	Absolem
\.


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (id);


--
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);


--
-- Name: class class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_pkey PRIMARY KEY (id);


--
-- Name: classroom classroom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classroom
    ADD CONSTRAINT classroom_pkey PRIMARY KEY (id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: school school_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school
    ADD CONSTRAINT school_pkey PRIMARY KEY (id);


--
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: school fk_address; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.school
    ADD CONSTRAINT fk_address FOREIGN KEY (address_id) REFERENCES public.address(id);


--
-- Name: book fk_author; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES public.author(id);


--
-- Name: subject fk_book; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES public.book(id);


--
-- Name: event fk_book; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES public.book(id);


--
-- Name: role fk_class; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT fk_class FOREIGN KEY (class_id) REFERENCES public.class(id);


--
-- Name: event fk_class; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk_class FOREIGN KEY (class_id) REFERENCES public.class(id);


--
-- Name: class fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT fk_classroom FOREIGN KEY (classroom_id) REFERENCES public.classroom(id);


--
-- Name: event fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk_classroom FOREIGN KEY (classroom_id) REFERENCES public.classroom(id);


--
-- Name: event fk_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public.role(id);


--
-- Name: classroom fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classroom
    ADD CONSTRAINT fk_school FOREIGN KEY (school_id) REFERENCES public.school(id);


--
-- Name: class fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT fk_school FOREIGN KEY (school_id) REFERENCES public.school(id);


--
-- Name: role fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT fk_school FOREIGN KEY (school_id) REFERENCES public.school(id);


--
-- Name: event fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk_subject FOREIGN KEY (subject_id) REFERENCES public.subject(id);


--
-- Name: role fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT fk_subject FOREIGN KEY (subject_id) REFERENCES public.subject(id);


--
-- Name: role fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: TABLE author; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.author TO school_student;


--
-- Name: TABLE book; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.book TO school_student;


--
-- Name: TABLE event; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.event TO school_student;


--
-- Name: TABLE subject; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.subject TO school_student;


--
-- PostgreSQL database dump complete
--

