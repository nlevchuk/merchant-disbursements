# Merchant disbursements

Here is a small Rails application with single API endpoint which returns disbursements for a given merchant on a given week. If no merchant is provided return for all of them.

## Technical stack

1. Ruby on Rails (API mode)
2. PostgreSQL

## Installation

1. Put `merchants.json`, `shoppers.json` and `orders.json` from the dataset into `tmp/` folder

2. Build the application image using Dockerfile from current directory

```
make build
```

3. Create and run containers for Rails and PostgreSQL applications. Wait until both applications running

```
make up
```

4. Make initial setup of the application (create databases, run migrations, populate development database)

```
make bootstrap
```

4. Go to the browser and open `http://localhost:3000?merchant=1&week=1`
