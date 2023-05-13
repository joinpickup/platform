-- +goose Up
insert into "interest" 
values (1, 'Soccer', 1) on conflict do nothing;

-- +goose Down