-- +goose Up
-- +goose StatementBegin
create or replace function get_notifications_for_person(
  p_person_id integer,
  p_is_read boolean
)
  returns table (
    notification_id integer,
    created_at timestamptz,
    is_read boolean,

    -- get post data
    post_id integer,
    post_created_at timestamptz,
    post_title varchar(255),
    post_body text,

    -- get poster data
    poster_id integer,
    poster_user_id integer,
    poster_name varchar,
    poster_username varchar,
    poster_avatar varchar,
    poster_created_at timestamptz,

    -- poster location information
    poster_location_id integer,
    poster_location_common_name varchar,
    poster_location_created_at timestamptz,

    -- get actor data
    actor_id integer,
    actor_user_id integer,
    actor_name varchar,
    actor_username varchar,
    actor_avatar varchar,
    actor_created_at timestamptz,

    -- location information
    actor_location_id integer,
    actor_location_common_name varchar,
    actor_location_created_at timestamptz

  )
as $$
begin
  return query select
    n.notification_id,
    n.created_at,
    n.is_read,

    -- get post data
    post.post_id,
    post.created_at,
    post.title,
    post.body,

    -- receiver info
    poster.person_id integer,
    poster.user_id integer,
    poster."name" varchar,
    poster.username varchar,
    poster.avatar varchar,
    poster.created_at timestamptz,

    -- location information
    poster_location.location_id integer,
    poster_location.common_name varchar,
    poster_location.created_at timestamptz,

    -- actor info
    actor.person_id integer,
    actor.user_id integer,
    actor."name" varchar,
    actor.username varchar,
    actor.avatar varchar,
    actor.created_at timestamptz,

    -- location information
    a_location.location_id integer,
    a_location.common_name varchar,
    a_location.created_at timestamptz

  from
    "notification" as n

  -- get back post information
  inner join post
    on post.post_id = n.post_id

  -- need to get back information about the reciever
  inner join person as poster
    on poster.person_id = post.poster_id
  inner join "location" as poster_location
    on poster_location.location_id = poster.person_id


  -- need to get back information about the actor
  inner join person as actor
    on actor.person_id = n.actor_id
  inner join "location" as a_location
    on a_location.location_id = actor.person_id

  where
    post.poster_id = p_person_id
    and n.is_read = p_is_read;
end;
$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function get_notifications_for_person (integer, boolean);