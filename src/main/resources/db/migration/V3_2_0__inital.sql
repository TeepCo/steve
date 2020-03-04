--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

CREATE SCHEMA IF NOT EXISTS stevedb;

--
-- Name: stevedb; Type: SCHEMA; Schema: -; Owner: steve
--

ALTER SCHEMA stevedb OWNER TO steve;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: address; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.address (
                                 address_pk int NOT NULL,
                                 street character varying(1000),
                                 house_number character varying(255),
                                 zip_code character varying(255),
                                 city character varying(255),
                                 country character varying(255)
);


ALTER TABLE stevedb.address OWNER TO steve;

--
-- Name: address_address_pk_seq; Type: SEQUENCE; Schema: stevedb; Owner: steve
--

CREATE SEQUENCE stevedb.address_address_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stevedb.address_address_pk_seq OWNER TO steve;

--
-- Name: address_address_pk_seq; Type: SEQUENCE OWNED BY; Schema: stevedb; Owner: steve
--

ALTER SEQUENCE stevedb.address_address_pk_seq OWNED BY stevedb.address.address_pk;


--
-- Name: charge_box; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.charge_box (
                                    charge_box_pk int NOT NULL,
                                    charge_box_id character varying(255) NOT NULL,
                                    endpoint_address character varying(255),
                                    ocpp_protocol character varying(255),
                                    charge_point_vendor character varying(255),
                                    charge_point_model character varying(255),
                                    charge_point_serial_number character varying(255),
                                    charge_box_serial_number character varying(255),
                                    fw_version character varying(255),
                                    fw_update_status character varying(255),
                                    fw_update_timestamp timestamp,
                                    iccid character varying(255),
                                    imsi character varying(255),
                                    meter_type character varying(255),
                                    meter_serial_number character varying(255),
                                    diagnostics_status character varying(255),
                                    diagnostics_timestamp timestamp,
                                    last_heartbeat_timestamp timestamp,
                                    description text,
                                    note text,
                                    location_latitude numeric(11,8),
                                    location_longitude numeric(11,8),
                                    address_pk int,
                                    admin_address character varying(255),
                                    insert_connector_status_after_transaction_msg boolean DEFAULT true
);


ALTER TABLE stevedb.charge_box OWNER TO steve;

--
-- Name: charge_box_charge_box_pk_seq; Type: SEQUENCE; Schema: stevedb; Owner: steve
--

CREATE SEQUENCE stevedb.charge_box_charge_box_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stevedb.charge_box_charge_box_pk_seq OWNER TO steve;

--
-- Name: charge_box_charge_box_pk_seq; Type: SEQUENCE OWNED BY; Schema: stevedb; Owner: steve
--

ALTER SEQUENCE stevedb.charge_box_charge_box_pk_seq OWNED BY stevedb.charge_box.charge_box_pk;


--
-- Name: charging_profile; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.charging_profile (
                                          charging_profile_pk int NOT NULL,
                                          stack_level int NOT NULL,
                                          charging_profile_purpose character varying(255) NOT NULL,
                                          charging_profile_kind character varying(255) NOT NULL,
                                          recurrency_kind character varying(255),
                                          valid_from timestamp,
                                          valid_to timestamp,
                                          duration_in_seconds int,
                                          start_schedule timestamp,
                                          charging_rate_unit character varying(255) NOT NULL,
                                          min_charging_rate numeric(15,1),
                                          description character varying(255),
                                          note text
);


ALTER TABLE stevedb.charging_profile OWNER TO steve;

--
-- Name: charging_profile_charging_profile_pk_seq; Type: SEQUENCE; Schema: stevedb; Owner: steve
--

CREATE SEQUENCE stevedb.charging_profile_charging_profile_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stevedb.charging_profile_charging_profile_pk_seq OWNER TO steve;

--
-- Name: charging_profile_charging_profile_pk_seq; Type: SEQUENCE OWNED BY; Schema: stevedb; Owner: steve
--

ALTER SEQUENCE stevedb.charging_profile_charging_profile_pk_seq OWNED BY stevedb.charging_profile.charging_profile_pk;


--
-- Name: charging_schedule_period; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.charging_schedule_period (
                                                  charging_profile_pk int NOT NULL,
                                                  start_period_in_seconds int NOT NULL,
                                                  power_limit_in_amperes numeric(15,1) NOT NULL,
                                                  number_phases int
);


ALTER TABLE stevedb.charging_schedule_period OWNER TO steve;

