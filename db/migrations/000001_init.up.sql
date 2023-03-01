-- TYPES

-- OBJECTS
create table if not exists "person" (
  "person_id" serial primary key,
  "name" varchar not null,
  "username" varchar unique not null,
  "user_id" int,
  "object_guid" uuid unique not null,
  "created_at" timestamptz not null default Now()
);
