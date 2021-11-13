### notes to myself:
1. figure out how to do error flash messages for creating a new discount with wrong values such as, when percentage is over 100, put %, or even when creating a discount that will never be used.  

# README

### Mod2 Group Project: Little Esty Shop
### Micha Bernhard, Sam Devine, Haewon Jeon & Christian Valesares
---

"Little Esty Shop" is an e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Schema

There are 6 tables with 5 one-to-many relationships:

<img width="658" alt="schema_little_esty_shop copy" src="https://user-images.githubusercontent.com/86392608/141384508-04b2a58d-8a04-4f84-b4e5-8ca4d0b80123.png">



## Tools Used:
- Rails 5.2.6
- Ruby 2.7.2
- PostgreSQL
- Heroku (https://frozen-peak-55560.herokuapp.com)

## Setup

* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## The following pages are built for the platform:
- Merchant Dashboard
- Merchant Items Index
- Merchant Items Show
- Merchant Invoices Index
- Merchant Invoices Show
- Admin Dashboard
- Admin Merchants Index
- Admin Merchants Show
- Admin Invoices Index
- Admin Invoices Show

## API

The platform can also consume GitHub API to provide GitHub repo name, GitHub usernames of all team members and their commit numbers, and a number of total merged PRs.
