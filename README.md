<img width="880" alt="Screen Shot 2022-09-21 at 1 24 13 PM" src="https://user-images.githubusercontent.com/102133027/191592811-8d89d231-457a-4eee-a74c-9ccbb70612f1.png">


# Bulk Discounts
This project is an extension of the Little Esty Shop group project. You will add functionality for merchants to create bulk discounts for their items. A "bulk discount" is a discount based on the quantity of items the customer is buying, for example "20% off orders of 10 or more items".

## Learning Goals
- Write migrations to create tables and relationships between tables
- Implement CRUD functionality for a resource using forms (form_tag or form_with), buttons, and links
- Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
- Use built-in ActiveRecord methods to join multiple tables of data, make calculations, and group data based on one or more attributes
- Write model tests that fully cover the data logic of the application
- Write feature tests that fully cover the functionality of the application

## Deets
- This is a solo project, to be completed alone without assistance from cohortmates, alumni, mentors, rocks, etc.
- Additional gems to be added to the project must have instructor approval. (RSpec, Capybara, Shoulda-Matchers, Orderly, HTTParty, Launchy, Faker are pre-approved)
- Scaffolding is not permitted on this project.
- This project must be deployed to Heroku.


## Rubric

4: Exceptional	One or more additional extension features complete.	Students implement strategies not discussed in class and can defend their design decisions (callbacks, scopes, application_helper view methods are created, etc)	ActiveRecord helpers are utilized whenever possible. ActiveRecord is used in a clear and effective way to read/write data including use of grouping, aggregating, and joining. Very little Ruby is used to process data.	Very clear Test Driven Development. Test files are extremely well organized and nested. Students can point to multiple examples of edge case testing that are not included in the user stories.

## Bulk Discounts
Bulk Discounts are subject to the following criteria:

- Bulk discounts should have a percentage discount as well as a quantity threshold
- Bulk discounts should belong to a Merchant
- A Bulk discount is eligible for all items that the merchant sells. Bulk discounts for one merchant should not affect items sold by another merchant
- Merchants can have multiple bulk discounts
  - If an item meets the quantity threshold for multiple bulk discounts, only the one with the greatest percentage discount should be applied
- Bulk discounts should apply on a per-item basis
  - If the quantity of an item ordered meets or exceeds the quantity threshold, then the percentage discount should apply to that item only. Other items that did not meet the quantity threshold will not be affected.
  - The quantities of items ordered cannot be added together to meet the quantity thresholds, e.g. a customer cannot order 1 of Item A and 1 of Item B to meet a quantity threshold of 2. They must order 2 or Item A and/or 2 of Item B

### Examples
#### Example 1

- Merchant A has one Bulk Discount
  - Bulk Discount A is 20% off 10 items
- Invoice A includes two of Merchant A's items
  - Item A is ordered in a quantity of 5
  - Item B is ordered in a quantity of 5
In this example, no bulk discounts should be applied.

#### Example 2

- Merchant A has one Bulk Discount
  - Bulk Discount A is 20% off 10 items
- Invoice A includes two of Merchant A's items
  - Item A is ordered in a quantity of 10
  - Item B is ordered in a quantity of 5
In this example, Item A should be discounted at 20% off. Item B should not be discounted.

#### Example 3

- Merchant A has two Bulk Discounts
  - Bulk Discount A is 20% off 10 items
  - Bulk Discount B is 30% off 15 items
- Invoice A includes two of Merchant A's items
  - Item A is ordered in a quantity of 12
  - Item B is ordered in a quantity of 15
In this example, Item A should discounted at 20% off, and Item B should discounted at 30% off.

#### Example 4

- Merchant A has two Bulk Discounts
  - Bulk Discount A is 20% off 10 items
  - Bulk Discount B is 15% off 15 items
- Invoice A includes two of Merchant A's items
  - Item A is ordered in a quantity of 12
  - Item B is ordered in a quantity of 15
In this example, Both Item A and Item B should discounted at 20% off. Additionally, there is no scenario where Bulk Discount B can ever be applied.

#### Example 5

