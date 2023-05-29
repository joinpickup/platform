-- +goose Up
-- +goose StatementBegin
create or replace function get_post(
    p_post_id integer
) returns table (
    post_id integer,
    created_at timestamptz,
    title varchar(255),
    body text,

    -- poster
    person_id integer,
    person_user_id integer,
    person_created_at timestamptz,
    "name" varchar,
    "username" varchar,
    "avatar" varchar,

    -- location
    location_id integer,
    location_common_name varchar,
    location_created_at timestamptz
) as $$
begin
    return query 
    select 

    -- post info
    post.post_id, post.created_at, post.title, post.body, 

    -- person info
    person.person_id, person.user_id, person.created_at, person."name", person.username, person.avatar,

    -- location info
    location.location_id, location.common_name, location.created_at

    from post
    inner join person
    on person.person_id = post.poster_id
    inner join "location"
    on person.location_id = location.location_id
    where post.post_id = p_post_id;
end;

$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function get_post (integer);