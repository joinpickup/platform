-- +goose Up
create table if not exists person_setting (
  person_id integer not null references "person"(person_id),
  setting_id integer not null references "setting"(setting_id),
  setting_value varchar not null,
  created_at timestamptz not null default now()
);

-- +goose Down
drop table if exists person_setting;