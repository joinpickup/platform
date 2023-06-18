-- +goose Up
-- +goose StatementBegin
create or replace function search_posts(
    space_ids integer[],
    interest_ids integer[],
    query text
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
    p.post_id, p.created_at, p.title, p.body, 

    -- person info
    person.person_id, person.user_id, person.created_at, person."name", person.username, person.avatar,

    -- location info
    location.location_id, location.common_name, location.created_at

    from post p
    join post_interest pi on p.post_id = pi.post_id
    join interest i on i.interest_id = pi.interest_id
    inner join person
    on person.person_id = p.poster_id
    inner join "location"
    on person.location_id = location.location_id
    where (
            (space_ids is null or i.space_id = any(space_ids))
            and (interest_ids is null or pi.interest_id = any(interest_ids))
            )
      and (p.title ilike '%' || query || '%' or p.body ilike '%' || query || '%');
end;
$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function search_posts (integer[], integer[], text);