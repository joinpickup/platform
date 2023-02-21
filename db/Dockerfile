FROM migrate/migrate

COPY ./migrations ./migrations

# needed for local dev
ENTRYPOINT [ "sh", "-c", "sleep 15s; migrate -path ./migrations -database ${DATABASE_URL} up" ]