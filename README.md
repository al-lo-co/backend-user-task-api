# User Tasks API

This is a RESTful API with basic token authentication built with Ruby on Rails that allows you to manage users and their related tasks. The project also supports GraphQL queries and mutations for advanced interaction.

## Features

- Create and manage users  
- Create and manage tasks associated with users  
- RESTful endpoints  
- GraphQL support (queries and mutations for users and tasks)  
- JSON serialization with **ActiveModel::Serializers**  
- Unit and request tests with **RSpec**  
- Dockerized with `Dockerfile` and `docker-compose`  
- PostgreSQL as the database, configured with persistent volume and isolated network
- Jenkins for CI/CD
- Uses dotenv for Enviorment variables

## Variables

Create a .env file with these variables

```
DATABASE_HOST=
RAILS_MAX_THREADS=
DATABASE_PORT=
DATABASE_USERNAME=
DATABASE_PASSWORD=
POSTGRES_PASSWORD=
AUTHENTICATION_TOKEN=""
```

## Docker

```bash
docker compose up --build
```

The server will be running at

http://localhost:3000

## Testing

Tests are written using **RSpec**, covering:

- Models  
- Request endpoints  

To run tests inside the container:

```bash
docker compose run web bundle exec rspec
```

## Technologies

	•	Ruby on Rails
	•	PostgreSQL
	•	ActiveModel Serializers
	•	RSpec
	•	GraphQL
	•	Docker
  •	Jenkins

## TODO
  •	Graphql unit tests
