while getopts e: flag
do
    case "${flag}" in
        e) env=${OPTARG};;
    esac
done

source "$env"
migrate -path ../migrations -database $DATABASE_URL down -all