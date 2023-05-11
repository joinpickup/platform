while getopts e: flag
do
    case "${flag}" in
        e) env=${OPTARG};;
    esac
done

source "$env"
goose -dir ../migrations/tables postgres $DATABASE_URL up
goose -dir ../migrations/functions postgres $DATABASE_URL up
goose -dir ../migrations/seed postgres $DATABASE_URL up