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


App setup

Setup Board Automation
Deploy your application to Heroku
Setup Database tables and relationships based on csv data
Create a rake task to seed the database with the csv data

Welcome Page
Welcome Page
As a visitor, when I visit the welcome page (“/”), I see a greeting welcoming me to the site along with two buttons one for merchants and one for admins. 
The merchant button takes me to the merchant index page (‘/merchants)
The Admin button takes me to the admin dashboard (‘/admin/dashboard)

Navigation Bar
Navigation links
As a visitor, When I am on any page, I see a navigation bar that includes links for the following:
- a link to return to the welcome / home page of the application ("/") 
- a link to the merchant index page ("/merchants")
- a link to the admin dashboard (“/admin/dashboard”)

Merchant Index Page
List of Merchants
As a visitor when I visit the merchants index page I see a list of all the merchants' names. When I click on a name, I am taken to that merchant’s dashboard page (`/merchant/:merchant_id/dashboard`)
Merchant Dashboard
Merchant Dashboard Links
For each specific merchant I see a link to the items index page that lists all of the items that that merchant sells (/merchant/:merchant_id/items)
A link to see all of the invoices for that merchant (/merchant/:merchant_id/invoices)
Each invoice number links to the invoice show page
A link to see all of the transactions for that merchant (/merchant/:merchant_id/transactions)
Each transaction links to the transaction show page
Each transaction show page displays the information about the customer that made the transaction.
A section to display business intelligence information

MERCHANT ITEMS
Merchant Items Index Page
As a merchant, When I visit the merchant items index page ("merchant/merchant_id/items")
I see a list of all items that belong to that merchant that includes:
Item name
Merchant Items Show Page
As a merchant, When I click on the name of an item from the items index page, I am taken to that item's show page (/merchant/merchant_id/items/item_id) where I can see all of the items attributes including: 
Name
Description
Unit_price

Merchant Item Update 
As a merchant, When I visit the show page of an item, I see a link to update the item information. When I click the link I am taken to the items edit form (/merchant/merchant_id/items/item_id/edit)
I see a form filled in with the existing item attribute information. When I update the information in the form I click ‘submit’ and am redirected back to the item show page where I see the updated information and a flash message stating that the information has been successfully updated. 

Merchant Item Disable/Enable
As a merchant when I visit my items index page, next to each item name, I see an option to disable/enable an item. 
For example: 
If an item’s status is currently set to enabled I should see a button to disable that item. When I click on “disable”, the page should refresh and a button to enable that item should now be displayed. when I visit the item show page, I should see the current status of the item “disabled” displayed.
If an item’s status is currently set to disabled, I should see a button to enable that item. When I click on “enable”, the page should refresh and a button to enable that item should now be displayed. When I visit the items show page, I should see the current status of the item “enabled” displayed.

Merchant Item Create
As a merchant when I visit my items index page, I see a link to create a new item. When I click on the link, I am taken to a form that allows me to add item information. Once I fill out the form I click ‘Submit’ and am taken back to the items index page where I see the item I just created displayed in the list of items. Each new item should have a default status of disabled. 
Possible extensions:
filtering items index page
Enabled/disabled
Sorting in items alphabetical order
MERCHANT INVOICES
 Merchant Invoices Index Page
As a merchant when I visit the merchant invoices index page (/merchant/merchant_id/invoices)
I see a list of all of the invoices that belong to that merchant including the: 
- invoice id
- status
 Merchant Invoice Show Page
As a merchant when I click on an invoice id from the invoice index page, I am taken to the show page for that invoice (/merchant/merchant_id/invoices/invoice_id) where I can see all of the information related to that invoice including: 
Invoice id
Invoice status
Invoice created_at date
 Merchant Invoice Show Page: Customer Information
As a merchant when I click on an invoice id from the invoice index page, I am taken to the show page for that invoice (/merchant/merchant_id/invoices/invoice_id) where I can see all of the customer information related to that invoice including: 
Customer First and last name
shipping address
 Merchant Invoice Show Page: Invoice Item Information
As a merchant when I click on an invoice id from the invoice index page, I am taken to the show page for that invoice (/merchant/merchant_id/invoices/invoice_id) where I can see all of the customer information related to that invoice including: 
Item name
Item quantity
Item unit price
Total cost of all items on invoice

 Merchant Invoice Update
As a merchant when I visit the invoice show page, I see a form to update the status of an invoice. The form includes a select menu where I can select a new status for that invoice 
canceled, 
packaging, 
pending, 
shipped 
After selecting the new status, I click submit and see the page refresh. I should now see the new status reflected at the top of that invoices show page. 

MERCHANT ITEM STATISTICS
 Merchant Items Index Page Statistics - 5 most popular items
When I visit the merchant items index page ("/merchant/:merchant_id/items"), I see the top 5 most popular items ranked by total revenue generated. In addition to the total revenue, I want to see the quantity purchased for each item.

 Items Index Page Statistics - Top Items Best Day
When I visit the items index page ("/merchant/:merchant_id/items"), next to each of the 5 most popular items, I see the date with the most sales for each item. With a label “Top selling date for <item name> was <date with most sales>. 
* Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.

Merchant Dashboard Statistics
Merchant Dashboard Statistics - customer count
When I visit the merchant dashboard for each specific merchant (/merchant/:merchant_id/dashboard) I see the total number of customers that merchant has. 

Merchant Dashboard Statistics - Favorite Customer
When I visit the merchant dashboard for a specific merchant (/merchant/:merchant_id/dashboard) I see the top 5 customers who have conducted the largest number of successful transactions. 

ADMIN DASHBOARD
 Admin Dashboard Merchant Index
As an admin when I visit the admin dashboard, I see a list of all merchant’s names.
each merchant name links to the merchant dashboard
next to each name I see insights about the merchant

 Total Revenue for each merchant
As an admin, when I visit the admin dashboard, I see a list of all the merchant’s names. Next to each name I see the total revenue for that merchant.
*include only successful transactions 

API CONSUMPTION
Github API 
Add user stories for API consumption


OPEN ENDED FEATURE
Merchant Item Discounts
As a merchant, I want to create bulk discounts on specific items so that customers are incentivised to purchase more from me.
*Add more information from the old bulk discounts final project.
This feature should include full CRUD functionality for discounts.
Discounts are specific to each merchant
Students are responsible for defining additional database tables, models and relationships. Use of a database diagram is highly encouraged.
Students are responsible for determining where the discount CRUD functionality lives in the app. Use of wireframes is highly encouraged.
Students do not need to add functionality to apply the discounts to invoices, only CRUD discounts for individual merchants.









