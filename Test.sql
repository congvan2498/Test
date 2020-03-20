CREATE TABLE "users" (
  "id" int,
  "full_name" varchar,
  "created_at" timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "account" (
  "id" int,
  "user_name" varchar,
  "haspwd" varchar,
  "type" enum,
  "user_id" int,
  "created_at" timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "film" (
  "id" int,
  "name" varchar,
  "created_at" timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "time_show" (
  "id" int,
  "time_show" timestamp,
  "film_id" int,
  "created_at" timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "cinema" (
  "id" int,
  "code" int,
  "sum_location" int,
  "film_id" int,
  "created_at" timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "cinema_film" (
  "id" int,
  "cinema_id" int,
  "film_id" int,
  "show_time" timestamp,
  "created_at" timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "cinema_film_ticket" (
  "id" int,
  "cinema_film_id" int,
  "ticket_id" int
);

CREATE TABLE "ticket" (
  "id" int,
  "price" int,
  "location" varchar,
  "created_at" timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "location" (
  "id" int,
  "name" varchar
);

CREATE TABLE "cinema_location" (
  "id" int,
  "location_id" int,
  "cinema_id" int,
  "free" boolean
);

CREATE TABLE "ticket_cinema" (
  "id" int,
  "ticket_id" int,
  "cinema_id" int,
  "created_at" timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "transaction_ticket" (
  "id" int,
  "ticket_id" int,
  "price" int,
  "user_id" int,
  "created_at" timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

CREATE TABLE "book_ticket" (
  "id" int,
  "ticket_id" int,
  "user_id" int,
  "created_at" timestamp,
  "updated_at" timestamp,
  "deleted_at" timestamp
);

ALTER TABLE "account" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "time_show" ADD FOREIGN KEY ("film_id") REFERENCES "film" ("id");

ALTER TABLE "cinema" ADD FOREIGN KEY ("film_id") REFERENCES "film" ("id");

ALTER TABLE "cinema_film" ADD FOREIGN KEY ("cinema_id") REFERENCES "cinema" ("id");

ALTER TABLE "cinema_film" ADD FOREIGN KEY ("film_id") REFERENCES "film" ("id");

ALTER TABLE "cinema_location" ADD FOREIGN KEY ("location_id") REFERENCES "location" ("id");

ALTER TABLE "cinema_location" ADD FOREIGN KEY ("cinema_id") REFERENCES "cinema" ("id");

ALTER TABLE "ticket_cinema" ADD FOREIGN KEY ("ticket_id") REFERENCES "ticket" ("id");

ALTER TABLE "ticket_cinema" ADD FOREIGN KEY ("cinema_id") REFERENCES "cinema" ("id");

ALTER TABLE "transaction_ticket" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");