- Merchant A has two Bulk Discounts
  - Bulk Discount A is 20% off 10 items
  - Bulk Discount B is 30% off 15 items
- Merchant B has no Bulk Discounts
- Invoice A includes two of Merchant A's items
  - Item A1 is ordered in a quantity of 12
  - Item A2 is ordered in a quantity of 15
- Invoice A also includes one of Merchant B's items
  - Item B is ordered in a quantity of 15
In this example, Item A1 should discounted at 20% off, and Item A2 should discounted at 30% off. Item B should not be discounted.

## User Stories
```
Merchant Bulk Discounts Index

As a merchant
When I visit my merchant dashboard
Then I see a link to view all my discounts
When I click this link
Then I am taken to my bulk discounts index page
Where I see all of my bulk discounts including their
percentage discount and quantity thresholds
And each bulk discount listed includes a link to its show page
```
```
 Merchant Bulk Discount Create

As a merchant
When I visit my bulk discounts index
Then I see a link to create a new discount
When I click this link
Then I am taken to a new page where I see a form to add a new bulk discount
When I fill in the form with valid data
Then I am redirected back to the bulk discount index
And I see my new bulk discount listed
```
```
Merchant Bulk Discount Delete

As a merchant
When I visit my bulk discounts index
Then next to each bulk discount I see a link to delete it
When I click this link
Then I am redirected back to the bulk discounts index page
And I no longer see the discount listed
```
```
Merchant Bulk Discount Show

As a merchant
When I visit my bulk discount show page
Then I see the bulk discount's quantity threshold and percentage discount
```
```
Merchant Bulk Discount Edit

As a merchant
When I visit my bulk discount show page
Then I see a link to edit the bulk discount
When I click this link
Then I am taken to a new page with a form to edit the discount
And I see that the discounts current attributes are pre-poluated in the form
When I change any/all of the information and click submit
Then I am redirected to the bulk discount's show page
And I see that the discount's attributes have been updated
```
```
Merchant Invoice Show Page: Total Revenue and Discounted Revenue

As a merchant
When I visit my merchant invoice show page
Then I see the total revenue for my merchant from this invoice (not including
 discounts)
And I see the total discounted revenue for my merchant from this invoice
which includes bulk discounts in the calculation
```
```
Merchant Invoice Show Page: Link to applied discounts

As a merchant
When I visit my merchant invoice show page
Next to each invoice item I see a link to the show page for the bulk discount
that was applied (if any)
```
```
Admin Invoice Show Page: Total Revenue and Discounted Revenue

As an admin
When I visit an admin invoice show page
Then I see the total revenue from this invoice (not including discounts)
And I see the total discounted revenue from this invoice which includes bulk discounts in the calculation
As a merchant
When I visit the discounts index page
I see a section with a header of "Upcoming Holidays"
In this section the name and date of the next 3 upcoming US holidays are listed.

Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)
```

## Extensions
- When an invoice is pending, a merchant should not be able to delete or edit a bulk discount that applies to any of their items on that invoice.
- When an Admin marks an invoice as "completed", then the discount percentage should be stored on the invoice item record so that it can be referenced later
- Merchants should not be able to create/edit bulk discounts if they already have a discount in the system that would prevent the new discount from being applied (see example 4)
- Holiday Discount Extensions
```
Create a Holiday Discount

As a merchant,
when I visit the discounts index page,
In the Holiday Discounts section, I see a `create discount` button next to each of the 3 upcoming holidays.
When I click on the button I am taken to a new discount form that has the form fields auto populated with the following:

Discount name: <name of holiday> discount
Percentage Discount: 30
Quantity Threshold: 2

I can leave the information as is, or modify it before saving.
I should be redirected to the discounts index page where I see the newly created discount added to the list of discounts.
```
```
View a Holiday Discount

As a merchant (if I have created a holiday discount for a specific holiday),
when I visit the discount index page,
within the `Upcoming Holidays` section I should not see the button to 'create a discount' next to that holiday,
instead I should see a `view discount` link.
When I click the link I am taken to the discount show page for that holiday discount.
```


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
