-- +goose Up
-- +goose StatementBegin
create or replace function get_person(
    p_person_id integer
)
  returns table (
    person_id integer,
    user_id integer,
    "name" varchar,
    username varchar,
    avatar varchar,
    created_at timestamptz,

    -- location information
    location_id integer,
    location_common_name varchar,
    location_created_at timestamptz
  )
as $$
begin
  return query select
    p.person_id,
    p.user_id,
    p.name,
    p.username,
    p.avatar,
    p.created_at,

    -- location info
    location.location_id, location.common_name, location.created_at

  from
    person as p
    inner join "location"
    on p.location_id = location.location_id
  where
    p.person_id = p_person_id;
end;
$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function get_person (integer);