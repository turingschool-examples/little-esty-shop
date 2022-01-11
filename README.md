# Little Esty Shop: Database Driven Web Application

## Table of Contents
- Overview
- Tools
- Contributors
- Project SetUp and Phases

## Overview

"Little Esty Shop" is a 10 day, 4 person group project completed during Module 2 of 4 for the Turing School of Software Engineering and Design's Back End Engineering Program.

The premise is a fictitious e-commerce platform where both merchants and admins to the site can manage inventory and fulfill customer invoices.

- Our Database Design
![Screen Shot 2022-01-03 at 7 24 37 PM](https://user-images.githubusercontent.com/79548116/147997637-ef70102b-8b85-4349-9cc7-ecac543a50e1.png)

- Learning Goals
  - Practice designing a normalized database schema and defining model relationships
  - Utilize advanced routing techniques including namespacing to organize and group like functionality together.
  - Utilize advanced active record techniques to perform complex database queries
  - Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

- Requirements
  - must use Rails 5.2.x
  - must use PostgreSQL
  - all code must be tested via feature tests and model tests, respectively
  - must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
  - must include a thorough README to describe the project
  - must deploy completed code to Heroku

## Tools
- Ruby 2.7.2
- Rails 5.2.6
- PostgreSQL
- Postico
- Capybara
- Launchy
- Orderly
- SimpleCov
- Pry
- RSpec
- Atom/VS Code
- Git/GitHub

## Contributors
💻 Jessica Grazulis [|Github|](https://github.com/jgrazulis) [|LinkedIn|](https://www.linkedin.com/in/jessicagrazulis/)

💻 Brad Breiten [|Github|](https://github.com/jbreit88) [|LinkedIn|](https://www.linkedin.com/in/jbradfordbreiten/)

💻 Karan Mehta [|Github|](https://github.com/karanm645) [|LinkedIn|](https://www.linkedin.com/in/karan-mehta-2b706093/)

💻 Sierra Tucker [|Github|](https://github.com/Sierra-T-9598) [|LinkedIn|](https://www.linkedin.com/in/sierra-tucker-a254201a8/)

## Project SetUp and Phases

### SetUp
- Ruby Version
  ```$ ruby -v
    ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [arm64-darwin20]
    ```
- Rails Version
  ```$ rails -v
    Rails 5.2.6
  ```
- Database Creation
  ```$ rails db:{drop, create, migrate, seed}
  ```
- Database Loading
```$ rails csv_load:all
```
- Run Entire Test Suite
```$ bundle exec rspec
```
- [Local Deployment](http://localhost:3000/)
```$rails s
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
- [Heroku Deployment:](https://morning-dusk-73772.herokuapp.com/) For Production

### Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)
