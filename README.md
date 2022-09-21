<img width="880" alt="Screen Shot 2022-09-21 at 1 24 13 PM" src="https://user-images.githubusercontent.com/102133027/191592811-8d89d231-457a-4eee-a74c-9ccbb70612f1.png">


# Little Esty Shop

In this project our group created a program that allows us to operate a digital store with may merchants and items.  When a customer buys something, an invoice is created which links to both a transaction and invoice_items.  The transaction handles the monetary information; the credit card number and expiration date. The invoice_items contain the quantity and  item id which links the invoice_item to the item table.  Finally the merchant can access each of their items and through the item they can see the invoice_item to see quantity.    

Using our application you can make changes to a merchant such as adding new items, and enabling or disabling items.  Accessing our application as an admin allows more access to data and other features including enabling or disabling merchants and merchants revenues.

On every page there is a footer that displays our repository name, contributors GitHub usernames and a count of each contributors commits.

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

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
