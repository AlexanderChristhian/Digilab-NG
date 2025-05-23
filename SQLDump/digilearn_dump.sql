--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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
-- Name: news_entity_type; Type: TYPE; Schema: public; Owner: digilearn_owner
--

CREATE TYPE public.news_entity_type AS ENUM (
    'class',
    'assignment',
    'module'
);


ALTER TYPE public.news_entity_type OWNER TO digilearn_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: assignments; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.assignments (
    id integer NOT NULL,
    class_id integer,
    title character varying(100) NOT NULL,
    description text NOT NULL,
    deadline timestamp without time zone NOT NULL,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.assignments OWNER TO digilearn_owner;

--
-- Name: assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.assignments_id_seq OWNER TO digilearn_owner;

--
-- Name: assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.assignments_id_seq OWNED BY public.assignments.id;


--
-- Name: class_enrollments; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.class_enrollments (
    id integer NOT NULL,
    class_id integer,
    user_id integer,
    enrolled_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.class_enrollments OWNER TO digilearn_owner;

--
-- Name: class_enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.class_enrollments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.class_enrollments_id_seq OWNER TO digilearn_owner;

--
-- Name: class_enrollments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.class_enrollments_id_seq OWNED BY public.class_enrollments.id;


--
-- Name: classes; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.classes (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    description text,
    image_url character varying(255),
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.classes OWNER TO digilearn_owner;

--
-- Name: classes_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.classes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.classes_id_seq OWNER TO digilearn_owner;

--
-- Name: classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.classes_id_seq OWNED BY public.classes.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    post_id integer,
    user_id integer,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.comments OWNER TO digilearn_owner;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO digilearn_owner;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: grades; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.grades (
    id integer NOT NULL,
    submission_id integer NOT NULL,
    grade numeric(5,2) NOT NULL,
    feedback text,
    graded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    graded_by integer NOT NULL,
    CONSTRAINT grades_grade_check CHECK (((grade >= (0)::numeric) AND (grade <= (100)::numeric)))
);


ALTER TABLE public.grades OWNER TO digilearn_owner;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.grades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grades_id_seq OWNER TO digilearn_owner;

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;


--
-- Name: module_files; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.module_files (
    id integer NOT NULL,
    module_id integer,
    file_name character varying(255) NOT NULL,
    file_url character varying(255) NOT NULL,
    file_type character varying(50),
    file_size integer,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.module_files OWNER TO digilearn_owner;

--
-- Name: module_files_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.module_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.module_files_id_seq OWNER TO digilearn_owner;

--
-- Name: module_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.module_files_id_seq OWNED BY public.module_files.id;


--
-- Name: module_folders; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.module_folders (
    id integer NOT NULL,
    class_id integer,
    title character varying(100) NOT NULL,
    order_index integer DEFAULT 0,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.module_folders OWNER TO digilearn_owner;

--
-- Name: module_folders_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.module_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.module_folders_id_seq OWNER TO digilearn_owner;

--
-- Name: module_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.module_folders_id_seq OWNED BY public.module_folders.id;


--
-- Name: modules; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.modules (
    id integer NOT NULL,
    folder_id integer,
    class_id integer,
    title character varying(100) NOT NULL,
    content text NOT NULL,
    order_index integer DEFAULT 0,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.modules OWNER TO digilearn_owner;

--
-- Name: modules_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.modules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.modules_id_seq OWNER TO digilearn_owner;

--
-- Name: modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.modules_id_seq OWNED BY public.modules.id;


--
-- Name: news; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.news (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    content text NOT NULL,
    image_url character varying(255),
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.news OWNER TO digilearn_owner;

--
-- Name: news_entities; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.news_entities (
    news_id integer NOT NULL,
    entity_type public.news_entity_type NOT NULL,
    entity_id integer NOT NULL
);


ALTER TABLE public.news_entities OWNER TO digilearn_owner;

--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_id_seq OWNER TO digilearn_owner;

--
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.news_id_seq OWNED BY public.news.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    user_id integer,
    content text NOT NULL,
    image_url character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.posts OWNER TO digilearn_owner;

--
-- Name: posts_entities; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.posts_entities (
    posts_id integer NOT NULL,
    entity_type character varying(20) NOT NULL,
    entity_id integer NOT NULL,
    CONSTRAINT posts_entities_entity_type_check CHECK (((entity_type)::text = ANY ((ARRAY['class'::character varying, 'module'::character varying, 'assignment'::character varying])::text[])))
);


ALTER TABLE public.posts_entities OWNER TO digilearn_owner;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO digilearn_owner;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.submissions (
    id integer NOT NULL,
    assignment_id integer,
    user_id integer,
    content text,
    file_url character varying(255),
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.submissions OWNER TO digilearn_owner;

--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.submissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.submissions_id_seq OWNER TO digilearn_owner;

--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.submissions_id_seq OWNED BY public.submissions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: digilearn_owner
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    role character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    profile_image character varying(255),
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['aslab'::character varying, 'praktikan'::character varying, 'guest'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO digilearn_owner;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: digilearn_owner
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO digilearn_owner;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digilearn_owner
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: assignments id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.assignments ALTER COLUMN id SET DEFAULT nextval('public.assignments_id_seq'::regclass);


--
-- Name: class_enrollments id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.class_enrollments ALTER COLUMN id SET DEFAULT nextval('public.class_enrollments_id_seq'::regclass);


--
-- Name: classes id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.classes ALTER COLUMN id SET DEFAULT nextval('public.classes_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);


--
-- Name: module_files id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.module_files ALTER COLUMN id SET DEFAULT nextval('public.module_files_id_seq'::regclass);


--
-- Name: module_folders id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.module_folders ALTER COLUMN id SET DEFAULT nextval('public.module_folders_id_seq'::regclass);


--
-- Name: modules id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.modules ALTER COLUMN id SET DEFAULT nextval('public.modules_id_seq'::regclass);


--
-- Name: news id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.news ALTER COLUMN id SET DEFAULT nextval('public.news_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: submissions id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.submissions ALTER COLUMN id SET DEFAULT nextval('public.submissions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: assignments; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.assignments (id, class_id, title, description, deadline, created_by, created_at, updated_at) FROM stdin;
2	1	TP2 - NIGGER	Anjay Mabar	2025-05-29 16:04:00	1	2025-05-13 16:04:57.346641	2025-05-13 16:04:57.346641
3	1	TP3 - Niggersaurus	Anjay makan	2025-05-28 16:05:00	1	2025-05-13 16:05:19.996444	2025-05-13 16:05:19.996444
4	2	Jumpscare part 60	Aowkwkwkwk	2025-05-24 16:57:00	1	2025-05-13 16:58:03.886571	2025-05-13 16:58:03.886571
1	1	TP1 - Testing Didilab	# Tugas Pendahuluan Modul 1 : Pengenalan Dasar Rangkaian Digital\n\nNama : Kafu [Ganti dengan nama lengkap anda]\nNPM    : 2401234567 [Ganti dengan NPM anda]\n\n## Teori\n\n### **Jangan lupa untuk mencantumkan referensi dalam setiap pengerjaan soal (jawaban tanpa referensi hanya mendapatkan maksimal 50% dari bobot soal)**\n\n### 1. **Apa itu breadboard? Jelaskan bagaimana breadboard dapat menghantarkan arus! (10 poin)**\n\n**Lorem Ipsum** is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\n#### Reference:\n\n- Example Website [Online]. Available: https://www.myWebsite.com/ilovedigilab/. [Accessed: 25-Aug-2024]\n\n### **2. Jelaskan apa yang dimaksud dengan VCC dan Ground, Dimana VCC dan Ground dihubungkan pada breadboard? (10 poin)**\n\n**Lorem Ipsum** is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\n#### Reference:\n\n- Example Website [Online]. Available: https://www.myWebsite.com/ilovedigilab/. [Accessed: 25-Aug-2024]\n\n### **3. Jelaskan apa itu LED, serta jelaskan apa itu Anode dan Katode pada LED! (10 poin)**\n\n**Lorem Ipsum** is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\n#### Reference:\n\n- Example Website [Online]. Available: https://www.myWebsite.com/ilovedigilab/. [Accessed: 25-Aug-2024]\n\n### **4. Jelaskan kegunaan resistor dalam suatu rangkaian. Apa yang terjadi bila resistor tidak digunakan pada komponen seperti LED? (10 poin)**\n\n**Lorem Ipsum** is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\n#### Reference:\n\n- Example Website [Online]. Available: https://www.myWebsite.com/ilovedigilab/. [Accessed: 25-Aug-2024]\n\n### **5. Jelaskan apa yang dimaksud dengan IC! Contohkan kegunaan IC dengan menjelaskan tentang IC 7408 (10 poin)**\n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\n#### Reference:\n\n- Example Website [Online]. Available: https://www.myWebsite.com/ilovedigilab/. [Accessed: 25-Aug-2024]\n\n### **6. Apa itu datasheet ? Jelaskan bagian-bagian apa saja yang dapat ditemukan pada datasheet beserta isinya!** (10 poin)\n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n\n#### Reference:\n\n- Example Website [Online]. Available: https://www.myWebsite.com/ilovedigilab/. [Accessed: 25-Aug-2024]\n\n## Praktik\n\nPada bagian ini anda akan mengikuti langkah-langkah untuk membuat sebuah rangkaian sederhana untuk menyalakan LED pada platform Tinkercad.\n\n1. Buatlah dan login pada akun [Tinkercad](https://www.tinkercad.com) atau login menggunakan akun Google.\n2. Navigasi ke **https://www.tinkercad.com/dashboard/designs/circuits** dan buatlah rangkaian baru dengan menggunakan menu **Create > Circuits**\n\n   ![1738932021072](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20194015.png)\n3. Letakkan sebuah breadboard dari bagian **Components**\n\n   ![1738932021072](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20194202.png)\n4. Gunakan component **Power Supply** sebagai sumber tegangan pada rangkaian\n\n   ![1738932359325](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20194554.png)\n5. Hubungkan power supply pada breadboard sesuai dengan jawaban soal teori no 2.\n6. Letakkan sebuah LED pada breadboard dan hubungkan Anode dengan bagian VCC breadboard dari breadboard. Anda dapat menghighlight kaki LED untuk mencari bagian anode. Posisi dari kabel dan LED pada breadboard dibebaskan.\n   ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20195720.png)\n7. Setelahnya, hubungkan katode dari LED dengan sebuah resistor. Hubungkan resistor tersebut ke bagian ground dari breadboard.\n   ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20200103.png)\n8. Tekan tombol **Start Simulation** untuk menjalankan rangkaian, pastikan LED menyala ketika simulasi dijalankan.\n   ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20200329.png)\n   ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20200427.png)\n9. Ubahlah warna dari kabel serta LED yang digunakan (dibebaskan), setelah itu ubahlah nama dari proyek Tinkercad yang dibuat menjadi NamaDepan_NPM.\n\n   ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20201101.png)\n\n   ### 10. **Jelaskan proses yang telah anda lakukan untuk menyalakan LED tersebut (Tidak perlu referensi) (20 poin)\n\n   ### 11. **Sertakan screenshot dari rangkaian yang telah anda buat dengan mengikuti langkah berikut (10 poin)**\n\n   HackMD:\n\n\n   1. Drag and Drop atau tambahkan gambar dengan Insert Image\n      ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20205452.png)\n   2. Tekan tombol Share dan ubah Read pada Note Permission menjadi Everyone. Ini akan memastikan image pada file .md bersifat public dan dapat dirender.\n      ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Untitled.png)\n\n      Selain HackMD:\n   3. Jika anda tidak menggunakan HackMD, anda dapat menggunakan link dari File Hosting Service seperti imgur untuk menambahkan image pada file .md anda dengan format berikut\n      ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20211132.png)\n      **Tidak disarankan untuk menggunakan link Discord, imgcdn, Whatsapp, Local File (Contoh: images/TP1/1738936726245.png), ataupun Google Drive. Karena berpotensi untuk expire atau tidak ter-render. Bila gambar tidak dapat ditampilkan pada file .md, maka dilakukan pengurangan nilai.**\n\n      ### Screenshot Rangkaian :\n\n   ### 12. Sertakan link dari file Tinkercad yang telah anda buat dengan mengikuti langkah berikut untuk memastikan file anda tidak bersifat Private (10 poin)\n\n   1. Tekan bagian berikut ini untuk melakukan navigasi pada dashboard Tinkercad\n      ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20204616.png)\n   2. Tekan rangkaian yang ingin anda bagikan\n   3. Tekan bagian "Change visibility to share"\n\n      ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20204758.png)\n   4. Ubah privacy menjadi Share link atau Public\n      ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20204948.png)\n   5. Save Changes dan copy link\n\n      ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20205035.png)\n\n      ### Link Rangkaian :\n	2025-05-20 02:59:00	1	2025-05-13 14:59:06.68955	2025-05-17 06:05:51.140877
\.


--
-- Data for Name: class_enrollments; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.class_enrollments (id, class_id, user_id, enrolled_at) FROM stdin;
1	1	2	2025-05-13 13:48:48.087203
2	2	2	2025-05-13 16:50:35.547718
3	1	4	2025-05-14 15:54:51.153302
4	2	4	2025-05-15 07:33:04.527582
\.


--
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.classes (id, title, description, image_url, created_by, created_at, updated_at) FROM stdin;
1	≡ƒôô Digital System Design (DSD)	Mata kuliah **Digital System Design (DSD)** membahas prinsip dan teknik dalam perancangan sistem digital menggunakan pendekatan berbasis logika dan pemodelan perangkat keras. Mahasiswa akan mempelajari representasi logika digital, pemrosesan sinyal digital, serta implementasi sistem menggunakan bahasa pemrograman perangkat keras seperti **VHDL** atau **Verilog**.\r\n\r\nTopik utama yang dibahas meliputi:\r\n- Logika Kombinasi dan Sekuensial\r\n- State Machine (Moore & Mealy)\r\n- Desain Register & Counter\r\n- Finite State Machine (FSM)\r\n- Desain dengan Multiplexer, Decoder, Encoder\r\n- Penggunaan Simulator & FPGA\r\n\r\nPraktikum atau proyek akhir sering kali mencakup implementasi desain digital ke dalam **FPGA** (Field Programmable Gate Array), melatih mahasiswa untuk mengembangkan solusi digital yang efisien dan aplikatif.\r\n\r\n**Capaian Pembelajaran:**\r\n- Merancang dan menganalisis sistem logika digital\r\n- Menggunakan alat bantu simulasi untuk memverifikasi sistem digital\r\n- Menerapkan logika digital dalam proyek nyata menggunakan perangkat PROTEUS dan VULKAN LOGIC BOARD\r\n	https://res.cloudinary.com/dnkkk7pgw/raw/upload/v1747144017/classes/q38phaft83giqkksgwb3	1	2025-05-13 13:46:57.952395	2025-05-13 15:27:19.309127
2	Kelas Dengan Proyektor 	IF you know you know	https://res.cloudinary.com/dnkkk7pgw/image/upload/v1747154931/classes/s0jowc4fhotbazdyfvj2.png	1	2025-05-13 16:48:52.266127	2025-05-13 16:48:52.266127
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.comments (id, post_id, user_id, content, created_at, updated_at) FROM stdin;
1	1	3	WAW MIE BABI RODOTUA	2025-05-14 18:22:36.627766	2025-05-14 18:22:36.627766
2	2	3	Tidak.	2025-05-16 15:57:23.462415	2025-05-16 15:57:23.462415
3	2	1	aku tak nak	2025-05-17 05:58:35.056208	2025-05-17 05:58:35.056208
4	3	1	hehe	2025-05-17 06:48:59.264781	2025-05-17 06:48:59.264781
5	4	2	## tes	2025-05-17 06:53:25.793974	2025-05-17 06:53:25.793974
\.


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.grades (id, submission_id, grade, feedback, graded_at, graded_by) FROM stdin;
1	1	100.00	Semangat niga	2025-05-13 16:00:10.652406	1
2	3	69.00	niger	2025-05-15 09:52:58.376111	3
\.


--
-- Data for Name: module_files; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.module_files (id, module_id, file_name, file_url, file_type, file_size, created_by, created_at) FROM stdin;
4	2	CS_ST_DaffaSayraFirdaus_2306267151_OS9.pdf	https://res.cloudinary.com/dnkkk7pgw/raw/upload/v1747146880/module_files/slfyzedqnwvl6ybct47w	application/pdf	728318	1	2025-05-13 14:34:37.623195
5	2	Kelompok1_NoSQLDatabase.pdf	https://res.cloudinary.com/dnkkk7pgw/raw/upload/v1747146892/module_files/wf1ibzhr4jljs3u4qtqb	application/pdf	8928718	1	2025-05-13 14:34:37.623195
6	2	DaffaSayraFirdaus_2306267151_TugasPerformanceEvaluationChapter1.pdf	https://res.cloudinary.com/dnkkk7pgw/raw/upload/v1747146897/module_files/a8wvxvyhdydpg3ut10q2	application/pdf	4415827	1	2025-05-13 14:34:37.623195
7	2	DaffaSayraFirdaus_2306267151_TugasKlasifikasiChapter1.pdf	https://res.cloudinary.com/dnkkk7pgw/raw/upload/v1747146901/module_files/ss5lvuex7os3psovh0k9	application/pdf	3243065	1	2025-05-13 14:34:37.623195
9	4	IPA_-_Fotosintesis_for_SD (2).pdf	https://res.cloudinary.com/dnkkk7pgw/raw/upload/v1747150724/module_files/ngfyzvoejycortvdntzq	application/pdf	7774	1	2025-05-13 15:38:43.246478
\.


--
-- Data for Name: module_folders; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.module_folders (id, class_id, title, order_index, created_by, created_at, updated_at) FROM stdin;
1	1	Modul 1	0	1	2025-05-13 14:04:25.06444	2025-05-13 14:04:25.06444
2	1	Modul 2	1	1	2025-05-13 15:37:55.659291	2025-05-13 15:37:55.659291
\.


--
-- Data for Name: modules; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.modules (id, folder_id, class_id, title, content, order_index, created_by, created_at, updated_at) FROM stdin;
2	1	1	Introduction to DSD	# Introduction to Digital Systems\r\n\r\nDigital systems are the foundation of modern computing and electronics. They process and store data in binary form, using the principles of logic and digital circuits to perform various operations.\r\n\r\n## What is a Digital System?\r\n\r\nA **digital system** is an electronic system that operates on discrete values (commonly 0 and 1) rather than a continuous range of values. These systems are designed to handle information in binary format and are built using digital logic components such as logic gates, multiplexers, flip-flops, and more.\r\n\r\n## Analog vs Digital\r\n\r\n- **Analog systems** process continuous signals (e.g., audio waveforms, light intensity).\r\n- **Digital systems** process discrete binary signals (0s and 1s).\r\n\r\n| Feature           | Analog System             | Digital System            |\r\n|------------------|---------------------------|---------------------------|\r\n| Signal Type      | Continuous                | Discrete (Binary)         |\r\n| Accuracy         | Prone to noise            | More noise-resistant      |\r\n| Components       | Resistors, capacitors     | Logic gates, flip-flops   |\r\n| Processing       | Real-time signal variation| Logical operations        |\r\n\r\n## Binary Number System\r\n\r\nDigital systems use the **binary number system**, which consists of only two digits:\r\n- `0` (low/off)\r\n- `1` (high/on)\r\n\r\n### Example:\r\nDecimal `5` = Binary `101`\r\n\r\n## Fundamental Logic Gates\r\n\r\n| Gate     | Symbol | Function                          | Boolean Expression |\r\n|----------|--------|-----------------------------------|--------------------|\r\n| AND      | Γêº      | Output is 1 if both inputs are 1 | A Γêº B              |\r\n| OR       | Γê¿      | Output is 1 if at least one is 1 | A Γê¿ B              |\r\n| NOT      | ┬¼      | Inverts the input                | ┬¼A                 |\r\n| NAND     |        | NOT of AND                       | ┬¼(A Γêº B)           |\r\n| NOR      |        | NOT of OR                        | ┬¼(A Γê¿ B)           |\r\n| XOR      | Γèò      | Output is 1 if inputs differ     | A Γèò B              |\r\n\r\n## Combinational vs Sequential Circuits\r\n\r\n- **Combinational circuits**: Output depends only on the current inputs.\r\n  - Examples: Adders, multiplexers, encoders.\r\n- **Sequential circuits**: Output depends on current inputs and past states.\r\n  - Examples: Flip-flops, counters, memory.\r\n\r\n## Applications of Digital Systems\r\n\r\n- Computers and microprocessors\r\n- Digital communication (Wi-Fi, Bluetooth)\r\n- Consumer electronics (TVs, smartphones)\r\n- Industrial automation and control systems\r\n- Digital signal processing\r\n\r\n## Summary\r\n\r\nDigital systems are essential in todayΓÇÖs technology-driven world. Understanding binary logic, circuits, and system architecture forms the core of digital electronics and computer engineering.\r\n\r\n> ΓÇ£In digital systems, simplicity in logic can lead to complexity in functionality.ΓÇ¥\r\n	0	1	2025-05-13 14:11:16.23549	2025-05-13 14:35:36.586165
3	1	1	Boolean Algebra	# Aljabar Boolean dan Sifat-sifatnya\r\n\r\nAljabar Boolean merupakan struktur matematika yang memiliki peran penting dalam teori himpunan, logika, elektronika digital, dan ilmu komputer. Sistem matematika ini dikembangkan oleh George Boole pada abad ke-19 dan telah menjadi landasan penting bagi perkembangan teknologi digital modern.\r\n\r\n![alt text](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhk0DI-iwf-6UqUq-gGZYI5JqtqbCHqJtRjPcwu1YwHJ0MM8AvVMuzz1oYb6I2UwMoIvv3c3lfhGhEelmuyXSDW2O1-vOnRINy-TDAe2hBLUVsypcmRuAjwe5jTb3AfqfSqjjUd2KWACqQ/s1600/Simbol-Gerbang-Logika+dasar.gif\r\n)\r\n\r\n## Konsep Dasar Aljabar Boolean\r\n\r\nAljabar Boolean beroperasi pada himpunan yang memiliki dua nilai saja, yaitu:\r\n- 0 (nol) - mewakili FALSE, OFF, atau LOW\r\n- 1 (satu) - mewakili TRUE, ON, atau HIGH\r\n\r\nSistem ini memiliki tiga operasi dasar:\r\n- AND (Γêº, ┬╖) - perkalian logika\r\n- OR (Γê¿, +) - penjumlahan logika\r\n- NOT (┬¼, ') - negasi/komplemen\r\n\r\n## Operasi Dasar dan Tabel Kebenaran\r\n\r\n### Operasi AND (Γêº)\r\nOperasi AND menghasilkan nilai 1 hanya jika kedua input bernilai 1.\r\n\r\n| A | B | A Γêº B |\r\n|---|---|-------|\r\n| 0 | 0 | 0     |\r\n| 0 | 1 | 0     |\r\n| 1 | 0 | 0     |\r\n| 1 | 1 | 1     |\r\n\r\n### Operasi OR (Γê¿)\r\nOperasi OR menghasilkan nilai 1 jika salah satu atau kedua input bernilai 1.\r\n\r\n| A | B | A Γê¿ B |\r\n|---|---|-------|\r\n| 0 | 0 | 0     |\r\n| 0 | 1 | 1     |\r\n| 1 | 0 | 1     |\r\n| 1 | 1 | 1     |\r\n\r\n### Operasi NOT (┬¼)\r\nOperasi NOT membalikkan nilai input.\r\n\r\n| A | ┬¼A |\r\n|---|-----|\r\n| 0 | 1   |\r\n| 1 | 0   |\r\n\r\n## Sifat-sifat Aljabar Boolean\r\n\r\n### 1. Sifat Identitas\r\n- **Identitas untuk AND**: A Γêº 1 = A\r\n- **Identitas untuk OR**: A Γê¿ 0 = A\r\n\r\n### 2. Sifat Nol dan Satu\r\n- **Nol untuk AND**: A Γêº 0 = 0\r\n- **Satu untuk OR**: A Γê¿ 1 = 1\r\n\r\n### 3. Sifat Involusi (Negasi Ganda)\r\n- ┬¼(┬¼A) = A\r\n\r\n### 4. Sifat Idempoten\r\n- A Γêº A = A\r\n- A Γê¿ A = A\r\n\r\n### 5. Sifat Komplemen\r\n- A Γêº ┬¼A = 0\r\n- A Γê¿ ┬¼A = 1\r\n\r\n### 6. Sifat Komutatif\r\n- A Γêº B = B Γêº A\r\n- A Γê¿ B = B Γê¿ A\r\n\r\n### 7. Sifat Asosiatif\r\n- (A Γêº B) Γêº C = A Γêº (B Γêº C)\r\n- (A Γê¿ B) Γê¿ C = A Γê¿ (B Γê¿ C)\r\n\r\n### 8. Sifat Distributif\r\n- A Γêº (B Γê¿ C) = (A Γêº B) Γê¿ (A Γêº C)\r\n- A Γê¿ (B Γêº C) = (A Γê¿ B) Γêº (A Γê¿ C)\r\n\r\n### 9. Hukum De Morgan\r\n- ┬¼(A Γêº B) = ┬¼A Γê¿ ┬¼B\r\n- ┬¼(A Γê¿ B) = ┬¼A Γêº ┬¼B\r\n\r\n### 10. Hukum Absorpsi\r\n- A Γê¿ (A Γêº B) = A\r\n- A Γêº (A Γê¿ B) = A\r\n\r\n## Aplikasi Aljabar Boolean\r\n\r\n### Dalam Rangkaian Digital\r\nAljabar Boolean menjadi dasar perancangan rangkaian digital seperti:\r\n- Gerbang logika (AND, OR, NOT, NAND, NOR, XOR)\r\n- Rangkaian kombinasional (multiplexer, decoder, adder)\r\n- Rangkaian sekuensial (flip-flop, register, counter)\r\n\r\n### Dalam Pemrograman Komputer\r\n- Operasi bit-level\r\n- Kondisi kontrol program (if-else statements)\r\n- Query database\r\n- Pemfilteran dan pencarian data\r\n\r\n### Dalam Teori Himpunan\r\n- Operasi himpunan (irisan, gabungan, komplemen)\r\n- Representasi relasi antar himpunan\r\n\r\n## Metode Penyederhanaan Ekspresi Boolean\r\n\r\n### 1. Metode Aljabar\r\nMenggunakan sifat-sifat aljabar Boolean untuk menyederhanakan ekspresi.\r\n\r\nContoh:\r\n```\r\nA┬╖B + A┬╖B╠ä = A┬╖(B + B╠ä) = A┬╖1 = A\r\n```\r\n\r\n### 2. Peta Karnaugh (K-Map)\r\nMetode visual untuk menyederhanakan fungsi Boolean dengan mengelompokkan istilah-istilah yang berdekatan.\r\n\r\n### 3. Metode Quine-McCluskey\r\nMetode tabular untuk meminimalkan fungsi Boolean, lebih sistematis daripada K-map untuk fungsi dengan banyak variabel.\r\n\r\n## Kesimpulan\r\n\r\nAljabar Boolean merupakan sistem matematika fundamental yang menjembatani logika abstrak dengan implementasi fisik dalam teknologi digital. Pemahaman yang baik tentang konsep dan sifat-sifat aljabar Boolean sangat penting dalam perancangan sistem digital, pemrograman, dan berbagai bidang komputasi lainnya.	1	1	2025-05-13 14:39:32.962091	2025-05-13 14:39:32.962091
4	2	1	Tes miger	Ambatunut	0	1	2025-05-13 15:38:43.246478	2025-05-13 15:38:43.246478
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.news (id, title, content, image_url, created_by, created_at, updated_at) FROM stdin;
10	TP3 KELUARRRRR !!!!!!!!	DEADLINE BESOK MALAM ATAU -100	http://res.cloudinary.com/dnkkk7pgw/image/upload/v1747245508/news/ouehd8mgdsuhvafvyajg.png	3	2025-05-14 17:58:29.40217	2025-05-14 17:58:29.40217
11	JOIN KELAS DSD	## JOIN ATAU -50 NILAI AKHIR MATKUL	http://res.cloudinary.com/dnkkk7pgw/image/upload/v1747247225/news/hcxae6fwhws8nkw1ostm.jpg	3	2025-05-14 18:27:06.486721	2025-05-14 18:27:06.486721
12	PRAKTIKAN JANGAN LUPA BELAJAR SBA	## ini modulnya	\N	3	2025-05-15 09:49:02.428297	2025-05-15 09:49:02.428297
\.


--
-- Data for Name: news_entities; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.news_entities (news_id, entity_type, entity_id) FROM stdin;
10	assignment	3
11	class	1
12	module	4
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.posts (id, user_id, content, image_url, created_at, updated_at) FROM stdin;
1	3	TEST	http://res.cloudinary.com/dnkkk7pgw/image/upload/v1747246945/posts/qmhgyzwlp9wk88opmr5r.jpg	2025-05-14 18:22:25.750821	2025-05-14 18:22:25.750821
2	3	Bang minta + 100 domg	http://res.cloudinary.com/dnkkk7pgw/image/upload/v1747410295/posts/isgdqdkzjiagbrkibo5u.jpg	2025-05-16 15:44:56.392178	2025-05-16 15:44:56.392178
3	2	Ini apa ya bang kok rasis banget sich, saya lapor ke dekanat ya	http://res.cloudinary.com/dnkkk7pgw/image/upload/v1747462584/posts/vcunm498bnjqpbzjyb0r.jpg	2025-05-17 06:16:25.409596	2025-05-17 06:16:25.409596
4	1	Bang ini kelasnya keknya masih belom ada materinya deh	http://res.cloudinary.com/dnkkk7pgw/image/upload/v1747464612/posts/dwzi8nnsjgpwejkydpp6.jpg	2025-05-17 06:50:12.578556	2025-05-17 06:50:12.578556
\.


--
-- Data for Name: posts_entities; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.posts_entities (posts_id, entity_type, entity_id) FROM stdin;
2	class	1
3	assignment	3
4	class	2
\.


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.submissions (id, assignment_id, user_id, content, file_url, submitted_at, updated_at) FROM stdin;
1	1	2	# Tugas Pendahuluan Modul 1 : Pengenalan Dasar Rangkaian Digital\r\n\r\nNama : Yolanda Vionida\r\nNPM    : 2406344290\r\n\r\n## Teori\r\n\r\n### **Jangan lupa untuk mencantumkan referensi dalam setiap pengerjaan soal (jawaban tanpa referensi hanya mendapatkan maksimal 50% dari bobot soal)**\r\n\r\n### 1. **Apa itu breadboard? Jelaskan bagaimana breadboard dapat menghantarkan arus! (10 poin)**\r\n\r\n**Jawaban:** Breadboard merupakan alat prototype rangkaian tanpa solder. Bentuknya menyerupai papan dengan lubang kecil saling terhubung. Lubang ini digunakan untuk nyambungin komponen elektronik. Breadboard digunakan untuk merancang, menguji, dan menghubungkan rangkaian elektronik dalam waktu sementara [1].\r\n\r\nreadboard ada 3 bagian, yaitu bagian atas, bagian bawah, dan bagian tengah breadboard.\r\n\r\n![breadboard 1](https://images.javatpoint.com/blog/images/breadboard2.png)\r\n\r\nBagian atas dan bawah breadboard terdapat lubang-lubang yang dapat menghubungkan rangkaian secara horizontal. Sedangkan, lubang pada bagian tengah breadboard dihubungkan secara vertikal [2].Artinya, setiap satu baris horizontal pada breadboard punya tempat sambungan yang sama. Begitu juga dengan baris vertikal. \r\n![breadboard 2](https://images.javatpoint.com/blog/images/breadboard3.png)\r\n\r\nBreadboard bisa menghantarkan arus listrik jika dihubungkan dengan sumber daya seperti baterai, power supply, maupun adaptor daya USB. Kabel kutub positif dari sumber daya perlu terhubung ke baris positif dan kabel negatif ke baris negatif breadboard. Saat memasukkan komponen, kakinya dimasukkan sepenuhnya ke dalam lubang dan menyentuh strip logam di dalam breadboard. Untuk menghubungkan antara baris dan breadboard, digunakan kabel jumper.\r\n\r\n#### Reference:\r\n\r\n- Available: [1] ΓÇ£Breadboard - Javatpoint,ΓÇ¥ www.javatpoint.com. https://www.javatpoint.com/breadboard\r\n- Available: [2] Science Buddies, ΓÇ£How to Use a Breadboard,ΓÇ¥ Science Buddies, 2019. https://www.sciencebuddies.org/science-fair-projects/references/how-to-use-a-breadboard\r\n- Available: [3] R. Ogle, ΓÇ£How Does a Breadboard Work?,ΓÇ¥ Electoviz, Jul. 04, 2024. https://electroviz.com/basic-electronics-concepts/how-does-a-breadboard-work (accessed Feb. 09, 2025).\r\nΓÇî\r\n\r\n### **2. Jelaskan apa yang dimaksud dengan VCC dan Ground, Dimana VCC dan Ground dihubungkan pada breadboard? (10 poin)**\r\n\r\n**Jawaban:** VCC atau Voltage Common Collecter adalah pin rangkaian elektronik. Fungsinya untuk menyuplai tegangan positif di rangkaian. VCC sering digunakan untuk menghubungkan catu daya ke BJT (bipolar junction transistor) di suatu rangkaian elektronik. Tujuannya suoaya sinyal bisa lebih mudah ditangani dan menjaga agar transistor berada pada fase konduksi. Pekerjaan rangkaian elektronik lebih efisien dalam menangani sinyal yang berasal dari input karena sumber tegangan VCC berada pada output transistor.\r\n\r\nGround adalah titik acuan tegangan 0 V dalam suatu rangkaian elektronik di mana suatu tegangan diukur.\r\nVCC dihubungkan pada jalur merah atau baris positif sedangkan ground dihubungkan pada jalur biru/hitam atau baris negatif breadbaord.\r\n\r\n![ground](https://www.allaboutcircuits.com/uploads/articles/Davis_ground_1.jpg)\r\n\r\n\r\n#### Reference:\r\n\r\n-  Available: [1] Electricalvolt, ΓÇ£VCC in Electronics,ΓÇ¥ Electrical Volt, Sep. 03, 2024. https://www.electricalvolt.com/what-does-vcc-mean-in-electronics/ (accessed Feb. 09, 2025).\r\n-  Available: [2] ΓÇ£What is Ground? Understanding the Foundation of Electrical Circuits - electrouniversity.com,ΓÇ¥ electrouniversity.com, Jun. 20, 2024. https://electrouniversity.com/what-is-ground/ (accessed Feb. 09, 2025).\r\nΓÇî\r\nΓÇî\r\n\r\n### **3. Jelaskan apa itu LED, serta jelaskan apa itu Anode dan Katode pada LED! (10 poin)**\r\n\r\n**Jawaban:** LED adalah contoh komponen elektronik yang bila dialiri arus listrik dapat memancarkan cahaya monokromatik. Warna yang dihasilkan juga tergantung pada jenis bahan semikonduktor yang digunakan dan panjang gelombang emisi cahayanya.\r\n\r\nAnoda sama artinya dengan  kutub positif kalau katoda adalah istilah lain kutub negatif. Arus listrik masuk lewat sisi positif (anoda) dan keluar melalui sisi negatif (katoda). Anoda berperan sebagai penyuplai elektron sedangkan katoda sebagai resistor elektron.\r\n\r\nPrinsip kerja LED mirip  dengan dioda yang lain, LED punya dua kutub yaitu kutub positif (P) dan kutub negatif (N). Saat tegangan mengalir pada LED dari Anoda atau kutub positif (P) menuju ke Katoda atau kutub negatif (N), kelebihan Elektron pada N-Type material akan berpindah ke yang kelebihan lubang yaitu yang bermuatan positif (P-Type material). Saat inilah, elektron mengenai lubang dan akan melepaskan photon dan memancarkan cahaya monokromatik (satu warna).\r\n\r\n![led](https://www.electrical4u.com/wp-content/uploads/What-is-a-LED.png?ezimgfmt=ng%3Awebp%2Fngcb38%2Frs%3Adevice%2Frscb38-1)\r\n\r\n#### Reference:\r\n\r\n-  Available: [1] Electrical4U, ΓÇ£Light emitting diode (LED): What is it & How Does it Work? | Electrical4U,ΓÇ¥ https://www.electrical4u.com/, Oct. 28, 2020. https://www.electrical4u.com/led-or-light-emitting-diode/\r\n- Available: [2] D. Kho, ΓÇ£Pengertian LED (Light Emitting Diode) dan Cara Kerja LED,ΓÇ¥ Teknik Elektronika, Dec. 08, 2014. https://teknikelektronika.com/pengertian-led-light-emitting-diode-cara-kerja/\r\n- Available:[3] TechGuru, ΓÇ£LED Anode vs Cathode - Difference Between and How to Identify,ΓÇ¥ Nerd Techy, Mar. 08, 2022. https://nerdtechy.com/led-anode-vs-cathode-difference\r\nΓÇî\r\n\r\n### **4. Jelaskan kegunaan resistor dalam suatu rangkaian. Apa yang terjadi bila resistor tidak digunakan pada komponen seperti LED? (10 poin)**\r\n\r\n**Jawaban:** \r\n![resistor](https://tse2.mm.bing.net/th?id=OIP.iGjI8DhElLz8P7cGNAJCNgHaEo&pid=Api&P=0&h=220)\r\nResistor adalah komponen listrik pasif yang bersifat menyerap energi. Resistor berfungsi untuk membatasi arus listrik dan mengatur tegangan yang mengalir dalam satu rangkaian dengan memberikan hambatan. Selain itu, resistor dapat berfungsi untuk melindungi komponen lain dan membagi tegangan.\r\n\r\nJika resistor tidak digunakan pada komponen seperti LED, maka arus listrik yang besar dan melebihi batas akan mengalir dan merusak komponen tersebut. Tegangan dan arus yang mengalir tidak stabil, juga pada efek panas berlebih yang berpotensi membakar komponen listrik.\r\n\r\n#### Reference:\r\n- Available: [1] ΓÇ£Resistor: Pengertian, Fungsi, dan Simbol dalam Elektronika,ΓÇ¥ ilmuteknik.id, Nov. 21, 2024. https://ilmuteknik.id/resistor-pengertian-fungsi-dan-simbol-dalam-elektronika/\r\n- Available: [2] Matan, ΓÇ£Apa Fungsi Resistor dalam Sebuah Rangkaian?,ΓÇ¥ Electricity - Magnetism, Aug. 17, 2024. https://www.electricity-magnetism.org/id/apa-fungsi-resistor-dalam-sebuah-rangkaian/\r\n-  Available: [3] https://www.facebook.com/supriyadi.pro, ΓÇ£Apa yang terjadi jika resistor rusak? | Tugassains Com,ΓÇ¥ Tugas Sains, Jan. 09, 2025. https://www.tugassains.com/2025/01/apa-yang-terjadi-jika-resistor-rusak.html (accessed Feb. 09, 2025).\r\nΓÇî\r\n\r\n### **5. Jelaskan apa yang dimaksud dengan IC! Contohkan kegunaan IC dengan menjelaskan tentang IC 7408 (10 poin)**\r\n\r\n**Jawaban:** IC (*Integrated Circuit*) adalah komponen elektronik yang bersifat aktif yang terdiri dari gabungan transistor, dioda, resistor dan kapasitor yang dibentuk menjadi suatu rangkaian elektronika dalam ukuran lebih kecil. Bahan utama untuk membentuk IC adalah bahan semikonduktor, misalnya silicon. \r\n\r\nIC dibagi menjadi tiga jenis klasifikasi, yaitu:\r\n\r\n1. TTL (Transistor Transistor Logic)\r\nIC TTL (Transistor Transistor Logic) adalah jenis IC digital yang banyak digunakan dalam  rangkaian elektronika. IC TTL menggunakan transistor sebagai komponen utamanya. Fungsi utama transistor sebagai pemicu variasi logis. IC TTL berfungsi untuk mengatur logika perangkat elektronik yang beroperasi dengan keadaan logis on dan off.\r\n3. IC-CMOS\r\nIC_CMOS atau *Complementary Metal-Oxide-Semiconductor*, adalah jenis IC digital yang memiliki karakteristik khusus. Pada IC-CMOS, penggunaan gelombang kotak digunakan dalam dua kondisi, yaitu 1 dan 0, yang berperan sebagai saklar. Fungsi utamanya sebagai gerbang logika.\r\n5. IC Linier\r\nFungsi utama IC linear untuk memperkuat tegangan. IC linear tidak berperan sebagai gerbang logika seperti IC digital. Jenis IC linear dirancang dengan rangkaian yang proporsional untuk menghasilkan output yang sebanding dengan inputnya.\r\n\r\nIC 7408 contoh jenis dari IC TTL (Transistor-Transistor Logic). IC 7408 terdiri dari 4 gerbang AND dua input, yang mana empat gerbang logika AND, masing-masing dengan dua input dan satu output. IC 7408 bisa digunakan untuk membuat sistem pengendali pada lampu indikator keamanan, gerbang logika dasar pada rangkaian, dll.\r\n\r\n#### Reference:\r\n\r\n- Available: [1] ΓÇ£Artikel TeknoBgt.com,ΓÇ¥ Kelas PLC, Sep. 27, 2023. https://www.kelasplc.com/pengertian-integrated-circuit-ic-dan-aplikasinya/\r\n- Available: [2] ΓÇ£IC Adalah: Pengertian, Fungsi, Jenis-jenis dan Contohnya,ΓÇ¥ ilmuteknik.id, Jan. 20, 2025. https://ilmuteknik.id/ic-adalah/\r\nΓÇî\r\n\r\n### **6. Apa itu datasheet ? Jelaskan bagian-bagian apa saja yang dapat ditemukan pada datasheet beserta isinya!** (10 poin)\r\n**Jawaban:** Data Sheet adalah dokumen mengenai rangkuman kinerja dan karakteristik lain komponen elektronik maupun sub-sistem seperti power supply, atau perangkat lunak yg cukup terinci untuk merancang komponen ke dalam sebuah sistem. Datasheet biasa digunakan sebagai referensi yang diciptakan oleh produsen untuk  memberikan informasi penting tentang produk atau layanan yang ditawarkan oleh perusahaan. dimulai dengan halaman pengantar yang menggambarkan keseluruhan dokumen,diikuti dengan daftar komponen tertentu, dengan informasi lebih lanjut tentang konektivitas perangkat. \r\n\r\nBagian-bagian yang dapat ditemukan pada data sheet dan isinya sebagai berikut:\r\n![Screenshot 2025-02-10 071821](https://hackmd.io/_uploads/rJGW86IFkx.png)\r\n\r\n\r\n#### Reference:\r\n\r\n- Available: [1] Moderator emiten.com, ΓÇ£Arti Penjelasan Istilah data sheet adalah,ΓÇ¥ Aplikasi Rekomendasi Riset Analisa Sinyal Saham Hari ini -, Sep. 06, 2022. https://emiten.com/info/arti-penjelasan-istilah-data-sheet-adalah/ (accessed Feb. 10, 2025).\r\nΓÇî\r\n\r\n## Praktik\r\n\r\nPada bagian ini anda akan mengikuti langkah-langkah untuk membuat sebuah rangkaian sederhana untuk menyalakan LED pada platform Tinkercad.\r\n\r\n1. Buatlah dan login pada akun <a href = https://www.tinkercad.com/>Tinkercad</a> atau login menggunakan akun Google.\r\n2. Navigasi ke **https://www.tinkercad.com/dashboard/designs/circuits** dan buatlah rangkaian baru dengan menggunakan menu **Create > Circuits**\r\n\r\n   ![1738932021072](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20194015.png)\r\n3. Letakkan sebuah breadboard dari bagian **Components**\r\n\r\n   ![1738932021072](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20194202.png)\r\n4. Gunakan component **Power Supply** sebagai sumber tegangan pada rangkaian\r\n\r\n   ![1738932359325](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20194554.png)\r\n5. Hubungkan power supply pada breadboard sesuai dengan jawaban soal teori no 2.\r\n6. Letakkan sebuah LED pada breadboard dan hubungkan Anode dengan bagian VCC breadboard dari breadboard. Anda dapat menghighlight kaki LED untuk mencari bagian anode. Posisi dari kabel dan LED pada breadboard dibebaskan.\r\n   ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20195720.png)\r\n7. Setelahnya, hubungkan katode dari LED dengan sebuah resistor. Hubungkan resistor tersebut ke bagian ground dari breadboard.\r\n   ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20200103.png)\r\n8. Tekan tombol **Start Simulation** untuk menjalankan rangkaian, pastikan LED menyala ketika simulasi dijalankan.\r\n   ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20200329.png)\r\n   ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20200427.png)\r\n9. Ubahlah warna dari kabel serta LED yang digunakan (dibebaskan), setelah itu ubahlah nama dari proyek Tinkercad yang dibuat menjadi NamaDepan_NPM.\r\n\r\n   ![1738933093993](https://raw.githubusercontent.com/lebit-L1X/FileDigilab/refs/heads/main/Screenshot%202025-02-07%20201101.png)\r\n\r\n   ### 10. **Jelaskan proses yang telah anda lakukan untuk menyalakan LED tersebut (Tidak perlu referensi) (20 poin)\r\n**Jawaban:**\r\n1. Power supply dihubungkan ke breadboard dengan cara menghubungkan kabel dari kutub positif power supply ke baris positif breadboard dan menghubungkan kabel kutub negatif power suppply ke baris negatif pada breadboard.\r\n2. Lampu LED yang sudah diambil dihubungkan anodanya (kaki panjang) ke salah satu kaki resistor. Lalu, katoda LED dihubungkan ke garis negatif breadboard.\r\n3. Kaki resistor yang satunya dihubungkan ke garis positif breadboard.\r\n4. Atur tegangan keluaran power supply dan besar hambatan. Di sini saya menggunakan tegangan sebesar 10 V dan hambatan sebesar 1 kilo ohm.\r\n5. Klik start simulation, maka lampu LED akan menyala.\r\n\r\n   ### 11. **Sertakan screenshot dari rangkaian yang telah anda buat dengan mengikuti langkah berikut (10 poin)**\r\n\r\n**Jawaban:** \r\n ### Screenshot Rangkaian :\r\n![Screenshot 2025-02-10 064017](https://hackmd.io/_uploads/SJNrpn8Kyg.png)\r\n\r\n\r\n   ### 12. Sertakan link dari file Tinkercad yang telah anda buat dengan mengikuti langkah berikut untuk memastikan file anda tidak bersifat Private (10 poin)\r\n**Jawaban:**\r\n### Link Rangkaian : https://www.tinkercad.com/things/1YwW0i1hDMM-yolanda-2406344290\r\n	["https://res.cloudinary.com/dnkkk7pgw/raw/upload/v1747150586/submissions/don7dsndlw6rbk27rdge"]	2025-05-13 15:36:26.757446	2025-05-13 15:36:26.757446
2	3	4	wdAWDASxazdsAWDaDAw	["http://res.cloudinary.com/dnkkk7pgw/raw/upload/v1747294581/submissions/ml5qithckriarvoyacjs"]	2025-05-15 07:36:22.151828	2025-05-15 07:36:22.151828
3	1	4	69	["http://res.cloudinary.com/dnkkk7pgw/raw/upload/v1747302331/submissions/e729v5l583fxnsjto7io"]	2025-05-15 09:45:32.319565	2025-05-15 09:45:32.319565
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: digilearn_owner
--

COPY public.users (id, username, email, password, role, created_at, updated_at, profile_image) FROM stdin;
2	DaffaSD	daffa.sayra.firdaus@gmail.com	$2b$10$T3OZ4mRe2WZDcLAfII6yLuMap3.gBhT7UzMV2ZYRcOKvCL2/dvqey	praktikan	2025-05-13 13:48:42.142291	2025-05-13 17:07:19.314282	https://res.cloudinary.com/dnkkk7pgw/image/upload/v1747156038/digilab/icf2bi4n93gxlujhzvbi.png
1	DaffaSMP	didi@gmail.com	$2b$10$YRl8S1LccxphpAxVRzM8hegb25YrqEypToP6YF5zZBPb3hBncXCFe	aslab	2025-05-13 13:46:19.683022	2025-05-13 17:12:16.792741	https://res.cloudinary.com/dnkkk7pgw/image/upload/v1747156335/digilab/b5og4iconxtu2hc6qpji.png
4	AlexStudent	alex@gmail.com	$2b$10$mCgsNeGQWnaFgoEHN0VVWuvMu7qF.h7/am7YrBwjJspPcVuZDu8oi	praktikan	2025-05-14 15:54:39.706641	2025-05-14 15:54:39.706641	\N
3	Alex	alexanderchristhian@gmail.com	$2b$10$wXPSJdsDm/kvfAdGUcokmO9UI/32dSqJ3BDdp0rVFXMtAobrZRdtC	aslab	2025-05-14 13:28:56.663641	2025-05-16 06:59:30.786229	https://res.cloudinary.com/dnkkk7pgw/image/upload/v1747378770/digilab/fhrpvmhgdgquuid39ty0.jpg
5	alextest	alex2@gmail.com	$2b$10$zCDDpNsCt0kcIkdAhzKmFuEAl6HEGiuoKWTdlr/5p1I5FGPUe0CS.	praktikan	2025-05-16 16:44:18.153048	2025-05-16 16:44:18.153048	\N
\.


--
-- Name: assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.assignments_id_seq', 4, true);


--
-- Name: class_enrollments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.class_enrollments_id_seq', 4, true);


--
-- Name: classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.classes_id_seq', 2, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.comments_id_seq', 5, true);


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.grades_id_seq', 2, true);


--
-- Name: module_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.module_files_id_seq', 9, true);


--
-- Name: module_folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.module_folders_id_seq', 2, true);


--
-- Name: modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.modules_id_seq', 4, true);


--
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.news_id_seq', 12, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.posts_id_seq', 4, true);


--
-- Name: submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.submissions_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digilearn_owner
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: assignments assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (id);


--
-- Name: class_enrollments class_enrollments_class_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.class_enrollments
    ADD CONSTRAINT class_enrollments_class_id_user_id_key UNIQUE (class_id, user_id);


--
-- Name: class_enrollments class_enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.class_enrollments
    ADD CONSTRAINT class_enrollments_pkey PRIMARY KEY (id);


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: grades grades_submission_id_key; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_submission_id_key UNIQUE (submission_id);


--
-- Name: module_files module_files_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.module_files
    ADD CONSTRAINT module_files_pkey PRIMARY KEY (id);


--
-- Name: module_folders module_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.module_folders
    ADD CONSTRAINT module_folders_pkey PRIMARY KEY (id);


--
-- Name: modules modules_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_pkey PRIMARY KEY (id);


--
-- Name: news_entities news_entities_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.news_entities
    ADD CONSTRAINT news_entities_pkey PRIMARY KEY (news_id, entity_type, entity_id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: posts_entities posts_entities_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.posts_entities
    ADD CONSTRAINT posts_entities_pkey PRIMARY KEY (posts_id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: submissions submissions_assignment_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_assignment_id_user_id_key UNIQUE (assignment_id, user_id);


--
-- Name: submissions submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: idx_grades_graded_by; Type: INDEX; Schema: public; Owner: digilearn_owner
--

CREATE INDEX idx_grades_graded_by ON public.grades USING btree (graded_by);


--
-- Name: idx_grades_submission_id; Type: INDEX; Schema: public; Owner: digilearn_owner
--

CREATE INDEX idx_grades_submission_id ON public.grades USING btree (submission_id);


--
-- Name: idx_news_entities_by_target; Type: INDEX; Schema: public; Owner: digilearn_owner
--

CREATE INDEX idx_news_entities_by_target ON public.news_entities USING btree (entity_type, entity_id);


--
-- Name: assignments assignments_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(id) ON DELETE CASCADE;


--
-- Name: assignments assignments_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: class_enrollments class_enrollments_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.class_enrollments
    ADD CONSTRAINT class_enrollments_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(id) ON DELETE CASCADE;


--
-- Name: class_enrollments class_enrollments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.class_enrollments
    ADD CONSTRAINT class_enrollments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: classes classes_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: comments comments_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: grades grades_graded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_graded_by_fkey FOREIGN KEY (graded_by) REFERENCES public.users(id);


--
-- Name: grades grades_submission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_submission_id_fkey FOREIGN KEY (submission_id) REFERENCES public.submissions(id) ON DELETE CASCADE;


--
-- Name: modules modules_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(id) ON DELETE CASCADE;


--
-- Name: modules modules_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: modules modules_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.modules
    ADD CONSTRAINT modules_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.module_folders(id) ON DELETE CASCADE;


--
-- Name: news news_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: news_entities news_entities_news_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.news_entities
    ADD CONSTRAINT news_entities_news_id_fkey FOREIGN KEY (news_id) REFERENCES public.news(id) ON DELETE CASCADE;


--
-- Name: posts_entities posts_entities_posts_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.posts_entities
    ADD CONSTRAINT posts_entities_posts_id_fkey FOREIGN KEY (posts_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: submissions submissions_assignment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_assignment_id_fkey FOREIGN KEY (assignment_id) REFERENCES public.assignments(id) ON DELETE CASCADE;


--
-- Name: submissions submissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: digilearn_owner
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

