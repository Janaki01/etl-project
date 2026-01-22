--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2026-01-22 14:44:14

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16566)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    customerid integer NOT NULL,
    customername character varying(200) NOT NULL,
    address1 character varying(200),
    address2 character varying(200),
    city character varying(100),
    state character varying(100),
    country character varying(100),
    status character varying(50) DEFAULT 'Active'::character varying NOT NULL,
    createdon timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updatedon timestamp without time zone
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16565)
-- Name: customer_customerid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_customerid_seq OWNER TO postgres;

--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 209
-- Name: customer_customerid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_customerid_seq OWNED BY public.customer.customerid;


--
-- TOC entry 216 (class 1259 OID 16649)
-- Name: discount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount (
    discountid integer NOT NULL,
    productid integer,
    discountamount numeric(18,2),
    discountpercentage numeric(5,2),
    status character varying(50) DEFAULT 'Active'::character varying NOT NULL,
    createdon timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updatedon timestamp without time zone
);


ALTER TABLE public.discount OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16648)
-- Name: discount_discountid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.discount_discountid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.discount_discountid_seq OWNER TO postgres;

--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 215
-- Name: discount_discountid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.discount_discountid_seq OWNED BY public.discount.discountid;


--
-- TOC entry 220 (class 1259 OID 16686)
-- Name: orderlineitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orderlineitems (
    orderlineitemid integer NOT NULL,
    orderid integer NOT NULL,
    productid integer NOT NULL,
    quantity integer NOT NULL,
    uom character varying(50),
    rate numeric(18,2) NOT NULL,
    discountid integer,
    taxid integer,
    amount numeric(18,2),
    createdon timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updatedon timestamp without time zone,
    CONSTRAINT orderlineitems_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.orderlineitems OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16685)
-- Name: orderlineitems_orderlineitemid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orderlineitems_orderlineitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orderlineitems_orderlineitemid_seq OWNER TO postgres;

--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 219
-- Name: orderlineitems_orderlineitemid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orderlineitems_orderlineitemid_seq OWNED BY public.orderlineitems.orderlineitemid;


--
-- TOC entry 218 (class 1259 OID 16663)
-- Name: ordertransaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordertransaction (
    orderid integer NOT NULL,
    customerid integer NOT NULL,
    discountid integer,
    taxid integer,
    totalamount numeric(18,2),
    createdon timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updatedonpdatedon timestamp without time zone
);


ALTER TABLE public.ordertransaction OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16662)
-- Name: ordertransaction_orderid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordertransaction_orderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ordertransaction_orderid_seq OWNER TO postgres;

--
-- TOC entry 3386 (class 0 OID 0)
-- Dependencies: 217
-- Name: ordertransaction_orderid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordertransaction_orderid_seq OWNED BY public.ordertransaction.orderid;


--
-- TOC entry 212 (class 1259 OID 16630)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    productid integer NOT NULL,
    productname character varying(200) NOT NULL,
    manufacturingdate date,
    shelflifeinmonths integer,
    rate numeric(18,2) NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    createdon timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updatedon timestamp without time zone
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16629)
-- Name: product_productid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_productid_seq OWNER TO postgres;

--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 211
-- Name: product_productid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_productid_seq OWNED BY public.product.productid;


