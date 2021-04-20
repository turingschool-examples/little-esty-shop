# Little Esty Shop

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Database Design Schema
![database schema](https://user-images.githubusercontent.com/57960885/115322048-cb931d00-a14a-11eb-9699-eeabcfc0f76a.png)

---

## Setup & Getting Started

This project requires Ruby 2.5.3 & Rails 5.2.5.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `gem install rails --version 5.2.5`
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* To seed development database:
    * `rails csv_load:all` to load all CSV files. Or,
    * `rails csv_load:<table_name>` to load a single CSV file.
    * Run `rails csv_load:correction_seq_id` to reset primary keys.
    * Lastly, run `rails db:seed`
* Run your development server with `rails s` to see the app in action.

---

## Contributions

To add more content to this open source project, fork the repository, clone your fork, create a feature branch, push branch to GitHub and create a pull request for review. Any and all pull request will be considered by other collaborators.

Current collaborators:
  * @ochar721
  * @klaudiastewart
  * @gaelyn
