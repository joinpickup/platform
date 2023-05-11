-- +goose Up
create table person (
  person_id serial primary key
  -- define fields for person here
);

-- +goose Down
drop table if exists person;