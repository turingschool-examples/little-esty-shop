# Little Esty Shop

## Table of Contents
* [Description](#description)
* [Status](#status)
* [Live App](#live-app)
* [Setup](#setup)
* [Learning Goals](#learning-goals)
* [Requirements](#requirements)
* [Phases](#phases)
* [Technologies Used](#technologies-used)
* [Evaluation](#evaluation)
* [Reflection](#reflection)
* [Contributors](#contributors)

## Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Status

This project is currently in development.

## Live App
[Link to live app. deployment](https://blooming-ridge-25668.herokuapp.com/)

## Database Schema

![little-esty-shop-schema](https://user-images.githubusercontent.com/15859827/104620557-5b0cc980-564c-11eb-9d8d-a3e15547956f.png)

## Setup

This project requires Ruby 2.5.3.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:{create, migrate}`
* Run rake csv_load:all
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Learning Goals

- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Turn open ended features into detailed user stories utilizing Github issues and a Github project board
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements

- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)

## Technologies Used

- Atom
- VSCode
- Git
- GitHub
- GitHub Projects
- Ruby
- Rails
- RSpec
- SimpleCov
- Slack
- Zoom
- Orderly
- Postico

## Evaluation

At the end of the project, you will be assessed based on [this Rubric](./doc/rubric.md)

## Reflection

__What was the context for this project?__


__What did you set out to build?__


__Why was this project challenging and therefore a really good learning experience?__

The challenges we ran into were:

1.
2.
3.

Because of these challenges we learned...

__What were some unexpected obstacles?__


## Contributors

- [Cydnee Owens](https://github.com/cowens87)
- [Mike Foy](https://github.com/foymikek)
- [Ryan Barnett](https://github.com/RyanDBarnett)
- [Yesi Meza](https://github.com/Yesi-MC)
