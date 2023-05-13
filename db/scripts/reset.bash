while getopts e: flag
do
    case "${flag}" in
        e) env=${OPTARG};;
    esac
done

source "$env"
goose -dir ../migrations/tables -no-versioning postgres $DATABASE_URL reset
goose -dir ../migrations/functions -no-versioning postgres $DATABASE_URL reset
goose -dir ../migrations/seed -no-versioning postgres $DATABASE_URL reset