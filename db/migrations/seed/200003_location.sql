-- +goose Up
insert into "location" 
values (1, 'East Rock') on conflict do nothing;

-- +goose Down