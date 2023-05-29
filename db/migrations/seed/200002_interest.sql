-- +goose Up
insert into "interest" 
values (1, 'Soccer', 1) on conflict do nothing;

insert into "interest" 
values (2, 'Basketball', 1) on conflict do nothing;

insert into "interest" 
values (3, 'Football', 1) on conflict do nothing;

insert into "interest" 
values (4, 'Tennis', 1) on conflict do nothing;

insert into "interest" 
values (5, 'Raquetball', 1) on conflict do nothing;

-- +goose Down