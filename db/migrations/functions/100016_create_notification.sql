-- +goose Up
-- +goose StatementBegin
create or replace function create_notification(
    p_post_id integer,
    p_actor_id integer
) returns integer as $$
declare
    id integer;
    p_poster_id integer;
begin
    select poster_id into p_poster_id from post where post_id = p_post_id;

    -- raise an error if actor_id is the same as poster_id
    if p_actor_id = p_poster_id then
        raise exception 'actor and poster cannot be the same';
    end if;

    -- actual insert
    insert into "notification" (post_id, is_read, actor_id)
    values (p_post_id, false, p_actor_id)
    returning notification_id into id;
    return id;
end;

$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function create_notification (integer, integer);