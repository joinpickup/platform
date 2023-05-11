-- +goose Up
create table interest (
  interest_id serial primary key
  -- define fields for interest here
);

-- +goose Down
drop table if exists interest;