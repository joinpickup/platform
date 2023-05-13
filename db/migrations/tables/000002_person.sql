-- +goose Up
create table if not exists person (
  person_id serial primary key,
  user_id int not null,
  "name" varchar not null,
  username varchar unique not null,
  avatar varchar not null,
  location_id integer not null references "location"(location_id),
  created_at timestamptz not null default Now()
);

-- +goose Down
drop table if exists person;