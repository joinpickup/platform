-- +goose Up
insert into "person" 
values (1, 1, 'Andrew', 'andyrewco', 'assets/avatars/fox_ai.png', 1) on conflict do nothing;

insert into "person" 
values (2, 1, 'Brain', 'windswept', 'assets/avatars/koala_cropped.png', 2) on conflict do nothing;

-- +goose Down