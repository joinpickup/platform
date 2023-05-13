-- +goose Up
-- +goose StatementBegin
create or replace function add_interest_for_post (
    p_post_id integer,
    p_interest_id integer
) returns void as $$
begin
    insert into post_interest (post_id, interest_id)
    values (p_post_id, p_interest_id);
end;

$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function add_interest_for_post (integer, integer);