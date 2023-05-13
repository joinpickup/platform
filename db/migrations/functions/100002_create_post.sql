-- +goose Up
-- +goose StatementBegin
create or replace function create_post(
    title varchar(255),
    body text,
    poster_id integer
) returns integer as $$
declare
    id integer;
begin
    insert into post (title, body, poster_id)
    values (title, body, poster_id)
    returning post_id into id;
    return id;
end;

$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function create_post (varchar(255), text, integer);