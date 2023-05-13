-- +goose Up
-- +goose StatementBegin
create or replace function update_post(
    p_post_id integer,
    p_body text default null
) returns table (
    post_id integer,
    created_at timestamptz,
    title varchar(255),
    body text
) as $$
begin
    update post set
        body = coalesce(p_body, post.body)
    where post.post_id = p_post_id;

    return query select post.post_id, post.created_at, post.title, post.body
    from post 
    where post.post_id = p_post_id;
end;

$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function update_post (integer, text);