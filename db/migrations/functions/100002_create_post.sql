-- +goose Up
-- +goose StatementBegin
create or replace function create_post(
    title varchar(255),
    body text,
    poster_id integer,
    interests integer[]
) returns integer as $$
declare
    r_post_id integer;
begin
    insert into post (title, body, poster_id)
    values (title, body, poster_id)
    returning post_id into r_post_id;


    if interests is not null then
        insert into post_interest (post_id, interest_id)
        select r_post_id, unnest(interests);
    end if;

    return id;
end;

$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function create_post (varchar(255), text, integer, integer[])