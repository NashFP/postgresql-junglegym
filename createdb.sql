-- Database: enronmail

DROP DATABASE enronmail;

CREATE DATABASE enronmail
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
--       LC_COLLATE = 'English_United States.1252'
--       LC_CTYPE = 'English_United States.1252'
       CONNECTION LIMIT = -1;

\connect enronmail

-- Table: "mailbox"

-- DROP TABLE "mailbox";

CREATE TABLE "mailbox"
(
  "id" serial NOT NULL,
  "mailbox_name" character varying(50),
  CONSTRAINT pk_id PRIMARY KEY ("id" )
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "mailbox"
  OWNER TO postgres;


-- Table: "folder"

-- DROP TABLE "folder";

CREATE TABLE "folder"
(
  "id" serial NOT NULL,
  "mailbox_id" integer,
  "parent_folder_id" integer,
  "folder_name" character varying(100),
  CONSTRAINT pk_folder_id PRIMARY KEY ("id" ),
  CONSTRAINT fk_folder_mailbox_id_to_mailbox FOREIGN KEY ("mailbox_id")
      REFERENCES "mailbox" ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_folder_parent_folder_id_to_folder FOREIGN KEY ("parent_folder_id")
      REFERENCES "folder" ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "folder"
  OWNER TO postgres;

-- Index: fki_folder_parent_folder_id_to_folder

-- DROP INDEX fki_folder_parent_folder_id_to_folder;

CREATE INDEX fki_folder_parent_folder_id_to_folder
  ON "folder"
  USING btree
  ("parent_folder_id" );


-- Table: "message"

-- DROP TABLE "message";

CREATE TABLE "message"
(
  "id" serial NOT NULL,
  "parent_folder_id" integer,
  "message_body" text,
  "date" time with time zone,
  "subject" character varying(512),
  CONSTRAINT pk_message_id PRIMARY KEY ("id" ),
  CONSTRAINT fk_message_parent_folder_id_to_folder FOREIGN KEY ("parent_folder_id")
      REFERENCES "folder" ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "message"
  OWNER TO postgres;

-- Index: fki_message_parent_folder_id_to_folder

-- DROP INDEX fki_message_parent_folder_id_to_folder;

CREATE INDEX fki_message_parent_folder_id_to_folder
  ON "message"
  USING btree
  ("parent_folder_id" );

