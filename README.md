# Little Esty Shop

Schema:
![image](https://user-images.githubusercontent.com/15107515/148599839-a478be3e-c43e-4977-9e3c-f26198e40b33.png)

## Background and Description

"Little Esty Shop" is a group project that required students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL

## Setup

This project requires Ruby 2.7.2.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
    * `rails import_csv:all` to seed the database with the full CSV data set. 
    * Each table in the database does have its own rake command to seed individually, which can be run with `rails import_csv:<tablename>`

* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Contributors
* [Leland Curtis](https://github.com/LelandCurtis)
* [Josh Walsh](https://github.com/jaw772)
* [Paul Leonard](https://github.com/pleonar1)
* [Eric Mielke](https://github.com/emielke76)




