-- +goose Up
-- +goose StatementBegin
create or replace function get_all_settings_for_person(
    p_person_id integer
)
returns table (
    setting_id integer,
    "name" varchar,
    "description" varchar,
    setting_value varchar
) as $$
begin
    return query
    select
        s.setting_id,
        s.name,
        s.description,
        coalesce(ps.setting_value, s.default_value) as setting_value
    from
        setting s
        inner join setting_type st on s.setting_type = st.setting_type_id
        left join person_setting ps on ps.setting_id = s.setting_id 
        and ps.person_id = p_person_id 
        -- only give us back the user settings
        where s.setting_type = 1
    order by s.setting_id;
end;
$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function get_all_settings_for_person (integer);