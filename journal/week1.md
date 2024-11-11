# Week 1 — App Containerization

`docker build -t backend-flask ./backend-flask`
`docker images` lists it

RUN: `docker run --rm -p 4567:4567 -it -e FRONTEND_URL='*' -e BACKEND_URL='*' -d backend-flask`

then go `http://127.0.0.1:4567/api/activities/home`

## DynamoDB local

`docker-compose up -d`

To connect to postgres: `docker exec -it aws-crudflask-db-1 psql -U postgres`

```
aws dynamodb create-table \
    --endpoint-url http://localhost:8000 \
    --table-name Music \
    --attribute-definitions \
        AttributeName=Artist,AttributeType=S \
        AttributeName=SongTitle,AttributeType=S \
    --key-schema AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --table-class STANDARD
```