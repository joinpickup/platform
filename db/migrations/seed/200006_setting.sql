-- +goose Up
insert into "setting_type" 
values (1, 'Person', 'Relating to a the person object') on conflict do nothing;

insert into "setting_type" 
values (2, 'Post', 'Relating to a the post object') on conflict do nothing;

insert into "setting" 
values (1, 'AppTheme', 'The choice for the application theme.', 'dark', 1) on conflict do nothing;

insert into "setting" 
values (2, 'EnableNotifications', 'Whether or not the person agrees to enable notifications', 'false', 1) on conflict do nothing;

insert into "setting" 
values (3, 'Visibility', 'Who can view the post.', 'public', 2) on conflict do nothing;