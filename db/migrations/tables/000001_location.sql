-- +goose Up
create table if not exists "location" (
  location_id serial primary key,
  -- define fields for interest here
  common_name varchar not null,
  created_at timestamptz not null default Now()
);

-- +goose Down
drop table if exists "location";
