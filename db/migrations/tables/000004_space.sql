-- +goose Up
create table if not exists space (
  space_id serial primary key,
  -- define fields for interest here
  "name" varchar unique not null,
  "description" varchar not null,
  created_at timestamptz not null default Now()
);

-- +goose Down
drop table if exists space;