--
-- TOC entry 214 (class 1259 OID 16639)
-- Name: taxation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.taxation (
    taxid integer NOT NULL,
    taxname character varying(200) NOT NULL,
    taxtypeapplicable character varying(50) NOT NULL,
    taxamount numeric(18,2),
    applicableyorn character(1) NOT NULL,
    createdon timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updatedon timestamp without time zone,
    CONSTRAINT taxation_applicableyorn_check CHECK ((applicableyorn = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
    CONSTRAINT taxation_taxtypeapplicable_check CHECK (((taxtypeapplicable)::text = ANY ((ARRAY['Orders'::character varying, 'Products'::character varying])::text[])))
);


ALTER TABLE public.taxation OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16638)
-- Name: taxation_taxid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taxation_taxid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taxation_taxid_seq OWNER TO postgres;

--
-- TOC entry 3388 (class 0 OID 0)
-- Dependencies: 213
-- Name: taxation_taxid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.taxation_taxid_seq OWNED BY public.taxation.taxid;


--
-- TOC entry 3189 (class 2604 OID 16569)
-- Name: customer customerid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN customerid SET DEFAULT nextval('public.customer_customerid_seq'::regclass);


--
-- TOC entry 3199 (class 2604 OID 16652)
-- Name: discount discountid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount ALTER COLUMN discountid SET DEFAULT nextval('public.discount_discountid_seq'::regclass);


--
-- TOC entry 3204 (class 2604 OID 16689)
-- Name: orderlineitems orderlineitemid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderlineitems ALTER COLUMN orderlineitemid SET DEFAULT nextval('public.orderlineitems_orderlineitemid_seq'::regclass);


--
-- TOC entry 3202 (class 2604 OID 16666)
-- Name: ordertransaction orderid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordertransaction ALTER COLUMN orderid SET DEFAULT nextval('public.ordertransaction_orderid_seq'::regclass);


--
-- TOC entry 3192 (class 2604 OID 16633)
-- Name: product productid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN productid SET DEFAULT nextval('public.product_productid_seq'::regclass);


--
-- TOC entry 3195 (class 2604 OID 16642)
-- Name: taxation taxid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxation ALTER COLUMN taxid SET DEFAULT nextval('public.taxation_taxid_seq'::regclass);


--
-- TOC entry 3367 (class 0 OID 16566)
-- Dependencies: 210
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.customer VALUES (1, 'Haynes', NULL, NULL, 'Gandhinagar', 'Gujrat', 'India', 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.customer VALUES (2, 'Sneha', NULL, NULL, 'Bangalore', 'Karnataka', 'India', 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.customer VALUES (3, 'Tamanna', NULL, NULL, 'Delhi', 'Delhi', 'India', 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.customer VALUES (5, 'Krishna', NULL, NULL, 'Hyderabad', 'Telangana', 'India', 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.customer VALUES (6, 'Rashmi', NULL, NULL, 'Noida', 'Uttar Pradesh', 'India', 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.customer VALUES (7, 'Akhila', NULL, NULL, 'Gandhinagar', 'Gujrat', 'India', 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.customer VALUES (8, 'Pranjali', NULL, NULL, 'Mumbai', 'Maharashtra', 'India', 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.customer VALUES (9, 'Rohit', NULL, NULL, 'Gandhinagar', 'Gujrat', 'India', 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.customer VALUES (10, 'Gaurav', NULL, NULL, 'Pune', 'Maharashtra', 'India', 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.customer VALUES (4, 'Janaki', 'KPHB', NULL, 'Hyderabad', 'Telangana', 'India', 'Active', '2026-01-22 14:08:36.992491', NULL);


--
-- TOC entry 3373 (class 0 OID 16649)
-- Dependencies: 216
-- Data for Name: discount; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.discount VALUES (1, 1, NULL, 8.00, 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.discount VALUES (2, 2, 100.00, NULL, 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.discount VALUES (3, 3, NULL, 5.00, 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.discount VALUES (4, 4, 1000.00, NULL, 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.discount VALUES (5, 5, NULL, 10.00, 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.discount VALUES (6, 6, NULL, 5.00, 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.discount VALUES (7, 7, 500.00, NULL, 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.discount VALUES (8, 8, NULL, 12.00, 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.discount VALUES (9, 9, 750.00, NULL, 'Active', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.discount VALUES (10, 10, NULL, 7.00, 'Active', '2026-01-22 14:08:36.992491', NULL);


--
-- TOC entry 3377 (class 0 OID 16686)
-- Dependencies: 220
-- Data for Name: orderlineitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orderlineitems VALUES (1, 1, 1, 1, 'Nos', 65000.00, 1, 1, 62790.00, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.orderlineitems VALUES (2, 1, 2, 1, 'Nos', 45000.00, 2, 2, 50288.00, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.orderlineitems VALUES (3, 2, 6, 1, 'Nos', 800.00, 6, 1, 800.00, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.orderlineitems VALUES (4, 3, 10, 2, 'Nos', 2500.00, 10, 2, 5208.00, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.orderlineitems VALUES (5, 3, 7, 1, 'Nos', 9000.00, 7, 3, 10030.00, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.orderlineitems VALUES (6, 3, 8, 1, 'Nos', 3500.00, 8, 5, 3220.00, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.orderlineitems VALUES (7, 4, 1, 1, 'Nos', 65000.00, 1, 1, 62790.00, '2026-01-22 14:08:36.992491', NULL);


--
-- TOC entry 3375 (class 0 OID 16663)
-- Dependencies: 218
-- Data for Name: ordertransaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ordertransaction VALUES (1, 2, NULL, 6, 118731.90, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.ordertransaction VALUES (2, 4, NULL, 8, 816.00, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.ordertransaction VALUES (3, 1, NULL, 7, 20303.80, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.ordertransaction VALUES (4, 3, NULL, 9, 62790.00, '2026-01-22 14:08:36.992491', NULL);


--
-- TOC entry 3369 (class 0 OID 16630)
-- Dependencies: 212
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product VALUES (1, 'Laptop', '2025-01-10', 24, 65000.00, 30, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.product VALUES (2, 'Smartphone', '2025-02-15', 18, 45000.00, 50, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.product VALUES (3, 'Tablet', '2025-03-20', 18, 30000.00, 40, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.product VALUES (4, 'Monitor', '2025-01-05', 36, 12000.00, 25, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.product VALUES (5, 'Keyboard', '2025-04-12', 48, 1500.00, 100, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.product VALUES (6, 'Mouse', '2025-04-18', 48, 800.00, 120, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.product VALUES (7, 'Printer', '2025-02-22', 24, 9000.00, 15, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.product VALUES (8, 'WiFi Router', '2025-03-28', 36, 3500.00, 35, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.product VALUES (9, 'External Hard Drive', '2025-01-09', 24, 6000.00, 20, '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.product VALUES (10, 'Webcam', '2025-02-11', 36, 2500.00, 60, '2026-01-22 14:08:36.992491', NULL);


--
-- TOC entry 3371 (class 0 OID 16639)
-- Dependencies: 214
-- Data for Name: taxation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.taxation VALUES (1, 'GST 5%', 'Products', 5.00, 'Y', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.taxation VALUES (2, 'GST 12%', 'Products', 12.00, 'Y', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.taxation VALUES (3, 'GST 18%', 'Products', 18.00, 'Y', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.taxation VALUES (4, 'GST 28%', 'Products', 28.00, 'Y', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.taxation VALUES (5, 'GST Exempt', 'Products', NULL, 'N', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.taxation VALUES (6, 'Service Charge 5%', 'Orders', 5.00, 'Y', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.taxation VALUES (7, 'Service Charge 10%', 'Orders', 10.00, 'Y', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.taxation VALUES (8, 'Packaging Tax 2%', 'Orders', 2.00, 'Y', '2026-01-22 14:08:36.992491', NULL);
INSERT INTO public.taxation VALUES (9, 'Delivery Tax', 'Orders', NULL, 'N', '2026-01-22 14:08:36.992491', NULL);


--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 209
-- Name: customer_customerid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customerid_seq', 10, true);


--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 215
-- Name: discount_discountid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.discount_discountid_seq', 10, true);


--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 219
-- Name: orderlineitems_orderlineitemid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orderlineitems_orderlineitemid_seq', 7, true);


--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 217
-- Name: ordertransaction_orderid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordertransaction_orderid_seq', 4, true);


--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 211
-- Name: product_productid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_productid_seq', 10, true);


--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 213
-- Name: taxation_taxid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taxation_taxid_seq', 9, true);


--
-- TOC entry 3208 (class 2606 OID 16575)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customerid);


--
-- TOC entry 3214 (class 2606 OID 16656)
-- Name: discount discount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount
    ADD CONSTRAINT discount_pkey PRIMARY KEY (discountid);


--
-- TOC entry 3218 (class 2606 OID 16693)
-- Name: orderlineitems orderlineitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderlineitems
    ADD CONSTRAINT orderlineitems_pkey PRIMARY KEY (orderlineitemid);


--
-- TOC entry 3216 (class 2606 OID 16669)
-- Name: ordertransaction ordertransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordertransaction
    ADD CONSTRAINT ordertransaction_pkey PRIMARY KEY (orderid);


--
-- TOC entry 3210 (class 2606 OID 16637)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (productid);


--
-- TOC entry 3212 (class 2606 OID 16647)
-- Name: taxation taxation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.taxation
    ADD CONSTRAINT taxation_pkey PRIMARY KEY (taxid);


--
-- TOC entry 3219 (class 2606 OID 16657)
-- Name: discount fk_discount_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount
    ADD CONSTRAINT fk_discount_product FOREIGN KEY (productid) REFERENCES public.product(productid);


--
-- TOC entry 3224 (class 2606 OID 16704)
-- Name: orderlineitems fk_oli_discount; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderlineitems
    ADD CONSTRAINT fk_oli_discount FOREIGN KEY (discountid) REFERENCES public.discount(discountid);


--
-- TOC entry 3226 (class 2606 OID 16694)
-- Name: orderlineitems fk_oli_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderlineitems
    ADD CONSTRAINT fk_oli_order FOREIGN KEY (orderid) REFERENCES public.ordertransaction(orderid);


--
-- TOC entry 3223 (class 2606 OID 16699)
-- Name: orderlineitems fk_oli_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderlineitems
    ADD CONSTRAINT fk_oli_product FOREIGN KEY (productid) REFERENCES public.product(productid);


--
-- TOC entry 3225 (class 2606 OID 16709)
-- Name: orderlineitems fk_oli_tax; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderlineitems
    ADD CONSTRAINT fk_oli_tax FOREIGN KEY (taxid) REFERENCES public.taxation(taxid);


--
-- TOC entry 3220 (class 2606 OID 16670)
-- Name: ordertransaction fk_order_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordertransaction
    ADD CONSTRAINT fk_order_customer FOREIGN KEY (customerid) REFERENCES public.customer(customerid);


--
-- TOC entry 3221 (class 2606 OID 16675)
-- Name: ordertransaction fk_order_discount; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordertransaction
    ADD CONSTRAINT fk_order_discount FOREIGN KEY (discountid) REFERENCES public.discount(discountid);


--
-- TOC entry 3222 (class 2606 OID 16680)
-- Name: ordertransaction fk_order_tax; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordertransaction
    ADD CONSTRAINT fk_order_tax FOREIGN KEY (taxid) REFERENCES public.taxation(taxid);


-- Completed on 2026-01-22 14:44:15

--
-- PostgreSQL database dump complete
--

