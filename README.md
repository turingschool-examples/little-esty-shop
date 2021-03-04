# Little Esty Shop

##About This Project
https://app.dbdesigner.net/designer/schema/396241
###Built With
  -Rails
  -Ruby
  -HTML
  -PostgreSQL
## Background and Description
"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices. We approached this project with four people for which we delegated tasks equally between all four of us. Katy La Tour and Jesus Quezada-Guillen took on the merchant side of the platform and Jeremiah Michlitsch and Joseph Budina took on the admin portion of the platform. A large focus of this project was to demonstrate the functionality built by many to many relationships within a relational database. Among these relationships lives several different tables titled Merchants, Items, Invoice Items, Invoices, Transactions, and Customers.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

##Set Up
- Run These Following Steps to Run This Program on Your Local Machine
- As a pre-requisite the project requires Rails 5.2.4.3 to be installed locally.
- Heres how to install Rails
```
gem install rails -v 5.2.4.3
```

-Next Clone The Repo - https://github.com/klatour324/little-esty-shop
-Then ```bundle install```
-Create The Database With ```rails db:{create, migrate}```
-Run The Rake Task With ```rake csv_load:all```, This Command Loads All The CSV Files Into Your Database
-Make Sure Rails Server is Running With The Following Command: ```rails s```
-Go to ```localhost:3000``` on Your Browser
##Project Overview
###Welcome Page
-When visiting our application welcome page, it does not have direct links to direct you to the admin or the merchant. In the future, we would like to add these to make it more user friendly and could allow for authentication for logins for an admin or a specific merchant user.

###Dashboards
-Merchant Dashboard
Provides Links to Merchant's Items and Invoices to see further statistics on each object the merchant has.
It will show the items that are ready to be shipped and in order by least recent (oldest to newest)
Will also display a Merchant's Top Five Customers and the Total Purchases for each Customer  
-Admin Dashboard
To get to Admin Dashboard, you need to visit ```localhost:3000/admin```
It will show the invoices that are Incomplete
Will also provide the Top Five Customers in General with the Most Successful Transactions in the Database
Also provides links to a Index with all the Merchants and an Index with all Invoices

###Show Page
-Item Show Page
Displays an Item's Description and the Current Price
-Invoice Show Page
 Displays an Invoice's Status, Created On Date, and Total Revenue
 Allows for the Item Status to be Updated
 -Admin Merchant Show Page
 Displays Name of Merchant and ability to update that Name

 In addition, please explore the functionality of updating an Item, Invoice, or Merchant 
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
