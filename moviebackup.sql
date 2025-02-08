--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-02-08 11:11:27

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 24593)
-- Name: actor_movie_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actor_movie_relations (
    movie_id integer,
    actor_id integer
);


ALTER TABLE public.actor_movie_relations OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24584)
-- Name: actor_names; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actor_names (
    id integer,
    actor_name character(100)
);


ALTER TABLE public.actor_names OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24602)
-- Name: genre_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre_list (
    genre_id integer NOT NULL,
    genre_name character varying(50) NOT NULL
);


ALTER TABLE public.genre_list OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24601)
-- Name: genre_list_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genre_list_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genre_list_genre_id_seq OWNER TO postgres;

--
-- TOC entry 4875 (class 0 OID 0)
-- Dependencies: 220
-- Name: genre_list_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genre_list_genre_id_seq OWNED BY public.genre_list.genre_id;


--
-- TOC entry 218 (class 1259 OID 24590)
-- Name: genre_movie_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genre_movie_relations (
    movie_id integer,
    genre_id integer
);


ALTER TABLE public.genre_movie_relations OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24618)
-- Name: movies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.movies (
    movie_id integer NOT NULL,
    movie_name character varying(100),
    movie_image character varying(150),
    vid_link character varying(300),
    year integer,
    description character varying(1000),
    length character varying(25)
);


ALTER TABLE public.movies OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24617)
-- Name: movies_movie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movies_movie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movies_movie_id_seq OWNER TO postgres;

--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 222
-- Name: movies_movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.movies_movie_id_seq OWNED BY public.movies.movie_id;


--
-- TOC entry 4712 (class 2604 OID 24605)
-- Name: genre_list genre_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre_list ALTER COLUMN genre_id SET DEFAULT nextval('public.genre_list_genre_id_seq'::regclass);


--
-- TOC entry 4713 (class 2604 OID 24621)
-- Name: movies movie_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies ALTER COLUMN movie_id SET DEFAULT nextval('public.movies_movie_id_seq'::regclass);


--
-- TOC entry 4865 (class 0 OID 24593)
-- Dependencies: 219
-- Data for Name: actor_movie_relations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actor_movie_relations (movie_id, actor_id) FROM stdin;
4	1
4	2
4	3
4	4
4	5
4	6
4	7
4	8
4	9
4	10
\.


--
-- TOC entry 4863 (class 0 OID 24584)
-- Dependencies: 217
-- Data for Name: actor_names; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actor_names (id, actor_name) FROM stdin;
1	Дэниэл Калуя                                                                                        
2	Эллисон Уильямс                                                                                     
3	Кэтрин Кинер                                                                                        
4	Брэдли Уитфорд                                                                                      
5	Калеб Лэндри Джонс                                                                                  
6	Маркус Хендерсон                                                                                    
7	Бетти Гэбриел                                                                                       
8	Лакит Стэнфилд                                                                                      
9	Стивен Рут                                                                                          
10	Лил Рел Ховери                                                                                      
\.


--
-- TOC entry 4867 (class 0 OID 24602)
-- Dependencies: 221
-- Data for Name: genre_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre_list (genre_id, genre_name) FROM stdin;
1	сериалы
2	аниме
3	мультфильм
4	вестерн
5	биография
6	боевик
7	военный
8	детектив
9	драма
10	документальный
11	история
12	комедия
13	криминал
14	мелодрама
15	музыка
16	приключения
17	спорт
18	триллер
19	ужасы
20	фэнтези
21	фантастика
\.


--
-- TOC entry 4864 (class 0 OID 24590)
-- Dependencies: 218
-- Data for Name: genre_movie_relations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genre_movie_relations (movie_id, genre_id) FROM stdin;
4	8
4	18
4	19
\.


