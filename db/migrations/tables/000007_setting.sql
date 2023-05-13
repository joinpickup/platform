-- +goose Up
create table if not exists setting_type (
  setting_type_id serial primary key,
  type_name varchar not null,
  type_description varchar not null,
  created_at timestamptz not null default now()
);

create table if not exists setting (
  setting_id serial primary key,
  "name" varchar unique not null,
  "description" varchar not null,
  default_value varchar, 
  setting_type integer not null references "setting_type"(setting_type_id),
  created_at timestamptz not null default now()
);

-- +goose Down
drop table if exists setting;
drop table if exists setting_type;