-- +goose Up
-- +goose StatementBegin

create or replace function create_person(
) returns integer as $$ 

declare id integer; 
begin 
    insert into person default values returning person_id into id;
    return id;
end;

$$ language plpgsql;
-- +goose StatementEnd

-- +goose Down
drop function if exists create_person ();