--
-- TOC entry 4869 (class 0 OID 24618)
-- Dependencies: 223
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.movies (movie_id, movie_name, movie_image, vid_link, year, description, length) FROM stdin;
1	Муфаса: Король лев	https://gidonline.net/uploads/mini/fullstory/4c/e056f60d035176fd5ca112769747eb.webp	\N	\N	\N	\N
2	Соник 3	https://gidonline.net/uploads/mini/fullstory/bd/aa6c320e975064c179f8cdadba2e4e.webp	\N	\N	\N	\N
3	Веном 3: Последний танец	https://gidonline.net/uploads/mini/fullstory/39/a77e256e4aa51cc0308ce65929b029.webp	\N	\N	\N	\N
5	Черное зеркало	https://gidonline.net/uploads/mini/fullstory/7f/90769f23d19eef8f33a8d9b70efe74.webp	\N	\N	\N	\N
6	Субстанция	https://gidonline.net/uploads/mini/fullstory/22/af91a8fba1caee73a52b944223b984.webp	\N	\N	\N	\N
7	Граф Монте-Кристо	https://gidonline.net/uploads/mini/fullstory/b0/3273fe664ca560c29bb2793f3deaf0.webp	\N	\N	\N	\N
8	Гладиатор 2	https://gidonline.net/uploads/mini/fullstory/0f/97dea642a38c01293c9294c48b552d.webp	\N	\N	\N	\N
9	Носферату	https://gidonline.net/uploads/mini/fullstory/b6/a5699c52d3ec1f2cc15b6899be00c3.webp	\N	\N	\N	\N
10	Лицо со шрамом	https://gidonline.net/uploads/mini/fullstory/f6/846115bfba20ccc4cd33a703198d61.webp	\N	\N	\N	\N
11	Дэдпул и Россомаха	https://gidonline.net/uploads/mini/fullstory/dd/50c5c8f31170377349627940734219.webp	\N	\N	\N	\N
12	Чужой: Ромул	https://gidonline.net/uploads/mini/fullstory/a6/c0caa67c79714fff9f841971f6292a.webp	\N	\N	\N	\N
14	Дюна	https://gidonline.net/uploads/mini/fullstory/cb/d8c356a7d15746ec127057c8d67f67.webp	\N	\N	\N	\N
4	Прочь	https://gidonline.net/uploads/mini/fullstory/6b/3680afe86294af18010ca7fd3e62bf.webp	\n      <iframe\n        width="720"\n        height="405"\n        src="https://rutube.ru/play/embed/01d8420bd70b3c69aeeba6d2205d0989"\n        frameBorder="0"\n        allow="clipboard-write; autoplay"\n        webkitAllowFullScreen\n        mozallowfullscreen\n        allowFullScreen\n      ></iframe>\n    	2017	Когда нью-йоркский фотограф отправляется знакомиться с родственниками своей подруги, он не ожидает ничего необычного. Он предполагает, что это будет обычный семейный уикенд с её родителями, которые являются частью высокопоставленного общества и живут в изолированной особняке за городом. Однако ему даже в голову не приходит, что приглашение таит в себе зловещую тайну, а его поездка превратится в борьбу за выживание. Если бы он знал настоящую причину, по которой он там, то старался бы изо всех сил убежать как можно быстрее... © ГидОнлайн	104 мин. / 01:44
15	Лоракс	https://gidonline.net/uploads/mini/shortstory/33/900a4aa5f34be828034407dabf58d8.webp	\N	2012	\N	\N
\.


--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 220
-- Name: genre_list_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genre_list_genre_id_seq', 21, true);


--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 222
-- Name: movies_movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movies_movie_id_seq', 15, true);


--
-- TOC entry 4715 (class 2606 OID 24607)
-- Name: genre_list genre_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genre_list
    ADD CONSTRAINT genre_list_pkey PRIMARY KEY (genre_id);


--
-- TOC entry 4717 (class 2606 OID 24625)
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movie_id);


-- Completed on 2025-02-08 11:11:27

--
-- PostgreSQL database dump complete
--

