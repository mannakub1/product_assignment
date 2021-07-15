### Installing

```sh
docker-compose up -d
```

### Create & Migration Database

##### Into bash container

```sh
docker-compose run --rm app bash
```

#### Create Database

```sh
  rails db:create
```

# Migration Database

```sh
  rails db:migrate
```

### Stop all services

```sh
docker-compose down
```
