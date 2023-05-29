-- +goose Up
create table if not exists "notification" (
  notification_id serial primary key,
  created_at timestamptz not null default Now(),
  post_id integer not null references post(post_id),
  is_read boolean not null default false,
  actor_id integer not null references person(person_id),

  constraint unique_post_actor_combo unique (post_id, actor_id)
);

-- +goose Down
drop table if exists "notification";