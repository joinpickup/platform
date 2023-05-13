-- +goose Up
-- +goose StatementBegin
create or replace function get_spaces(
) returns table (
    space_id integer,
    "name" varchar,
    "description" varchar,
    created_at timestamptz
) as $$
begin
    return query 
    select * from space;
end;

$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function get_spaces ();