-- +goose Up
create table post (
  post_id serial primary key,
  created_at timestamptz not null default Now(),
  title varchar(255) not null,
  body text not null,
  poster_id integer not null references person(person_id)
);

create table post_interest (
  post_id integer not null references post(post_id),
  interest_id integer not null references interest(interest_id),
  primary key (post_id, interest_id)
);

-- +goose Down
drop table if exists post_interest;
drop table if exists post;
