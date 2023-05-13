-- +goose Up
-- +goose StatementBegin
create or replace function get_interests_for_post (
    p_post_id integer
) returns table (
    interest_id integer,
    display_name varchar,
    space_name varchar,
    space_id int,
    created_at timestamptz
) as $$
begin
    return query select interest.interest_id, interest.display_name, space."name", space.space_id, interest.created_at
    from interest
    inner join space
    on interest.space_id = space.space_id
    inner join post_interest
    on interest.interest_id = post_interest.interest_id
    where post_interest.post_id = p_post_id;
end;

$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function get_interests_for_post (integer);