--
-- Name: connector; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.connector (
                                   connector_pk int NOT NULL,
                                   charge_box_id character varying(255) NOT NULL,
                                   connector_id int NOT NULL
);


ALTER TABLE stevedb.connector OWNER TO steve;

--
-- Name: connector_charging_profile; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.connector_charging_profile (
                                                    connector_pk int NOT NULL,
                                                    charging_profile_pk int NOT NULL
);


ALTER TABLE stevedb.connector_charging_profile OWNER TO steve;

--
-- Name: connector_connector_pk_seq; Type: SEQUENCE; Schema: stevedb; Owner: steve
--

CREATE SEQUENCE stevedb.connector_connector_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stevedb.connector_connector_pk_seq OWNER TO steve;

--
-- Name: connector_connector_pk_seq; Type: SEQUENCE OWNED BY; Schema: stevedb; Owner: steve
--

ALTER SEQUENCE stevedb.connector_connector_pk_seq OWNED BY stevedb.connector.connector_pk;


--
-- Name: connector_meter_value; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.connector_meter_value (
                                               connector_pk int NOT NULL,
                                               transaction_pk int,
                                               value_timestamp timestamp,
                                               value character varying(255),
                                               reading_context character varying(255),
                                               format character varying(255),
                                               measurand character varying(255),
                                               location character varying(255),
                                               unit character varying(255),
                                               phase character varying(255)
);


ALTER TABLE stevedb.connector_meter_value OWNER TO steve;

--
-- Name: connector_status; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.connector_status (
                                          connector_pk int NOT NULL,
                                          status_timestamp timestamp,
                                          status character varying(255),
                                          error_code character varying(255),
                                          error_info character varying(255),
                                          vendor_id character varying(255),
                                          vendor_error_code character varying(255)
);


ALTER TABLE stevedb.connector_status OWNER TO steve;

--
-- Name: ocpp_tag; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.ocpp_tag (
                                  ocpp_tag_pk int NOT NULL,
                                  id_tag character varying(255) NOT NULL,
                                  parent_id_tag character varying(255),
                                  expiry_date timestamp,
                                  in_transaction boolean NOT NULL DEFAULT FALSE,
                                  blocked boolean NOT NULL,
                                  note text
);


ALTER TABLE stevedb.ocpp_tag OWNER TO steve;

--
-- Name: ocpp_tag_ocpp_tag_pk_seq; Type: SEQUENCE; Schema: stevedb; Owner: steve
--

CREATE SEQUENCE stevedb.ocpp_tag_ocpp_tag_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stevedb.ocpp_tag_ocpp_tag_pk_seq OWNER TO steve;

--
-- Name: ocpp_tag_ocpp_tag_pk_seq; Type: SEQUENCE OWNED BY; Schema: stevedb; Owner: steve
--

ALTER SEQUENCE stevedb.ocpp_tag_ocpp_tag_pk_seq OWNED BY stevedb.ocpp_tag.ocpp_tag_pk;


--
-- Name: reservation; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.reservation (
                                     reservation_pk int NOT NULL,
                                     connector_pk int NOT NULL,
                                     transaction_pk int,
                                     id_tag character varying(255) NOT NULL,
                                     start_datetime timestamp,
                                     expiry_datetime timestamp,
                                     status character varying(255) NOT NULL
);


ALTER TABLE stevedb.reservation OWNER TO steve;

--
-- Name: reservation_reservation_pk_seq; Type: SEQUENCE; Schema: stevedb; Owner: steve
--

CREATE SEQUENCE stevedb.reservation_reservation_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stevedb.reservation_reservation_pk_seq OWNER TO steve;

--
-- Name: reservation_reservation_pk_seq; Type: SEQUENCE OWNED BY; Schema: stevedb; Owner: steve
--

ALTER SEQUENCE stevedb.reservation_reservation_pk_seq OWNED BY stevedb.reservation.reservation_pk;


-- ALTER TABLE stevedb.schema_version OWNER TO steve;

--
-- Name: settings; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.settings (
                                  app_id character varying(40) NOT NULL,
                                  heartbeat_interval_in_seconds int,
                                  hours_to_expire int,
                                  mail_enabled boolean DEFAULT false,
                                  mail_host character varying(255),
                                  mail_username character varying(255),
                                  mail_password character varying(255),
                                  mail_from character varying(255),
                                  mail_protocol character varying(255) DEFAULT 'smtp'::character varying,
                                  mail_port int DEFAULT '25'::int,
                                  mail_recipients text,
                                  notification_features text
);

