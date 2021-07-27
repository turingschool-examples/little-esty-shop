## Relational Rails

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
# Welcome to Relational Rails - A database driven web application
<p align="center">
  <img src="https://user-images.githubusercontent.com/74567704/124989834-92fa3580-e00d-11eb-8238-ffebdd18eeae.png" alt="Relational Rails Welcome"/>
</p>

<!-- ![Relational Rails Welcome Screen](https://user-images.githubusercontent.com/74567704/124805908-1e01ff80-df2a-11eb-92bc-3a1536aa9c84.png) -->

Find the [project spec here](https://backend.turing.edu/module2/projects/relational_rails).
## Table of Contents

- [Overview](#overview)
- [Tools Utilized](#tools-used)
- [Contributing](#contributors)

# README
------

### <ins>Overview</ins>

[Relational Rails](https://github.com/deebot10/relational_rails_1) is a 10-day, 2 person project, during Mod 2 of 4 for Turing School's Back End Engineering Program.

Our challenge was to build a functioning web app consisting of multiple relational databases.

Learning goals and areas of focus consisted of:

- Apply principles of flow control across multiple methods
- Design a one to many relationship using a schema designer
- Write migrations to create tables with columns of varying data types and foreign keys.
- Use Rails to create web pages that allow users to CRUD resources
- Create instance and class methods on a Rails model that use ActiveRecord methods and helpers
- Write model and feature tests that fully cover data logic and potential user behavior

[Technical Requirements](https://backend.turing.edu/module2/projects/relational_rails)

### <ins>Tools Used</ins>
- Ruby 2.7.2
- Rails 5.2.6
- PostgresQL
- Postico
- Capybara
- Launchy
- Orderly
- SimpleCov
- Git/GitHub
- HTML
- CSS
- Bootstrap
- RSpec
- Pry
- Atom
- VS Code


### <ins>Contributors</ins>

👤  **Brian Fletcher**
- Github: [Brian Fletcher](https://github.com/bfl3tch)
- LinkedIn: [Brian Fletcher](https://www.linkedin.com/in/bfl3tch)

👤  **Dee Hill**
- Github: [Dee Hill](https://github.com/deebot10)
- LinkedIn: [Dee Hill](https://www.linkedin.com/in/dee-hill-82b18220b/)


<!-- MARKDOWN LINKS & IMAGES -->

[contributors-shield]: https://img.shields.io/github/contributors/deebot10/relational_rails_1.svg?style=flat-square
[contributors-url]: https://github.com/deebot10/relational_rails_1/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/deebot10/relational_rails_1.svg?style=flat-square
[forks-url]: https://github.com/deebot10/relational_rails_1/network/members
[stars-shield]: https://img.shields.io/github/stars/deebot10/relational_rails_1.svg?style=flat-square
[stars-url]: https://github.com/deebot10/relational_rails_1/stargazers
[issues-shield]: https://img.shields.io/github/issues/deebot10/relational_rails_1.svg?style=flat-square
[issues-url]: https://github.com/deebot10/relational_rails_1/issues
<!-- 


# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... -->


# Little Esty Shop

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

## Setup

This project requires Ruby 2.7.2.

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



#### Project Configurations

* Ruby version
    ```bash
    $ ruby -v
    ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin20]
    ```

* [System dependencies](https://github.com/bfl3tch/little-esty-shop/blob/main/Gemfile)
    ```bash
    $ rails -v
    Rails 5.2.6
    ```

* Database creation
    ```bash
    $ rails db:{drop,create,migrate,seed}
    Created database 'little_etsy_shop_development'
    Created database 'little_etsy_shop_test'
    ```

* Database initialization
    ```bash
    $ rake csv_load:all
    ```

* How to run the test suite
    ```bash
    $ bundle exec rspec
    ```

* [Local Deployment](http://localhost:3000), for testing:
    ```bash
    $ rails s
    => Booting Puma
    => Rails 5.2.6 application starting in development
    => Run `rails server -h` for more startup options
    Puma starting in single mode...
    * Version 3.12.6 (ruby 2.7.2-p137), codename: Llamas in Pajamas
    * Min threads: 5, max threads: 5
    * Environment: development
    * Listening on tcp://localhost:3000
    Use Ctrl-C to stop

    ```

* Heroku Deployment, for production (link pending)
