-- Database: enronmail

DROP DATABASE enronmail;

CREATE DATABASE enronmail
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'English_United States.1252'
       LC_CTYPE = 'English_United States.1252'
       CONNECTION LIMIT = -1;

-- Table: "Mailbox"

-- DROP TABLE "Mailbox";

CREATE TABLE "Mailbox"
(
  "Id" serial NOT NULL,
  "MailboxName" character varying(50),
  CONSTRAINT pk_id PRIMARY KEY ("Id" )
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mailbox"
  OWNER TO postgres;


-- Table: "Folder"

-- DROP TABLE "Folder";

CREATE TABLE "Folder"
(
  "Id" serial NOT NULL,
  "MailboxId" integer,
  "ParentFolderId" integer,
  "FolderName" character varying(100),
  CONSTRAINT pk_folder_id PRIMARY KEY ("Id" ),
  CONSTRAINT fk_folder_mailboxid_to_mailbox FOREIGN KEY ("MailboxId")
      REFERENCES "Mailbox" ("Id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_folder_parentfolderid_to_folder FOREIGN KEY ("ParentFolderId")
      REFERENCES "Folder" ("Id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Folder"
  OWNER TO postgres;

-- Index: fki_folder_parentfolderid_to_folder

-- DROP INDEX fki_folder_parentfolderid_to_folder;

CREATE INDEX fki_folder_parentfolderid_to_folder
  ON "Folder"
  USING btree
  ("ParentFolderId" );


-- Table: "Message"

-- DROP TABLE "Message";

CREATE TABLE "Message"
(
  "Id" serial NOT NULL,
  "ParentFolderId" integer,
  "MessageBody" text,
  "Date" time with time zone,
  "Subject" character varying(512),
  CONSTRAINT pk_message_id PRIMARY KEY ("Id" ),
  CONSTRAINT fk_message_parentfolderid_to_folder FOREIGN KEY ("ParentFolderId")
      REFERENCES "Folder" ("Id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Message"
  OWNER TO postgres;

-- Index: fki_message_parentfolderid_to_folder

-- DROP INDEX fki_message_parentfolderid_to_folder;

CREATE INDEX fki_message_parentfolderid_to_folder
  ON "Message"
  USING btree
  ("ParentFolderId" );