INSERT INTO stevedb.settings (app_id, heartbeat_interval_in_seconds, hours_to_expire, mail_enabled, mail_host, mail_username, mail_password, mail_from, mail_protocol, mail_port, mail_recipients, notification_features)
VALUES ('U3RlY2tkb3NlblZlcndhbHR1bmc=', 14400, 1, false, null, null, null, null, 'smtp', 25, null, null);

ALTER TABLE stevedb.settings OWNER TO steve;

--
-- Name: COLUMN settings.mail_recipients; Type: COMMENT; Schema: stevedb; Owner: steve
--

COMMENT ON COLUMN stevedb.settings.mail_recipients IS 'comma separated list of email addresses';


--
-- Name: COLUMN settings.notification_features; Type: COMMENT; Schema: stevedb; Owner: steve
--

COMMENT ON COLUMN stevedb.settings.notification_features IS 'comma separated list';


--
-- Name: transaction; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb.transaction (
                                     transaction_pk int NOT NULL,
                                     connector_pk int NOT NULL,
                                     id_tag character varying(255) NOT NULL,
                                     start_timestamp timestamp,
                                     start_value character varying(255),
                                     stop_timestamp timestamp,
                                     stop_value character varying(255),
                                     stop_reason character varying(255)
);


ALTER TABLE stevedb.transaction OWNER TO steve;

--
-- Name: transaction_transaction_pk_seq; Type: SEQUENCE; Schema: stevedb; Owner: steve
--

CREATE SEQUENCE stevedb.transaction_transaction_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stevedb.transaction_transaction_pk_seq OWNER TO steve;

--
-- Name: transaction_transaction_pk_seq; Type: SEQUENCE OWNED BY; Schema: stevedb; Owner: steve
--

ALTER SEQUENCE stevedb.transaction_transaction_pk_seq OWNED BY stevedb.transaction.transaction_pk;


--
-- Name: user; Type: TABLE; Schema: stevedb; Owner: steve
--

CREATE TABLE stevedb."user" (
                                user_pk int NOT NULL,
                                ocpp_tag_pk int,
                                address_pk int,
                                first_name character varying(255),
                                last_name character varying(255),
                                birth_day date,
                                sex character(1),
                                phone character varying(255),
                                e_mail character varying(255),
                                note text
);


ALTER TABLE stevedb."user" OWNER TO steve;

--
-- Name: user_user_pk_seq; Type: SEQUENCE; Schema: stevedb; Owner: steve
--

CREATE SEQUENCE stevedb.user_user_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE stevedb.user_user_pk_seq OWNER TO steve;

--
-- Name: user_user_pk_seq; Type: SEQUENCE OWNED BY; Schema: stevedb; Owner: steve
--

ALTER SEQUENCE stevedb.user_user_pk_seq OWNED BY stevedb."user".user_pk;


--
-- Name: address address_pk; Type: DEFAULT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.address ALTER COLUMN address_pk SET DEFAULT nextval('stevedb.address_address_pk_seq'::regclass);


--
-- Name: charge_box charge_box_pk; Type: DEFAULT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.charge_box ALTER COLUMN charge_box_pk SET DEFAULT nextval('stevedb.charge_box_charge_box_pk_seq'::regclass);


--
-- Name: charging_profile charging_profile_pk; Type: DEFAULT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.charging_profile ALTER COLUMN charging_profile_pk SET DEFAULT nextval('stevedb.charging_profile_charging_profile_pk_seq'::regclass);


--
-- Name: connector connector_pk; Type: DEFAULT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.connector ALTER COLUMN connector_pk SET DEFAULT nextval('stevedb.connector_connector_pk_seq'::regclass);


--
-- Name: ocpp_tag ocpp_tag_pk; Type: DEFAULT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.ocpp_tag ALTER COLUMN ocpp_tag_pk SET DEFAULT nextval('stevedb.ocpp_tag_ocpp_tag_pk_seq'::regclass);


--
-- Name: reservation reservation_pk; Type: DEFAULT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.reservation ALTER COLUMN reservation_pk SET DEFAULT nextval('stevedb.reservation_reservation_pk_seq'::regclass);


--
-- Name: transaction transaction_pk; Type: DEFAULT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.transaction ALTER COLUMN transaction_pk SET DEFAULT nextval('stevedb.transaction_transaction_pk_seq'::regclass);


--
-- Name: user user_pk; Type: DEFAULT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb."user" ALTER COLUMN user_pk SET DEFAULT nextval('stevedb.user_user_pk_seq'::regclass);


