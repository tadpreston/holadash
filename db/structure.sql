--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- Name: portal_dictionary; Type: TEXT SEARCH DICTIONARY; Schema: public; Owner: -
--

CREATE TEXT SEARCH DICTIONARY portal_dictionary (
    TEMPLATE = pg_catalog.simple );


--
-- Name: portal_fts; Type: TEXT SEARCH CONFIGURATION; Schema: public; Owner: -
--

CREATE TEXT SEARCH CONFIGURATION portal_fts (
    PARSER = pg_catalog."default" );

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR asciiword WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR word WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR numword WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR email WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR url WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR host WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR sfloat WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR version WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR hword_numpart WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR hword_part WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR hword_asciipart WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR numhword WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR asciihword WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR hword WITH english_stem;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR url_path WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR file WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR "float" WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR "int" WITH simple;

ALTER TEXT SEARCH CONFIGURATION portal_fts
    ADD MAPPING FOR uint WITH simple;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: club_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE club_users (
    id integer NOT NULL,
    club_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: club_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE club_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: club_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE club_users_id_seq OWNED BY club_users.id;


--
-- Name: clubs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE clubs (
    id integer NOT NULL,
    name character varying(255),
    region_id integer,
    address text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: clubs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE clubs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: clubs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE clubs_id_seq OWNED BY clubs.id;


--
-- Name: envelopes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE envelopes (
    id integer NOT NULL,
    message_id integer,
    recipient_id integer,
    read_flag boolean DEFAULT false,
    trash_flag boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: envelopes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE envelopes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: envelopes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE envelopes_id_seq OWNED BY envelopes.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE messages (
    id integer NOT NULL,
    author_id integer,
    send_to character varying(255),
    copy_to character varying(255),
    blind_copy_to character varying(255),
    subject character varying(255),
    body text,
    status character varying(255) DEFAULT 'draft'::character varying,
    importance character varying(255) DEFAULT 'normal'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    sent_at timestamp without time zone
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE regions (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE regions_id_seq OWNED BY regions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sys_logs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_logs (
    id integer NOT NULL,
    message text,
    message_type character varying(255),
    actioned_by character varying(255),
    loggable_id integer,
    loggable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sys_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sys_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: sys_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sys_logs_id_seq OWNED BY sys_logs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(255),
    email character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    password_digest character varying(255),
    roles character varying(255),
    employee_id character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    password_reset_token character varying(255),
    password_reset_sent_at timestamp without time zone,
    auth_token character varying(255),
    display_name character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY club_users ALTER COLUMN id SET DEFAULT nextval('club_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY clubs ALTER COLUMN id SET DEFAULT nextval('clubs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY envelopes ALTER COLUMN id SET DEFAULT nextval('envelopes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY regions ALTER COLUMN id SET DEFAULT nextval('regions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sys_logs ALTER COLUMN id SET DEFAULT nextval('sys_logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: club_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY club_users
    ADD CONSTRAINT club_users_pkey PRIMARY KEY (id);


--
-- Name: clubs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clubs
    ADD CONSTRAINT clubs_pkey PRIMARY KEY (id);


--
-- Name: envelopes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY envelopes
    ADD CONSTRAINT envelopes_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: sys_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_logs
    ADD CONSTRAINT sys_logs_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_envelopes_on_message_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_envelopes_on_message_id ON envelopes USING btree (message_id);


--
-- Name: index_envelopes_on_recipient_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_envelopes_on_recipient_id ON envelopes USING btree (recipient_id);


--
-- Name: index_messages_on_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_author_id ON messages USING btree (author_id);


--
-- Name: index_messages_on_sent_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_sent_at ON messages USING btree (sent_at);


--
-- Name: index_messages_on_subject; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_subject ON messages USING btree (subject);


--
-- Name: index_sys_logs_on_loggable_id_and_loggable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sys_logs_on_loggable_id_and_loggable_type ON sys_logs USING btree (loggable_id, loggable_type);


--
-- Name: index_users_on_display_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_display_name ON users USING btree (display_name);


--
-- Name: index_users_on_employee_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_employee_id ON users USING btree (employee_id);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: users_first_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX users_first_name ON users USING gin (to_tsvector('english'::regconfig, (first_name)::text));


--
-- Name: users_last_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX users_last_name ON users USING gin (to_tsvector('english'::regconfig, (last_name)::text));


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20120606023927');

INSERT INTO schema_migrations (version) VALUES ('20120607012123');

INSERT INTO schema_migrations (version) VALUES ('20120607012255');

INSERT INTO schema_migrations (version) VALUES ('20120607015043');

INSERT INTO schema_migrations (version) VALUES ('20120608160237');

INSERT INTO schema_migrations (version) VALUES ('20120608172711');

INSERT INTO schema_migrations (version) VALUES ('20120616205029');

INSERT INTO schema_migrations (version) VALUES ('20120702164046');

INSERT INTO schema_migrations (version) VALUES ('20120703180649');

INSERT INTO schema_migrations (version) VALUES ('20120704213432');

INSERT INTO schema_migrations (version) VALUES ('20120709211033');

INSERT INTO schema_migrations (version) VALUES ('20120710195839');

INSERT INTO schema_migrations (version) VALUES ('20120712163914');