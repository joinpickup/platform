-- +goose Up
-- +goose StatementBegin
create or replace function get_person_setting(
    p_person_id integer,
    p_setting_name varchar
) returns varchar as $$
declare
    v_setting_value varchar;
begin
    -- attempt to retrieve the setting for the person
    select ps.setting_value into v_setting_value
    from person_setting ps
    join setting s on s.setting_id = ps.setting_id
    where ps.person_id = p_person_id and s.name = p_setting_name;
    
    -- if the setting value was not found, use the default value
    if v_setting_value is null then
        select default_value into v_setting_value
        from setting s
        where s.name = p_setting_name;
    end if;
    
    return v_setting_value;
end;
$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function get_person_setting (integer, varchar);