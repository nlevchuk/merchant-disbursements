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

4. Make initial setup of the application (create databases, run migrations, populate development database, calculate disbursements)

```
make bootstrap
```

4. Go to the browser and open one of the following URLs:
- http://localhost:3000
- http://localhost:3000?week=01-2018
- http://localhost:3000?week=03-2018&merchant=1

Parameters:
`week` - weekly range. Available values: from 01-2018 to 14-2018
`merchant` - merchant ID. Available values: from 1 to 14

## Tests

```
make test
```

## Technical choices and tradeoffs

### Which language to use? Ruby or JavaScript?

I used JS for the past 4 years but current position requires Ruby. So I decided to revise my knowledge

### Does the amount value should be persisted as a single column (floating point type) or as two columns (cents and currency)?

I used two columns for two reasons:
- There are rounding errors when working with floating point numbers. So I persisted amount column in cents (Integer type)
- I used `Money` gem which provides methods to work with monetary values and it requires two columns (cents and currency)

## TODO

1. Add unit tests for merchang_disbursement_calculator
2. Add integration tests for disbursements_controller
3. Set up background job for sending disbursements for previous week on monday
