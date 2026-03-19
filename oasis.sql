--
-- PostgreSQL database dump
--

\restrict aVACWy75y0228YMpGQfCiRGgcIdIFRgkWqfTmpzpXZ1AUaee8ydNL65LgYhn3tq

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
-- Name: admin_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role character varying(255) DEFAULT 'staff'::character varying NOT NULL,
    permissions character varying(255)[] DEFAULT ARRAY[]::character varying[],
    active boolean DEFAULT true NOT NULL,
    last_login_at timestamp(0) without time zone,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.admin_users OWNER TO postgres;

--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_users_id_seq OWNER TO postgres;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: ai_usages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_usages (
    id bigint NOT NULL,
    action character varying(255) NOT NULL,
    model character varying(255) NOT NULL,
    prompt_tokens integer DEFAULT 0,
    completion_tokens integer DEFAULT 0,
    total_tokens integer DEFAULT 0,
    cost_usd numeric(12,8) DEFAULT 0,
    metadata jsonb DEFAULT '{}'::jsonb,
    inserted_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.ai_usages OWNER TO postgres;

--
-- Name: ai_usages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ai_usages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ai_usages_id_seq OWNER TO postgres;

--
-- Name: ai_usages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ai_usages_id_seq OWNED BY public.ai_usages.id;


--
-- Name: collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collections (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text,
    image_url character varying(255),
    "position" integer DEFAULT 0,
    visible boolean DEFAULT true,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.collections OWNER TO postgres;

--
-- Name: collections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.collections_id_seq OWNER TO postgres;

--
-- Name: collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.collections_id_seq OWNED BY public.collections.id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expenses (
    id bigint NOT NULL,
    store_id bigint,
    title character varying(255) NOT NULL,
    amount numeric(12,2) NOT NULL,
    category character varying(255) NOT NULL,
    date date NOT NULL,
    notes character varying(255),
    receipt_url character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.expenses OWNER TO postgres;

--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.expenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.expenses_id_seq OWNER TO postgres;

--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.expenses_id_seq OWNED BY public.expenses.id;


--
-- Name: hero_slides; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hero_slides (
    id bigint NOT NULL,
    label character varying(255),
    title character varying(255),
    subtitle character varying(255),
    price character varying(255),
    cta_label character varying(255) DEFAULT 'View More'::character varying,
    cta_href character varying(255) DEFAULT '#'::character varying,
    image_url character varying(255),
    "position" integer DEFAULT 0,
    active boolean DEFAULT true,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.hero_slides OWNER TO postgres;

--
-- Name: hero_slides_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hero_slides_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hero_slides_id_seq OWNER TO postgres;

--
-- Name: hero_slides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hero_slides_id_seq OWNED BY public.hero_slides.id;


--
-- Name: legal_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.legal_documents (
    id bigint NOT NULL,
    type character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    intro text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.legal_documents OWNER TO postgres;

--
-- Name: legal_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.legal_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.legal_documents_id_seq OWNER TO postgres;

--
-- Name: legal_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.legal_documents_id_seq OWNED BY public.legal_documents.id;


--
-- Name: legal_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.legal_items (
    id bigint NOT NULL,
    content text NOT NULL,
    "position" integer DEFAULT 0,
    legal_section_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.legal_items OWNER TO postgres;

--
-- Name: legal_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.legal_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.legal_items_id_seq OWNER TO postgres;

--
-- Name: legal_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.legal_items_id_seq OWNED BY public.legal_items.id;


--
-- Name: legal_sections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.legal_sections (
    id bigint NOT NULL,
    heading character varying(255) NOT NULL,
    "position" integer DEFAULT 0,
    legal_document_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.legal_sections OWNER TO postgres;

--
-- Name: legal_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.legal_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.legal_sections_id_seq OWNER TO postgres;

--
-- Name: legal_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.legal_sections_id_seq OWNED BY public.legal_sections.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id bigint NOT NULL,
    city character varying(255) NOT NULL,
    address text NOT NULL,
    image_url character varying(255),
    "position" integer DEFAULT 0,
    visible boolean DEFAULT true,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    lat double precision,
    lng double precision,
    phone character varying(255),
    hours character varying(255),
    map_label character varying(255)
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_id_seq OWNER TO postgres;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: nav_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nav_items (
    id bigint NOT NULL,
    label character varying(255) NOT NULL,
    href character varying(255) NOT NULL,
    "position" integer DEFAULT 0,
    has_dropdown boolean DEFAULT false,
    visible boolean DEFAULT true,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    "group" character varying(255) DEFAULT 'navbar'::character varying NOT NULL
);


ALTER TABLE public.nav_items OWNER TO postgres;

--
-- Name: nav_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nav_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nav_items_id_seq OWNER TO postgres;

--
-- Name: nav_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nav_items_id_seq OWNED BY public.nav_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    reference character varying(255) NOT NULL,
    customer_email character varying(255) NOT NULL,
    customer_name character varying(255),
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    total_amount numeric NOT NULL,
    items jsonb DEFAULT '{}'::jsonb NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    customer_location character varying(255),
    customer_phone character varying(255),
    store_id bigint,
    package_size character varying(255),
    delivery_fee numeric(10,2)
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
-- Name: product_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_images (
    id bigint NOT NULL,
    url character varying(255) NOT NULL,
    "position" integer DEFAULT 0,
    product_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.product_images OWNER TO postgres;

--
-- Name: product_images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_images_id_seq OWNER TO postgres;

--
-- Name: product_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_images_id_seq OWNED BY public.product_images.id;


--
-- Name: product_specs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_specs (
    id bigint NOT NULL,
    label character varying(255) NOT NULL,
    value character varying(255) NOT NULL,
    "position" integer DEFAULT 0,
    product_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.product_specs OWNER TO postgres;

--
-- Name: product_specs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_specs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_specs_id_seq OWNER TO postgres;

--
-- Name: product_specs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_specs_id_seq OWNED BY public.product_specs.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL,
    original_price numeric(10,2),
    rating integer DEFAULT 5,
    on_sale boolean DEFAULT false,
    sku character varying(255),
    brand character varying(255),
    in_stock character varying(255) DEFAULT 'In Stock'::character varying,
    delivery_days integer DEFAULT 4,
    description text,
    description_title character varying(255),
    description_body text[] DEFAULT ARRAY[]::text[],
    image_url character varying(255),
    featured boolean DEFAULT false,
    "position" integer DEFAULT 0,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    stock_quantity integer DEFAULT 100 NOT NULL,
    returnable boolean DEFAULT false NOT NULL,
    return_window_days integer DEFAULT 7,
    code character varying(255),
    cost numeric(10,2) DEFAULT 0
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_collections (
    product_id bigint NOT NULL,
    collection_id bigint NOT NULL
);


ALTER TABLE public.products_collections OWNER TO postgres;

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
-- Name: returns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.returns (
    id bigint NOT NULL,
    order_id bigint,
    product_id bigint,
    customer_name character varying(255),
    customer_email character varying(255) NOT NULL,
    reason character varying(255) NOT NULL,
    notes text,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    resolution character varying(255),
    refund_amount numeric,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    store_id bigint,
    logged_by_admin boolean DEFAULT false
);


ALTER TABLE public.returns OWNER TO postgres;

--
-- Name: returns_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.returns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.returns_id_seq OWNER TO postgres;

--
-- Name: returns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.returns_id_seq OWNED BY public.returns.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    rating integer DEFAULT 5,
    body text NOT NULL,
    headline character varying(255),
    role character varying(255),
    product_name character varying(255),
    avatar_url character varying(255),
    product_image_url character varying(255),
    featured boolean DEFAULT false,
    visible boolean DEFAULT true,
    context character varying(255) DEFAULT 'home'::character varying,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_id_seq OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    id bigint NOT NULL,
    product_id bigint,
    order_id bigint,
    quantity integer DEFAULT 1 NOT NULL,
    unit_price numeric NOT NULL,
    total_price numeric NOT NULL,
    notes text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    store_id bigint,
    payment_method character varying(255) DEFAULT 'cash'::character varying,
    payment_status character varying(255) DEFAULT 'paid'::character varying NOT NULL
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- Name: sales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sales_id_seq OWNER TO postgres;

--
-- Name: sales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_id_seq OWNED BY public.sales.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: service_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_jobs (
    id bigint NOT NULL,
    reference character varying(255) NOT NULL,
    customer_name character varying(255) NOT NULL,
    customer_phone character varying(255),
    device character varying(255) NOT NULL,
    fault text,
    title character varying(255) NOT NULL,
    notes text,
    amount numeric(12,2),
    parts_cost numeric(12,2),
    status character varying(255) DEFAULT 'received'::character varying,
    technician character varying(255),
    date_in date,
    date_out date,
    store_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.service_jobs OWNER TO postgres;

--
-- Name: service_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_jobs_id_seq OWNER TO postgres;

--
-- Name: service_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_jobs_id_seq OWNED BY public.service_jobs.id;


--
-- Name: site_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.site_settings (
    id bigint NOT NULL,
    brand character varying(255) DEFAULT 'GadgetZ'::character varying,
    tagline text,
    phone character varying(255),
    email character varying(255),
    address character varying(255),
    city character varying(255),
    newsletter_text character varying(255),
    copyright_text character varying(255),
    facebook_url character varying(255),
    twitter_url character varying(255),
    instagram_url character varying(255),
    tiktok_url character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    mission_image_url character varying(255),
    before_image_url character varying(255),
    after_image_url character varying(255),
    about_hero_main_image_url character varying(255),
    about_hero_secondary_image_url character varying(255),
    about_mission_image_url character varying(255),
    skills_image_1_url character varying(255),
    skills_image_2_url character varying(255),
    skills_image_3_url character varying(255),
    online_sales_enabled boolean DEFAULT true NOT NULL,
    whatsapp_number character varying(255)
);


ALTER TABLE public.site_settings OWNER TO postgres;

--
-- Name: site_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.site_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.site_settings_id_seq OWNER TO postgres;

--
-- Name: site_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.site_settings_id_seq OWNED BY public.site_settings.id;


--
-- Name: skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skills (
    id bigint NOT NULL,
    label character varying(255) NOT NULL,
    percent integer NOT NULL,
    "position" integer DEFAULT 0,
    visible boolean DEFAULT true,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.skills OWNER TO postgres;

--
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skills_id_seq OWNER TO postgres;

--
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;


--
-- Name: stock_movements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_movements (
    id bigint NOT NULL,
    store_id bigint,
    product_id bigint NOT NULL,
    quantity_change integer NOT NULL,
    type character varying(255) NOT NULL,
    notes character varying(255),
    cost_per_unit numeric(12,2),
    reference character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.stock_movements OWNER TO postgres;

--
-- Name: stock_movements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_movements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_movements_id_seq OWNER TO postgres;

--
-- Name: stock_movements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stock_movements_id_seq OWNED BY public.stock_movements.id;


--
-- Name: store_stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_stock (
    id bigint NOT NULL,
    store_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    oversold boolean DEFAULT false,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.store_stock OWNER TO postgres;

--
-- Name: store_stock_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_stock_id_seq OWNER TO postgres;

--
-- Name: store_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_stock_id_seq OWNED BY public.store_stock.id;


--
-- Name: stores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stores (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) DEFAULT 'physical'::character varying,
    location character varying(255),
    description text,
    phone character varying(255),
    active boolean DEFAULT true,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    protected boolean DEFAULT false,
    location_id bigint
);


ALTER TABLE public.stores OWNER TO postgres;

--
-- Name: stores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stores_id_seq OWNER TO postgres;

--
-- Name: stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stores_id_seq OWNED BY public.stores.id;


--
-- Name: team_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team_members (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    role character varying(255) NOT NULL,
    image_url character varying(255),
    featured boolean DEFAULT false,
    "position" integer DEFAULT 0,
    visible boolean DEFAULT true,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.team_members OWNER TO postgres;

--
-- Name: team_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.team_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.team_members_id_seq OWNER TO postgres;

--
-- Name: team_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.team_members_id_seq OWNED BY public.team_members.id;


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
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: ai_usages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_usages ALTER COLUMN id SET DEFAULT nextval('public.ai_usages_id_seq'::regclass);


--
-- Name: collections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections ALTER COLUMN id SET DEFAULT nextval('public.collections_id_seq'::regclass);


--
-- Name: expenses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses ALTER COLUMN id SET DEFAULT nextval('public.expenses_id_seq'::regclass);


--
-- Name: hero_slides id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_slides ALTER COLUMN id SET DEFAULT nextval('public.hero_slides_id_seq'::regclass);


--
-- Name: legal_documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_documents ALTER COLUMN id SET DEFAULT nextval('public.legal_documents_id_seq'::regclass);


--
-- Name: legal_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_items ALTER COLUMN id SET DEFAULT nextval('public.legal_items_id_seq'::regclass);


--
-- Name: legal_sections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_sections ALTER COLUMN id SET DEFAULT nextval('public.legal_sections_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: nav_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nav_items ALTER COLUMN id SET DEFAULT nextval('public.nav_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: product_images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_images ALTER COLUMN id SET DEFAULT nextval('public.product_images_id_seq'::regclass);


--
-- Name: product_specs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_specs ALTER COLUMN id SET DEFAULT nextval('public.product_specs_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: returns id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returns ALTER COLUMN id SET DEFAULT nextval('public.returns_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: sales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales ALTER COLUMN id SET DEFAULT nextval('public.sales_id_seq'::regclass);


--
-- Name: service_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_jobs ALTER COLUMN id SET DEFAULT nextval('public.service_jobs_id_seq'::regclass);


--
-- Name: site_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_settings ALTER COLUMN id SET DEFAULT nextval('public.site_settings_id_seq'::regclass);


--
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);


--
-- Name: stock_movements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements ALTER COLUMN id SET DEFAULT nextval('public.stock_movements_id_seq'::regclass);


--
-- Name: store_stock id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_stock ALTER COLUMN id SET DEFAULT nextval('public.store_stock_id_seq'::regclass);


--
-- Name: stores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores ALTER COLUMN id SET DEFAULT nextval('public.stores_id_seq'::regclass);


--
-- Name: team_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_members ALTER COLUMN id SET DEFAULT nextval('public.team_members_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens ALTER COLUMN id SET DEFAULT nextval('public.users_tokens_id_seq'::regclass);


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_users (id, name, email, password_hash, role, permissions, active, last_login_at, inserted_at, updated_at) FROM stdin;
1	Super Admin	michaelmunavu83@gmail.com	8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92	super_admin	{dashboard,analytics,reports,hero_slides,orders,sales,returns,service_jobs,products,collections,reviews,posters,team,skills,locations,stores,stock,expenses,nav_items,legal,settings,users,ai_usage}	t	\N	2026-03-07 06:42:43	2026-03-07 06:42:43
2	Josphat Kwendo	josphato73@gmail.com	8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92	super_admin	{}	t	\N	2026-03-07 06:46:48	2026-03-07 06:46:48
3	Reagan Tiama	tiamaregan19@gmail.com	8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92	staff	{dashboard,analytics,reports,hero_slides,orders,sales,returns,service_jobs,products,collections,reviews,posters,team,skills,locations,stores,stock,expenses,nav_items,legal,settings,users,ai_usage}	t	\N	2026-03-07 06:47:55	2026-03-07 06:47:55
4	Ajak Bol	ajakbol1802@gmail.com	8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92	staff	{dashboard,analytics,reports,hero_slides,orders,sales,returns,service_jobs,products,collections,reviews,posters,team,skills,locations,stores,stock,expenses,nav_items,legal,settings,users,ai_usage}	t	\N	2026-03-07 06:48:19	2026-03-07 06:48:19
5	Magina Eddy	maginaryan401@gmail.com	8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92	staff	{dashboard,analytics,reports,hero_slides,orders,sales,returns,service_jobs,products,collections,reviews,posters,team,skills,locations,stores,stock,expenses,nav_items,legal,settings,users,ai_usage}	t	\N	2026-03-07 06:54:45	2026-03-07 06:54:45
6	Njenga Simon	njengasimon22437@gmail.com	8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92	staff	{dashboard,analytics,reports,hero_slides,orders,sales,returns,service_jobs,products,collections,reviews,posters,team,skills,locations,stores,stock,expenses,nav_items,legal,settings,users,ai_usage}	t	\N	2026-03-07 06:57:00	2026-03-07 06:57:00
\.


--
-- Data for Name: ai_usages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_usages (id, action, model, prompt_tokens, completion_tokens, total_tokens, cost_usd, metadata, inserted_at) FROM stdin;
1	poster_copy	gpt-4o-mini	233	76	309	0.00008055	{"product": "Portable Bluetooth Speaker"}	2026-03-07 06:51:07
2	poster_generation	dall-e-3	0	0	0	0.00000000	{"style": "elegant", "product": "Portable Bluetooth Speaker", "platform": "story"}	2026-03-07 06:51:38
3	poster_copy	gpt-4o-mini	225	75	300	0.00007875	{"product": "Premium Tempered Glass Screen Protector (2-Pack)"}	2026-03-07 06:52:25
4	poster_generation	dall-e-3	0	0	0	0.00000000	{"style": "elegant", "product": "Premium Tempered Glass Screen Protector (2-Pack)", "platform": "square"}	2026-03-07 06:53:04
5	poster_generation	dall-e-3	0	0	0	0.00000000	{"style": "modern", "product": "Premium Tempered Glass Screen Protector (2-Pack)", "platform": "landscape"}	2026-03-07 06:54:04
6	specs_from_name	gpt-4o-mini	347	351	698	0.00026265	{"product_name": "oraimo spacebuds"}	2026-03-07 07:22:13
7	specs_from_name	gpt-4o-mini	350	360	710	0.00026850	{"product_name": "AWEI P139k power bank"}	2026-03-07 07:38:24
8	specs_from_name	gpt-4o-mini	350	315	665	0.00024150	{"product_name": "AWEI P51K power Bank"}	2026-03-07 07:47:39
9	specs_from_name	gpt-4o-mini	350	376	726	0.00027810	{"product_name": "AWEI P20k power bank"}	2026-03-07 07:52:40
10	specs_from_name	gpt-4o-mini	357	384	741	0.00028395	{"product_name": "Oraimo 15w 30000mAh power box 300 lit"}	2026-03-07 08:00:08
11	specs_from_name	gpt-4o-mini	346	356	702	0.00026550	{"product_name": "awei power bank"}	2026-03-07 09:25:49
12	specs_from_name	gpt-4o-mini	348	344	692	0.00025860	{"product_name": "SAMSUNG CHARGER"}	2026-03-07 09:27:09
13	product_analysis	gpt-4o	443	139	582	0.00249750	{"image_url": "https://oasistechnologies.co.ke/uploads/lyVsFzVLW64_samsung-45w-pd.jpg"}	2026-03-07 09:28:03
14	specs_from_name	gpt-4o-mini	351	367	718	0.00027285	{"product_name": "SAMSUNG 45W PD Power Adapter"}	2026-03-07 09:28:42
15	product_analysis	gpt-4o	443	137	580	0.00247750	{"image_url": "https://oasistechnologies.co.ke/uploads/w2iGPkTBilA_samsung-45w-pd.jpg"}	2026-03-07 09:30:08
16	specs_from_name	gpt-4o-mini	351	362	713	0.00026985	{"product_name": "SAMSUNG 45W PD Power Adapter"}	2026-03-07 09:30:48
17	product_analysis	gpt-4o	443	161	604	0.00271750	{"image_url": "https://oasistechnologies.co.ke/uploads/vCbUEHqWpnk_muse.jpg"}	2026-03-07 09:39:09
18	specs_from_name	gpt-4o-mini	350	360	710	0.00026850	{"product_name": "1.32\\" AMOLED Smartwatch"}	2026-03-07 09:41:45
19	product_analysis	gpt-4o	443	154	597	0.00264750	{"image_url": "https://oasistechnologies.co.ke/uploads/8SZwbqe_2Ss_1001196245.jpg"}	2026-03-07 10:07:25
20	specs_from_name	gpt-4o-mini	351	397	748	0.00029085	{"product_name": "Watch 5 lite | osw-804"}	2026-03-09 07:45:46
21	specs_from_name	gpt-4o-mini	353	369	722	0.00027435	{"product_name": "Oraimo Watch 5 lite | osw-804"}	2026-03-09 07:45:54
22	product_analysis	gpt-4o	443	155	598	0.00265750	{"image_url": "https://oasistechnologies.co.ke/uploads/eNgV_7Fp8W8_1001834833.jpg"}	2026-03-09 07:48:36
23	specs_from_name	gpt-4o-mini	348	383	731	0.00028200	{"product_name": "AWEI T50 ENC"}	2026-03-09 07:53:07
24	product_analysis	gpt-4o	443	169	612	0.00279750	{"image_url": "https://oasistechnologies.co.ke/uploads/615nLffGiF4_1001993613.jpg"}	2026-03-09 07:55:18
25	product_analysis	gpt-4o	443	180	623	0.00290750	{"image_url": "https://oasistechnologies.co.ke/uploads/7_Up5GKEybc_1001993614.jpg"}	2026-03-09 08:00:12
26	product_analysis	gpt-4o	443	174	617	0.00284750	{"image_url": "https://oasistechnologies.co.ke/uploads/w4PC2XNuMF0_1001996607.jpg"}	2026-03-09 17:46:53
27	product_analysis	gpt-4o	443	160	603	0.00270750	{"image_url": "https://oasistechnologies.co.ke/uploads/zG1Du9SZGW4_1001996668.jpg"}	2026-03-09 17:58:31
28	specs_from_name	gpt-4o-mini	345	375	720	0.00027675	{"product_name": "Sam A07"}	2026-03-09 18:11:16
29	product_analysis	gpt-4o	443	143	586	0.00253750	{"image_url": "https://oasistechnologies.co.ke/uploads/PkdqFaHT8-A_a172.jpg"}	2026-03-09 20:08:18
30	specs_from_name	gpt-4o-mini	349	458	807	0.00032715	{"product_name": "Samsung Galaxy A17 5G"}	2026-03-09 20:08:41
31	specs_from_name	gpt-4o-mini	345	392	737	0.00028695	{"product_name": "Sam A07"}	2026-03-09 20:20:13
32	product_analysis	gpt-4o	443	174	617	0.00284750	{"image_url": "https://oasistechnologies.co.ke/uploads/AYoEk6DqrKs_s24_ultr.jpg"}	2026-03-09 20:38:38
33	specs_from_name	gpt-4o-mini	350	441	791	0.00031710	{"product_name": "Samsung Galaxy S24 Ultra 256GB"}	2026-03-09 20:39:16
34	specs_from_name	gpt-4o-mini	350	475	825	0.00033750	{"product_name": "Samsung Galaxy s24 ultra 5G"}	2026-03-09 20:41:38
35	specs_from_name	gpt-4o-mini	345	429	774	0.00030915	{"product_name": "s24 ultra"}	2026-03-09 20:46:14
36	product_analysis	gpt-4o	443	173	616	0.00283750	{"image_url": "https://oasistechnologies.co.ke/uploads/1qYcGyhvt1A_s24_ultr.jpg"}	2026-03-09 20:48:09
37	specs_from_name	gpt-4o-mini	350	467	817	0.00033270	{"product_name": "Samsung Galaxy S23 Ultra 256GB"}	2026-03-09 20:49:01
38	specs_from_name	gpt-4o-mini	350	435	785	0.00031350	{"product_name": "Samsung Galaxy S24 Ultra 256GB"}	2026-03-09 20:49:22
39	product_analysis	gpt-4o	443	139	582	0.00249750	{"image_url": "https://oasistechnologies.co.ke/uploads/ZnU6dn7F9h8_ylizdgdt1694359830-697x702.webp"}	2026-03-09 20:56:22
40	product_analysis	gpt-4o	443	140	583	0.00250750	{"image_url": "https://oasistechnologies.co.ke/uploads/ZnU6dn7F9h8_ylizdgdt1694359830-697x702.webp"}	2026-03-09 20:56:49
41	poster_copy	gpt-4o-mini	286	92	378	0.00009810	{"product": "AWEI P139k power bank "}	2026-03-09 21:02:21
42	poster_generation	dall-e-3	0	0	0	0.00000000	{"style": "modern", "product": "AWEI P139k power bank ", "platform": "story"}	2026-03-09 21:02:59
43	poster_generation	dall-e-3	0	0	0	0.00000000	{"style": "modern", "product": "AWEI P139k power bank ", "platform": "story"}	2026-03-09 21:04:04
44	poster_generation	dall-e-3	0	0	0	0.00000000	{"style": "bold", "product": "AWEI P139k power bank ", "platform": "story"}	2026-03-09 21:05:00
45	poster_copy	gpt-4o-mini	268	72	340	0.00008340	{"product": "Sam A07"}	2026-03-09 21:05:33
46	poster_generation	dall-e-3	0	0	0	0.00000000	{"style": "elegant", "product": "Sam A07", "platform": "square"}	2026-03-09 21:06:36
47	specs_from_name	gpt-4o-mini	347	419	766	0.00030345	{"product_name": "Tecno spark 40"}	2026-03-09 21:08:54
48	product_analysis	gpt-4o	443	179	622	0.00289750	{"image_url": "https://oasistechnologies.co.ke/uploads/wQr0pr95yQY_251106160120_173707eadc398f2ed6bde5a0b43.jpg"}	2026-03-09 21:13:40
49	product_analysis	gpt-4o	443	185	628	0.00295750	{"image_url": "https://oasistechnologies.co.ke/uploads/xlY6K58KaTw_3-550x550_png.webp"}	2026-03-09 21:23:34
50	specs_from_name	gpt-4o-mini	350	325	675	0.00024750	{"product_name": "AWEI P51K power Bank"}	2026-03-09 21:29:20
51	specs_from_name	gpt-4o-mini	347	349	696	0.00026145	{"product_name": "K31pro wireless microphone"}	2026-03-10 16:28:34
52	specs_from_name	gpt-4o-mini	348	395	743	0.00028920	{"product_name": "Awei Outdoor Waterproof wireless Speaker"}	2026-03-10 16:30:51
53	specs_from_name	gpt-4o-mini	350	301	651	0.00023310	{"product_name": "Collapsible telescopic bracket no.s313"}	2026-03-10 16:34:46
54	specs_from_name	gpt-4o-mini	353	365	718	0.00027195	{"product_name": "Q18 Gimble Stabilizer 360 rotating desktop tripod"}	2026-03-10 16:40:02
55	specs_from_name	gpt-4o-mini	349	426	775	0.00030795	{"product_name": "Samsung Galaxy A17 5G"}	2026-03-10 16:43:30
56	product_analysis	gpt-4o	443	165	608	0.00275750	{"image_url": "https://oasistechnologies.co.ke/uploads/nb1gwSPbmmE_20241002135257_awei_p139k_power_bank_100.jpeg"}	2026-03-14 08:33:37
57	specs_from_name	gpt-4o-mini	352	372	724	0.00027600	{"product_name": "Awei P139K Mini Portable Magnetic Power Bank"}	2026-03-14 08:34:51
58	product_analysis	gpt-4o	443	147	590	0.00257750	{"image_url": "https://oasistechnologies.co.ke/uploads/dERglzrh0EQ_cn-11134207-7r98o-lyk9hr6jwpeq68.jpg"}	2026-03-14 08:53:41
59	specs_from_name	gpt-4o-mini	348	324	672	0.00024660	{"product_name": "Collapsible telescopic Bracket"}	2026-03-14 09:08:32
60	specs_from_name	gpt-4o-mini	352	330	682	0.00025080	{"product_name": "c-706 Car charger Plus USB DATA CABLE"}	2026-03-14 09:27:59
61	specs_from_name	gpt-4o-mini	352	308	660	0.00023760	{"product_name": "C-706 Car Charger Plus USB DATA CABLE"}	2026-03-14 09:31:30
62	specs_from_name	gpt-4o-mini	351	317	668	0.00024285	{"product_name": "C-706 Car Charger + USB Data Cable"}	2026-03-14 09:36:55
63	product_analysis	gpt-4o	443	155	598	0.00265750	{"image_url": "https://oasistechnologies.co.ke/uploads/PrK8w01ex20_274340685_1408_1076.webp"}	2026-03-14 09:51:37
64	product_analysis	gpt-4o	443	172	615	0.00282750	{"image_url": "https://oasistechnologies.co.ke/uploads/l3knXX50dCg_1_5.jpg"}	2026-03-14 09:52:53
65	specs_from_name	gpt-4o-mini	344	323	667	0.00024540	{"product_name": "soundcore"}	2026-03-14 09:54:30
66	product_analysis	gpt-4o	443	174	617	0.00284750	{"image_url": "https://oasistechnologies.co.ke/uploads/Xl8nr3xemZQ_20250217125945_o_lonnie_mecha_d3_in_ear_.jpeg"}	2026-03-15 12:48:37
67	specs_from_name	gpt-4o-mini	353	359	712	0.00026835	{"product_name": "O-Lonnie Mecha D3 Bluetooth Earphones"}	2026-03-15 12:50:00
68	product_analysis	gpt-4o	443	148	591	0.00258750	{"image_url": "https://oasistechnologies.co.ke/uploads/_u2X6QmpVio_watch_5_lite_pink.webp"}	2026-03-15 12:58:14
69	product_analysis	gpt-4o	443	146	589	0.00256750	{"image_url": "https://oasistechnologies.co.ke/uploads/_u2X6QmpVio_watch_5_lite_pink.webp"}	2026-03-15 12:58:37
70	specs_from_name	gpt-4o-mini	346	379	725	0.00027930	{"product_name": "Smart Fitness Watch Pink"}	2026-03-15 12:59:02
71	product_analysis	gpt-4o	443	148	591	0.00258750	{"image_url": "https://oasistechnologies.co.ke/uploads/r9Lj0_IbPiw_anker-u2i-01.jpeg"}	2026-03-15 13:02:18
72	specs_from_name	gpt-4o-mini	347	366	713	0.00027165	{"product_name": "Soundcore Wireless Earphones"}	2026-03-15 13:02:57
73	product_analysis	gpt-4o	443	143	586	0.00253750	{"image_url": "https://oasistechnologies.co.ke/uploads/JP3Z1pgqhVY_anker-u2i-07.jpeg"}	2026-03-15 13:05:16
74	poster_copy	gpt-4o-mini	281	78	359	0.00008895	{"product": "AWEI P139k power bank "}	2026-03-15 13:11:12
75	poster_generation	dall-e-3	0	0	0	0.00000000	{"style": "modern", "product": "AWEI P139k power bank ", "platform": "square"}	2026-03-15 13:11:42
76	poster_copy	gpt-4o-mini	290	81	371	0.00009210	{"product": "Awei T50 ENC Bluetooth Earbuds"}	2026-03-15 13:12:26
77	poster_generation	dall-e-3	0	0	0	0.00000000	{"style": "modern", "product": "Awei T50 ENC Bluetooth Earbuds", "platform": "story"}	2026-03-15 13:13:19
78	product_analysis	gpt-4o	443	166	609	0.00276750	{"image_url": "https://oasistechnologies.co.ke/uploads/8m5jdSwDN2s_ld0006236933.jpg"}	2026-03-15 14:46:39
79	specs_from_name	gpt-4o-mini	349	432	781	0.00031155	{"product_name": "Samsung Galaxy A36 5G"}	2026-03-15 14:47:14
80	product_analysis	gpt-4o	443	173	616	0.00283750	{"image_url": "https://oasistechnologies.co.ke/uploads/b7QxFJIh3Cs_ld0006236933.jpg"}	2026-03-15 14:50:10
81	specs_from_name	gpt-4o-mini	349	455	804	0.00032535	{"product_name": "Samsung Galaxy A36 5G"}	2026-03-15 14:50:45
82	product_analysis	gpt-4o	443	160	603	0.00270750	{"image_url": "https://oasistechnologies.co.ke/uploads/b7QxFJIh3Cs_ld0006236933.jpg"}	2026-03-15 14:51:36
83	specs_from_name	gpt-4o-mini	348	265	613	0.00021120	{"product_name": "Amaya tk- 05"}	2026-03-15 14:58:15
84	specs_from_name	gpt-4o-mini	351	346	697	0.00026025	{"product_name": "AMAYA TK-05 EARBUDS"}	2026-03-15 14:59:50
85	product_analysis	gpt-4o	443	152	595	0.00262750	{"image_url": "https://oasistechnologies.co.ke/uploads/N14lM3MI5bs_miniso_20231003075159_1094_416_6821_6605.webp"}	2026-03-15 15:03:41
86	product_analysis	gpt-4o	443	149	592	0.00259750	{"image_url": "https://oasistechnologies.co.ke/uploads/tuud2wfwRMY_1.jpg"}	2026-03-15 15:09:32
87	specs_from_name	gpt-4o-mini	352	324	676	0.00024720	{"product_name": "APPLE IPHONE USB-C Charger and Cable Set"}	2026-03-15 15:10:16
88	product_analysis	gpt-4o	443	152	595	0.00262750	{"image_url": "https://oasistechnologies.co.ke/uploads/eS-8eYQ9fNE_s-l1600.jpg"}	2026-03-15 15:15:34
89	specs_from_name	gpt-4o-mini	347	318	665	0.00024285	{"product_name": "USB-C to Lightning Cable"}	2026-03-15 15:16:25
90	product_analysis	gpt-4o	443	142	585	0.00252750	{"image_url": "https://oasistechnologies.co.ke/uploads/I4tFtpjJEl8_oraimo-watch-muse-osw-831n-4.webp"}	2026-03-16 05:54:10
91	specs_from_name	gpt-4o-mini	348	309	657	0.00023760	{"product_name": "Smartwatch with Gold Mesh Band"}	2026-03-16 05:54:20
92	specs_from_name	gpt-4o-mini	348	345	693	0.00025920	{"product_name": "Smartwatch with Gold Mesh Band"}	2026-03-16 05:54:30
93	product_analysis	gpt-4o	443	151	594	0.00261750	{"image_url": "https://oasistechnologies.co.ke/uploads/KraWS_PdJqI_oraimo-watch-muse-osw-831n-4.webp"}	2026-03-16 05:55:23
94	specs_from_name	gpt-4o-mini	351	380	731	0.00028065	{"product_name": "SAMSUNG 25W PD Power Adapter"}	2026-03-16 06:28:39
95	specs_from_name	gpt-4o-mini	355	383	738	0.00028305	{"product_name": "Oraimo Power Nova Q21 |OPB-7200Q"}	2026-03-16 06:43:58
96	product_analysis	gpt-4o	443	190	633	0.00300750	{"image_url": "https://oasistechnologies.co.ke/uploads/I6LSXsAm5FM_oraimo-traveler-2-20000-mah-powerbank.jpg"}	2026-03-16 06:54:46
97	specs_from_name	gpt-4o-mini	346	298	644	0.00023070	{"product_name": "Oraimo POwe"}	2026-03-16 06:58:50
98	specs_from_name	gpt-4o-mini	348	344	692	0.00025860	{"product_name": "Ring light 12 inch RGB"}	2026-03-16 07:00:53
99	product_analysis	gpt-4o	443	158	601	0.00268750	{"image_url": "https://oasistechnologies.co.ke/uploads/GeeMD7LOjz4_samsung-usb-c-charger-25w.webp"}	2026-03-16 08:10:47
100	product_analysis	gpt-4o	443	140	583	0.00250750	{"image_url": "https://oasistechnologies.co.ke/uploads/fzWOER8vCwU_2.jpg"}	2026-03-16 11:20:32
101	specs_from_name	gpt-4o-mini	351	359	710	0.00026805	{"product_name": "Xundo Case ipone 13promax"}	2026-03-16 11:25:47
104	specs_from_name	gpt-4o-mini	345	304	649	0.00023415	{"product_name": "Car Phone holder"}	2026-03-16 11:37:39
105	product_analysis	gpt-4o	443	157	600	0.00267750	{"image_url": "https://oasistechnologies.co.ke/uploads/fzTXL_XzniM_oraimo-power-bank-powernova-qf1-opb-7270.webp"}	2026-03-16 12:12:55
106	specs_from_name	gpt-4o-mini	353	349	702	0.00026235	{"product_name": "Oraimo Power NovaQ21 20000mAh"}	2026-03-16 12:13:40
102	specs_from_name	gpt-4o-mini	349	310	659	0.00023835	{"product_name": "Nilikin case SAM S26 Ultra"}	2026-03-16 11:28:42
103	product_analysis	gpt-4o	443	166	609	0.00276750	{"image_url": "https://oasistechnologies.co.ke/uploads/gaZvB_aDDV8_d0968ed9c2b80267430b40284dd52f35-600x600.png"}	2026-03-16 11:30:58
107	product_analysis	gpt-4o	443	169	612	0.00279750	{"image_url": "https://oasistechnologies.co.ke/uploads/xCS9p35vhpc_oraimo-power-bank-powernova-qf1-opb-7270.webp"}	2026-03-16 12:17:20
108	specs_from_name	gpt-4o-mini	352	431	783	0.00031140	{"product_name": "Redmi 15C 8gb+256gb"}	2026-03-16 12:21:47
109	product_analysis	gpt-4o	443	138	581	0.00248750	{"image_url": "https://oasistechnologies.co.ke/uploads/JkSWzcxPPYk_6.jpg"}	2026-03-16 12:28:50
110	specs_from_name	gpt-4o-mini	346	432	778	0.00031110	{"product_name": "Redmi 15C"}	2026-03-16 12:28:59
111	specs_from_name	gpt-4o-mini	352	419	771	0.00030420	{"product_name": "Redmi 15C 8gb+256gb"}	2026-03-16 12:29:16
112	product_analysis	gpt-4o	443	142	585	0.00252750	{"image_url": "https://oasistechnologies.co.ke/uploads/JkSWzcxPPYk_6.jpg"}	2026-03-16 12:37:03
113	specs_from_name	gpt-4o-mini	348	304	652	0.00023460	{"product_name": "Tempered glass 21D"}	2026-03-16 12:57:43
114	specs_from_name	gpt-4o-mini	349	307	656	0.00023655	{"product_name": "ORAIMO BOOM POP N"}	2026-03-16 13:14:35
115	specs_from_name	gpt-4o-mini	349	329	678	0.00024975	{"product_name": "ORAIMO BOOM POP N"}	2026-03-16 13:15:33
116	product_analysis	gpt-4o	443	149	592	0.00259750	{"image_url": "https://oasistechnologies.co.ke/uploads/KUtMLDG70wk_oraimo-wireless-headphones-boompop-n-ohp.webp"}	2026-03-16 13:18:51
117	specs_from_name	gpt-4o-mini	349	389	738	0.00028575	{"product_name": "Oppo Enco X Wireless Headphones"}	2026-03-16 13:19:34
118	specs_from_name	gpt-4o-mini	347	316	663	0.00024165	{"product_name": "Oraimo Boom Pop n"}	2026-03-16 13:19:58
119	specs_from_name	gpt-4o-mini	347	303	650	0.00023385	{"product_name": "Oraimo Boom Pop n"}	2026-03-16 13:20:16
120	specs_from_name	gpt-4o-mini	353	310	663	0.00023895	{"product_name": "Oraimo Boom Pop N | OHP-915N"}	2026-03-16 13:42:57
121	specs_from_name	gpt-4o-mini	353	314	667	0.00024135	{"product_name": "Oraimo Boom Pop N | OHP-915N"}	2026-03-16 13:44:11
122	specs_from_name	gpt-4o-mini	348	368	716	0.00027300	{"product_name": "Ring light 10 inch RGB"}	2026-03-16 14:21:39
123	specs_from_name	gpt-4o-mini	350	354	704	0.00026490	{"product_name": "L16 Alumunium Tripd Stand"}	2026-03-16 16:19:48
124	product_analysis	gpt-4o	443	147	590	0.00257750	{"image_url": "https://oasistechnologies.co.ke/uploads/twyZbXi7WG8_26980221c2e166be9f090fb25b857dba_png_720.png"}	2026-03-16 16:21:16
125	specs_from_name	gpt-4o-mini	348	322	670	0.00024540	{"product_name": "P 180 max selfie stick"}	2026-03-16 16:25:40
126	product_analysis	gpt-4o	443	160	603	0.00270750	{"image_url": "https://oasistechnologies.co.ke/uploads/di-rnj55rjM_shopping.webp"}	2026-03-16 16:36:22
127	specs_from_name	gpt-4o-mini	351	348	699	0.00026145	{"product_name": "C17 AI Tripod Stand with Bluetooth Remote"}	2026-03-16 16:41:35
128	specs_from_name	gpt-4o-mini	351	353	704	0.00026445	{"product_name": "C17 AI Tripod Stand with Bluetooth Remote"}	2026-03-16 16:42:14
129	product_analysis	gpt-4o	443	144	587	0.00254750	{"image_url": "https://oasistechnologies.co.ke/uploads/RLGCP-keahI_shopping.webp"}	2026-03-16 16:43:57
130	specs_from_name	gpt-4o-mini	350	317	667	0.00024270	{"product_name": "ORAIMO SPACEBOX 80W"}	2026-03-16 16:51:22
131	specs_from_name	gpt-4o-mini	351	325	676	0.00024765	{"product_name": "ORAIMO SPACEBOXPRO 80W"}	2026-03-16 16:51:45
132	specs_from_name	gpt-4o-mini	354	356	710	0.00026670	{"product_name": "ORAIMO SPACEBOXPRO 80W BT SPEAKER"}	2026-03-16 16:52:22
133	specs_from_name	gpt-4o-mini	353	371	724	0.00027555	{"product_name": "Oraimo Speaker-Spacebox-Pro-OBS-682"}	2026-03-16 16:58:05
134	product_analysis	gpt-4o	443	151	594	0.00261750	{"image_url": "https://oasistechnologies.co.ke/uploads/UHzGtR8V7Ys_chinese-manufacturer-battery-replacement.webp"}	2026-03-17 17:02:36
135	specs_from_name	gpt-4o-mini	347	335	682	0.00025305	{"product_name": "negoglass tripod stand"}	2026-03-17 17:05:49
136	specs_from_name	gpt-4o-mini	350	338	688	0.00025530	{"product_name": "O-LONNIE ROUND N13"}	2026-03-17 17:10:01
137	specs_from_name	gpt-4o-mini	351	372	723	0.00027585	{"product_name": "LJJ 16 INCH PLANEL LIGHT"}	2026-03-17 17:17:57
138	specs_from_name	gpt-4o-mini	352	361	713	0.00026940	{"product_name": "LJJ 18 INCH RGB RINLIGHT"}	2026-03-17 17:24:34
139	product_analysis	gpt-4o	443	145	588	0.00255750	{"image_url": "https://oasistechnologies.co.ke/uploads/39LPdWWGUAU_tt.jpg"}	2026-03-17 17:28:06
140	specs_from_name	gpt-4o-mini	353	359	712	0.00026835	{"product_name": "LJJ 18 INCH RGB  RINGLIGHT"}	2026-03-17 17:29:49
141	specs_from_name	gpt-4o-mini	354	368	722	0.00027390	{"product_name": "LJJ 18 INCG RGB RINGLIGT"}	2026-03-17 17:32:34
142	specs_from_name	gpt-4o-mini	350	324	674	0.00024690	{"product_name": "SAMSUNG TYPE C ARPHONES"}	2026-03-17 17:41:07
143	specs_from_name	gpt-4o-mini	352	322	674	0.00024600	{"product_name": "SAMSUNG TYPE C AKG EARPHONES"}	2026-03-17 17:42:58
144	specs_from_name	gpt-4o-mini	352	408	760	0.00029760	{"product_name": "Tecno Pop 20 8+128gb"}	2026-03-19 10:10:40
145	specs_from_name	gpt-4o-mini	350	420	770	0.00030450	{"product_name": "Tecno pop 20 128gb"}	2026-03-19 10:17:40
146	specs_from_name	gpt-4o-mini	347	457	804	0.00032625	{"product_name": "Iphone 15 Pro Max"}	2026-03-19 10:26:23
147	specs_from_name	gpt-4o-mini	350	399	749	0.00029190	{"product_name": "Tecno pop 20 128gb"}	2026-03-19 11:11:06
148	specs_from_name	gpt-4o-mini	352	432	784	0.00031200	{"product_name": "Infinix Hot 60I 128GB"}	2026-03-19 11:13:17
149	specs_from_name	gpt-4o-mini	353	434	787	0.00031335	{"product_name": "INFINIX SMART 10 4GB=64"}	2026-03-19 11:17:17
150	specs_from_name	gpt-4o-mini	354	433	787	0.00031290	{"product_name": "INFINIX SMART 10 4GB+64GB"}	2026-03-19 11:19:00
\.


--
-- Data for Name: collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collections (id, title, slug, description, image_url, "position", visible, inserted_at, updated_at) FROM stdin;
1	Ex-UK iPhones	ex-uk-iphones	Premium pre-owned iPhones sourced directly from the UK. Every device is unlocked, factory reset, rigorously tested and graded before it reaches your hands.	https://images.pexels.com/photos/788946/pexels-photo-788946.jpeg?auto=compress&cs=tinysrgb&w=900	1	t	2026-03-07 06:42:43	2026-03-07 06:42:43
6	Fast Charger	Fast Charger	FAST CHARGERS	/uploads/Qn59z1ldf-I_samsung-45w-pd.jpg	6	t	2026-03-07 09:55:00	2026-03-07 09:56:05
7	Car Accessories.	car-accessories	car accessories	/uploads/yzHAP6oEgOI_car_acc.jpg	6	t	2026-03-09 08:04:05	2026-03-09 20:32:34
9	Power Banks	power banks	\N	/uploads/eQBEDETMGVQ_orimo-traveler-2-20000-mah-powerbank-a.jpg	8	t	2026-03-16 06:37:31	2026-03-16 06:38:53
13	Ringlights 	ringlight	\N	/uploads/J8sKearMR1M_674a4a294813c52a599082bf3145b3b8_2.jpg	10	t	2026-03-16 07:06:28	2026-03-16 07:06:28
2	Smartphones	Smartphones	New and premium Ex-UK Samsung phones. Whether you want the latest flagship or a value-packed mid-ranger, we have the Samsung for you — tested and guaranteed.	https://images.pexels.com/photos/47261/pexels-photo-47261.jpeg?auto=compress&cs=tinysrgb&w=900	2	t	2026-03-07 06:42:43	2026-03-16 08:12:38
12	Head Phones	Headphones	\N	/uploads/NF8g4CLUhQg_baseus-xh1-bose-headphones-flash-sale-ma.jpg	0	t	2026-03-16 06:41:34	2026-03-16 11:04:12
11	Phone Cases	phone Cases	\N	/uploads/-cq2ecBnHKI_2.jpg	0	t	2026-03-16 06:40:32	2026-03-16 11:09:45
14	Tripod Stand	tripod stand	\N	/uploads/dk5JDKSv1Fc_26980221c2e166be9f090fb25b857dba_png_720.png	0	t	2026-03-16 16:18:09	2026-03-16 16:18:09
10	Screen Protectors	screen protectors	\N	/uploads/X7WaH756onM_premium-glass-ipha23-clear-4.webp	9	t	2026-03-16 06:39:47	2026-03-16 17:11:46
8	Phone screens ,Lcd,Led,Oled and Super Amoled	Phonescreens	\N	/uploads/SNNeab8ikqI_images.jpg	7	t	2026-03-09 20:22:13	2026-03-16 17:19:15
4	Bluetooth Speakers	bluetooth-speakers	Fill any space with rich, powerful sound. Our range of portable Bluetooth speakers is curated for those who demand audio quality without the premium price tag.	/uploads/UMbcwXgimRA_untitled.jpg	4	t	2026-03-07 06:42:43	2026-03-16 17:21:23
3	Accessories	accessories	Protect and power your device. Original chargers, genuine power banks, premium cases and screen protectors — everything your phone needs to stay safe and charged.	/uploads/6ScL3I95EVo_rreee.jpg	3	t	2026-03-07 06:42:43	2026-03-16 17:29:26
\.


--
-- Data for Name: expenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expenses (id, store_id, title, amount, category, date, notes, receipt_url, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: hero_slides; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hero_slides (id, label, title, subtitle, price, cta_label, cta_href, image_url, "position", active, inserted_at, updated_at) FROM stdin;
2	New Stock	Samsung Devices	New & Ex-UK — verified premium quality	From KES 28,000	Shop Samsung	/collections/samsung-devices	/uploads/fGJw7ROirNU_1002052559.jpg	2	t	2026-03-07 06:42:43	2026-03-17 15:19:28
1	Just Arrived	Premium Ex-UK iPhones	Genuine, unlocked & rigorously tested	From KES 45,000	Shop iPhones	/collections/ex-uk-iphones	/uploads/hNaMjYCuk7s_1002052577.png	1	t	2026-03-07 06:42:43	2026-03-17 15:25:10
3	Repair Centre	Cracked Screen? Fixed Today.	Genuine parts. 30-day warranty. Same day.	From KES 3,500	Book a Repair	/contact	/uploads/aSaoDwcBhV4_1002053601.jpg	3	t	2026-03-07 06:42:43	2026-03-17 16:43:05
5	Tribal Case	Tribal	\N	From KES 2500	View More	#	/uploads/DayGP1StZMU_1001995690.jpg	5	t	2026-03-17 14:19:50	2026-03-17 16:43:42
4	Latest arrivals	infinix note 60pro	\N	From KES 45,000	View More	#	/uploads/ugXeSmRi7tU_1.jpg	4	t	2026-03-09 20:35:50	2026-03-17 16:55:42
\.


--
-- Data for Name: legal_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.legal_documents (id, type, title, intro, inserted_at, updated_at) FROM stdin;
1	privacy	Privacy Policy	At Oasis Technologies, your privacy matters to us. This Privacy Policy explains how we collect, use and protect your personal information when you visit our website or purchase from our Thika store.	2026-03-07 06:42:43	2026-03-07 06:42:43
2	terms	Terms & Conditions	Please read these Terms and Conditions carefully before purchasing from Oasis Technologies. By buying from us — online or in-store — you agree to be bound by these terms.	2026-03-07 06:42:43	2026-03-07 06:42:43
3	refund	Refund & Returns Policy	We stand behind every product and service we provide. If something is not right, our fair returns and repair warranty policy has you covered.	2026-03-07 06:42:43	2026-03-07 06:42:43
\.


--
-- Data for Name: legal_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.legal_items (id, content, "position", legal_section_id, inserted_at, updated_at) FROM stdin;
1	Personal identification information (name, email address, phone number) provided when you register or place an order.	0	1	2026-03-07 06:42:43	2026-03-07 06:42:43
2	Payment information collected by our secure payment processor — we never store card or M-Pesa PINs on our servers.	1	1	2026-03-07 06:42:43	2026-03-07 06:42:43
3	Device and browsing data (IP address, browser type, pages visited) collected automatically via cookies.	2	1	2026-03-07 06:42:43	2026-03-07 06:42:43
4	Location data you provide for delivery or store visit purposes.	3	1	2026-03-07 06:42:43	2026-03-07 06:42:43
5	To process and fulfil your orders, including dispatch notifications and delivery updates.	0	2	2026-03-07 06:42:43	2026-03-07 06:42:43
6	To personalise your shopping experience and recommend relevant products.	1	2	2026-03-07 06:42:43	2026-03-07 06:42:43
7	To send marketing communications — you can opt out at any time via the unsubscribe link.	2	2	2026-03-07 06:42:43	2026-03-07 06:42:43
8	To improve our website, in-store experience and product range based on aggregated feedback.	3	2	2026-03-07 06:42:43	2026-03-07 06:42:43
9	We do not sell or rent your personal information to any third parties.	0	3	2026-03-07 06:42:43	2026-03-07 06:42:43
10	We share data only with trusted service providers contractually bound to protect it.	1	3	2026-03-07 06:42:43	2026-03-07 06:42:43
11	We may disclose information if required by Kenyan law or to protect the rights of Oasis Technologies and our customers.	2	3	2026-03-07 06:42:43	2026-03-07 06:42:43
12	You have the right to access, correct or delete the personal data we hold about you.	0	4	2026-03-07 06:42:43	2026-03-07 06:42:43
13	You can request a copy of your data at any time by emailing info@oasistechnologies.co.ke.	1	4	2026-03-07 06:42:43	2026-03-07 06:42:43
14	You have the right to withdraw consent for marketing communications at any time.	2	4	2026-03-07 06:42:43	2026-03-07 06:42:43
15	All Ex-UK devices are pre-owned, sourced from the United Kingdom and thoroughly tested before sale.	0	5	2026-03-07 06:42:43	2026-03-07 06:42:43
16	Grading is carried out honestly: Grade A means no visible screen scratches and minimal cosmetic wear on the body.	1	5	2026-03-07 06:42:43	2026-03-07 06:42:43
17	Battery health is disclosed for all Ex-UK devices — we guarantee a minimum of 85% battery capacity.	2	5	2026-03-07 06:42:43	2026-03-07 06:42:43
18	IMEI numbers are checked against the UK Stolen Devices database before any device is sold.	3	5	2026-03-07 06:42:43	2026-03-07 06:42:43
19	Prices are displayed in Kenyan Shillings (KES) and are subject to change without notice.	0	6	2026-03-07 06:42:43	2026-03-07 06:42:43
20	We accept M-Pesa, cash, Visa and Mastercard for all purchases.	1	6	2026-03-07 06:42:43	2026-03-07 06:42:43
21	In the event of a pricing error, we reserve the right to cancel affected orders and issue a full refund.	2	6	2026-03-07 06:42:43	2026-03-07 06:42:43
22	All online transactions are processed securely through our payment provider.	3	6	2026-03-07 06:42:43	2026-03-07 06:42:43
23	In-store purchases are final upon payment and handover of the device.	0	7	2026-03-07 06:42:43	2026-03-07 06:42:43
24	Online orders are confirmed upon payment — dispatch is within 24 hours for in-stock items.	1	7	2026-03-07 06:42:43	2026-03-07 06:42:43
25	We are not liable for delays caused by courier services once the device has been dispatched.	2	7	2026-03-07 06:42:43	2026-03-07 06:42:43
26	We reserve the right to refuse or cancel any order at our sole discretion.	3	7	2026-03-07 06:42:43	2026-03-07 06:42:43
27	Oasis Technologies shall not be liable for any indirect or consequential damages.	0	8	2026-03-07 06:42:43	2026-03-07 06:42:43
28	Our total liability shall not exceed the purchase price of the product in question.	1	8	2026-03-07 06:42:43	2026-03-07 06:42:43
29	Nothing in these terms limits liability for personal injury caused by our negligence.	2	8	2026-03-07 06:42:43	2026-03-07 06:42:43
30	Ex-UK and new devices may be returned within 7 days of purchase if they develop a manufacturing fault.	0	9	2026-03-07 06:42:43	2026-03-07 06:42:43
31	Devices must be returned with all original accessories and in the same condition as purchased.	1	9	2026-03-07 06:42:43	2026-03-07 06:42:43
32	We do not accept returns for devices that have been physically damaged, water damaged or tampered with after purchase.	2	9	2026-03-07 06:42:43	2026-03-07 06:42:43
33	Change-of-mind returns are not accepted on opened devices — please confirm your choice before purchase.	3	9	2026-03-07 06:42:43	2026-03-07 06:42:43
34	All repairs carried out at Oasis Technologies carry a 30-day warranty on the specific repair.	0	10	2026-03-07 06:42:43	2026-03-07 06:42:43
35	If the same fault recurs within 30 days, we will repair it again at no additional cost.	1	10	2026-03-07 06:42:43	2026-03-07 06:42:43
36	Repair warranty is void if the device has been dropped, water damaged or tampered with after repair.	2	10	2026-03-07 06:42:43	2026-03-07 06:42:43
37	Screen replacements using genuine OEM parts are warranted against display defects for 30 days.	3	10	2026-03-07 06:42:43	2026-03-07 06:42:43
38	Accessories may be returned within 7 days if they are unused, in original packaging and with proof of purchase.	0	11	2026-03-07 06:42:43	2026-03-07 06:42:43
39	Opened batteries, SIM accessories and hygiene items are not eligible for return unless faulty.	1	11	2026-03-07 06:42:43	2026-03-07 06:42:43
40	Faulty accessories will be replaced or refunded in full.	2	11	2026-03-07 06:42:43	2026-03-07 06:42:43
41	Approved refunds are processed immediately in-store via the original payment method.	0	12	2026-03-07 06:42:43	2026-03-07 06:42:43
42	M-Pesa refunds are processed within 24 hours of approval.	1	12	2026-03-07 06:42:43	2026-03-07 06:42:43
43	Contact us on +254 724 300 900 or info@oasistechnologies.co.ke to initiate any return or refund.	2	12	2026-03-07 06:42:43	2026-03-07 06:42:43
\.


--
-- Data for Name: legal_sections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.legal_sections (id, heading, "position", legal_document_id, inserted_at, updated_at) FROM stdin;
1	1. Information We Collect	0	1	2026-03-07 06:42:43	2026-03-07 06:42:43
2	2. How We Use Your Information	1	1	2026-03-07 06:42:43	2026-03-07 06:42:43
3	3. Sharing Your Information	2	1	2026-03-07 06:42:43	2026-03-07 06:42:43
4	4. Your Rights	3	1	2026-03-07 06:42:43	2026-03-07 06:42:43
5	1. Ex-UK Device Policy	0	2	2026-03-07 06:42:43	2026-03-07 06:42:43
6	2. Pricing & Payment	1	2	2026-03-07 06:42:43	2026-03-07 06:42:43
7	3. Orders & Delivery	2	2	2026-03-07 06:42:43	2026-03-07 06:42:43
8	4. Limitation of Liability	3	2	2026-03-07 06:42:43	2026-03-07 06:42:43
9	1. Device Returns	0	3	2026-03-07 06:42:43	2026-03-07 06:42:43
10	2. Repair Warranty	1	3	2026-03-07 06:42:43	2026-03-07 06:42:43
11	3. Accessories Returns	2	3	2026-03-07 06:42:43	2026-03-07 06:42:43
12	4. Refund Process	3	3	2026-03-07 06:42:43	2026-03-07 06:42:43
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (id, city, address, image_url, "position", visible, inserted_at, updated_at, lat, lng, phone, hours, map_label) FROM stdin;
2	Oasis Technologies - Skatters Thika	Oasis Technologies - Skatters Thika	\N	1	t	2026-03-07 07:05:07	2026-03-07 07:05:07	-1.0456234	37.0751363	+254715676167	Mon–Sat 8am–9pm, Sun 11am - 8:30 pm	Oasis Technologies - Skatters Thika
1	Jeff K Centre Thika	Mama Ngina Jeff K Centre\nGround Floor, Shop No. 20\nThika Town, Kiambu County\nKenya	https://images.pexels.com/photos/9833515/pexels-photo-9833515.jpeg?auto=compress&cs=tinysrgb&w=900	1	t	2026-03-07 06:42:43	2026-03-07 07:12:59	1.0357	37.0743	+25411211440	Mon–Sat 8am–9pm, Sun 11am - 8:30 pm	Oasis Technologies — Thika
\.


--
-- Data for Name: nav_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nav_items (id, label, href, "position", has_dropdown, visible, inserted_at, updated_at, "group") FROM stdin;
1	Home	/	1	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	navbar
2	About	/about	2	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	navbar
3	Shop	/collections	3	t	t	2026-03-07 06:42:43	2026-03-07 06:42:43	navbar
4	Contact	/contact	5	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	navbar
5	Home	/	1	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	useful_links
6	About Us	/about	2	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	useful_links
7	Shop	/collections	3	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	useful_links
8	Contact	/contact	4	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	useful_links
9	Legal	/legal	5	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	useful_links
10	Collections	/collections	1	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	quick_links
11	About Us	/about	2	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	quick_links
12	Contact Us	/contact	3	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	quick_links
13	Privacy Policy	/legal	4	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	quick_links
14	Terms of Use	/legal	1	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	extra_links
15	Returns Policy	/legal	2	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	extra_links
16	Warranty Info	/legal	3	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	extra_links
17	FAQ	/contact	4	f	t	2026-03-07 06:42:43	2026-03-07 06:42:43	extra_links
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, reference, customer_email, customer_name, status, total_amount, items, inserted_at, updated_at, customer_location, customer_phone, store_id, package_size, delivery_fee) FROM stdin;
1	OT-FB923BE3CCBF	michaelmunavu83@gmail.com	Michael Munavu	completed	32000.00	{"line_items": [{"name": "Samsung Galaxy A55 5G (New)", "quantity": 1, "image_url": "https://images.pexels.com/photos/7742506/pexels-photo-7742506.jpeg?auto=compress&cs=tinysrgb&w=600", "product_id": 4, "unit_price": "32000.00"}]}	2026-03-07 07:23:22	2026-03-07 07:24:01	7576-kangundo	+254740769596	1	\N	\N
2	OT-D8A7F7F8FF51	josphato73@gmail.com	josphat kwendo	completed	2500.00	{"line_items": [{"name": "Awei P20K 10000mAh Power Bank", "quantity": 1, "image_url": "/uploads/dd2nxuxQJP8_p20k2.webp", "product_id": 11, "unit_price": "2500.00"}]}	2026-03-09 21:48:27	2026-03-14 09:03:55	thika	0724303826	1	\N	\N
3	OT-099096B9D0BB	bonifacenganga24@gmail.com	Boniface Ganga	failed	3500.00	{"line_items": [{"name": "AWEI P139k power bank ", "quantity": 1, "image_url": "/uploads/i3Ma_yxvTh8_r.jpg", "product_id": 9, "unit_price": "3500.00"}]}	2026-03-14 10:41:13	2026-03-14 20:56:01	Thika jomoko	0721461603	\N	\N	\N
\.


--
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_images (id, url, "position", product_id, inserted_at, updated_at) FROM stdin;
1	/uploads/AK6YJY-pqU4_11.jpg	0	12	2026-03-09 19:53:26	2026-03-09 19:53:26
2	/uploads/VmANIg4Z-Pc_sam_45w.jpg	1	12	2026-03-09 19:53:26	2026-03-09 19:53:26
3	/uploads/Ba-va_1HapU_untitled.jpg	2	12	2026-03-09 19:53:26	2026-03-09 19:53:26
4	/uploads/BFm22IyKgXo_a07s.jpg	0	20	2026-03-09 20:02:54	2026-03-09 20:02:54
5	/uploads/NslHjzrs2RE_a07.jpg	1	20	2026-03-09 20:02:54	2026-03-09 20:02:54
6	/uploads/VDFfz_bpGeA_a.jpg	2	20	2026-03-09 20:02:54	2026-03-09 20:02:54
7	/uploads/8KDDCed3NqE_s24_ultra_2.jpg	0	21	2026-03-09 20:51:02	2026-03-09 20:51:02
8	/uploads/v-G9OJfjdhI_s24_ultr.jpg	1	21	2026-03-09 20:51:02	2026-03-09 20:51:02
9	/uploads/chOozMzllEI_251106160119_5a0defdadc75606c9e2f5b9c916.jpg	0	23	2026-03-09 21:15:01	2026-03-09 21:15:01
10	/uploads/O6WCzR4-QQ0_251106160120_68863e6a6bd090fb1b4a6cff265.jpg	1	23	2026-03-09 21:15:01	2026-03-09 21:15:01
11	/uploads/OB-uJgjExuQ_251106160120_9e3933341671226657a305e30c4.jpg	2	23	2026-03-09 21:15:01	2026-03-09 21:15:01
12	/uploads/MfjU3nwxilo_251106160120_1ccb8847c3df03b220022a78d6e.jpg	3	23	2026-03-09 21:15:01	2026-03-09 21:15:01
13	/uploads/dd2nxuxQJP8_p20k2.webp	0	11	2026-03-09 21:25:10	2026-03-09 21:25:10
14	/uploads/IYwr0O_wweo_p20k1.webp	1	11	2026-03-09 21:25:10	2026-03-09 21:25:10
15	/uploads/S6LXsAtTyrw_h3c03788dbed54eb5a5383d4fd3689155r.webp	0	10	2026-03-09 21:31:50	2026-03-09 21:31:50
16	/uploads/69Bp6K2JQU0_c67585cb723d3e98311d14e9c4fe470735cadde9.jpeg	1	10	2026-03-09 21:31:50	2026-03-09 21:31:50
17	/uploads/TqS8fEArFD8_h3c03788dbed54eb5a5383d4fd3689155r.webp	2	10	2026-03-09 21:31:50	2026-03-09 21:31:50
18	/uploads/kSAVa_GDfms_oip__1_.webp	0	18	2026-03-10 16:30:11	2026-03-10 16:30:11
19	/uploads/i3Ma_yxvTh8_r.jpg	0	9	2026-03-14 08:39:28	2026-03-14 08:39:28
20	/uploads/qPOr81Fw6x8_awei-p139k-10000mah-15w-magnetic-wireles.jpg	1	9	2026-03-14 08:39:28	2026-03-14 08:39:28
21	/uploads/CHqsSs-cBDg_awei-p139k-10000mah.jpg	2	9	2026-03-14 08:39:28	2026-03-14 08:39:28
22	/uploads/FnRRZpjUef0_20241002135257_awei_p139k_power_bank_100.jpeg	3	9	2026-03-14 08:39:28	2026-03-14 08:39:28
23	/uploads/3SKxSF2q49Q_cn-11134207-7r98o-lyk9hr6jwpeq68.jpg	3	10	2026-03-14 08:57:52	2026-03-14 08:57:52
24	/uploads/srOIZUaWnCc_t50.jpg	0	16	2026-03-15 12:42:55	2026-03-15 12:42:55
25	/uploads/jY9bJnWlcOA_t50.jpg	1	16	2026-03-15 12:42:55	2026-03-15 12:42:55
26	/uploads/MQpB3tD9dc8_oip__3_.webp	2	16	2026-03-15 12:42:55	2026-03-15 12:42:55
27	/uploads/7GeQ5WcRx-Q_watch-5-lite-0013.webp	0	15	2026-03-15 13:00:09	2026-03-15 13:00:09
28	/uploads/sea54x0Tf6g_241211145304_b01494ffb5db96f06f68df4656f.png	1	15	2026-03-15 13:00:09	2026-03-15 13:00:09
29	/uploads/oYXl2EqSklM_anker-u2i-01.jpeg	0	27	2026-03-15 13:03:58	2026-03-15 13:03:58
30	/uploads/pcclEYOfSdw_1_5.jpg	1	27	2026-03-15 13:03:58	2026-03-15 13:03:58
31	/uploads/R_jVqgPk71A_oip__6_.webp	0	26	2026-03-15 13:21:35	2026-03-15 13:21:35
32	/uploads/zqvdTG6Idao_oip__5_.webp	1	26	2026-03-15 13:21:35	2026-03-15 13:21:35
33	/uploads/yf7TCns_G5I_oip__7_.webp	2	26	2026-03-15 13:21:35	2026-03-15 13:21:35
34	/uploads/YhsWNxfGw3o_oip__4_.webp	3	26	2026-03-15 13:21:35	2026-03-15 13:21:35
35	/uploads/ZW-rtFN3Yws_ld0006236933.jpg	0	29	2026-03-15 14:54:15	2026-03-15 14:54:15
36	/uploads/HRxFiMuXmv4_oip.webp	1	29	2026-03-15 14:54:15	2026-03-15 14:54:15
37	/uploads/RPjgVGITcBQ_samsung-galaxy-a36-lavender-official-ima.webp	2	29	2026-03-15 14:54:15	2026-03-15 14:54:15
38	/uploads/tXhVs5dqy7c_miniso_20231003075306_5453_8594_2363_839.webp	0	30	2026-03-15 15:04:47	2026-03-15 15:04:47
39	/uploads/aRL3Y8SudB8_miniso_20231003075231_7501_5117_604_458_.webp	1	30	2026-03-15 15:04:47	2026-03-15 15:04:47
40	/uploads/ScY3dstVaFk_miniso_20231003075214_147_1674_2582_9034.webp	2	30	2026-03-15 15:04:47	2026-03-15 15:04:47
41	/uploads/DPRSs1lEkJQ_oraimo-watch-muse-osw-831n-extended-powe.webp	0	13	2026-03-16 06:01:15	2026-03-16 06:01:15
42	/uploads/PY_rOWhnySo_oraimo-watch-muse-osw-831n-2.webp	1	13	2026-03-16 06:01:15	2026-03-16 06:01:15
43	/uploads/FfuToR5JhoI_oraimo-watch-muse-osw-831n-1.webp	2	13	2026-03-16 06:01:15	2026-03-16 06:01:15
44	/uploads/6MSBaNQG0Zg_674a4a294813c52a599082bf3145b3b8.jpg	0	36	2026-03-16 07:08:28	2026-03-16 07:08:28
45	/uploads/VGhlTtId5jU_3.jpg	0	37	2026-03-16 11:27:48	2026-03-16 11:27:48
46	/uploads/TLOEsbxhfhM_1.jpg	1	37	2026-03-16 11:27:48	2026-03-16 11:27:48
47	/uploads/LNfegn87D2k_s-l16008.jpg	0	39	2026-03-16 11:51:56	2026-03-16 11:51:56
48	/uploads/aBUQwlqvwGQ_t.jpg	1	39	2026-03-16 11:51:56	2026-03-16 11:51:56
49	/uploads/yrTfGMZb-_c_oraimo-power-bank-powernova-qf1-opb-7270.webp	0	34	2026-03-16 12:16:25	2026-03-16 12:16:25
50	/uploads/dekhbKsQvas_oraimo-power-bank-powernova-qf1-opb-7270.webp	1	34	2026-03-16 12:16:25	2026-03-16 12:16:25
51	/uploads/oYsX_GgrAgU_latest-xiaomi-redmi-15c-128gb-price-buy-.webp	0	40	2026-03-16 12:38:09	2026-03-16 12:38:09
52	/uploads/UGn3a3bkx2I_buy-xiaomi-redmi-15c-128gb-christmas-off.webp	1	40	2026-03-16 12:38:09	2026-03-16 12:38:09
53	/uploads/aEZ3UpU7WSQ_glass-full-glue-21d-iph-16-pro-max_2f17.webp	0	41	2026-03-16 13:02:52	2026-03-16 13:02:52
54	/uploads/3AjE1me4LaI_oraimo-wireless-headphones-boompop-n-ohp.webp	0	42	2026-03-16 13:50:54	2026-03-16 13:50:54
55	/uploads/9X5PYuAJPsg_oraimo-wireless-headphones-boompop-n-ohp.webp	1	42	2026-03-16 13:50:54	2026-03-16 13:50:54
56	/uploads/8GP6GP_QdW0_oraimo-wireless-headphones-boompop-n-ohp.webp	2	42	2026-03-16 13:50:54	2026-03-16 13:50:54
57	/uploads/x2Qn9pqB7VY_oraimo-wireless-headphones-boompop-n-ohp.webp	3	42	2026-03-16 13:50:54	2026-03-16 13:50:54
58	/uploads/cYW-5VJFn2A_oraimo-wireless-headphones-boompop-n-ohp.webp	4	42	2026-03-16 13:50:54	2026-03-16 13:50:54
59	/uploads/pVoWQOyv5xE_j10lnymsdlnguaze8mmjmn4dxbdpdrjuxzrxinrs.jpg	0	43	2026-03-16 16:23:02	2026-03-16 16:23:02
60	/uploads/3Oe5bQHFEqU_image_3.jpg	1	43	2026-03-16 16:23:02	2026-03-16 16:23:02
61	/uploads/p47nAQRv2e0_wrc-10-playstation-5-2025-08-16t120432_0.png	0	46	2026-03-16 16:48:49	2026-03-16 16:48:49
62	/uploads/bxap98i8WMw_shopping.webp	1	46	2026-03-16 16:48:49	2026-03-16 16:48:49
63	/uploads/zbf1KyuGq4g_speaker-spacebox-pro-obs-682-10-google-p.webp	0	48	2026-03-16 17:01:39	2026-03-16 17:01:39
64	/uploads/lV2ni_kbSc4_speaker-spacebox-pro-obs-682-8-playtime-.webp	1	48	2026-03-16 17:01:39	2026-03-16 17:01:39
65	/uploads/4KE9zXUK2ac_speaker-spacebox-pro-obs-682-1.webp	2	48	2026-03-16 17:01:39	2026-03-16 17:01:39
66	/uploads/i-1BiDrSxc8_1.jpg	3	48	2026-03-16 17:01:39	2026-03-16 17:01:39
67	/uploads/w7hYcCi0k70_speaker-spacebox-pro-obs-682-10-google-p.webp	0	47	2026-03-16 17:45:37	2026-03-16 17:45:37
68	/uploads/BU26KHFPTow_speaker-spacebox-pro-obs-682-8-playtime-.webp	1	47	2026-03-16 17:45:37	2026-03-16 17:45:37
69	/uploads/n8VlQj3aJvI_speaker-spacebox-pro-obs-682-1.webp	2	47	2026-03-16 17:45:37	2026-03-16 17:45:37
70	/uploads/j6DSdCZuop4_speaker-spacebox-pro-obs-682-3-80w.webp	3	47	2026-03-16 17:45:37	2026-03-16 17:45:37
\.


--
-- Data for Name: product_specs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product_specs (id, label, value, "position", product_id, inserted_at, updated_at) FROM stdin;
60	Charging Time	6-8 hours	3	9	2026-03-07 07:40:51	2026-03-07 07:40:51
61	Dimensions	150 x 75 x 15 mm	4	9	2026-03-07 07:40:51	2026-03-07 07:40:51
62	Weight	250g	5	9	2026-03-07 07:40:51	2026-03-07 07:40:51
63	Color	Black	6	9	2026-03-07 07:40:51	2026-03-07 07:40:51
64	Condition	New	7	9	2026-03-07 07:40:51	2026-03-07 07:40:51
65	Compatibility	Universal for smartphones and tablets	8	9	2026-03-07 07:40:51	2026-03-07 07:40:51
66	LED Indicator	Yes	9	9	2026-03-07 07:40:51	2026-03-07 07:40:51
67	Capacity	10000mAh	0	10	2026-03-07 07:49:50	2026-03-07 07:49:50
68	Output Ports	2 USB ports	1	10	2026-03-07 07:49:50	2026-03-07 07:49:50
69	Input Port	Micro USB	2	10	2026-03-07 07:49:50	2026-03-07 07:49:50
70	Charging Speed	Fast charging support	3	10	2026-03-07 07:49:50	2026-03-07 07:49:50
71	Dimensions	150 x 75 x 15 mm	4	10	2026-03-07 07:49:50	2026-03-07 07:49:50
72	Weight	200g	5	10	2026-03-07 07:49:50	2026-03-07 07:49:50
73	Color	Black	6	10	2026-03-07 07:49:50	2026-03-07 07:49:50
74	Condition	New	7	10	2026-03-07 07:49:50	2026-03-07 07:49:50
76	Input	Micro USB, 5V/2A	1	11	2026-03-07 07:54:29	2026-03-07 07:54:29
77	Output	Dual USB, 5V/2.1A	2	11	2026-03-07 07:54:29	2026-03-07 07:54:29
78	Dimensions	150 x 75 x 15 mm	3	11	2026-03-07 07:54:29	2026-03-07 07:54:29
79	Weight	400g	4	11	2026-03-07 07:54:29	2026-03-07 07:54:29
80	Color	Black	5	11	2026-03-07 07:54:29	2026-03-07 07:54:29
81	Condition	New	6	11	2026-03-07 07:54:29	2026-03-07 07:54:29
82	Compatibility	Universal for smartphones and tablets	7	11	2026-03-07 07:54:29	2026-03-07 07:54:29
83	LED Indicator	Yes	8	11	2026-03-07 07:54:29	2026-03-07 07:54:29
84	Charging Time	Approximately 8-10 hours	9	11	2026-03-07 07:54:29	2026-03-07 07:54:29
85	Power Output	45W	0	12	2026-03-07 09:32:59	2026-03-07 09:32:59
86	Charging Technology	Power Delivery (PD)	1	12	2026-03-07 09:32:59	2026-03-07 09:32:59
87	Compatibility	Samsung and other USB-C devices	2	12	2026-03-07 09:32:59	2026-03-07 09:32:59
88	Input Voltage	100-240V AC	3	12	2026-03-07 09:32:59	2026-03-07 09:32:59
89	Output Voltage	5V, 9V, 15V, 20V	4	12	2026-03-07 09:32:59	2026-03-07 09:32:59
90	Dimensions	2.5 x 2.5 x 1.1 inches	5	12	2026-03-07 09:32:59	2026-03-07 09:32:59
91	Weight	0.5 lbs	6	12	2026-03-07 09:32:59	2026-03-07 09:32:59
92	Color	White	7	12	2026-03-07 09:32:59	2026-03-07 09:32:59
93	Condition	New	8	12	2026-03-07 09:32:59	2026-03-07 09:32:59
94	Display	1.32" AMOLED	0	13	2026-03-07 09:42:22	2026-03-07 09:42:22
95	Battery Life	Up to 7 days	1	13	2026-03-07 09:42:22	2026-03-07 09:42:22
96	Water Resistance	IP68	2	13	2026-03-07 09:42:22	2026-03-07 09:42:22
97	Connectivity	Bluetooth 5.0	3	13	2026-03-07 09:42:22	2026-03-07 09:42:22
98	Compatibility	iOS and Android	4	13	2026-03-07 09:42:22	2026-03-07 09:42:22
99	Sensors	Heart Rate, Sleep Monitor	5	13	2026-03-07 09:42:22	2026-03-07 09:42:22
100	Weight	50 grams	6	13	2026-03-07 09:42:22	2026-03-07 09:42:22
101	Color Options	Black, Silver, Rose Gold	7	13	2026-03-07 09:42:22	2026-03-07 09:42:22
102	Condition	New	8	13	2026-03-07 09:42:22	2026-03-07 09:42:22
103	Dimensions	42 x 36 x 10 mm	9	13	2026-03-07 09:42:22	2026-03-07 09:42:22
105	Processor	Custom Oraimo Chip	1	15	2026-03-09 07:48:48	2026-03-09 07:48:48
106	Battery	210mAh, up to 10 days	2	15	2026-03-09 07:48:48	2026-03-09 07:48:48
107	Water Resistance	IP68	3	15	2026-03-09 07:48:48	2026-03-09 07:48:48
108	Connectivity	Bluetooth 5.0	4	15	2026-03-09 07:48:48	2026-03-09 07:48:48
109	Sensors	Heart Rate, SpO2, Sleep Monitor	5	15	2026-03-09 07:48:48	2026-03-09 07:48:48
110	Compatibility	iOS and Android	6	15	2026-03-09 07:48:48	2026-03-09 07:48:48
111	Weight	40g	7	15	2026-03-09 07:48:48	2026-03-09 07:48:48
112	Color Options	Black, Pink, Green	8	15	2026-03-09 07:48:48	2026-03-09 07:48:48
113	Condition	Brand New	9	15	2026-03-09 07:48:48	2026-03-09 07:48:48
114	Type	In-ear Wireless Earbuds	0	16	2026-03-09 07:56:17	2026-03-09 07:56:17
115	Noise Cancellation	Active Noise Cancellation (ENC)	1	16	2026-03-09 07:56:17	2026-03-09 07:56:17
116	Battery Life	Up to 20 hours with charging case	2	16	2026-03-09 07:56:17	2026-03-09 07:56:17
117	Bluetooth Version	Bluetooth 5.0	3	16	2026-03-09 07:56:17	2026-03-09 07:56:17
118	Driver Size	10mm	4	16	2026-03-09 07:56:17	2026-03-09 07:56:17
119	Water Resistance	IPX5	5	16	2026-03-09 07:56:17	2026-03-09 07:56:17
120	Charging Port	USB-C	6	16	2026-03-09 07:56:17	2026-03-09 07:56:17
121	Weight	5g per earbud	7	16	2026-03-09 07:56:17	2026-03-09 07:56:17
122	Color Options	Black, White	8	16	2026-03-09 07:56:17	2026-03-09 07:56:17
123	Compatibility	iOS and Android devices	9	16	2026-03-09 07:56:17	2026-03-09 07:56:17
124	Condition	Brand New	10	16	2026-03-09 07:56:17	2026-03-09 07:56:17
125	Display	6.5 inches, HD+	0	20	2026-03-09 18:12:40	2026-03-09 18:12:40
126	Processor	Octa-core	1	20	2026-03-09 18:12:40	2026-03-09 18:12:40
129	Battery	5000mAh	4	20	2026-03-09 18:12:40	2026-03-09 18:12:40
130	Camera	13MP rear, 5MP front	5	20	2026-03-09 18:12:40	2026-03-09 18:12:40
131	OS	Android 11	6	20	2026-03-09 18:12:40	2026-03-09 18:12:40
132	Connectivity	4G LTE, Wi-Fi, Bluetooth	7	20	2026-03-09 18:12:40	2026-03-09 18:12:40
133	Dimensions	164.2 x 75.9 x 9.1 mm	8	20	2026-03-09 18:12:40	2026-03-09 18:12:40
134	Color	Black, Blue, Red	9	20	2026-03-09 18:12:40	2026-03-09 18:12:40
135	Condition	Ex-UK	10	20	2026-03-09 18:12:40	2026-03-09 18:12:40
128	Storage	128GB, expandable via microSD	3	20	2026-03-09 18:12:40	2026-03-09 19:59:21
127	RAM	4GB	2	20	2026-03-09 18:12:40	2026-03-09 20:01:10
136	Display	6.5 inches, HD+	11	20	2026-03-09 20:20:13	2026-03-09 20:20:13
137	Processor	Octa-core	12	20	2026-03-09 20:20:13	2026-03-09 20:20:13
138	RAM	3GB	13	20	2026-03-09 20:20:13	2026-03-09 20:20:13
139	Storage	32GB, expandable via microSD	14	20	2026-03-09 20:20:13	2026-03-09 20:20:13
140	Battery	5000mAh	15	20	2026-03-09 20:20:13	2026-03-09 20:20:13
141	Camera	13MP rear, 5MP front	16	20	2026-03-09 20:20:13	2026-03-09 20:20:13
142	OS	Android 11	17	20	2026-03-09 20:20:13	2026-03-09 20:20:13
143	Connectivity	4G LTE, Wi-Fi, Bluetooth	18	20	2026-03-09 20:20:13	2026-03-09 20:20:13
144	Dimensions	164.2 x 75.9 x 9.1 mm	19	20	2026-03-09 20:20:13	2026-03-09 20:20:13
59	Output Ports	USB	2	9	2026-03-07 07:40:51	2026-03-14 08:37:27
58	Input Port	TYPE C	1	9	2026-03-07 07:40:51	2026-03-14 08:37:50
57	Battery Capacity	10000mAh	0	9	2026-03-07 07:40:51	2026-03-14 08:38:01
104	Display	2.01-inch TFT LCD	0	15	2026-03-09 07:48:48	2026-03-15 13:00:56
145	Color	Black, Blue, Red	20	20	2026-03-09 20:20:13	2026-03-09 20:20:13
156	Dimensions	163.4 x 78.1 x 8.9 mm	9	21	2026-03-09 20:50:15	2026-03-09 20:50:15
167	Connectivity	4G LTE, Wi-Fi, Bluetooth	8	23	2026-03-09 21:10:44	2026-03-09 21:10:44
146	Condition	Ex-UK, refurbished	21	20	2026-03-09 20:20:13	2026-03-09 20:20:13
154	OS	Android 14	7	21	2026-03-09 20:50:15	2026-03-09 20:50:15
165	Camera (Front)	8MP	6	23	2026-03-09 21:10:44	2026-03-09 21:10:44
147	Display	6.8-inch Dynamic AMOLED 2X	0	21	2026-03-09 20:50:15	2026-03-09 20:50:15
157	Color	Phantom Black	10	21	2026-03-09 20:50:15	2026-03-09 20:50:15
161	RAM	4GB	2	23	2026-03-09 21:10:44	2026-03-09 21:10:44
148	Processor	Exynos 2200 / Snapdragon 8 Gen 2	1	21	2026-03-09 20:50:15	2026-03-09 20:50:15
158	Condition	Ex-UK	11	21	2026-03-09 20:50:15	2026-03-09 20:50:15
168	Dimensions	164.5 x 76.2 x 8.5 mm	9	23	2026-03-09 21:10:44	2026-03-09 21:10:44
149	RAM	12GB	2	21	2026-03-09 20:50:15	2026-03-09 20:50:15
166	OS	Android 12, HiOS	7	23	2026-03-09 21:10:44	2026-03-09 21:10:44
150	Storage	256GB	3	21	2026-03-09 20:50:15	2026-03-09 20:50:15
162	Storage	128GB, expandable via microSD	3	23	2026-03-09 21:10:44	2026-03-09 21:10:44
151	Battery	5000mAh	4	21	2026-03-09 20:50:15	2026-03-09 20:50:15
160	Processor	MediaTek Helio G85	1	23	2026-03-09 21:10:44	2026-03-09 21:10:44
170	Condition	Brand New	11	23	2026-03-09 21:10:44	2026-03-09 21:10:44
152	Camera	200MP + 12MP + 10MP + 10MP Quad Camera	5	21	2026-03-09 20:50:15	2026-03-09 20:50:15
163	Battery	5000mAh	4	23	2026-03-09 21:10:44	2026-03-09 21:10:44
153	Front Camera	12MP	6	21	2026-03-09 20:50:15	2026-03-09 20:50:15
159	Display	6.6 inches, HD+	0	23	2026-03-09 21:10:44	2026-03-09 21:10:44
169	Color	Various options available	10	23	2026-03-09 21:10:44	2026-03-09 21:10:44
155	Connectivity	5G, Wi-Fi 6E, Bluetooth 5.3	8	21	2026-03-09 20:50:15	2026-03-09 20:50:15
164	Camera (Rear)	50MP + 0.08MP	5	23	2026-03-09 21:10:44	2026-03-09 21:10:44
75	Capacity	10,000mAh	0	11	2026-03-07 07:54:29	2026-03-09 21:23:59
171	Capacity	10000mAh	8	10	2026-03-09 21:29:20	2026-03-09 21:29:20
172	Output Ports	2 USB ports	9	10	2026-03-09 21:29:20	2026-03-09 21:29:20
173	Input Port	Micro USB	10	10	2026-03-09 21:29:20	2026-03-09 21:29:20
174	Charging Speed	Fast charging support	11	10	2026-03-09 21:29:20	2026-03-09 21:29:20
175	Dimensions	140 x 70 x 15 mm	12	10	2026-03-09 21:29:20	2026-03-09 21:29:20
176	Weight	200g	13	10	2026-03-09 21:29:20	2026-03-09 21:29:20
177	Color	Black	14	10	2026-03-09 21:29:20	2026-03-09 21:29:20
178	Condition	Brand New	15	10	2026-03-09 21:29:20	2026-03-09 21:29:20
189	Water Resistance	IPX7 Waterproof	0	18	2026-03-10 16:30:51	2026-03-10 16:30:51
190	Bluetooth Version	5.0	1	18	2026-03-10 16:30:51	2026-03-10 16:30:51
191	Battery Life	Up to 12 hours	2	18	2026-03-10 16:30:51	2026-03-10 16:30:51
192	Speaker Output	10W	3	18	2026-03-10 16:30:51	2026-03-10 16:30:51
193	Charging Time	3 hours	4	18	2026-03-10 16:30:51	2026-03-10 16:30:51
194	Dimensions	7.5 x 3.5 x 3 inches	5	18	2026-03-10 16:30:51	2026-03-10 16:30:51
195	Weight	1.2 lbs	6	18	2026-03-10 16:30:51	2026-03-10 16:30:51
196	Color Options	Black, Blue, Red	7	18	2026-03-10 16:30:51	2026-03-10 16:30:51
197	Microphone	Built-in for hands-free calls	8	18	2026-03-10 16:30:51	2026-03-10 16:30:51
198	Compatibility	Compatible with all Bluetooth devices	9	18	2026-03-10 16:30:51	2026-03-10 16:30:51
199	Condition	Brand New	10	18	2026-03-10 16:30:51	2026-03-10 16:30:51
200	Material	Durable Plastic and Metal	0	25	2026-03-10 16:36:30	2026-03-10 16:36:30
201	Height Adjustment	Telescopic up to 1.5 meters	1	25	2026-03-10 16:36:30	2026-03-10 16:36:30
202	Weight Capacity	Supports up to 5 kg	2	25	2026-03-10 16:36:30	2026-03-10 16:36:30
203	Compatibility	Universal for smartphones and tablets	3	25	2026-03-10 16:36:30	2026-03-10 16:36:30
204	Folded Size	Compact for easy storage	4	25	2026-03-10 16:36:30	2026-03-10 16:36:30
205	Color	Black	5	25	2026-03-10 16:36:30	2026-03-10 16:36:30
206	Condition	New	6	25	2026-03-10 16:36:30	2026-03-10 16:36:30
207	Type	Gimbal Stabilizer	0	26	2026-03-10 16:42:35	2026-03-10 16:42:35
208	Rotation	360 Degrees	1	26	2026-03-10 16:42:35	2026-03-10 16:42:35
209	Material	Aluminum Alloy	2	26	2026-03-10 16:42:35	2026-03-10 16:42:35
210	Height	Adjustable up to 60 cm	3	26	2026-03-10 16:42:35	2026-03-10 16:42:35
211	Weight Capacity	Up to 2 kg	4	26	2026-03-10 16:42:35	2026-03-10 16:42:35
212	Compatibility	Smartphones and Cameras	5	26	2026-03-10 16:42:35	2026-03-10 16:42:35
213	Mounting Type	1/4 inch Screw	6	26	2026-03-10 16:42:35	2026-03-10 16:42:35
214	Color	Black	7	26	2026-03-10 16:42:35	2026-03-10 16:42:35
215	Condition	New	8	26	2026-03-10 16:42:35	2026-03-10 16:42:35
216	Included Accessories	Carrying Bag, Phone Holder	9	26	2026-03-10 16:42:35	2026-03-10 16:42:35
217	Capacity	10000mAh	10	9	2026-03-14 08:34:51	2026-03-14 08:34:51
218	Output Ports	1 USB-A, 1 USB-C	11	9	2026-03-14 08:34:51	2026-03-14 08:34:51
219	Input Ports	USB-C	12	9	2026-03-14 08:34:51	2026-03-14 08:34:51
220	Dimensions	95 x 63 x 15 mm	13	9	2026-03-14 08:34:51	2026-03-14 08:34:51
221	Weight	200g	14	9	2026-03-14 08:34:51	2026-03-14 08:34:51
223	Color	Black	16	9	2026-03-14 08:34:51	2026-03-14 08:34:51
224	Condition	Brand New	17	9	2026-03-14 08:34:51	2026-03-14 08:34:51
225	Compatibility	Universal for all smartphones	18	9	2026-03-14 08:34:51	2026-03-14 08:34:51
226	Magnetic Feature	Yes	19	9	2026-03-14 08:34:51	2026-03-14 08:34:51
222	Charging Speed	Fast Charging 22.5W	15	9	2026-03-14 08:34:51	2026-03-14 08:38:57
235	Brand	Anker	0	27	2026-03-14 10:00:59	2026-03-14 10:00:59
236	Model	Soundcore	1	27	2026-03-14 10:00:59	2026-03-14 10:00:59
237	Audio Type	Wireless Earbuds/Speakers	2	27	2026-03-14 10:00:59	2026-03-14 10:00:59
238	Battery Life	Up to 20 hours	3	27	2026-03-14 10:00:59	2026-03-14 10:00:59
239	Connectivity	Bluetooth 5.0	4	27	2026-03-14 10:00:59	2026-03-14 10:00:59
240	Water Resistance	IPX7	5	27	2026-03-14 10:00:59	2026-03-14 10:00:59
241	Weight	Varies by model	6	27	2026-03-14 10:00:59	2026-03-14 10:00:59
242	Color Options	Black, White, Blue	7	27	2026-03-14 10:00:59	2026-03-14 10:00:59
243	Condition	New	8	27	2026-03-14 10:00:59	2026-03-14 10:00:59
244	Bluetooth Version	5.0	0	28	2026-03-15 12:50:16	2026-03-15 12:50:16
245	Battery Life	Up to 10 hours	1	28	2026-03-15 12:50:16	2026-03-15 12:50:16
246	Charging Time	1.5 hours	2	28	2026-03-15 12:50:16	2026-03-15 12:50:16
247	Driver Size	10mm	3	28	2026-03-15 12:50:16	2026-03-15 12:50:16
248	Weight	15 grams	4	28	2026-03-15 12:50:16	2026-03-15 12:50:16
249	Water Resistance	IPX4	5	28	2026-03-15 12:50:16	2026-03-15 12:50:16
250	Color Options	Black, White	6	28	2026-03-15 12:50:16	2026-03-15 12:50:16
251	Microphone	Built-in	7	28	2026-03-15 12:50:16	2026-03-15 12:50:16
252	Compatibility	iOS and Android	8	28	2026-03-15 12:50:16	2026-03-15 12:50:16
253	Condition	Brand New	9	28	2026-03-15 12:50:16	2026-03-15 12:50:16
255	Battery Life	Up to 7 days	11	15	2026-03-15 12:59:02	2026-03-15 12:59:02
256	Heart Rate Monitor	Yes	12	15	2026-03-15 12:59:02	2026-03-15 12:59:02
257	Sleep Tracking	Yes	13	15	2026-03-15 12:59:02	2026-03-15 12:59:02
258	Water Resistance	IP68	14	15	2026-03-15 12:59:02	2026-03-15 12:59:02
259	Connectivity	Bluetooth 5.0	15	15	2026-03-15 12:59:02	2026-03-15 12:59:02
260	Compatibility	iOS and Android	16	15	2026-03-15 12:59:02	2026-03-15 12:59:02
261	Color	Pink	17	15	2026-03-15 12:59:02	2026-03-15 12:59:02
262	Weight	30 grams	18	15	2026-03-15 12:59:02	2026-03-15 12:59:02
263	Dimensions	40mm x 35mm x 10mm	19	15	2026-03-15 12:59:02	2026-03-15 12:59:02
264	Condition	New	20	15	2026-03-15 12:59:02	2026-03-15 12:59:02
254	Display	2.01-inch TFT LCD	10	15	2026-03-15 12:59:02	2026-03-15 13:01:10
265	Type	In-ear	9	27	2026-03-15 13:02:57	2026-03-15 13:02:57
266	Connectivity	Bluetooth 5.0	10	27	2026-03-15 13:02:57	2026-03-15 13:02:57
267	Battery Life	Up to 24 hours	11	27	2026-03-15 13:02:57	2026-03-15 13:02:57
268	Charging Time	1.5 hours	12	27	2026-03-15 13:02:57	2026-03-15 13:02:57
269	Driver Size	10mm	13	27	2026-03-15 13:02:57	2026-03-15 13:02:57
270	Water Resistance	IPX7	14	27	2026-03-15 13:02:57	2026-03-15 13:02:57
271	Weight	15 grams	15	27	2026-03-15 13:02:57	2026-03-15 13:02:57
272	Color	Black	16	27	2026-03-15 13:02:57	2026-03-15 13:02:57
273	Microphone	Built-in	17	27	2026-03-15 13:02:57	2026-03-15 13:02:57
274	Controls	Touch controls	18	27	2026-03-15 13:02:57	2026-03-15 13:02:57
278	RAM	6GB	2	29	2026-03-15 14:52:51	2026-03-15 14:52:51
275	Condition	New	19	27	2026-03-15 13:02:57	2026-03-15 13:02:57
285	Dimensions	159.9 x 75.1 x 8.4 mm	9	29	2026-03-15 14:52:52	2026-03-15 14:52:52
276	Display	6.5 inches, FHD+ Super AMOLED	0	29	2026-03-15 14:52:51	2026-03-15 14:52:51
286	Color	Awesome Black, Awesome White	10	29	2026-03-15 14:52:52	2026-03-15 14:52:52
277	Processor	Exynos 1280 Octa-core	1	29	2026-03-15 14:52:51	2026-03-15 14:52:51
287	Condition	Ex-UK, Like New	11	29	2026-03-15 14:52:52	2026-03-15 14:52:52
279	Storage	128GB, expandable via microSD	3	29	2026-03-15 14:52:51	2026-03-15 14:52:51
280	Battery	5000mAh with fast charging	4	29	2026-03-15 14:52:51	2026-03-15 14:52:51
281	Camera	Triple rear camera: 50MP + 12MP + 5MP	5	29	2026-03-15 14:52:51	2026-03-15 14:52:51
282	Front Camera	13MP	6	29	2026-03-15 14:52:52	2026-03-15 14:52:52
283	OS	Android 13, One UI 5.1	7	29	2026-03-15 14:52:52	2026-03-15 14:52:52
284	Connectivity	5G, Wi-Fi 6, Bluetooth 5.2	8	29	2026-03-15 14:52:52	2026-03-15 14:52:52
288	Driver Size	10 mm	0	30	2026-03-15 15:00:35	2026-03-15 15:00:35
289	Battery Life	Up to 8 hours	1	30	2026-03-15 15:00:35	2026-03-15 15:00:35
290	Connectivity	Bluetooth 5.0	2	30	2026-03-15 15:00:35	2026-03-15 15:00:35
291	Weight	5 grams per earbud	3	30	2026-03-15 15:00:35	2026-03-15 15:00:35
292	Charging Case	Included	4	30	2026-03-15 15:00:35	2026-03-15 15:00:35
293	Water Resistance	IPX4	5	30	2026-03-15 15:00:35	2026-03-15 15:00:35
294	Color Options	Black, White	6	30	2026-03-15 15:00:35	2026-03-15 15:00:35
295	Microphone	Built-in	7	30	2026-03-15 15:00:35	2026-03-15 15:00:35
296	Compatibility	iOS and Android	8	30	2026-03-15 15:00:35	2026-03-15 15:00:35
297	Condition	New	9	30	2026-03-15 15:00:35	2026-03-15 15:00:35
298	Charger Type	USB-C Power Adapter	0	31	2026-03-15 15:11:31	2026-03-15 15:11:31
299	Cable Length	1 meter	1	31	2026-03-15 15:11:31	2026-03-15 15:11:31
300	Output Power	20W	2	31	2026-03-15 15:11:31	2026-03-15 15:11:31
301	Compatibility	iPhone models with USB-C	3	31	2026-03-15 15:11:31	2026-03-15 15:11:31
302	Material	High-quality plastic and copper	4	31	2026-03-15 15:11:31	2026-03-15 15:11:31
303	Color	White	5	31	2026-03-15 15:11:31	2026-03-15 15:11:31
304	Condition	New	6	31	2026-03-15 15:11:31	2026-03-15 15:11:31
305	Weight	150 grams	7	31	2026-03-15 15:11:31	2026-03-15 15:11:31
306	Warranty	1 year	8	31	2026-03-15 15:11:31	2026-03-15 15:11:31
307	Compatibility	iPhone, iPad, and iPod models with Lightning connector	0	32	2026-03-15 15:17:19	2026-03-15 15:17:19
308	Length	1 meter	1	32	2026-03-15 15:17:19	2026-03-15 15:17:19
309	Connector Type	USB-C to Lightning	2	32	2026-03-15 15:17:19	2026-03-15 15:17:19
310	Charging Speed	Up to 20W fast charging	3	32	2026-03-15 15:17:19	2026-03-15 15:17:19
311	Data Transfer Speed	Up to 480 Mbps	4	32	2026-03-15 15:17:19	2026-03-15 15:17:19
313	Color	White	6	32	2026-03-15 15:17:19	2026-03-15 15:17:19
314	Condition	Brand new	7	32	2026-03-15 15:17:19	2026-03-15 15:17:19
312	Material	Durable PVC	5	32	2026-03-15 15:17:19	2026-03-15 15:18:06
315	Display	1.5 inch AMOLED	10	13	2026-03-16 05:54:20	2026-03-16 05:54:20
317	Water Resistance	IP68	12	13	2026-03-16 05:54:20	2026-03-16 05:54:20
318	Fitness Tracking	Heart rate, steps, sleep monitoring	13	13	2026-03-16 05:54:20	2026-03-16 05:54:20
319	Connectivity	Bluetooth 5.0	14	13	2026-03-16 05:54:20	2026-03-16 05:54:20
320	Compatibility	iOS and Android	15	13	2026-03-16 05:54:20	2026-03-16 05:54:20
321	Color	Gold	16	13	2026-03-16 05:54:20	2026-03-16 05:54:20
322	Material	Stainless Steel	17	13	2026-03-16 05:54:20	2026-03-16 05:54:20
323	Condition	New	18	13	2026-03-16 05:54:20	2026-03-16 05:54:20
325	Battery Life	Up to 7 days	20	13	2026-03-16 05:54:30	2026-03-16 05:54:30
326	Water Resistance	IP68	21	13	2026-03-16 05:54:30	2026-03-16 05:54:30
327	Connectivity	Bluetooth 5.0	22	13	2026-03-16 05:54:30	2026-03-16 05:54:30
328	Health Monitoring	Heart rate, Sleep tracking	23	13	2026-03-16 05:54:30	2026-03-16 05:54:30
329	Compatibility	iOS and Android	24	13	2026-03-16 05:54:30	2026-03-16 05:54:30
330	Material	Stainless steel with gold finish	25	13	2026-03-16 05:54:30	2026-03-16 05:54:30
331	Weight	50 grams	26	13	2026-03-16 05:54:30	2026-03-16 05:54:30
332	Dimensions	42mm x 42mm x 10mm	27	13	2026-03-16 05:54:30	2026-03-16 05:54:30
333	Condition	Brand new	28	13	2026-03-16 05:54:30	2026-03-16 05:54:30
324	Display	1.32-inch AMOLED	19	13	2026-03-16 05:54:30	2026-03-16 06:00:02
316	Battery Life	Up to 11 days	11	13	2026-03-16 05:54:20	2026-03-16 06:00:27
334	Power Output	25W	0	33	2026-03-16 06:30:08	2026-03-16 06:30:08
335	Charging Technology	Power Delivery (PD)	1	33	2026-03-16 06:30:08	2026-03-16 06:30:08
336	Input Voltage	100-240V	2	33	2026-03-16 06:30:08	2026-03-16 06:30:08
337	Output Voltage	5V/9V/12V	3	33	2026-03-16 06:30:08	2026-03-16 06:30:08
338	Compatibility	Universal for USB-C devices	4	33	2026-03-16 06:30:08	2026-03-16 06:30:08
339	Dimensions	2.5 x 2.5 x 1.0 inches	5	33	2026-03-16 06:30:08	2026-03-16 06:30:08
340	Weight	0.15 lbs	6	33	2026-03-16 06:30:08	2026-03-16 06:30:08
341	Color	White	7	33	2026-03-16 06:30:08	2026-03-16 06:30:08
342	Condition	New	8	33	2026-03-16 06:30:08	2026-03-16 06:30:08
343	Safety Features	Overvoltage and overcurrent protection	9	33	2026-03-16 06:30:08	2026-03-16 06:30:08
344	Capacity	7200mAh	0	34	2026-03-16 06:46:53	2026-03-16 06:46:53
345	Output Ports	2 USB ports	1	34	2026-03-16 06:46:53	2026-03-16 06:46:53
346	Input Port	Micro USB	2	34	2026-03-16 06:46:53	2026-03-16 06:46:53
347	Charging Time	Approximately 5-6 hours	3	34	2026-03-16 06:46:53	2026-03-16 06:46:53
348	Dimensions	140 x 70 x 15 mm	4	34	2026-03-16 06:46:53	2026-03-16 06:46:53
349	Weight	180g	5	34	2026-03-16 06:46:53	2026-03-16 06:46:53
350	Color	Black	6	34	2026-03-16 06:46:53	2026-03-16 06:46:53
351	Condition	Brand New	7	34	2026-03-16 06:46:53	2026-03-16 06:46:53
352	Compatibility	Universal for smartphones and tablets	8	34	2026-03-16 06:46:53	2026-03-16 06:46:53
353	Safety Features	Overcharge protection, short circuit protection	9	34	2026-03-16 06:46:53	2026-03-16 06:46:53
354	Diameter	12 inches	0	36	2026-03-16 07:03:25	2026-03-16 07:03:25
355	Light Type	RGB LED	1	36	2026-03-16 07:03:25	2026-03-16 07:03:25
356	Brightness Levels	Adjustable	2	36	2026-03-16 07:03:25	2026-03-16 07:03:25
357	Color Temperature	3200K to 6000K	3	36	2026-03-16 07:03:25	2026-03-16 07:03:25
358	Power Source	AC Adapter	4	36	2026-03-16 07:03:25	2026-03-16 07:03:25
359	Tripod Height	Adjustable up to 6 feet	5	36	2026-03-16 07:03:25	2026-03-16 07:03:25
360	Weight	1.5 kg	6	36	2026-03-16 07:03:25	2026-03-16 07:03:25
361	Material	Plastic and Metal	7	36	2026-03-16 07:03:25	2026-03-16 07:03:25
362	Compatibility	Smartphones and Cameras	8	36	2026-03-16 07:03:25	2026-03-16 07:03:25
363	Condition	New	9	36	2026-03-16 07:03:25	2026-03-16 07:03:25
364	Compatibility	iPhone 13 Pro Max	0	37	2026-03-16 11:26:53	2026-03-16 11:26:53
365	Material	TPU and Polycarbonate	1	37	2026-03-16 11:26:53	2026-03-16 11:26:53
366	Color	Black	2	37	2026-03-16 11:26:53	2026-03-16 11:26:53
367	Weight	50g	3	37	2026-03-16 11:26:53	2026-03-16 11:26:53
368	Dimensions	160.8 x 78.1 x 7.65 mm	4	37	2026-03-16 11:26:53	2026-03-16 11:26:53
369	Drop Protection	Up to 3 meters	5	37	2026-03-16 11:26:53	2026-03-16 11:26:53
370	Wireless Charging	Yes	6	37	2026-03-16 11:26:53	2026-03-16 11:26:53
371	Screen Protection	Raised edges for screen protection	7	37	2026-03-16 11:26:53	2026-03-16 11:26:53
372	Condition	New	8	37	2026-03-16 11:26:53	2026-03-16 11:26:53
373	Warranty	1 Year	9	37	2026-03-16 11:26:53	2026-03-16 11:26:53
376	Color	Black	2	38	2026-03-16 11:31:14	2026-03-16 11:31:14
383	Mount Type	Dashboard and Windshield	1	39	2026-03-16 11:38:41	2026-03-16 11:38:41
391	Battery Capacity	20000mAh	10	34	2026-03-16 12:13:40	2026-03-16 12:13:40
408	Connectivity	4G LTE, Wi-Fi, Bluetooth 5.0	7	40	2026-03-16 12:37:06	2026-03-16 12:37:06
414	Hardness	9H	2	41	2026-03-16 13:00:08	2026-03-16 13:00:08
438	Condition	Brand new	19	36	2026-03-16 14:21:39	2026-03-16 14:21:39
374	Compatibility	Samsung S26 Ultra	0	38	2026-03-16 11:31:14	2026-03-16 11:31:14
385	Adjustability	360-degree Rotation	3	39	2026-03-16 11:38:41	2026-03-16 11:38:41
392	Output Ports	3 USB Ports	11	34	2026-03-16 12:13:40	2026-03-16 12:13:40
404	Storage	256GB	3	40	2026-03-16 12:37:06	2026-03-16 12:37:06
413	Thickness	0.3 mm	1	41	2026-03-16 13:00:08	2026-03-16 13:00:08
428	Condition	Brand New	7	42	2026-03-16 13:45:28	2026-03-16 13:45:28
434	Tripod Height	Adjustable up to 6 feet	15	36	2026-03-16 14:21:39	2026-03-16 14:21:39
375	Material	Polycarbonate and TPU	1	38	2026-03-16 11:31:14	2026-03-16 11:31:14
386	Installation	Easy Adhesive or Suction Cup	4	39	2026-03-16 11:38:41	2026-03-16 11:38:41
396	Weight	400g	15	34	2026-03-16 12:13:40	2026-03-16 12:13:40
409	Dimensions	168.8 x 76.4 x 8.8 mm	8	40	2026-03-16 12:37:06	2026-03-16 12:37:06
417	Clarity	99% Transparency	5	41	2026-03-16 13:00:08	2026-03-16 13:00:08
425	Dimensions	230 x 90 x 90 mm	4	42	2026-03-16 13:45:28	2026-03-16 13:45:28
433	Power Source	USB powered	14	36	2026-03-16 14:21:39	2026-03-16 14:21:39
377	Weight	50g	3	38	2026-03-16 11:31:14	2026-03-16 11:31:14
384	Compatibility	Most Smartphones	2	39	2026-03-16 11:38:41	2026-03-16 11:38:41
405	Battery	6000mAh	4	40	2026-03-16 12:37:06	2026-03-16 12:38:26
415	Compatibility	Universal for smartphones	3	41	2026-03-16 13:00:08	2026-03-16 13:00:08
427	Color Options	Black	6	42	2026-03-16 13:45:28	2026-03-16 13:48:19
432	Brightness Levels	Adjustable from 1% to 100%	13	36	2026-03-16 14:21:39	2026-03-16 14:21:39
378	Dimensions	165 x 75 x 10 mm	4	38	2026-03-16 11:31:14	2026-03-16 11:31:14
398	Compatibility	Universal for all USB devices	17	34	2026-03-16 12:13:40	2026-03-16 12:13:40
401	Display	6.71 inches, HD+	0	40	2026-03-16 12:37:05	2026-03-16 12:37:05
411	Condition	Brand New	10	40	2026-03-16 12:37:06	2026-03-16 12:37:06
418	Installation	Easy bubble-free installation	6	41	2026-03-16 13:00:08	2026-03-16 13:00:08
435	Material	Durable plastic and metal	16	36	2026-03-16 14:21:39	2026-03-16 14:21:39
379	Protection Level	Shockproof and Scratch-resistant	5	38	2026-03-16 11:31:14	2026-03-16 11:31:14
390	Condition	New	8	39	2026-03-16 11:38:41	2026-03-16 11:38:41
397	Color	Black	16	34	2026-03-16 12:13:40	2026-03-16 12:13:40
402	Processor	MediaTek Helio G85	1	40	2026-03-16 12:37:05	2026-03-16 12:37:05
412	Material	Tempered Glass	0	41	2026-03-16 13:00:08	2026-03-16 13:00:08
422	Battery Life	Up to 65H ANC OFF	1	42	2026-03-16 13:45:28	2026-03-16 13:46:59
436	Weight	1.5 kg	17	36	2026-03-16 14:21:39	2026-03-16 14:21:39
380	Design	Slim and Lightweight	6	38	2026-03-16 11:31:14	2026-03-16 11:31:14
388	Dimensions	5 x 3 x 2 inches	6	39	2026-03-16 11:38:41	2026-03-16 11:38:41
395	Dimensions	150 x 75 x 20 mm	14	34	2026-03-16 12:13:40	2026-03-16 12:13:40
400	Charging Rate	22.5 W	19	34	2026-03-16 12:15:25	2026-03-16 12:16:01
407	OS	MIUI 13 based on Android 12	6	40	2026-03-16 12:37:06	2026-03-16 12:37:06
426	Charging Time	Approx 2HRS	5	42	2026-03-16 13:45:28	2026-03-16 13:49:10
437	Compatibility	Smartphones and cameras	18	36	2026-03-16 14:21:39	2026-03-16 14:21:39
381	Warranty	1 Year	7	38	2026-03-16 11:31:14	2026-03-16 11:31:14
387	Color	Black	5	39	2026-03-16 11:38:41	2026-03-16 11:38:41
394	Charging Speed	Fast Charging	13	34	2026-03-16 12:13:40	2026-03-16 12:13:40
410	Color	Graphite Gray, Ocean Blue, Mint Green	9	40	2026-03-16 12:37:06	2026-03-16 12:37:06
420	Condition	Brand New	8	41	2026-03-16 13:00:08	2026-03-16 13:00:08
421	Bluetooth Range	10 mtrs	0	42	2026-03-16 13:45:28	2026-03-16 13:48:04
429	Diameter	10 inches	10	36	2026-03-16 14:21:39	2026-03-16 14:21:39
382	Material	Durable Plastic	0	39	2026-03-16 11:38:41	2026-03-16 11:38:41
399	Condition	Brand New	18	34	2026-03-16 12:13:40	2026-03-16 12:13:40
403	RAM	8GB	2	40	2026-03-16 12:37:06	2026-03-16 12:37:06
419	Color	Clear	7	41	2026-03-16 13:00:08	2026-03-16 13:00:08
424	Water Resistance	IPX7	3	42	2026-03-16 13:45:28	2026-03-16 13:45:28
430	Color Temperature	3200K to 6500K	11	36	2026-03-16 14:21:39	2026-03-16 14:21:39
389	Weight	150 grams	7	39	2026-03-16 11:38:41	2026-03-16 11:38:41
393	Input Port	Micro USB	12	34	2026-03-16 12:13:40	2026-03-16 12:13:40
406	Camera	50MP + 2MP Dual Rear, 5MP Front	5	40	2026-03-16 12:37:06	2026-03-16 12:37:06
416	Coverage	Full-screen coverage	4	41	2026-03-16 13:00:08	2026-03-16 13:00:08
423	Connectivity	Bluetooth 5.0	2	42	2026-03-16 13:45:28	2026-03-16 13:45:28
431	RGB Modes	Multiple color options	12	36	2026-03-16 14:21:39	2026-03-16 14:21:39
439	Material	Aluminum	0	43	2026-03-16 16:22:11	2026-03-16 16:22:11
440	Height Range	Adjustable from 24 to 60 inches	1	43	2026-03-16 16:22:11	2026-03-16 16:22:11
441	Weight Capacity	Up to 5 kg	2	43	2026-03-16 16:22:11	2026-03-16 16:22:11
442	Folded Length	24 inches	3	43	2026-03-16 16:22:11	2026-03-16 16:22:11
443	Head Type	3-way pan head	4	43	2026-03-16 16:22:11	2026-03-16 16:22:11
444	Leg Lock Type	Flip locks	5	43	2026-03-16 16:22:11	2026-03-16 16:22:11
445	Color	Black	6	43	2026-03-16 16:22:11	2026-03-16 16:22:11
446	Weight	1.5 kg	7	43	2026-03-16 16:22:11	2026-03-16 16:22:11
447	Compatibility	Universal for cameras and smartphones	8	43	2026-03-16 16:22:11	2026-03-16 16:22:11
448	Condition	New	9	43	2026-03-16 16:22:11	2026-03-16 16:22:11
449	Type	Selfie Stick	0	44	2026-03-16 16:27:14	2026-03-16 16:27:14
450	Max Length	180 cm	1	44	2026-03-16 16:27:14	2026-03-16 16:27:14
451	Material	Aluminum Alloy	2	44	2026-03-16 16:27:14	2026-03-16 16:27:14
452	Weight	200 g	3	44	2026-03-16 16:27:14	2026-03-16 16:27:14
453	Compatibility	Universal Smartphone Compatibility	4	44	2026-03-16 16:27:14	2026-03-16 16:27:14
454	Color	Black	5	44	2026-03-16 16:27:14	2026-03-16 16:27:14
455	Folded Length	30 cm	6	44	2026-03-16 16:27:14	2026-03-16 16:27:14
456	Bluetooth Remote	Yes	7	44	2026-03-16 16:27:14	2026-03-16 16:27:14
457	Warranty	1 Year	8	44	2026-03-16 16:27:14	2026-03-16 16:27:14
458	Material	Aluminum Alloy	0	46	2026-03-16 16:47:19	2026-03-16 16:47:19
459	Max Height	160 cm	1	46	2026-03-16 16:47:19	2026-03-16 16:47:19
460	Min Height	50 cm	2	46	2026-03-16 16:47:19	2026-03-16 16:47:19
461	Weight	1.2 kg	3	46	2026-03-16 16:47:19	2026-03-16 16:47:19
462	Load Capacity	3 kg	4	46	2026-03-16 16:47:19	2026-03-16 16:47:19
463	Bluetooth Range	10 meters	5	46	2026-03-16 16:47:19	2026-03-16 16:47:19
464	Compatibility	Smartphones and Cameras	6	46	2026-03-16 16:47:19	2026-03-16 16:47:19
465	Color	Black	7	46	2026-03-16 16:47:19	2026-03-16 16:47:19
466	Condition	New	8	46	2026-03-16 16:47:19	2026-03-16 16:47:19
467	Folded Size	45 cm	9	46	2026-03-16 16:47:19	2026-03-16 16:47:19
468	Output Power	80W	0	47	2026-03-16 16:53:26	2026-03-16 16:53:26
469	Bluetooth Version	5.0	1	47	2026-03-16 16:53:26	2026-03-16 16:53:26
470	Battery Life	Up to 12 hours	2	47	2026-03-16 16:53:26	2026-03-16 16:53:26
471	Charging Time	4 hours	3	47	2026-03-16 16:53:26	2026-03-16 16:53:26
472	Water Resistance	IPX7	4	47	2026-03-16 16:53:26	2026-03-16 16:53:26
473	Dimensions	30 x 10 x 10 cm	5	47	2026-03-16 16:53:26	2026-03-16 16:53:26
474	Weight	1.5 kg	6	47	2026-03-16 16:53:26	2026-03-16 16:53:26
475	Connectivity	Bluetooth, AUX, USB	7	47	2026-03-16 16:53:26	2026-03-16 16:53:26
476	Color	Black	8	47	2026-03-16 16:53:26	2026-03-16 16:53:26
477	Condition	New	9	47	2026-03-16 16:53:26	2026-03-16 16:53:26
478	Audio Output	20W	0	48	2026-03-16 16:59:41	2026-03-16 16:59:41
479	Battery Life	Up to 12 hours	1	48	2026-03-16 16:59:41	2026-03-16 16:59:41
480	Connectivity	Bluetooth 5.0	2	48	2026-03-16 16:59:41	2026-03-16 16:59:41
481	Water Resistance	IPX7	3	48	2026-03-16 16:59:41	2026-03-16 16:59:41
482	Dimensions	220 x 100 x 100 mm	4	48	2026-03-16 16:59:41	2026-03-16 16:59:41
483	Weight	1.2 kg	5	48	2026-03-16 16:59:41	2026-03-16 16:59:41
484	Color	Black	6	48	2026-03-16 16:59:41	2026-03-16 16:59:41
485	Condition	Brand New	7	48	2026-03-16 16:59:41	2026-03-16 16:59:41
486	Microphone	Built-in	8	48	2026-03-16 16:59:41	2026-03-16 16:59:41
487	Charging Port	USB-C	9	48	2026-03-16 16:59:41	2026-03-16 16:59:41
488	Compatibility	All Bluetooth-enabled devices	10	48	2026-03-16 16:59:41	2026-03-16 16:59:41
489	Material	Aluminum and Plastic	0	49	2026-03-17 17:07:25	2026-03-17 17:07:25
490	Max Height	60 inches	1	49	2026-03-17 17:07:25	2026-03-17 17:07:25
491	Min Height	24 inches	2	49	2026-03-17 17:07:25	2026-03-17 17:07:25
492	Weight	1.5 kg	3	49	2026-03-17 17:07:25	2026-03-17 17:07:25
493	Load Capacity	3 kg	4	49	2026-03-17 17:07:25	2026-03-17 17:07:25
494	Head Type	Pan and Tilt	5	49	2026-03-17 17:07:25	2026-03-17 17:07:25
495	Compatibility	Smartphones and Cameras	6	49	2026-03-17 17:07:25	2026-03-17 17:07:25
496	Color	Black	7	49	2026-03-17 17:07:25	2026-03-17 17:07:25
497	Folded Length	24 inches	8	49	2026-03-17 17:07:25	2026-03-17 17:07:25
498	Condition	New	9	49	2026-03-17 17:07:25	2026-03-17 17:07:25
499	Display	Round 1.5-inch LCD	0	50	2026-03-17 17:11:54	2026-03-17 17:11:54
500	Battery Life	Up to 48 hours	1	50	2026-03-17 17:11:54	2026-03-17 17:11:54
501	Water Resistance	IP67 rated	2	50	2026-03-17 17:11:54	2026-03-17 17:11:54
502	Connectivity	Bluetooth 5.0	3	50	2026-03-17 17:11:54	2026-03-17 17:11:54
503	Compatibility	iOS and Android	4	50	2026-03-17 17:11:54	2026-03-17 17:11:54
504	Material	Stainless Steel	5	50	2026-03-17 17:11:54	2026-03-17 17:11:54
505	Color	Black and Silver	6	50	2026-03-17 17:11:54	2026-03-17 17:11:54
506	Weight	150 grams	7	50	2026-03-17 17:11:54	2026-03-17 17:11:54
507	Condition	New	8	50	2026-03-17 17:11:54	2026-03-17 17:11:54
508	Type	LED Panel Light	0	51	2026-03-17 17:18:41	2026-03-17 17:18:41
509	Diameter	16 inches	1	51	2026-03-17 17:18:41	2026-03-17 17:18:41
510	Wattage	24W	2	51	2026-03-17 17:18:41	2026-03-17 17:18:41
511	Lumen Output	2400 lumens	3	51	2026-03-17 17:18:41	2026-03-17 17:18:41
512	Color Temperature	3000K - 6000K	4	51	2026-03-17 17:18:41	2026-03-17 17:18:41
513	Material	Aluminum and Acrylic	5	51	2026-03-17 17:18:41	2026-03-17 17:18:41
514	Voltage	AC 220-240V	6	51	2026-03-17 17:18:41	2026-03-17 17:18:41
515	Lifespan	50,000 hours	7	51	2026-03-17 17:18:41	2026-03-17 17:18:41
516	Installation Type	Recessed or Surface Mount	8	51	2026-03-17 17:18:41	2026-03-17 17:18:41
517	Energy Rating	A+	9	51	2026-03-17 17:18:41	2026-03-17 17:18:41
518	Condition	New	10	51	2026-03-17 17:18:41	2026-03-17 17:18:41
519	Display	6.6 inches HD+	0	52	2026-03-19 11:12:06	2026-03-19 11:12:06
520	Processor	Octa-core 2.0 GHz	1	52	2026-03-19 11:12:06	2026-03-19 11:12:06
521	RAM	4GB	2	52	2026-03-19 11:12:06	2026-03-19 11:12:06
522	Storage	128GB (expandable via microSD)	3	52	2026-03-19 11:12:06	2026-03-19 11:12:06
523	Battery	5000 mAh	4	52	2026-03-19 11:12:06	2026-03-19 11:12:06
524	Camera	13MP rear, 8MP front	5	52	2026-03-19 11:12:06	2026-03-19 11:12:06
525	OS	Android 12	6	52	2026-03-19 11:12:06	2026-03-19 11:12:06
526	Connectivity	4G LTE, Wi-Fi, Bluetooth	7	52	2026-03-19 11:12:06	2026-03-19 11:12:06
527	Dimensions	164.5 x 76.2 x 8.5 mm	8	52	2026-03-19 11:12:06	2026-03-19 11:12:06
528	Color	Various options available	9	52	2026-03-19 11:12:06	2026-03-19 11:12:06
529	Condition	Brand New	10	52	2026-03-19 11:12:06	2026-03-19 11:12:06
530	Display	6.6 inches, HD+	0	53	2026-03-19 11:14:41	2026-03-19 11:14:41
531	Processor	MediaTek Helio G85	1	53	2026-03-19 11:14:41	2026-03-19 11:14:41
532	RAM	4GB	2	53	2026-03-19 11:14:41	2026-03-19 11:14:41
533	Storage	128GB, expandable via microSD	3	53	2026-03-19 11:14:41	2026-03-19 11:14:41
534	Battery	5000mAh	4	53	2026-03-19 11:14:41	2026-03-19 11:14:41
535	Camera (Rear)	50MP + 2MP dual camera	5	53	2026-03-19 11:14:41	2026-03-19 11:14:41
536	Camera (Front)	8MP	6	53	2026-03-19 11:14:41	2026-03-19 11:14:41
537	OS	Android 12	7	53	2026-03-19 11:14:41	2026-03-19 11:14:41
538	Connectivity	4G LTE, Wi-Fi, Bluetooth 5.0	8	53	2026-03-19 11:14:41	2026-03-19 11:14:41
539	Dimensions	164.5 x 76.5 x 8.8 mm	9	53	2026-03-19 11:14:41	2026-03-19 11:14:41
540	Color	Various options available	10	53	2026-03-19 11:14:41	2026-03-19 11:14:41
541	Condition	Brand New	11	53	2026-03-19 11:14:41	2026-03-19 11:14:41
542	Display	6.82 inches, HD+	0	54	2026-03-19 11:20:07	2026-03-19 11:20:07
543	Processor	MediaTek Helio G25	1	54	2026-03-19 11:20:07	2026-03-19 11:20:07
544	RAM	4GB	2	54	2026-03-19 11:20:07	2026-03-19 11:20:07
545	Storage	64GB, expandable via microSD	3	54	2026-03-19 11:20:07	2026-03-19 11:20:07
546	Battery	5000mAh	4	54	2026-03-19 11:20:07	2026-03-19 11:20:07
547	Camera (Rear)	13MP + 2MP Dual Camera	5	54	2026-03-19 11:20:07	2026-03-19 11:20:07
548	Camera (Front)	8MP	6	54	2026-03-19 11:20:07	2026-03-19 11:20:07
549	OS	Android 11	7	54	2026-03-19 11:20:07	2026-03-19 11:20:07
550	Connectivity	4G LTE, Wi-Fi, Bluetooth	8	54	2026-03-19 11:20:07	2026-03-19 11:20:07
551	Dimensions	171.8 x 77.3 x 8.8 mm	9	54	2026-03-19 11:20:07	2026-03-19 11:20:07
552	Color	Various options available	10	54	2026-03-19 11:20:07	2026-03-19 11:20:07
553	Condition	Ex-UK, refurbished	11	54	2026-03-19 11:20:07	2026-03-19 11:20:07
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, slug, price, original_price, rating, on_sale, sku, brand, in_stock, delivery_days, description, description_title, description_body, image_url, featured, "position", inserted_at, updated_at, stock_quantity, returnable, return_window_days, code, cost) FROM stdin;
14	Fold 6 Luxury Marble Case	fold-6-luxury-marble-case	3000.00	3500.00	5	t	PROD-001	\N	In Stock	1	Transform your Fold 6 with this exquisite luxury marble case, designed to blend elegance with protection. The striking marble pattern and gold accents not only enhance the phone's aesthetic but also provide robust defense against daily wear and tear. Crafted with precision, this case ensures a perfect fit, allowing easy access to all ports and buttons. Ideal for those in Kenya who appreciate both style and functionality, this case is a must-have accessory for your premium device.	Elevate Your Fold 6 with Luxurious Style	{}	/uploads/8SZwbqe_2Ss_1001196245.jpg	t	14	2026-03-07 10:07:49	2026-03-09 20:33:28	100	t	7	\N	1000.00
17	O-Lonnie Car MP3 Player SFC-18	o-lonnie-car-mp3-player-sfc-18	1200.00	1500.00	5	t	OLN-SFC18	O-Lonnie	In Stock	1	The O-Lonnie Car MP3 Player SFC-18 is your ultimate driving companion, offering seamless music playback and vibrant RGB ambient lighting. With its 3.1A PD charging capability, keep your devices powered up on the go. Enjoy a wide range of colors to match your mood or vehicle interior, making every journey more enjoyable. Perfect for those who love to combine style with functionality, this MP3 player is a must-have for Kenyan drivers seeking both entertainment and convenience on the road.	Transform Your Drive with RGB Lighting and Music	{}	/uploads/7_Up5GKEybc_1001993614.jpg	t	17	2026-03-09 08:01:30	2026-03-09 20:33:33	100	f	7	\N	500.00
21	Samsung Galaxy S24 Ultra 256GB	samsung-galaxy-s24-ultra-256gb	129999.00	132999.00	5	t	SAM-GS24U-256	Samsung	In Stock	1	The Samsung Galaxy S24 Ultra is a powerhouse smartphone designed for those who demand the best. With its stunning 256GB storage, you can store all your photos, videos, and apps without worry. The advanced camera system captures breathtaking images, making it perfect for capturing the vibrant life in Kenya. Plus, its sleek design and powerful performance ensure you stay connected and productive wherever you go.	Experience the Power of Samsung Galaxy S24 Ultra	{}	/uploads/1qYcGyhvt1A_s24_ultr.jpg	f	23	2026-03-09 20:50:15	2026-03-09 20:50:15	100	t	7	\N	118000.00
16	Awei T50 ENC Bluetooth Earbuds	Awei-t50-enc-bluetooth-earbuds	2500.00	3000.00	5	t	AWEI-T50-ENC	Awei	In Stock	1	The Awei T50 ENC Bluetooth Earbuds offer exceptional sound quality with advanced noise reduction technology, ensuring your calls are crystal clear even in noisy environments. Featuring a sleek design and smart touch controls, these earbuds provide a seamless and intuitive user experience. With long-lasting battery life, you can enjoy hours of uninterrupted music and calls. Perfect for tech-savvy individuals in Kenya, these earbuds combine style, functionality, and convenience, making them an ideal choice for everyday use.	Experience Crystal Clear Calls with Awei T50 ENC	{}	/uploads/8H1Yj3VEbeo_aweit50p2.webp	t	0	2026-03-09 07:56:17	2026-03-16 14:51:46	9	f	7	\N	1700.00
9	AWEI P139k power bank 	awei-p139k-power-bank	3500.00	4000.00	5	t	PROD-001	AWEI	In Stock	4	The AWEI P139K Power Bank is your perfect companion for on-the-go charging. With a high-capacity battery, it ensures your devices stay powered throughout the day, making it ideal for busy lifestyles in Kenya. Its sleek design and lightweight build make it easy to carry, while the dual USB ports allow you to charge multiple devices simultaneously. Don't let low battery anxiety hold you back; stay connected and powered up wherever you are.	Stay Powered Anywhere with AWEI P139K Power Bank	{}	/uploads/pFUdIO079MQ_r.jpg	t	0	2026-03-07 07:40:51	2026-03-14 08:48:41	100	f	7	\N	2000.00
18	Awei Outdoor Waterproof wireless Speaker 	awei-outdoor-waterproof-wireless-speaker	5499.00	5999.00	5	t	PROD-001	Awei	In Stock	1	The Awei Outdoor Waterproof Wireless Speaker is your perfect companion for outdoor adventures. With its robust waterproof design, you can enjoy your favorite tunes by the pool, at the beach, or during a hike without worrying about splashes or rain. Its powerful sound quality ensures that every beat resonates, making it ideal for gatherings or solo relaxation. Plus, its portable size means you can take it anywhere, ensuring your soundtrack is always with you.	Experience Music Anywhere with Awei's Waterproof Speaker	{}	/uploads/qr-51k98TF0_8c2026c760da4cf46af77a657d7b0529.jpg	f	18	2026-03-09 17:50:22	2026-03-10 16:31:56	100	f	7	\N	4400.00
10	Awei Power Bank with Built-in Cables	awei-power-bank-with-built-in-cables	2500.00	2799.00	5	t	AWEI-PB-001	Awei	In Stock	4	The Awei Power Bank is your perfect travel companion, featuring built-in cables for ultimate convenience. With its sleek design and robust build, this power bank ensures your devices stay charged on the go. Ideal for tech-savvy individuals in Kenya, it offers reliable power backup for smartphones and other gadgets. Experience the freedom of staying connected without the hassle of carrying extra cables.	Stay Charged Anywhere with Awei Power Bank	{}	/uploads/dERglzrh0EQ_cn-11134207-7r98o-lyk9hr6jwpeq68.jpg	t	0	2026-03-07 07:49:50	2026-03-14 08:53:56	100	t	7	P51k	1300.00
15	Oraimo Watch 5 lite | osw-804	oraimo-watch-5-lite-osw-804	2700.00	2999.00	5	t	ORA-OW5L-001	Oraimo	In Stock	1	The Oraimo Watch 5 Lite is your perfect fitness companion, blending style with functionality. With its sleek design and vibrant display, it not only tracks your health metrics but also elevates your fashion game. Enjoy features like heart rate monitoring, sleep tracking, and multiple sports modes to keep you motivated. In Kenya's active lifestyle, this smartwatch ensures you stay connected and informed without compromising on style.	Stay Fit and Stylish with Oraimo Watch 5 Lite	{}	/uploads/jFp99SCjSsI_241211145304_b01494ffb5db96f06f68df4656f.png	t	15	2026-03-09 07:48:48	2026-03-15 13:22:16	100	f	7	\N	1700.00
13	Oraimo Watch Muse osw-831N 1.32" AMOLED Smartwatch	1-32-amoled-smartwatch	5299.00	5799.00	5	t	PROD-001	\N	In Stock	1	Experience the perfect blend of style and functionality with our 1.32" AMOLED Smartwatch. Designed for the modern individual, this smartwatch offers a vibrant display that makes notifications and fitness tracking a breeze. With its sleek design, it complements any outfit, making it ideal for both workouts and casual outings. Enjoy features like heart rate monitoring and sleep tracking, ensuring you stay on top of your health while looking great.	Stay Connected with Our 1.32" AMOLED Smartwatch	{}	/uploads/_U6Zknq95so_oraimo-watch-muse-osw-831n-4.webp	t	0	2026-03-07 09:42:22	2026-03-16 06:25:35	100	t	7	\N	4300.00
12	SAMSUNG 45W PD Power Adapter	samsung-45w-pd-power-adapter	2799.00	2999.00	5	t	SAM-PD45W-001	Samsung	In Stock	1	Experience rapid charging with the Samsung 45W PD Power Adapter, designed to power up your devices quickly and efficiently. This adapter is perfect for your Samsung devices, ensuring you spend less time tethered to an outlet and more time enjoying your tech. With its compact design, it's easy to carry, making it an ideal companion for your travels around Kenya. Say goodbye to slow charging and hello to convenience with this powerful adapter.	Fast Charging Made Easy with Samsung 45W PD Adapter	{}	/uploads/w2iGPkTBilA_samsung-45w-pd.jpg	t	13	2026-03-07 09:32:59	2026-03-09 19:55:35	100	t	7	\N	800.00
20	Sam A07	sam-a07	14199.00	14999.00	5	t	SAM-SMA07	Samsung	In Stock	1	The Samsung A07 is designed to elevate your mobile experience with its impressive features and sleek design. With a vibrant display and powerful performance, this smartphone is perfect for browsing, streaming, and staying connected. Its long-lasting battery ensures you can enjoy all your favorite apps without interruption. Whether you're capturing memories with its quality camera or enjoying your favorite games, the A07 is a reliable companion for everyday life in Kenya.	Experience the Power of Samsung A07 Today!	{}	/uploads/l_diys_mNR8_a07s.jpg	t	21	2026-03-09 18:12:40	2026-03-09 20:20:43	100	t	7	\N	11700.00
11	Awei P20K 10000mAh Power Bank	awei-p20k-10000mah-power-bank	2500.00	3000.00	5	t	AWEI-P20K-10000	Awei	In Stock	4	The Awei P20K 10000mAh Power Bank is your perfect companion for staying powered on the go. With its dual USB output, you can charge multiple devices simultaneously, ensuring you never run out of battery. Its sleek and compact design makes it easy to carry, while the 2.4A fast charging capability ensures your devices are charged quickly and efficiently. Ideal for tech-savvy users in Kenya, this power bank offers reliability and convenience, keeping your devices ready whenever you need them.	Stay Charged Anywhere with Awei P20K Power Bank	{}	/uploads/xlY6K58KaTw_3-550x550_png.webp	t	0	2026-03-07 07:54:29	2026-03-09 21:24:01	99	t	7	P20k	1800.00
22	Awei Dual USB Car Charger	dual-usb-car-charger	999.00	1249.00	5	t	PROD-001	Jave	In Stock	4	Experience seamless charging on the road with the Jave Dual USB Car Charger. Designed for stability, this charger ensures your devices stay powered even on bumpy roads. Its enhanced anti-skid design provides a secure fit, making it perfect for long drives across Kenya's diverse landscapes. With dual USB ports, you can charge multiple devices simultaneously, ensuring you're always connected wherever your journey takes you.	Stay Powered on the Go with Dual USB Charger	{}	/uploads/ZnU6dn7F9h8_ylizdgdt1694359830-697x702.webp	f	24	2026-03-09 20:58:14	2026-03-09 20:58:14	100	f	7	\N	450.00
23	Tecno spark 40	tecno-spark-40	13999.00	14499.00	5	t	PROD-001	Tecno	In Stock	1	The Tecno Spark 40 is designed for the modern user who values both style and functionality. With its vibrant display and powerful camera, capturing life's moments has never been easier. Enjoy seamless multitasking with ample RAM and storage, making it perfect for both work and play. Its sleek design and affordable price make it an ideal choice for tech-savvy Kenyans looking for quality without breaking the bank.	Unleash Your Creativity with Tecno Spark 40	{}	/uploads/Qwcei7q6Vig_251106160120_1ccb8847c3df03b220022a78d6e.jpg	f	0	2026-03-09 21:10:44	2026-03-09 21:18:11	100	t	7	\N	12800.00
25	Collapsible telescopic bracket no.s313	collapsible-telescopic-bracket-nos313	350.00	400.00	5	t	PROD-001	\N	In Stock	4	Discover the ultimate convenience with the Collapsible Telescopic Bracket No.S313. This innovative bracket is designed to provide adjustable support for various devices, making it perfect for both home and office use. Its lightweight and portable design allows for easy transport, ensuring you can set it up wherever you go. Whether you're using it for presentations or as a phone holder, this bracket adapts to your needs effortlessly.	Versatile Collapsible Telescopic Bracket for All Needs	{}	/uploads/jnc__51_5XU_image.jpg	f	0	2026-03-10 16:36:30	2026-03-10 16:36:30	100	f	7	\N	200.00
28	O-Lonnie Mecha D3 Bluetooth Earphones	o-lonnie-mecha-d3-bluetooth-earphones	1199.00	1499.00	5	f	PROD-001	O-Lonnie	In Stock	1	The O-Lonnie Mecha D3 Bluetooth Earphones offer an unparalleled audio experience for music lovers on the go. With a sleek design and comfortable fit, these earphones are perfect for long listening sessions. Enjoy crystal-clear sound quality and deep bass, making them ideal for both casual listening and intense workouts. Plus, their long battery life ensures you stay connected throughout your busy day in Kenya.	Experience Wireless Freedom with O-Lonnie Mecha D3	{}	/uploads/Xl8nr3xemZQ_20250217125945_o_lonnie_mecha_d3_in_ear_.jpeg	f	28	2026-03-15 12:50:16	2026-03-15 12:50:16	100	t	7	\N	650.00
27	Soundcore u2i Flexible Bluetooth Neckband	flexible-bluetooth-neckband	2500.00	2999.00	5	t	PROD-001	\N	In Stock	1	Enjoy the perfect blend of comfort and sound with the Ultra-Flexible Bluetooth Neckband. Designed for those on the move, this neckband offers a snug fit that adapts to your lifestyle. With high-quality audio and a lightweight design, it's ideal for long listening sessions, whether you're commuting or working out. Experience seamless connectivity and impressive battery life, making it a must-have for music lovers in Kenya.	Experience Comfort and Flexibility in Sound	{}	/uploads/0AgbBNymXc8_anker-u2i-01.jpeg	f	27	2026-03-14 10:00:59	2026-03-15 13:09:01	100	f	7	\N	2000.00
26	Q18 Gimble Stabilizer 360 rotating desktop tripod 	q18-gimble-stabilizer-360-rotating-desktop-tripod	3800.00	4500.00	5	t	PROD-001	Q18	In Stock	4	The Q18 Gimbal Stabilizer is your perfect companion for capturing smooth and professional-looking videos. With its 360-degree rotation and sturdy desktop tripod design, you can easily achieve the perfect angle for your shots. Whether you're vlogging, streaming, or taking photos, this stabilizer ensures that your content is free from shaky footage. Ideal for content creators in Kenya looking to elevate their production quality.	Capture Steady Shots with Q18 Gimbal Stabilizer	{}	/uploads/PscLCADCTdc_s-l1600.jpg	t	0	2026-03-10 16:42:35	2026-03-15 13:19:24	100	t	7	\N	2200.00
29	Samsung Galaxy A36 5G	samsung-galaxy-a36-5g	38999.00	40999.00	5	t	SAM-GA36-5G	Samsung	In Stock	4	The Samsung Galaxy A36 5G is your gateway to seamless connectivity and powerful performance. Featuring a sleek design and vibrant display, this smartphone ensures you stay connected in style. Its advanced 5G capabilities mean faster downloads and smoother streaming, perfect for the tech-savvy user in Kenya. Enjoy the robust build quality and intuitive interface that Samsung is renowned for. Elevate your mobile experience with the Galaxy A36 5G.	Experience Next-Level Connectivity with Galaxy A36 5G	{}	/uploads/b7QxFJIh3Cs_ld0006236933.jpg	t	29	2026-03-15 14:52:51	2026-03-15 14:52:51	100	t	7	\N	35000.00
30	Amaya Wireless Earbuds	amaya-wireless-earbuds	1499.00	1699.00	5	t	AMY-WE-001	Amaya	In Stock	4	Discover the perfect blend of style and functionality with Amaya Wireless Earbuds. These sleek earbuds offer exceptional sound quality, allowing you to enjoy your favorite tunes with crystal-clear clarity. With a comfortable fit and long-lasting battery life, they're ideal for all-day wear, whether you're commuting or working out. Plus, the compact charging case ensures your earbuds are always ready to go, making them a must-have accessory for music lovers in Kenya.	Experience True Wireless Freedom with Amaya Earbuds	{}	/uploads/N14lM3MI5bs_miniso_20231003075159_1094_416_6821_6605.webp	t	30	2026-03-15 15:00:35	2026-03-15 15:03:56	100	t	7	\N	900.00
31	APPLE IPHONE USB-C Charger and Cable Set	apple-iphone-usb-c-charger-and-cable-set	3299.00	3499.00	5	t	APL-IPHUSBC-SET	Apple	In Stock	4	Experience rapid charging with the Apple USB-C Charger and Cable Set, designed for your iPhone. This premium accessory ensures your device powers up quickly and efficiently, making it perfect for busy lifestyles in Kenya. The durable cable provides reliable connectivity, while the compact charger is ideal for home or travel. Elevate your charging experience with this essential set that combines quality and convenience.	Fast Charging with Apple USB-C Charger and Cable	{}	/uploads/tuud2wfwRMY_1.jpg	t	31	2026-03-15 15:11:31	2026-03-15 15:11:31	100	f	7	\N	700.00
32	USB-C to Lightning Cable	usb-c-to-lightning-cable	699.00	799.00	5	t	APL-USBC-LC	Apple	In Stock	1	Experience rapid charging and data transfer with the USB-C to Lightning Cable. This premium cable is designed to work seamlessly with your Apple devices, ensuring you spend less time tethered to a wall outlet. Its durable construction means it can withstand daily wear and tear, making it perfect for on-the-go use in Kenya's bustling lifestyle. Enjoy the convenience of fast charging and reliable performance wherever you are.	Fast Charging with USB-C to Lightning Cable	{}	/uploads/eS-8eYQ9fNE_s-l1600.jpg	t	32	2026-03-15 15:17:19	2026-03-15 15:17:19	100	t	7	\N	200.00
35	Oraimo Traveler Link 20 Power Bank 20000mAh	oraimo-traveler-link-20-power-bank-20000mah	2500.00	2600.00	5	t	ORA-TRL20-20000	Oraimo	In Stock	4	The Oraimo Traveler Link 20 Power Bank is your ultimate solution for staying charged on the go. With an impressive 20000mAh capacity, this power bank ensures your devices are powered throughout the day, making it perfect for busy lifestyles in Kenya. Featuring 4 built-in charging and recharging cables, it offers unmatched convenience and versatility. The sleek design and durable build make it a reliable travel companion, while the AniFast technology ensures quick and efficient charging. Experience freedom from low battery anxiety with Oraimo's trusted quality.	Stay Powered Anywhere with 20000mAh Capacity	{}	/uploads/I6LSXsAm5FM_oraimo-traveler-2-20000-mah-powerbank.jpg	t	35	2026-03-16 06:57:31	2026-03-16 06:57:31	100	t	7	\N	1700.00
39	Car Phone holder	car-phone-holder	899.00	999.00	5	t	PROD-001	\N	In Stock	4	Keep your phone within reach and securely mounted with our Car Phone Holder. Designed for convenience, it allows for easy navigation and hands-free calls, ensuring you stay focused on the road. Its adjustable grip fits most smartphones, making it a versatile accessory for any driver. Enjoy a safer driving experience in Kenya's bustling traffic with this essential gadget.	Secure Your Phone While Driving	{}	/uploads/IlkZ1ldICIE_s-l1600.jpg	t	37	2026-03-16 11:38:41	2026-03-17 17:17:14	100	t	7	\N	350.00
33	25W PD Adapter USB-C	25w-pd-adapter-usb-c	799.00	999.00	5	t	SAM-25WPD-USB-C	Samsung	In Stock	1	Experience the convenience of rapid charging with the Samsung 25W PD Adapter. Designed to deliver efficient power, this adapter ensures your devices are charged quickly and safely. Its compact and sleek design makes it perfect for travel or everyday use. Compatible with a wide range of USB-C devices, it's an essential accessory for anyone looking to keep their gadgets powered up and ready to go. Enjoy the peace of mind that comes with Samsung's trusted quality and innovation.	Fast and Reliable Charging for Your Devices	{}	/uploads/GeeMD7LOjz4_samsung-usb-c-charger-25w.webp	t	24	2026-03-16 06:30:08	2026-03-16 08:10:59	100	t	7	\N	400.00
37	Xundo Case ipone 13promax	xundo-case-iphone-13promax	1799.00	1999.00	5	t	PROD-001	Xundo	In Stock	1	The Xundo Case for iPhone 13 Pro Max offers unparalleled protection without compromising style. Designed with durability in mind, this case shields your device from drops and scratches while maintaining a sleek profile. Its precise cutouts ensure easy access to all ports and buttons, making it a practical choice for everyday use. Enjoy peace of mind knowing your premium device is well-protected in the vibrant Kenyan lifestyle.	Ultimate Protection for Your iPhone 13 Pro Max	{}	/uploads/fzWOER8vCwU_2.jpg	t	0	2026-03-16 11:26:53	2026-03-16 11:26:53	100	f	7	\N	600.00
38	Samsung Galaxy S26 Ultra Protective Case	samsung-galaxy-s21-ultra-protective-case	1799.00	2299.00	5	t	SAM-S21U-CASE	Samsung	In Stock	4	Shield your Samsung Galaxy S21 Ultra with this robust protective case, designed to offer maximum defense against drops and scratches. The sleek, textured finish not only enhances grip but also adds a touch of elegance to your device. With precise cutouts, it ensures easy access to all ports and buttons, making it a perfect blend of style and functionality. Ideal for those in Kenya who value both protection and aesthetics, this case is a must-have accessory for your premium smartphone.	Ultimate Protection for Your Samsung Galaxy S21 Ultra	{}	/uploads/gaZvB_aDDV8_d0968ed9c2b80267430b40284dd52f35-600x600.png	t	36	2026-03-16 11:31:14	2026-03-16 11:31:14	100	t	7	\N	800.00
34	Oraimo Power Bank 20000mAh	oraimo-power-bank-20000mah	2499.00	2799.00	5	t	ORA-PB-20000	Oraimo	In Stock	4	Never run out of battery with the Oraimo Power Bank 20000mAh. Designed for the modern Kenyan lifestyle, this power bank offers ample capacity to charge your devices multiple times on the go. Its sleek design and dual USB ports make it a perfect companion for both travel and daily use. Enjoy the reliability and convenience of fast charging, ensuring your devices are always ready when you need them. Experience the freedom of staying connected without the worry of low battery.	Stay Powered Up with Oraimo's 20000mAh Power Bank	{}	/uploads/xCS9p35vhpc_oraimo-power-bank-powernova-qf1-opb-7270.webp	t	29	2026-03-16 06:46:53	2026-03-16 12:17:37	100	t	7	\N	1800.00
41	Tempered glass 21D 	tempered-glass-21d	399.00	499.00	5	t	PROD-001	\N	In Stock	1	Protect your device's screen with our premium 21D tempered glass. Designed to absorb shocks and resist scratches, this screen protector ensures your phone remains pristine. Its ultra-thin design maintains touch sensitivity while providing maximum coverage. Perfect for the Kenyan market, it offers durability and clarity, making it an essential accessory for your smartphone.	Ultimate Protection with 21D Tempered Glass	{}	/uploads/xdIX4CRUP9c_glass-full-glue-21d-iph-16-pro-max_2f17.webp	f	33	2026-03-16 13:00:08	2026-03-16 13:03:37	100	f	7	\N	100.00
36	Ring light 10 inch RGB	ring-light-10-inch-rgb	1499.00	2499.00	5	t	PROD-001	Unknown	In Stock	1	Enhance your photography and videography with our 10 inch RGB ring light. This versatile lighting solution offers adjustable brightness and a spectrum of colors to create the perfect ambiance for any setting. Ideal for makeup artists, content creators, and anyone looking to elevate their visuals, this ring light ensures you always look your best. Its compact size makes it easy to transport, perfect for on-the-go shoots in Thika and beyond.	Illuminate Your Creativity with 10 Inch RGB Ring Light	{}	/uploads/at_41a85yhg_674a4a294813c52a599082bf3145b3b8.jpg	t	35	2026-03-16 07:03:25	2026-03-16 16:49:34	30	t	7	\N	800.00
40	Redmi 15C Smartphone	redmi-15c-smartphone	19000.00	19499.00	5	t	XIA-REDMI15C	Xiaomi	In Stock	1	The Redmi 15C Smartphone by Xiaomi offers a perfect blend of style and functionality. Its sleek design and vibrant display make it a joy to use, whether you're browsing, streaming, or gaming. Powered by a robust processor, it ensures smooth multitasking and efficient performance. Ideal for tech-savvy users in Kenya, this smartphone promises reliability and innovation at your fingertips.	Experience Seamless Performance with Redmi 15C	{}	/uploads/JkSWzcxPPYk_6.jpg	t	39	2026-03-16 12:37:05	2026-03-19 17:55:16	0	f	7	\N	16400.00
43	L16 Aluminium Selfie Tripod Stand	selfie-stick-tripod-with-bluetooth-remote	1999.00	2399.00	5	t	PROD-001	\N	In Stock	1	This versatile selfie stick tripod is perfect for capturing stunning photos and videos with ease. Equipped with a Bluetooth remote, it allows you to take shots from a distance, making group photos and solo adventures a breeze. The sturdy tripod ensures your device stays stable, while the adjustable length offers flexibility for different angles. Ideal for content creators and travelers in Kenya, this gadget enhances your photography experience with convenience and style.	Capture Every Moment with Ease and Stability	{}	/uploads/twyZbXi7WG8_26980221c2e166be9f090fb25b857dba_png_720.png	t	41	2026-03-16 16:22:11	2026-03-16 16:49:59	30	f	7	\N	1200.00
42	Oraimo Boom Pop N | OHP-915N	oraimo-boom-pop-n-ohp-915n	3799.00	3999.00	5	f	ORA-OHP915N	Oraimo	In Stock	1	The Oraimo Boom Pop N is your ultimate portable speaker, designed to deliver an immersive audio experience. With its compact design, you can easily take it anywhere, making it perfect for outdoor adventures or cozy indoor gatherings. Enjoy rich bass and clear sound quality that will elevate your music listening experience. Plus, its long battery life ensures that the party keeps going without interruptions.	Experience Powerful Sound with Oraimo Boom Pop N	{}	/uploads/KUtMLDG70wk_oraimo-wireless-headphones-boompop-n-ohp.webp	t	41	2026-03-16 13:45:28	2026-03-16 13:52:30	3	f	7	\N	3000.00
44	P 180 max selfie stick	p-180-max-selfie-stick	1499.00	1699.00	5	t	PROD-001	\N	In Stock	1	The P 180 Max Selfie Stick is your ultimate companion for capturing perfect selfies and group photos. Its extendable design allows you to reach impressive angles, ensuring everyone fits in the frame. Made with durable materials, this selfie stick is lightweight and easy to carry, making it ideal for adventures around Kenya. Whether you're at the beach or exploring the savannah, the P 180 Max will help you create unforgettable memories.	Capture Stunning Selfies with P 180 Max Selfie Stick	{}	\N	f	0	2026-03-16 16:27:14	2026-03-16 16:27:14	0	f	7	\N	600.00
46	C17 AI-Powered Selfie Stick Tripod	ai-powered-selfie-stick-tripod	3699.00	3999.00	5	f	PROD-001	\N	In Stock	4	Elevate your selfie game with this AI-powered selfie stick tripod, designed for those who love capturing every moment. Its intelligent features ensure you get the perfect shot every time, while the extendable design offers flexibility and convenience. Built with durable materials, it promises longevity and stability, making it ideal for both casual and professional use. Perfect for tech-savvy individuals in Kenya who want to enhance their photography experience.	Capture Perfect Selfies with AI Precision	{}	/uploads/RLGCP-keahI_shopping.webp	t	0	2026-03-16 16:47:19	2026-03-16 16:47:19	3	f	7	\N	2300.00
48	Oraimo Speaker-Spacebox-Pro-OBS-682	oraimo-speaker-spacebox-pro-obs-682	10799.00	10999.00	5	t	ORA-OBS682	Oraimo	In Stock	1	Experience music like never before with the Oraimo Spacebox Pro speaker. Designed for the modern music lover, this portable speaker delivers rich, high-quality sound that fills any space. Its sleek design and robust build make it perfect for outdoor adventures or cozy indoor gatherings. With long battery life and easy connectivity options, you can enjoy your favorite tunes wherever you go in Kenya.	Unleash Powerful Sound with Oraimo Spacebox Pro	{}	/uploads/2lQHsdznB7k_speaker-spacebox-pro-obs-682-3-80w.webp	t	42	2026-03-16 16:59:41	2026-03-16 17:04:37	3	f	7	\N	8000.00
50	O-LONNIE ROUND N13	o-lonnie-round-n13	999.00	1299.00	5	f	PROD-001	O-LONNIE	In Stock	4	The O-LONNIE Round N13 is the perfect accessory to elevate your style. With its sleek design and versatile functionality, this round watch is ideal for both casual and formal settings. Its durable build ensures it withstands daily wear while keeping you on time and in style. Experience the blend of elegance and practicality that makes the O-LONNIE Round N13 a must-have in your collection.	Stylish O-LONNIE Round N13 for Every Occasion	{}	/uploads/-5LFqMRgAlM_sg-11134201-7reqa-m1wfmwdcx6wv00.jpg	t	44	2026-03-17 17:11:54	2026-03-17 17:11:54	0	f	7	\N	650.00
47	ORAIMO SPACEBOXPRO 80W BT SPEAKER	oraimo-spaceboxpro-80w-bt-speaker	11499.00	10999.00	5	t	ORA-SPBXPRO-80W	Oraimo	In Stock	4	Experience music like never before with the Oraimo SpaceboxPro 80W Bluetooth Speaker. This powerful speaker delivers crystal-clear sound and deep bass, making it perfect for parties or outdoor adventures. With its sleek design and portable build, you can take your music anywhere in Kenya. Enjoy up to 12 hours of playtime on a single charge, ensuring your soundtrack never stops.	Unleash Powerful Sound with Oraimo SpaceboxPro	{}	/uploads/MoYhz-zfTXE_1.jpg	f	0	2026-03-16 16:53:26	2026-03-16 17:42:37	3	f	7	\N	8000.00
49	Negoglass tripod stand	negoglass-tripod-stand	3499.00	3699.00	5	f	PROD-001	\N	In Stock	4	Capture stunning photos and videos with the Negoglass Tripod Stand, designed for stability and versatility. Its adjustable height and 360-degree rotation allow you to find the perfect angle for every shot. Whether you're a professional photographer or a casual user, this tripod is perfect for your smartphone or camera. Lightweight and portable, it’s ideal for outdoor adventures or indoor shoots.	Sturdy Negoglass Tripod Stand for Perfect Shots	{}	/uploads/ugCABWc9fvA_untitled.jpg	t	43	2026-03-17 17:07:25	2026-03-17 17:07:25	0	f	7	\N	1800.00
51	LJJ 16 INCH PLANEL LIGHT	ljj-16-inch-panel-light	2999.00	3499.00	5	t	PROD-001	\N	In Stock	4	Transform your home or office with the LJJ 16 Inch Panel Light, designed for efficiency and style. This sleek lighting solution offers bright, even illumination, perfect for any room. With its modern design, it seamlessly blends into your decor while providing energy-saving benefits. Ideal for Kenyan homes, this panel light enhances visibility and creates a warm atmosphere for gatherings or work.	Illuminate Your Space with LJJ 16 Inch Panel Light	{}	\N	f	0	2026-03-17 17:18:41	2026-03-17 17:18:41	0	t	7	\N	1600.00
52	Tecno pop 20 128gb	tecno-pop-20-128gb	14999.00	15499.00	5	t	TEC-POP20-128	Tecno	In Stock	4	The Tecno Pop 20 is designed for those who love to capture life's moments. With a generous 128GB storage, you can store countless photos, videos, and apps without worrying about space. Its vibrant display and powerful battery ensure that you enjoy every moment without interruptions. Perfect for the Kenyan lifestyle, this device combines style and functionality, making it a great choice for students and professionals alike.	Unleash Your Creativity with Tecno Pop 20!	{}	/uploads/YiH9chq1Eag_screenshot-2026-01-23-at-10-24-39-tecno-.jpg	f	45	2026-03-19 11:12:06	2026-03-19 11:12:06	0	f	7	\N	13000.00
53	Infinix Hot 60I 128GB	infinix-hot-60i-128gb	15999.00	16999.00	5	t	PROD-001	Infinix	In Stock	1	The Infinix Hot 60I is designed for those who crave performance without breaking the bank. With a generous 128GB storage, you can store all your favorite apps, photos, and videos effortlessly. Its sleek design and vibrant display make it a joy to use, whether you're streaming your favorite shows or browsing social media. Perfect for the Kenyan market, this device offers exceptional value, ensuring you stay connected and entertained.	Experience Power and Performance with Infinix Hot 60I	{}	\N	t	46	2026-03-19 11:14:41	2026-03-19 11:14:41	0	f	7	\N	13000.00
54	INFINIX SMART 10 4GB+64GB	infinix-smart-10-4gb-64gb	11999.00	12499.00	5	t	PROD-001	Infinix	In Stock	1	The Infinix Smart 10 is designed for those who crave speed and efficiency. With 4GB of RAM and 64GB of storage, multitasking becomes a breeze, allowing you to switch between apps without any lag. Its vibrant display brings your favorite content to life, making it perfect for streaming and gaming. Plus, with a long-lasting battery, you can stay connected throughout your busy day in Kenya's dynamic environment.	Experience Seamless Performance with Infinix Smart 10	{}	\N	f	47	2026-03-19 11:20:07	2026-03-19 11:20:07	0	f	7	\N	9200.00
\.


--
-- Data for Name: products_collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products_collections (product_id, collection_id) FROM stdin;
10	3
11	3
12	3
13	3
14	3
15	3
16	3
17	3
18	4
20	2
21	2
22	7
23	8
25	3
26	3
27	4
28	3
29	2
30	3
31	6
32	6
34	9
9	9
35	9
10	9
36	3
36	13
33	6
37	11
38	11
39	3
39	7
40	2
41	3
42	12
43	14
44	14
46	14
47	4
48	4
49	14
50	12
51	13
52	2
53	2
54	2
\.


--
-- Data for Name: returns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.returns (id, order_id, product_id, customer_name, customer_email, reason, notes, status, resolution, refund_amount, inserted_at, updated_at, store_id, logged_by_admin) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, name, rating, body, headline, role, product_name, avatar_url, product_image_url, featured, visible, context, inserted_at, updated_at) FROM stdin;
1	Brian Kamau	5	Got an iPhone 14 from Oasis Technologies. The phone is genuinely in A condition — no scratches, battery is at 91% and it's unlocked perfectly. Staff were transparent about everything. This is how every phone shop should operate.	Best Ex-UK iPhone deal in Thika	Verified Buyer	iPhone 14 128GB (Ex-UK)	https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80	https://images.pexels.com/photos/788946/pexels-photo-788946.jpeg?auto=compress&cs=tinysrgb&w=120	t	t	home	2026-03-07 06:42:43	2026-03-07 06:42:43
2	Cynthia Wambui	5	My iPhone 12 screen shattered badly. Walked into Oasis Technologies in the morning — they showed me the genuine part, gave me a price immediately and fixed it in under 2 hours. 30-day warranty too. Can't fault them.	Screen replaced, good as new	Verified Customer	iPhone Screen Replacement (Genuine)	https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80	https://images.pexels.com/photos/6755053/pexels-photo-6755053.jpeg?auto=compress&cs=tinysrgb&w=120	t	t	home	2026-03-07 06:42:43	2026-03-07 06:42:43
3	Kevin Odhiambo	5	Bought the Ex-UK Samsung S22 Ultra. The S Pen works perfectly, cameras are stunning and the screen has zero marks. At KES 52,000 for what is still a flagship-tier phone, it's genuinely the best deal I've found in Kenya.	Samsung S22 Ultra — unreal value	Verified Buyer	Samsung Galaxy S22 Ultra 256GB (Ex-UK)	https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&q=80	https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?auto=format&fit=crop&w=120&q=80	f	t	home	2026-03-07 06:42:43	2026-03-07 06:42:43
4	Grace Muthoni	5	I've bought three phones from Oasis Technologies over two years — two Ex-UK iPhones and one Samsung. Every single time, the team listened to my budget and needs honestly. They never pushed me to overspend. That kind of integrity is rare.	They actually care about customers	Loyal Customer	\N	https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=150&q=80	\N	t	t	about	2026-03-07 06:42:43	2026-03-07 06:42:43
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales (id, product_id, order_id, quantity, unit_price, total_price, notes, inserted_at, updated_at, store_id, payment_method, payment_status) FROM stdin;
1	\N	1	1	32000.00	32000.00	\N	2026-03-07 07:23:45	2026-03-07 07:23:45	1	cash	paid
2	11	2	1	2500.00	2500.00	\N	2026-03-14 09:03:36	2026-03-14 09:03:36	1	cash	paid
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, inserted_at) FROM stdin;
20260227113045	2026-03-07 06:42:41
20260227113046	2026-03-07 06:42:41
20260227113048	2026-03-07 06:42:41
20260227113050	2026-03-07 06:42:41
20260227113100	2026-03-07 06:42:41
20260227113102	2026-03-07 06:42:41
20260227113103	2026-03-07 06:42:41
20260227113104	2026-03-07 06:42:41
20260227113105	2026-03-07 06:42:41
20260227113107	2026-03-07 06:42:41
20260227113109	2026-03-07 06:42:41
20260227113110	2026-03-07 06:42:41
20260227113112	2026-03-07 06:42:41
20260227113113	2026-03-07 06:42:41
20260227113120	2026-03-07 06:42:41
20260227113121	2026-03-07 06:42:41
20260301120455	2026-03-07 06:42:41
20260301121517	2026-03-07 06:42:41
20260301121518	2026-03-07 06:42:41
20260301121519	2026-03-07 06:42:41
20260301122950	2026-03-07 06:42:41
20260301131136	2026-03-07 06:42:41
20260302100001	2026-03-07 06:42:41
20260302100002	2026-03-07 06:42:41
20260303145129	2026-03-07 06:42:41
20260303150001	2026-03-07 06:42:41
20260303160001	2026-03-07 06:42:41
20260303160002	2026-03-07 06:42:41
20260303160003	2026-03-07 06:42:41
20260303160004	2026-03-07 06:42:41
20260303170001	2026-03-07 06:42:42
20260303180001	2026-03-07 06:42:42
20260303190001	2026-03-07 06:42:42
20260303200001	2026-03-07 06:42:42
20260303210001	2026-03-07 06:42:42
20260303220001	2026-03-07 06:42:42
20260303230001	2026-03-07 06:42:42
20260303240001	2026-03-07 06:42:42
20260303250001	2026-03-07 06:42:42
20260308000001	2026-03-10 16:32:58
\.


--
-- Data for Name: service_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_jobs (id, reference, customer_name, customer_phone, device, fault, title, notes, amount, parts_cost, status, technician, date_in, date_out, store_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.site_settings (id, brand, tagline, phone, email, address, city, newsletter_text, copyright_text, facebook_url, twitter_url, instagram_url, tiktok_url, inserted_at, updated_at, mission_image_url, before_image_url, after_image_url, about_hero_main_image_url, about_hero_secondary_image_url, about_mission_image_url, skills_image_1_url, skills_image_2_url, skills_image_3_url, online_sales_enabled, whatsapp_number) FROM stdin;
1	Oasis Technologies	Elevate your style, protect with might. Thika's world-class tech hub specialising in premium Ex-UK iPhones, Samsung devices, essential accessories and genuine screen repairs.	+254724303826	info@oasistechnologies.co.ke	Mama Ngina Jeff K Centre, Ground Floor, Shop No. 20	Thika, Kenya	Join our mailing list & be first to get exclusive deals .	© 2026 Oasis Technologies. All rights reserved.	https://facebook.com/oasistechnologies	https://twitter.com/oasis_tech	https://www.instagram.com/oasis_.technologies/	https://tiktok.com/@oasis_.technologies	2026-03-07 06:42:43	2026-03-09 21:33:24	https://images.pexels.com/photos/788946/pexels-photo-788946.jpeg?auto=compress&cs=tinysrgb&w=1200	https://images.pexels.com/photos/1476316/pexels-photo-1476316.jpeg?auto=compress&cs=tinysrgb&w=800	https://images.pexels.com/photos/3586249/pexels-photo-3586249.jpeg?auto=compress&cs=tinysrgb&w=800	https://images.pexels.com/photos/3945698/pexels-photo-3945698.jpeg?auto=compress&cs=tinysrgb&w=900	https://images.pexels.com/photos/788946/pexels-photo-788946.jpeg?auto=compress&cs=tinysrgb&w=600	https://images.pexels.com/photos/6755092/pexels-photo-6755092.jpeg?auto=compress&cs=tinysrgb&w=900	https://images.pexels.com/photos/788946/pexels-photo-788946.jpeg?auto=compress&cs=tinysrgb&w=400	https://images.pexels.com/photos/47261/pexels-photo-47261.jpeg?auto=compress&cs=tinysrgb&w=400	https://images.pexels.com/photos/6755053/pexels-photo-6755053.jpeg?auto=compress&cs=tinysrgb&w=400	t	+254724303826
\.


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skills (id, label, percent, "position", visible, inserted_at, updated_at) FROM stdin;
1	Speed & Reliability	97	1	t	2026-03-07 06:42:43	2026-03-07 06:42:43
2	Technical Excellence (Repairs)	96	2	t	2026-03-07 06:42:43	2026-03-07 06:42:43
3	Customer-Centric Service	99	3	t	2026-03-07 06:42:43	2026-03-07 06:42:43
4	Premium Device Sourcing	95	4	t	2026-03-07 06:42:43	2026-03-07 06:42:43
5	Value & Integrity	98	5	t	2026-03-07 06:42:43	2026-03-07 06:42:43
\.


--
-- Data for Name: stock_movements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_movements (id, store_id, product_id, quantity_change, type, notes, cost_per_unit, reference, inserted_at) FROM stdin;
\.


--
-- Data for Name: store_stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_stock (id, store_id, product_id, quantity, oversold, inserted_at, updated_at) FROM stdin;
83	1	31	0	f	2026-03-15 15:11:31	2026-03-15 15:11:31
17	1	9	0	f	2026-03-07 07:40:51	2026-03-07 07:40:51
18	2	9	0	f	2026-03-07 07:40:51	2026-03-07 07:40:51
19	3	9	0	f	2026-03-07 07:40:51	2026-03-07 07:40:51
20	1	10	10	f	2026-03-07 07:49:50	2026-03-07 07:49:50
21	2	10	5	f	2026-03-07 07:49:50	2026-03-07 07:49:50
22	3	10	5	f	2026-03-07 07:49:50	2026-03-07 07:49:50
24	2	11	0	f	2026-03-07 07:54:29	2026-03-07 07:54:29
25	3	11	0	f	2026-03-07 07:54:29	2026-03-07 07:54:29
26	1	12	10	f	2026-03-07 09:32:59	2026-03-07 09:32:59
27	2	12	10	f	2026-03-07 09:32:59	2026-03-07 09:32:59
28	3	12	10	f	2026-03-07 09:32:59	2026-03-07 09:32:59
29	1	13	0	f	2026-03-07 09:42:22	2026-03-07 09:42:22
30	2	13	0	f	2026-03-07 09:42:22	2026-03-07 09:42:22
31	3	13	0	f	2026-03-07 09:42:22	2026-03-07 09:42:22
32	1	14	0	f	2026-03-07 10:07:49	2026-03-07 10:07:49
33	2	14	0	f	2026-03-07 10:07:49	2026-03-07 10:07:49
34	3	14	0	f	2026-03-07 10:07:49	2026-03-07 10:07:49
35	1	15	0	f	2026-03-09 07:48:48	2026-03-09 07:48:48
36	2	15	0	f	2026-03-09 07:48:48	2026-03-09 07:48:48
37	3	15	0	f	2026-03-09 07:48:48	2026-03-09 07:48:48
41	1	17	0	f	2026-03-09 08:01:30	2026-03-09 08:01:30
42	2	17	0	f	2026-03-09 08:01:30	2026-03-09 08:01:30
43	3	17	0	f	2026-03-09 08:01:30	2026-03-09 08:01:30
44	1	18	1	f	2026-03-09 17:50:22	2026-03-09 17:50:22
45	2	18	0	f	2026-03-09 17:50:22	2026-03-09 17:50:22
46	3	18	0	f	2026-03-09 17:50:22	2026-03-09 17:50:22
50	1	20	2	f	2026-03-09 18:12:40	2026-03-09 20:20:43
51	2	20	1	f	2026-03-09 18:12:40	2026-03-09 20:20:43
52	3	20	1	f	2026-03-09 18:12:40	2026-03-09 20:20:43
53	1	21	1	f	2026-03-09 20:50:15	2026-03-09 20:50:15
54	2	21	1	f	2026-03-09 20:50:15	2026-03-09 20:50:15
55	3	21	0	f	2026-03-09 20:50:15	2026-03-09 20:50:15
56	1	22	0	f	2026-03-09 20:58:14	2026-03-09 20:58:14
57	2	22	0	f	2026-03-09 20:58:14	2026-03-09 20:58:14
58	3	22	0	f	2026-03-09 20:58:14	2026-03-09 20:58:14
59	1	23	0	f	2026-03-09 21:10:44	2026-03-09 21:10:44
60	2	23	0	f	2026-03-09 21:10:44	2026-03-09 21:10:44
61	3	23	0	f	2026-03-09 21:10:44	2026-03-09 21:10:44
65	1	25	0	f	2026-03-10 16:36:30	2026-03-10 16:36:30
66	2	25	0	f	2026-03-10 16:36:30	2026-03-10 16:36:30
67	3	25	0	f	2026-03-10 16:36:30	2026-03-10 16:36:30
23	1	11	0	t	2026-03-07 07:54:29	2026-03-14 09:03:36
84	2	31	0	f	2026-03-15 15:11:31	2026-03-15 15:11:31
85	3	31	0	f	2026-03-15 15:11:31	2026-03-15 15:11:31
71	1	27	0	f	2026-03-14 10:00:59	2026-03-14 10:00:59
72	2	27	0	f	2026-03-14 10:00:59	2026-03-14 10:00:59
73	3	27	0	f	2026-03-14 10:00:59	2026-03-14 10:00:59
38	1	16	3	f	2026-03-09 07:56:17	2026-03-15 12:42:50
39	2	16	4	f	2026-03-09 07:56:17	2026-03-15 12:42:50
40	3	16	2	f	2026-03-09 07:56:17	2026-03-15 12:42:50
74	1	28	0	f	2026-03-15 12:50:16	2026-03-15 12:50:16
75	2	28	0	f	2026-03-15 12:50:16	2026-03-15 12:50:16
76	3	28	0	f	2026-03-15 12:50:16	2026-03-15 12:50:16
68	1	26	2	f	2026-03-10 16:42:35	2026-03-15 13:20:01
69	2	26	2	f	2026-03-10 16:42:35	2026-03-15 13:20:01
70	3	26	3	f	2026-03-10 16:42:35	2026-03-15 13:20:01
78	2	29	0	f	2026-03-15 14:52:51	2026-03-15 14:52:51
77	1	29	1	f	2026-03-15 14:52:51	2026-03-15 14:53:34
79	3	29	1	f	2026-03-15 14:52:51	2026-03-15 14:53:34
80	1	30	0	f	2026-03-15 15:00:35	2026-03-15 15:00:35
81	2	30	0	f	2026-03-15 15:00:35	2026-03-15 15:00:35
82	3	30	0	f	2026-03-15 15:00:35	2026-03-15 15:00:35
86	1	32	0	f	2026-03-15 15:17:19	2026-03-15 15:17:19
87	2	32	0	f	2026-03-15 15:17:19	2026-03-15 15:17:19
88	3	32	0	f	2026-03-15 15:17:19	2026-03-15 15:17:19
89	1	33	0	f	2026-03-16 06:30:08	2026-03-16 06:30:08
90	2	33	0	f	2026-03-16 06:30:08	2026-03-16 06:30:08
91	3	33	0	f	2026-03-16 06:30:08	2026-03-16 06:30:08
92	1	34	0	f	2026-03-16 06:46:53	2026-03-16 06:46:53
93	2	34	0	f	2026-03-16 06:46:53	2026-03-16 06:46:53
94	3	34	0	f	2026-03-16 06:46:53	2026-03-16 06:46:53
95	1	35	0	f	2026-03-16 06:57:31	2026-03-16 06:57:31
96	2	35	0	f	2026-03-16 06:57:31	2026-03-16 06:57:31
97	3	35	0	f	2026-03-16 06:57:31	2026-03-16 06:57:31
101	1	37	0	f	2026-03-16 11:26:53	2026-03-16 11:26:53
102	2	37	0	f	2026-03-16 11:26:53	2026-03-16 11:26:53
103	3	37	0	f	2026-03-16 11:26:53	2026-03-16 11:26:53
104	1	38	0	f	2026-03-16 11:31:14	2026-03-16 11:31:14
105	2	38	0	f	2026-03-16 11:31:14	2026-03-16 11:31:14
106	3	38	0	f	2026-03-16 11:31:14	2026-03-16 11:31:14
107	1	39	0	f	2026-03-16 11:38:41	2026-03-16 11:38:41
108	2	39	0	f	2026-03-16 11:38:41	2026-03-16 11:38:41
109	3	39	0	f	2026-03-16 11:38:41	2026-03-16 11:38:41
110	1	40	0	f	2026-03-16 12:37:05	2026-03-16 12:37:05
111	2	40	0	f	2026-03-16 12:37:05	2026-03-16 12:37:05
112	3	40	0	f	2026-03-16 12:37:05	2026-03-16 12:37:05
113	1	41	10	f	2026-03-16 13:00:08	2026-03-16 13:03:37
114	2	41	10	f	2026-03-16 13:00:08	2026-03-16 13:03:37
115	3	41	10	f	2026-03-16 13:00:08	2026-03-16 13:03:37
116	1	42	1	f	2026-03-16 13:45:28	2026-03-16 13:52:30
117	2	42	1	f	2026-03-16 13:45:28	2026-03-16 13:52:30
118	3	42	1	f	2026-03-16 13:45:28	2026-03-16 13:52:30
122	1	44	0	f	2026-03-16 16:27:14	2026-03-16 16:27:14
123	2	44	0	f	2026-03-16 16:27:14	2026-03-16 16:27:14
124	3	44	0	f	2026-03-16 16:27:14	2026-03-16 16:27:14
125	1	46	1	f	2026-03-16 16:47:19	2026-03-16 16:47:19
126	2	46	1	f	2026-03-16 16:47:19	2026-03-16 16:47:19
127	3	46	1	f	2026-03-16 16:47:19	2026-03-16 16:47:19
99	2	36	10	f	2026-03-16 07:03:25	2026-03-16 16:49:34
100	3	36	10	f	2026-03-16 07:03:25	2026-03-16 16:49:34
119	1	43	10	f	2026-03-16 16:22:11	2026-03-16 16:49:59
120	2	43	10	f	2026-03-16 16:22:11	2026-03-16 16:49:59
121	3	43	10	f	2026-03-16 16:22:11	2026-03-16 16:49:59
128	1	47	1	f	2026-03-16 16:53:26	2026-03-16 16:53:26
98	1	36	10	f	2026-03-16 07:03:25	2026-03-16 16:49:34
134	1	49	0	f	2026-03-17 17:07:25	2026-03-17 17:07:25
138	2	50	0	f	2026-03-17 17:11:54	2026-03-17 17:11:54
141	2	51	0	f	2026-03-17 17:18:41	2026-03-17 17:18:41
144	2	52	0	f	2026-03-19 11:12:06	2026-03-19 11:12:06
151	3	54	0	f	2026-03-19 11:20:07	2026-03-19 11:20:07
129	2	47	1	f	2026-03-16 16:53:26	2026-03-16 16:53:26
136	3	49	0	f	2026-03-17 17:07:25	2026-03-17 17:07:25
147	2	53	0	f	2026-03-19 11:14:41	2026-03-19 11:14:41
150	2	54	0	f	2026-03-19 11:20:07	2026-03-19 11:20:07
130	3	47	1	f	2026-03-16 16:53:26	2026-03-16 16:53:26
131	1	48	1	f	2026-03-16 16:59:41	2026-03-16 17:04:37
132	2	48	1	f	2026-03-16 16:59:41	2026-03-16 17:04:37
133	3	48	1	f	2026-03-16 16:59:41	2026-03-16 17:04:37
139	3	50	0	f	2026-03-17 17:11:54	2026-03-17 17:11:54
145	3	52	0	f	2026-03-19 11:12:06	2026-03-19 11:12:06
135	2	49	0	f	2026-03-17 17:07:25	2026-03-17 17:07:25
137	1	50	0	f	2026-03-17 17:11:54	2026-03-17 17:11:54
140	1	51	0	f	2026-03-17 17:18:41	2026-03-17 17:18:41
146	1	53	0	f	2026-03-19 11:14:41	2026-03-19 11:14:41
142	3	51	0	f	2026-03-17 17:18:41	2026-03-17 17:18:41
149	1	54	0	f	2026-03-19 11:20:07	2026-03-19 11:20:07
143	1	52	0	f	2026-03-19 11:12:06	2026-03-19 11:12:06
148	3	53	0	f	2026-03-19 11:14:41	2026-03-19 11:14:41
\.


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stores (id, name, type, location, description, phone, active, inserted_at, updated_at, protected, location_id) FROM stdin;
1	Online Store	online	\N	Default store for all ecommerce / website orders.	\N	t	2026-03-07 06:42:43	2026-03-07 06:42:43	t	\N
2	Oasis Technologies - Jeff K Centre	physical	Mama Ngina Jeff K Centre, Ground Floor, Shop No. 20, Thika Town	Our flagship physical store in Thika Town. Walk in for Ex-UK phones, accessories, screen repairs and instant support.	+254 7112111440	t	2026-03-07 06:42:43	2026-03-07 07:14:26	f	1
3	Oasis Technologies - Skatters Thika	physical	Shop 7 	\N	+254715676167	t	2026-03-07 07:15:16	2026-03-07 07:15:16	f	2
\.


--
-- Data for Name: team_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_members (id, name, role, image_url, featured, "position", visible, inserted_at, updated_at) FROM stdin;
2	Ajak Bol	Shop Technician	/uploads/l9QY8a7_WLQ_unnamed.jpg	f	2	t	2026-03-07 06:42:43	2026-03-07 06:59:21
5	Eddie 	Shop Technician	/uploads/9GpJl6i9k-4_img_7045_jpg.jpg	f	1	t	2026-03-07 06:44:37	2026-03-07 07:01:07
4	Simon 	Shop Technician	/uploads/ld6yLWMPZKE_unnamed__1_.jpg	f	4	t	2026-03-07 06:42:43	2026-03-07 07:01:41
1	Josphat Kwendo	Founder & CEO	/uploads/itqhwoEI_pU_whatsapp_image_2026-03-07_at_10_05_40.jpeg	t	0	t	2026-03-07 06:42:43	2026-03-07 07:08:26
3	Reagan Tiama	Shop Technician	/uploads/jmore6_wHDo_unnamed.png	f	3	t	2026-03-07 06:42:43	2026-03-07 07:11:53
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, hashed_password, confirmed_at, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_tokens (id, user_id, token, context, sent_to, inserted_at) FROM stdin;
\.


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 6, true);


--
-- Name: ai_usages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ai_usages_id_seq', 150, true);


--
-- Name: collections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collections_id_seq', 14, true);


--
-- Name: expenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.expenses_id_seq', 1, false);


--
-- Name: hero_slides_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hero_slides_id_seq', 5, true);


--
-- Name: legal_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.legal_documents_id_seq', 3, true);


--
-- Name: legal_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.legal_items_id_seq', 43, true);


--
-- Name: legal_sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.legal_sections_id_seq', 12, true);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_seq', 2, true);


--
-- Name: nav_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nav_items_id_seq', 17, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 3, true);


--
-- Name: product_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_images_id_seq', 70, true);


--
-- Name: product_specs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_specs_id_seq', 553, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 54, true);


--
-- Name: returns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.returns_id_seq', 1, false);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 6, true);


--
-- Name: sales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_id_seq', 2, true);


--
-- Name: service_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_jobs_id_seq', 1, false);


--
-- Name: site_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.site_settings_id_seq', 1, true);


--
-- Name: skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.skills_id_seq', 5, true);


--
-- Name: stock_movements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_movements_id_seq', 1, false);


--
-- Name: store_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_stock_id_seq', 151, true);


--
-- Name: stores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stores_id_seq', 3, true);


--
-- Name: team_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.team_members_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: users_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_tokens_id_seq', 1, false);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: ai_usages ai_usages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_usages
    ADD CONSTRAINT ai_usages_pkey PRIMARY KEY (id);


--
-- Name: collections collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_pkey PRIMARY KEY (id);


--
-- Name: expenses expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: hero_slides hero_slides_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hero_slides
    ADD CONSTRAINT hero_slides_pkey PRIMARY KEY (id);


--
-- Name: legal_documents legal_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_documents
    ADD CONSTRAINT legal_documents_pkey PRIMARY KEY (id);


--
-- Name: legal_items legal_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_items
    ADD CONSTRAINT legal_items_pkey PRIMARY KEY (id);


--
-- Name: legal_sections legal_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_sections
    ADD CONSTRAINT legal_sections_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: nav_items nav_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nav_items
    ADD CONSTRAINT nav_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_images product_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);


--
-- Name: product_specs product_specs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_specs
    ADD CONSTRAINT product_specs_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: returns returns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returns
    ADD CONSTRAINT returns_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: service_jobs service_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_jobs
    ADD CONSTRAINT service_jobs_pkey PRIMARY KEY (id);


--
-- Name: site_settings site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (id);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: stock_movements stock_movements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_pkey PRIMARY KEY (id);


--
-- Name: store_stock store_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_stock
    ADD CONSTRAINT store_stock_pkey PRIMARY KEY (id);


--
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: team_members team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_pkey PRIMARY KEY (id);


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
-- Name: admin_users_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX admin_users_email_index ON public.admin_users USING btree (email);


--
-- Name: ai_usages_action_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ai_usages_action_index ON public.ai_usages USING btree (action);


--
-- Name: ai_usages_inserted_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ai_usages_inserted_at_index ON public.ai_usages USING btree (inserted_at);


--
-- Name: collections_slug_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX collections_slug_index ON public.collections USING btree (slug);


--
-- Name: expenses_category_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX expenses_category_index ON public.expenses USING btree (category);


--
-- Name: expenses_date_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX expenses_date_index ON public.expenses USING btree (date);


--
-- Name: expenses_store_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX expenses_store_id_index ON public.expenses USING btree (store_id);


--
-- Name: hero_slides_active_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX hero_slides_active_index ON public.hero_slides USING btree (active);


--
-- Name: hero_slides_position_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX hero_slides_position_index ON public.hero_slides USING btree ("position");


--
-- Name: legal_documents_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX legal_documents_type_index ON public.legal_documents USING btree (type);


--
-- Name: legal_items_legal_section_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX legal_items_legal_section_id_index ON public.legal_items USING btree (legal_section_id);


--
-- Name: legal_sections_legal_document_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX legal_sections_legal_document_id_index ON public.legal_sections USING btree (legal_document_id);


--
-- Name: locations_position_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX locations_position_index ON public.locations USING btree ("position");


--
-- Name: nav_items_position_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX nav_items_position_index ON public.nav_items USING btree ("position");


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
-- Name: orders_store_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX orders_store_id_index ON public.orders USING btree (store_id);


--
-- Name: product_images_product_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_images_product_id_index ON public.product_images USING btree (product_id);


--
-- Name: product_images_product_id_position_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_images_product_id_position_index ON public.product_images USING btree (product_id, "position");


--
-- Name: product_specs_product_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX product_specs_product_id_index ON public.product_specs USING btree (product_id);


--
-- Name: products_code_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_code_index ON public.products USING btree (code);


--
-- Name: products_collections_collection_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_collections_collection_id_index ON public.products_collections USING btree (collection_id);


--
-- Name: products_collections_product_id_collection_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX products_collections_product_id_collection_id_index ON public.products_collections USING btree (product_id, collection_id);


--
-- Name: products_featured_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_featured_index ON public.products USING btree (featured);


--
-- Name: products_on_sale_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX products_on_sale_index ON public.products USING btree (on_sale);


--
-- Name: products_slug_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX products_slug_index ON public.products USING btree (slug);


--
-- Name: returns_customer_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX returns_customer_email_index ON public.returns USING btree (customer_email);


--
-- Name: returns_order_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX returns_order_id_index ON public.returns USING btree (order_id);


--
-- Name: returns_product_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX returns_product_id_index ON public.returns USING btree (product_id);


--
-- Name: returns_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX returns_status_index ON public.returns USING btree (status);


--
-- Name: returns_store_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX returns_store_id_index ON public.returns USING btree (store_id);


--
-- Name: reviews_context_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reviews_context_index ON public.reviews USING btree (context);


--
-- Name: reviews_featured_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX reviews_featured_index ON public.reviews USING btree (featured);


--
-- Name: sales_order_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sales_order_id_index ON public.sales USING btree (order_id);


--
-- Name: sales_payment_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sales_payment_status_index ON public.sales USING btree (payment_status);


--
-- Name: sales_product_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sales_product_id_index ON public.sales USING btree (product_id);


--
-- Name: sales_store_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sales_store_id_index ON public.sales USING btree (store_id);


--
-- Name: service_jobs_reference_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX service_jobs_reference_index ON public.service_jobs USING btree (reference);


--
-- Name: service_jobs_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX service_jobs_status_index ON public.service_jobs USING btree (status);


--
-- Name: service_jobs_store_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX service_jobs_store_id_index ON public.service_jobs USING btree (store_id);


--
-- Name: skills_position_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX skills_position_index ON public.skills USING btree ("position");


--
-- Name: stock_movements_inserted_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stock_movements_inserted_at_index ON public.stock_movements USING btree (inserted_at);


--
-- Name: stock_movements_product_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stock_movements_product_id_index ON public.stock_movements USING btree (product_id);


--
-- Name: stock_movements_store_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stock_movements_store_id_index ON public.stock_movements USING btree (store_id);


--
-- Name: stock_movements_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stock_movements_type_index ON public.stock_movements USING btree (type);


--
-- Name: store_stock_product_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX store_stock_product_id_index ON public.store_stock USING btree (product_id);


--
-- Name: store_stock_store_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX store_stock_store_id_index ON public.store_stock USING btree (store_id);


--
-- Name: store_stock_store_id_product_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX store_stock_store_id_product_id_index ON public.store_stock USING btree (store_id, product_id);


--
-- Name: stores_location_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX stores_location_id_index ON public.stores USING btree (location_id);


--
-- Name: stores_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX stores_name_index ON public.stores USING btree (name);


--
-- Name: team_members_position_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX team_members_position_index ON public.team_members USING btree ("position");


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
-- Name: expenses expenses_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE SET NULL;


--
-- Name: legal_items legal_items_legal_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_items
    ADD CONSTRAINT legal_items_legal_section_id_fkey FOREIGN KEY (legal_section_id) REFERENCES public.legal_sections(id) ON DELETE CASCADE;


--
-- Name: legal_sections legal_sections_legal_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.legal_sections
    ADD CONSTRAINT legal_sections_legal_document_id_fkey FOREIGN KEY (legal_document_id) REFERENCES public.legal_documents(id) ON DELETE CASCADE;


--
-- Name: orders orders_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE SET NULL;


--
-- Name: product_images product_images_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: product_specs product_specs_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_specs
    ADD CONSTRAINT product_specs_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_collections products_collections_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_collections
    ADD CONSTRAINT products_collections_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collections(id) ON DELETE CASCADE;


--
-- Name: products_collections products_collections_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_collections
    ADD CONSTRAINT products_collections_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: returns returns_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returns
    ADD CONSTRAINT returns_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE SET NULL;


--
-- Name: returns returns_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returns
    ADD CONSTRAINT returns_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: returns returns_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.returns
    ADD CONSTRAINT returns_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE SET NULL;


--
-- Name: sales sales_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE SET NULL;


--
-- Name: sales sales_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE SET NULL;


--
-- Name: sales sales_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE SET NULL;


--
-- Name: service_jobs service_jobs_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_jobs
    ADD CONSTRAINT service_jobs_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE SET NULL;


--
-- Name: stock_movements stock_movements_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: stock_movements stock_movements_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE SET NULL;


--
-- Name: store_stock store_stock_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_stock
    ADD CONSTRAINT store_stock_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: store_stock store_stock_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_stock
    ADD CONSTRAINT store_stock_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- Name: stores stores_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id) ON DELETE SET NULL;


--
-- Name: users_tokens users_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens
    ADD CONSTRAINT users_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict aVACWy75y0228YMpGQfCiRGgcIdIFRgkWqfTmpzpXZ1AUaee8ydNL65LgYhn3tq

