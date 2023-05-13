-- +goose Up
insert into "setting_type" 
values (1, 'Person', 'Relating to a the person object') on conflict do nothing;

insert into "setting_type" 
values (2, 'Post', 'Relating to a the post object') on conflict do nothing;

insert into "setting" 
values (1, 'AppTheme', 'The choice for the application theme.', 'dark', 1) on conflict do nothing;