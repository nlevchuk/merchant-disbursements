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
- `week` - weekly range. Available values: from 01-2018 to 14-2018
- `merchant` - merchant ID. Available values: from 1 to 14

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

## Should I calculate order disbursed amount beforehand and persist it in the orders table?

There were two options here:
- Calculate disbursed amount when order gets completed and persist it, or
- Calculate disbursed amount for completed orders when calculating all disbursements

I chose the first option because it spreads executing actions in time and not doing all of them in single task.

### When does disbursed amount for order should be calculated?

When order gets completed.

### When disbursements should be sent to merchants?

Every monday.

### When disbursements are calculated, which dates(created or completed) should be used for fetching completed orders?

Let's imagine the situation that we decided to use order's `created_at` column for fetching completed orders. 
Today is tuesday and we have an order which was created on last week. Some disbursements were sent yesterday (on monday) but not our order because it wasn't completed yesterday. Today the order finally gets completed and we expect that its disbursed amount will be sent to merchant on next monday.

Unfortunately, no. Our order won't be picked up because it'll have two-week created_at date on next monday but our background job only sends disbursements for previous week.

So we should use order's `completed_at` date.

## TODO

1. Add unit tests for merchang_disbursement_calculator
2. Add integration tests for disbursements_controller
3. Set up background jobs
4. Add a job for calculating disbursed amount once order is completed
5. Add a job for sending disbursements for previous week on monday
