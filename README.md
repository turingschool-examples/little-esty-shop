# Little Esty Shop
DB diagram below:
https://app.dbdesigner.net/designer/schema/555577

## Background and Description

"Little Esty Shop" is a group project that builds a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

- All functionality of merchants is the same for items within the app
- admin and merchants utilize a dashboard with links to index of merchants and invoices
- Within the respective admin or merchant page, a new merchant can be create
- Within the respective admin or merchant page, you can update an existing merchant
- You can enable and disable merchant status and have the merchant sorted into the appropriate status category 
- Access to a specific merchant or admin/invoice show page will display itemized info
- Top merchants/customers are displayed along with their total revenue as well as their best day of sales

## Goals
- Designing a normalized database schema and defining model relationships
- Utilize advanced active record techniques to perform complex database queries
- Consumed a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku
- Continuous Integration / Continuous Deployment is not allowed
- Any gems added to the project must be approved by an instructor

## Setup

This project requires Ruby 2.7.4.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