--
-- Name: address_address_pk_seq; Type: SEQUENCE SET; Schema: stevedb; Owner: steve
--

SELECT pg_catalog.setval('stevedb.address_address_pk_seq', 1, true);


--
-- Name: charge_box_charge_box_pk_seq; Type: SEQUENCE SET; Schema: stevedb; Owner: steve
--

SELECT pg_catalog.setval('stevedb.charge_box_charge_box_pk_seq', 1, true);


--
-- Name: charging_profile_charging_profile_pk_seq; Type: SEQUENCE SET; Schema: stevedb; Owner: steve
--

SELECT pg_catalog.setval('stevedb.charging_profile_charging_profile_pk_seq', 1, true);


--
-- Name: connector_connector_pk_seq; Type: SEQUENCE SET; Schema: stevedb; Owner: steve
--

SELECT pg_catalog.setval('stevedb.connector_connector_pk_seq', 1, true);


--
-- Name: ocpp_tag_ocpp_tag_pk_seq; Type: SEQUENCE SET; Schema: stevedb; Owner: steve
--

SELECT pg_catalog.setval('stevedb.ocpp_tag_ocpp_tag_pk_seq', 1, true);


--
-- Name: reservation_reservation_pk_seq; Type: SEQUENCE SET; Schema: stevedb; Owner: steve
--

SELECT pg_catalog.setval('stevedb.reservation_reservation_pk_seq', 1, true);


--
-- Name: transaction_transaction_pk_seq; Type: SEQUENCE SET; Schema: stevedb; Owner: steve
--

SELECT pg_catalog.setval('stevedb.transaction_transaction_pk_seq', 1, true);


--
-- Name: user_user_pk_seq; Type: SEQUENCE SET; Schema: stevedb; Owner: steve
--

SELECT pg_catalog.setval('stevedb.user_user_pk_seq', 1, true);


--
-- Name: address idx_17364_primary; Type: CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.address
    ADD CONSTRAINT idx_17364_primary PRIMARY KEY (address_pk);


--
-- Name: charge_box idx_17373_primary; Type: CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.charge_box
    ADD CONSTRAINT idx_17373_primary PRIMARY KEY (charge_box_pk);


--
-- Name: charging_profile idx_17383_primary; Type: CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.charging_profile
    ADD CONSTRAINT idx_17383_primary PRIMARY KEY (charging_profile_pk);


--
-- Name: connector idx_17395_primary; Type: CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.connector
    ADD CONSTRAINT idx_17395_primary PRIMARY KEY (connector_pk);


--
-- Name: ocpp_tag idx_17416_primary; Type: CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.ocpp_tag
    ADD CONSTRAINT idx_17416_primary PRIMARY KEY (ocpp_tag_pk);


--
-- Name: reservation idx_17425_primary; Type: CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.reservation
    ADD CONSTRAINT idx_17425_primary PRIMARY KEY (reservation_pk);


--
-- Name: settings idx_17439_primary; Type: CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.settings
    ADD CONSTRAINT idx_17439_primary PRIMARY KEY (app_id);


--
-- Name: transaction idx_17450_primary; Type: CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.transaction
    ADD CONSTRAINT idx_17450_primary PRIMARY KEY (transaction_pk);


--
-- Name: user idx_17459_primary; Type: CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb."user"
    ADD CONSTRAINT idx_17459_primary PRIMARY KEY (user_pk);


--
-- Name: idx_17373_chargebox_op_ep_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17373_chargebox_op_ep_idx ON stevedb.charge_box USING btree (ocpp_protocol, endpoint_address);


--
-- Name: idx_17373_chargeboxid_unique; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE UNIQUE INDEX idx_17373_chargeboxid_unique ON stevedb.charge_box USING btree (charge_box_id);


--
-- Name: idx_17373_fk_charge_box_address_apk; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17373_fk_charge_box_address_apk ON stevedb.charge_box USING btree (address_pk);


--
-- Name: idx_17390_uq_charging_schedule_period; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE UNIQUE INDEX idx_17390_uq_charging_schedule_period ON stevedb.charging_schedule_period USING btree (charging_profile_pk, start_period_in_seconds);


--
-- Name: idx_17395_connector_cbid_cid_unique; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE UNIQUE INDEX idx_17395_connector_cbid_cid_unique ON stevedb.connector USING btree (charge_box_id, connector_id);


--
-- Name: idx_17395_connector_pk_unique; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE UNIQUE INDEX idx_17395_connector_pk_unique ON stevedb.connector USING btree (connector_pk);


