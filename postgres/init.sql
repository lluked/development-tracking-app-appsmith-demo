CREATE USER development_app_user PASSWORD 'changeme';
CREATE DATABASE development_app_db;
GRANT ALL PRIVILEGES ON DATABASE development_app_db TO development_app_user;

\connect development_app_db development_app_user;

CREATE SCHEMA development_app_schema;

-- Ideas Table

CREATE SEQUENCE "development_app_schema"."ideas_id_seq" INCREMENT 1 MINVALUE 100 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "development_app_schema"."ideas" (
    "idea_id" integer DEFAULT nextval('"development_app_schema"."ideas_id_seq"') NOT NULL,
    "title" text,
    "description" text,
    "ignored" boolean,
    "ignored_by" text,
    "refinement_created" boolean,
    "author" text,
    "created" bigint,
    "last_updated" bigint,
    CONSTRAINT "ideas_pkey" PRIMARY KEY ("idea_id")
) WITH (oids = false);

-- Ideas Comments Table

CREATE SEQUENCE "development_app_schema"."idea_comment_id_seq" INCREMENT 1 MINVALUE 100 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "development_app_schema"."idea_comments" (
    "idea_comment_id" integer DEFAULT nextval('"development_app_schema"."idea_comment_id_seq"') NOT NULL,
    "idea_id" integer REFERENCES "development_app_schema"."ideas"(idea_id),
    "comment" text,
    "created" bigint,
    "editied" bigint,
    CONSTRAINT "idea_comment_pkey" PRIMARY KEY ("idea_comment_id")
) WITH (oids = false);

-- Refinement Table

CREATE SEQUENCE "development_app_schema"."refinement_id_seq" INCREMENT 1 MINVALUE 100 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "development_app_schema"."refinement" (
    "refinement_id" integer DEFAULT nextval('"development_app_schema"."refinement_id_seq"') NOT NULL,
    "idea_id" integer REFERENCES "development_app_schema"."ideas"(idea_id),
    "title" text,
    "notes" text,
    "author" text,
    "created" bigint,
    "last_updated" bigint,
    CONSTRAINT "refinement_pkey" PRIMARY KEY ("refinement_id")
) WITH (oids = false);

-- Development Table

CREATE SEQUENCE "development_app_schema"."development_id_seq" INCREMENT 1 MINVALUE 100 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "development_app_schema"."development" (
    "development_id" integer DEFAULT nextval('"development_app_schema"."development_id_seq"') NOT NULL,
    "refinement_id" integer REFERENCES "development_app_schema"."refinement"(refinement_id),
    "title" text,
    "notes" text,
    "author" text,
    "created" bigint,
    "last_updated" bigint,
    CONSTRAINT "development_pkey" PRIMARY KEY ("development_id")
) WITH (oids = false);

-- Testing Table

CREATE SEQUENCE "development_app_schema"."testing_id_seq" INCREMENT 1 MINVALUE 100 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "development_app_schema"."testing" (
    "testing_id" integer DEFAULT nextval('"development_app_schema"."testing_id_seq"') NOT NULL,
    "development_id" integer REFERENCES "development_app_schema"."development"(development_id),
    "title" text,
    "notes" text,
    "author" text,
    "created" bigint,
    "last_updated" bigint,
    CONSTRAINT "testing_pkey" PRIMARY KEY ("testing_id")
) WITH (oids = false);

--- Data

INSERT INTO "development_app_schema"."ideas" ("idea_id", "title", "description", "ignored", "ignored_by", "refinement_created", "author", "created", "last_updated") VALUES
(1, 'DNS Exfil', 'Detect DNS Exfil', NULL, NULL, NULL, 'Bob', 1699139938 , 1699139938),
(2, 'Bruteforce Attack', 'Detect Bruteforce Attack', NULL, NULL, NULL, 'Andy', 1699139938, 1699139938);

INSERT INTO "development_app_schema"."refinement" ("refinement_id", "idea_id", "title", "notes", "author", "created", "last_updated") VALUES
(1,	1, 'DNS Exfil', 'Not possible', 'Andy',	1699139938, 1699139938);

INSERT INTO "development_app_schema"."development" ("development_id", "refinement_id", "title", "notes", "author", "created", "last_updated") VALUES
(1,	1, 'Bruteforce Attack', 'Not possible', 'Andy', 1699139938, 1699139938);

INSERT INTO "development_app_schema"."testing" ("testing_id", "development_id", "title", "notes", "author", "created", "last_updated") VALUES
(1, 1, 'Bruteforce Attack', 'Not possible', 'Andy', 1699139938, 1699139938);
