-- +goose Up
insert into "person" 
values (1, 1, 'Andrew', 'andyrewco', 'assets/avatars/fox_ai.png', 1) on conflict do nothing;


-- +goose Down