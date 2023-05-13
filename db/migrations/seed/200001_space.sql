-- +goose Up
insert into "space" values (1, 'Sports', 'Related to a competitive and organized game or physical activity.') on conflict do nothing;


-- +goose Down
