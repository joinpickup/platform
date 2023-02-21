while getopts e:v: flag
do
    case "${flag}" in
        e) env=${OPTARG};;
        v) version=${OPTARG};;
    esac
done

source "$env"
migrate -path ../migrations -database $DATABASE_URL force $version