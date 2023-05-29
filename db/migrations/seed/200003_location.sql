-- +goose Up
insert into "location" 
values (1, 'East Rock') on conflict do nothing;

insert into "location" 
values (2, 'Westville') on conflict do nothing;

-- +goose Down