--
-- Name: idx_17399_fk_connector_charging_profile_charging_profile_pk; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17399_fk_connector_charging_profile_charging_profile_pk ON stevedb.connector_charging_profile USING btree (charging_profile_pk);


--
-- Name: idx_17399_uq_connector_charging_profile; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE UNIQUE INDEX idx_17399_uq_connector_charging_profile ON stevedb.connector_charging_profile USING btree (connector_pk, charging_profile_pk);


--
-- Name: idx_17402_cmv_value_timestamp_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17402_cmv_value_timestamp_idx ON stevedb.connector_meter_value USING btree (value_timestamp);


--
-- Name: idx_17402_fk_cm_pk_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17402_fk_cm_pk_idx ON stevedb.connector_meter_value USING btree (connector_pk);


--
-- Name: idx_17402_fk_tid_cm_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17402_fk_tid_cm_idx ON stevedb.connector_meter_value USING btree (transaction_pk);


--
-- Name: idx_17408_connector_status_cpk_st_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17408_connector_status_cpk_st_idx ON stevedb.connector_status USING btree (connector_pk, status_timestamp);


--
-- Name: idx_17408_fk_cs_pk_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17408_fk_cs_pk_idx ON stevedb.connector_status USING btree (connector_pk);


--
-- Name: idx_17416_fk_ocpp_tag_parent_id_tag; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17416_fk_ocpp_tag_parent_id_tag ON stevedb.ocpp_tag USING btree (parent_id_tag);


--
-- Name: idx_17416_idtag_unique; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE UNIQUE INDEX idx_17416_idtag_unique ON stevedb.ocpp_tag USING btree (id_tag);


--
-- Name: idx_17416_user_blocked_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17416_user_blocked_idx ON stevedb.ocpp_tag USING btree (blocked);


--
-- Name: idx_17416_user_expirydate_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17416_user_expirydate_idx ON stevedb.ocpp_tag USING btree (expiry_date);


--
-- Name: idx_17416_user_intransaction_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17416_user_intransaction_idx ON stevedb.ocpp_tag USING btree (in_transaction);


--
-- Name: idx_17425_fk_connector_pk_reserv_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17425_fk_connector_pk_reserv_idx ON stevedb.reservation USING btree (connector_pk);


--
-- Name: idx_17425_fk_idtag_r_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17425_fk_idtag_r_idx ON stevedb.reservation USING btree (id_tag);


--
-- Name: idx_17425_reservation_expiry_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17425_reservation_expiry_idx ON stevedb.reservation USING btree (expiry_datetime);


--
-- Name: idx_17425_reservation_pk_unique; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE UNIQUE INDEX idx_17425_reservation_pk_unique ON stevedb.reservation USING btree (reservation_pk);


--
-- Name: idx_17425_reservation_start_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17425_reservation_start_idx ON stevedb.reservation USING btree (start_datetime);


--
-- Name: idx_17425_reservation_status_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17425_reservation_status_idx ON stevedb.reservation USING btree (status);


--
-- Name: idx_17425_transaction_pk_unique; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE UNIQUE INDEX idx_17425_transaction_pk_unique ON stevedb.reservation USING btree (transaction_pk);


--
-- Name: idx_17439_settings_id_unique; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE UNIQUE INDEX idx_17439_settings_id_unique ON stevedb.settings USING btree (app_id);


--
-- Name: idx_17450_connector_pk_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17450_connector_pk_idx ON stevedb.transaction USING btree (connector_pk);


--
-- Name: idx_17450_idtag_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17450_idtag_idx ON stevedb.transaction USING btree (id_tag);


--
-- Name: idx_17450_transaction_pk_unique; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE UNIQUE INDEX idx_17450_transaction_pk_unique ON stevedb.transaction USING btree (transaction_pk);


--
-- Name: idx_17450_transaction_start_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17450_transaction_start_idx ON stevedb.transaction USING btree (start_timestamp);


--
-- Name: idx_17450_transaction_stop_idx; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17450_transaction_stop_idx ON stevedb.transaction USING btree (stop_timestamp);


--
-- Name: idx_17459_fk_user_address_apk; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17459_fk_user_address_apk ON stevedb."user" USING btree (address_pk);


--
-- Name: idx_17459_fk_user_ocpp_tag_otpk; Type: INDEX; Schema: stevedb; Owner: steve
--

CREATE INDEX idx_17459_fk_user_ocpp_tag_otpk ON stevedb."user" USING btree (ocpp_tag_pk);


