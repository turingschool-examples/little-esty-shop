# README

### Mod3 Group Project: Little Esty Shop
### Micha Bernhard, Sam Devine, Haewon Jeon & Christian Valesares
---

"Little Esty Shop" is an e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Schema

There are 6 tables with 5 one-to-many relationships as below:

![Schema](./wireframes/schema_little_esty_shop.png)

## Tools Used:
- Rails 5.2.6
- Ruby 2.7.2
- PostgreSQL
- Heroku (address: https://frozen-peak-55560.herokuapp.com)

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
