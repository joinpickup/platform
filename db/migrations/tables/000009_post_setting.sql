-- +goose Up
create table if not exists post_setting (
  post_id integer not null references "post"(post_id),
  setting_id integer not null references "setting"(setting_id),
  setting_value varchar not null,
  created_at timestamptz not null default now(),
  primary key (post_id, setting_id)
);

-- +goose Down
drop table if exists post_setting;