# Little Esty Shop

This platform is designed for merchants and merchants alike to be able to see key data, manage inventory, and fulfill their daily financial tasks. Little Esty's Shop is designed to make daily tasks more efficient and accessible.

## Installation

- clone this repository
- cd into the repository and run ```bundle install```
- open the repository on your chosen text editor
- run:
* ```rails db:setup```
* ```rails csv_load:all```
    *note: csv_load:all is to load the original database records. if you wish not to have those records, skip that command.* 
- run all the tests with ```bundle exec rspec``` to make sure everyhting is working properly!

## Usage

#### Admin

As an Admin, you can access quite a bit of information. for example, you may access:

- Merchants
![Image of Admin Merchants Index](./app/images/admin_merchant_index.png)
    * Enable/Disable the merchant
    * See the top five merchants in the database, with their total revenue and best day
    * A list of enabled and disabled merchants, respectively
    * Create a new Merchant
    * Access a merchant's specific page, where you can update that merchant

- Invoices
    * A list of all open invoices
    * Access to each invoice, where you can:
        * Update the status
        * See the name of the customer
        * See each item on the invoice
        * See the total revenue from that invoice
    ![Image of Admin Invoice Show](./app/images/admin_invoice_show.png)

#### Merchant

As a Merchant, you can also access a decent amount of information. for example, you can access:

- Dashboard
    ![Image of Merchant Dashboard](./app/images/merchant_dashboard.png)
    * See the top five customers
    * See all unshipped items
    * Access to the merchants invoices and items

- Items
    * See a list of enabled and disabled items, respectively
    * See the top 5 items with it's sales
    * Create a new item for the merchant

- Invoices
    * See a list of the merchants invoices with its status and a link to that invoices show page



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

This project requires Ruby 2.5.3.

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

## Evaluation

At the end of the project, you will be assessed based on [this Rubric](./doc/rubric.md)
