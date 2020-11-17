### Background and Description

"Little Etsy Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants, and admins can manage inventory, and fulfill customer invoices.

### Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Turn open ended features into detailed user stories utilizing Github issues and a Github project board
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

### Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all controller and model code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

### Invoice Status
- `pending` means a customer has placed items in a cart and "checked out" to create an invoice for one or more merchants. A merchant may or may not have fulfilled any items yet
- `packaged` means a merchant has fulfilled their items for the invoice, and it has been packaged and ready to ship
- `shipped` means a merchant has `shipped` a package and it can no longer be cancelled by a customer
- `cancelled` - only `pending` and `packaged` invoices can be cancelled

## Setup

This project requires Ruby 2.5.3.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.
