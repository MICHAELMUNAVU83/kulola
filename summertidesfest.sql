--
-- PostgreSQL database dump
--

\restrict TQlTTbDfpeIyl9XvXePMSwCXvqicruvMAJhnDG052xzrFrRCYKWsWLMJXF0kBXH

-- Dumped from database version 17.7 (Ubuntu 17.7-0ubuntu0.25.04.1)
-- Dumped by pg_dump version 17.7 (Ubuntu 17.7-0ubuntu0.25.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint,
    product_name character varying(255) NOT NULL,
    size character varying(255),
    quantity integer DEFAULT 1 NOT NULL,
    unit_price integer NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    customer_name character varying(255) NOT NULL,
    customer_email character varying(255) NOT NULL,
    customer_phone character varying(255),
    total integer NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying,
    notes text,
    reference character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price integer NOT NULL,
    sizes character varying(255)[] DEFAULT ARRAY[]::character varying[],
    images character varying(255)[] DEFAULT ARRAY[]::character varying[],
    category character varying(255) NOT NULL,
    in_stock boolean DEFAULT true,
    stock_count integer DEFAULT 0,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email public.citext NOT NULL,
    hashed_password character varying(255) NOT NULL,
    confirmed_at timestamp(0) without time zone,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token bytea NOT NULL,
    context character varying(255) NOT NULL,
    sent_to character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.users_tokens OWNER TO postgres;

--
-- Name: users_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_tokens_id_seq OWNER TO postgres;

--
-- Name: users_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_tokens_id_seq OWNED BY public.users_tokens.id;


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens ALTER COLUMN id SET DEFAULT nextval('public.users_tokens_id_seq'::regclass);


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, product_name, size, quantity, unit_price, inserted_at, updated_at) FROM stdin;
1	1	5	Summer Tides Cap	One Size	3	1500	2026-03-12 09:10:53	2026-03-12 09:10:53
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, customer_name, customer_email, customer_phone, total, status, notes, reference, inserted_at, updated_at) FROM stdin;
1	Michael Munavu	michaelmunavu83@gmail.com	+254740769596	4500	processing	\N	ST-A4C09A12	2026-03-12 09:10:53	2026-03-12 09:11:13
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, description, price, sizes, images, category, in_stock, stock_count, inserted_at, updated_at) FROM stdin;
1	Summer Love Classic Tee	The iconic Summer Tides 2026 tee. 100% cotton, relaxed fit. Made for the beach, made for the crowd.	2500	{XS,S,M,L,XL,XXL}	{https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1503341504253-dff4815485f1?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1562157873-818bc0726f68?w=800&fit=crop&q=80}	Tees	t	100	2026-03-12 08:51:33	2026-03-12 08:51:33
2	Summer Tides Wave Tee	Limited edition wave-print tee. Ultra-soft fabric with a bold graphic on the back. Festival energy all year round.	2500	{S,M,L,XL,XXL}	{https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1529374255404-311a2a4f1fd9?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=800&fit=crop&q=80}	Tees	t	80	2026-03-12 08:51:33	2026-03-12 08:51:33
4	Summer Love Bucket Hat	Sun protection meets festival fashion. Reversible bucket hat with embroidered logo. One size fits all.	1800	{"One Size"}	{https://images.unsplash.com/photo-1572307480813-ceb0e59d8325?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1514327605112-b887c0e61c0a?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1617952739647-a0de90b1d4df?w=800&fit=crop&q=80}	Hats	t	60	2026-03-12 08:51:33	2026-03-12 08:51:33
5	Summer Tides Cap	Structured 6-panel cap with curved brim. Adjustable strap. Embroidered Summer Tides logo on front.	1500	{"One Size"}	{https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1596643397885-e9f7c3ff8a72?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1556306535-0f09a537f0a3?w=800&fit=crop&q=80}	Hats	t	75	2026-03-12 08:51:33	2026-03-12 08:51:33
6	Festival Beach Towel	XL microfibre beach towel with full Summer Tides 2026 graphic. Sand-resistant, quick-dry. Your festival essential.	2200	{"One Size"}	{https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1473116763249-2faaef81ccda?w=800&fit=crop&q=80}	Accessories	t	40	2026-03-12 08:51:33	2026-03-12 08:51:33
7	Summer Tides Tote Bag	Heavy-duty canvas tote. Carry your festival gear in style. Printed Summer Tides artwork on natural canvas.	1200	{"One Size"}	{https://images.unsplash.com/photo-1591561954557-26941169b49e?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&fit=crop&q=80,https://images.unsplash.com/photo-1547949003-9792a18a2601?w=800&fit=crop&q=80}	Accessories	t	90	2026-03-12 08:51:33	2026-03-12 08:51:33
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, inserted_at) FROM stdin;
20260311132947	2026-03-12 08:51:32
20260311140000	2026-03-12 08:51:32
20260311140001	2026-03-12 08:51:32
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, hashed_password, confirmed_at, inserted_at, updated_at) FROM stdin;
1	admin@gmail.com	$2b$12$F8vvM9ws.Uf8iA1aowOpa.a9YTBuI3hoIWveYW.wEgaTkDLSpzfrm	\N	2026-03-12 08:51:33	2026-03-12 08:51:33
\.


--
-- Data for Name: users_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_tokens (id, user_id, token, context, sent_to, inserted_at) FROM stdin;
1	1	\\x17c5220d8123b2882530a08553a504d980acaf0cdc9e6489d44a3594836e8d0f	session	\N	2026-03-12 09:08:44
\.


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 8, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: users_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_tokens_id_seq', 1, true);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_tokens users_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens
    ADD CONSTRAINT users_tokens_pkey PRIMARY KEY (id);


--
-- Name: order_items_order_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_items_order_id_index ON public.order_items USING btree (order_id);


--
-- Name: order_items_product_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX order_items_product_id_index ON public.order_items USING btree (product_id);


--
-- Name: orders_customer_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_customer_email_index ON public.orders USING btree (customer_email);


--
-- Name: orders_reference_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX orders_reference_index ON public.orders USING btree (reference);


--
-- Name: orders_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_status_index ON public.orders USING btree (status);


--
-- Name: products_category_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_category_index ON public.products USING btree (category);


--
-- Name: products_in_stock_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_in_stock_index ON public.products USING btree (in_stock);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: users_tokens_context_token_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_tokens_context_token_index ON public.users_tokens USING btree (context, token);


--
-- Name: users_tokens_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_tokens_user_id_index ON public.users_tokens USING btree (user_id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: users_tokens users_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens
    ADD CONSTRAINT users_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict TQlTTbDfpeIyl9XvXePMSwCXvqicruvMAJhnDG052xzrFrRCYKWsWLMJXF0kBXH

