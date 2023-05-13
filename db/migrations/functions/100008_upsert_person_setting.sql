-- +goose Up
-- +goose StatementBegin
create or replace function upsert_person_setting(
    p_person_id integer,
    p_setting_id integer,
    p_setting_value varchar
) returns void as $$
begin
    insert into person_setting (person_id, setting_id, setting_value)
    values (p_person_id, p_setting_id, p_setting_value)
    on conflict (person_id, setting_id) do update
    set setting_value = p_setting_value;
end;

$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function upsert_person_setting (integer, integer, varchar);