--
-- Name: charge_box fk_charge_box_address_apk; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.charge_box
    ADD CONSTRAINT fk_charge_box_address_apk FOREIGN KEY (address_pk) REFERENCES stevedb.address(address_pk) ON DELETE SET NULL;


--
-- Name: charging_schedule_period fk_charging_schedule_period_charging_profile_pk; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.charging_schedule_period
    ADD CONSTRAINT fk_charging_schedule_period_charging_profile_pk FOREIGN KEY (charging_profile_pk) REFERENCES stevedb.charging_profile(charging_profile_pk) ON DELETE CASCADE;


--
-- Name: connector fk_connector_charge_box_cbid; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.connector
    ADD CONSTRAINT fk_connector_charge_box_cbid FOREIGN KEY (charge_box_id) REFERENCES stevedb.charge_box(charge_box_id) ON DELETE CASCADE;


--
-- Name: connector_charging_profile fk_connector_charging_profile_charging_profile_pk; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.connector_charging_profile
    ADD CONSTRAINT fk_connector_charging_profile_charging_profile_pk FOREIGN KEY (charging_profile_pk) REFERENCES stevedb.charging_profile(charging_profile_pk);


--
-- Name: connector_charging_profile fk_connector_charging_profile_connector_pk; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.connector_charging_profile
    ADD CONSTRAINT fk_connector_charging_profile_connector_pk FOREIGN KEY (connector_pk) REFERENCES stevedb.connector(connector_pk) ON DELETE CASCADE;


--
-- Name: reservation fk_connector_pk_reserv; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.reservation
    ADD CONSTRAINT fk_connector_pk_reserv FOREIGN KEY (connector_pk) REFERENCES stevedb.connector(connector_pk) ON DELETE CASCADE;


--
-- Name: transaction fk_connector_pk_t; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.transaction
    ADD CONSTRAINT fk_connector_pk_t FOREIGN KEY (connector_pk) REFERENCES stevedb.connector(connector_pk) ON DELETE CASCADE;


--
-- Name: connector_status fk_cs_pk; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.connector_status
    ADD CONSTRAINT fk_cs_pk FOREIGN KEY (connector_pk) REFERENCES stevedb.connector(connector_pk) ON DELETE CASCADE;


--
-- Name: ocpp_tag fk_ocpp_tag_parent_id_tag; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.ocpp_tag
    ADD CONSTRAINT fk_ocpp_tag_parent_id_tag FOREIGN KEY (parent_id_tag) REFERENCES stevedb.ocpp_tag(id_tag);


--
-- Name: connector_meter_value fk_pk_cm; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.connector_meter_value
    ADD CONSTRAINT fk_pk_cm FOREIGN KEY (connector_pk) REFERENCES stevedb.connector(connector_pk) ON DELETE CASCADE;


--
-- Name: reservation fk_reservation_ocpp_tag_id_tag; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.reservation
    ADD CONSTRAINT fk_reservation_ocpp_tag_id_tag FOREIGN KEY (id_tag) REFERENCES stevedb.ocpp_tag(id_tag) ON DELETE CASCADE;


--
-- Name: connector_meter_value fk_tid_cm; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.connector_meter_value
    ADD CONSTRAINT fk_tid_cm FOREIGN KEY (transaction_pk) REFERENCES stevedb.transaction(transaction_pk) ON DELETE SET NULL;


--
-- Name: transaction fk_transaction_ocpp_tag_id_tag; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.transaction
    ADD CONSTRAINT fk_transaction_ocpp_tag_id_tag FOREIGN KEY (id_tag) REFERENCES stevedb.ocpp_tag(id_tag) ON DELETE CASCADE;


--
-- Name: reservation fk_transaction_pk_r; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb.reservation
    ADD CONSTRAINT fk_transaction_pk_r FOREIGN KEY (transaction_pk) REFERENCES stevedb.transaction(transaction_pk);


--
-- Name: user fk_user_address_apk; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb."user"
    ADD CONSTRAINT fk_user_address_apk FOREIGN KEY (address_pk) REFERENCES stevedb.address(address_pk) ON DELETE SET NULL;


--
-- Name: user fk_user_ocpp_tag_otpk; Type: FK CONSTRAINT; Schema: stevedb; Owner: steve
--

ALTER TABLE ONLY stevedb."user"
    ADD CONSTRAINT fk_user_ocpp_tag_otpk FOREIGN KEY (ocpp_tag_pk) REFERENCES stevedb.ocpp_tag(ocpp_tag_pk) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

