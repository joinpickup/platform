-- +goose Up
-- +goose StatementBegin
create or replace function update_post_setting(
    p_post_id integer,
    p_setting_id integer,
    p_setting_value varchar
) returns void as $$
begin
    insert into post_setting (post_id, setting_id, setting_value)
    values (p_post_id, p_setting_id, p_setting_value)
    on conflict (post_id, setting_id) do update
    set setting_value = p_setting_value;
end;

$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function update_post_setting (integer, integer, varchar);