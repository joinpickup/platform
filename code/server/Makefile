hello:
	echo "Hello"

build:
	env GOOS=linux GOARCH=amd64 go build -o bin/pocketbase main.go

run:
	go run main.go serve

upload:
	rsync -l 5000 -avz -e ssh ./pb_data ./bin/pocketbase root@159.223.165.89:/root/pb