-- +goose Up
create table if not exists interest (
  interest_id serial primary key,
  -- define fields for interest here
  display_name varchar not null,
  space_id integer not null references "space"(space_id),
  created_at timestamptz not null default Now()
);

-- +goose Down
drop table if exists interest;