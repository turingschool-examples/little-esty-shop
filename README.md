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
- must use GitHub branching, team code reviews via GitHub PR comments, and either GitHub Projects or a project management tool of your group's choice (Trello, Notion, etc.)
- must include a thorough README to describe the project
   - README should include a basic description of the project, a summary of the work completed, and some ideas for a potential contributor to work on/refactor next. Also include the names and GitHub links of all student contributors on your project. 
- must deploy completed code to Heroku
- Continuous Integration / Continuous Deployment is not allowed
- Use of scaffolding is not allowed
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
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

<details>
<summary>User Stories</summary>
Merchants
Merchant Dashboard

1. Merchant Dashboard

As a merchant,
When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
Then I see the name of my merchant

2. Merchant Dashboard Links

As a merchant,
When I visit my merchant dashboard
Then I see link to my merchant items index (/merchants/merchant_id/items)
And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)

3. Merchant Dashboard Statistics - Favorite Customers

As a merchant,
When I visit my merchant dashboard
Then I see the names of the top 5 customers
who have conducted the largest number of successful transactions with my merchant
And next to each customer name I see the number of successful transactions they have
conducted with my merchant

4. Merchant Dashboard Items Ready to Ship

As a merchant
When I visit my merchant dashboard
Then I see a section for "Items Ready to Ship"
In that section I see a list of the names of all of my items that
have been ordered and have not yet been shipped,
And next to each Item I see the id of the invoice that ordered my item
And each invoice id is a link to my merchant's invoice show page

5. Merchant Dashboard Invoices sorted by least recent

As a merchant
When I visit my merchant dashboard
In the section for "Items Ready to Ship",
Next to each Item name I see the date that the invoice was created
And I see the date formatted like "Monday, July 18, 2019"
And I see that the list is ordered from oldest to newest

Merchant Items

6. Merchant Items Index Page

As a merchant,
When I visit my merchant items index page ("merchants/merchant_id/items")
I see a list of the names of all of my items
And I do not see items for any other merchant

7. Merchant Items Show Page

As a merchant,
When I click on the name of an item from the merchant items index page,
Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
And I see all of the item's attributes including:

- Name
- Description
- Current Selling Price

8. Merchant Item Update

As a merchant,
When I visit the merchant show page of an item
I see a link to update the item information.
When I click the link
Then I am taken to a page to edit this item
And I see a form filled in with the existing item attribute information
When I update the information in the form and I click ‘submit’
Then I am redirected back to the item show page where I see the updated information
And I see a flash message stating that the information has been successfully updated.


9. Merchant Item Disable/Enable

As a merchant
When I visit my items index page
Next to each item name I see a button to disable or enable that item.
When I click this button
Then I am redirected back to the items index
And I see that the items status has changed

10. Merchant Items Grouped by Status

As a merchant,
When I visit my merchant items index page
Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
And I see that each Item is listed in the appropriate section

11. Merchant Item Create

As a merchant
When I visit my items index page
I see a link to create a new item.
When I click on the link,
I am taken to a form that allows me to add item information.
When I fill out the form I click ‘Submit’
Then I am taken back to the items index page
And I see the item I just created displayed in the list of items.
And I see my item was created with a default status of disabled.

12. Merchant Items Index: 5 most popular items

As a merchant
When I visit my items index page
Then I see the names of the top 5 most popular items ranked by total revenue generated
And I see that each item name links to my merchant item show page for that item
And I see the total revenue generated next to each item name

Notes on Revenue Calculation:
- Only invoices with at least one successful transaction should count towards revenue
- Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
- Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

13. Merchant Items Index: Top Item's Best Day

As a merchant
When I visit my items index page
Then next to each of the 5 most popular items I see the date with the most sales for each item.
And I see a label “Top selling date for <item name> was <date with most sales>"

Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
Merchant Invoices
When a customer purchases something from the shop, a new invoice will be created in the system. A Merchant needs to be able to fulfill orders for their items on invoices.

14. Merchant Invoices Index

As a merchant,
When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
Then I see all of the invoices that include at least one of my merchant's items
And for each invoice I see its id
And each id links to the merchant invoice show page

15. Merchant Invoice Show Page

As a merchant
When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
Then I see information related to that invoice including:
- Invoice id
- Invoice status
- Invoice created_at date in the format "Monday, July 18, 2019"
- Customer first and last name

16. Merchant Invoice Show Page: Invoice Item Information

As a merchant
When I visit my merchant invoice show page
Then I see all of my items on the invoice including:
- Item name
- The quantity of the item ordered
- The price the Item sold for
- The Invoice Item status
And I do not see any information related to Items for other merchants

17. Merchant Invoice Show Page: Total Revenue

As a merchant
When I visit my merchant invoice show page
Then I see the total revenue that will be generated from all of my items on the invoice

18. Merchant Invoice Show Page: Update Item Status

As a merchant
When I visit my merchant invoice show page
I see that each invoice item status is a select field
And I see that the invoice item's current status is selected
When I click this select field,
Then I can select a new status for the Item,
And next to the select field I see a button to "Update Item Status"
When I click this button
I am taken back to the merchant invoice show page
And I see that my Item's status has now been updated

Admins
Admin Dashboard

19. Admin Dashboard

As an admin,
When I visit the admin dashboard (/admin)
Then I see a header indicating that I am on the admin dashboard

20. Admin Dashboard Links

As an admin,
When I visit the admin dashboard (/admin)
Then I see a link to the admin merchants index (/admin/merchants)
And I see a link to the admin invoices index (/admin/invoices)

21. Admin Dashboard Statistics - Top Customers

As an admin,
When I visit the admin dashboard
Then I see the names of the top 5 customers
who have conducted the largest number of successful transactions
And next to each customer name I see the number of successful transactions they have
conducted

22. Admin Dashboard Incomplete Invoices

As an admin,
When I visit the admin dashboard
Then I see a section for "Incomplete Invoices"
In that section I see a list of the ids of all invoices
That have items that have not yet been shipped
And each invoice id links to that invoice's admin show page

23. Admin Dashboard Invoices sorted by least recent

As an admin,
When I visit the admin dashboard
In the section for "Incomplete Invoices",
Next to each invoice id I see the date that the invoice was created
And I see the date formatted like "Monday, July 18, 2019"
And I see that the list is ordered from oldest to newest
Admin Merchants

24. Admin Merchants Index

As an admin,
When I visit the admin merchants index (/admin/merchants)
Then I see the name of each merchant in the system

25. Admin Merchant Show

As an admin,
When I click on the name of a merchant from the admin merchants index page,
Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
And I see the name of that merchant

26. Admin Merchant Update

As an admin,
When I visit a merchant's admin show page
Then I see a link to update the merchant's information.
When I click the link
Then I am taken to a page to edit this merchant
And I see a form filled in with the existing merchant attribute information
When I update the information in the form and I click ‘submit’
Then I am redirected back to the merchant's admin show page where I see the updated information
And I see a flash message stating that the information has been successfully updated.

27. Admin Merchant Enable/Disable

As an admin,
When I visit the admin merchants index
Then next to each merchant name I see a button to disable or enable that merchant.
When I click this button
Then I am redirected back to the admin merchants index
And I see that the merchant's status has changed

28. Admin Merchants Grouped by Status

As an admin,
When I visit the admin merchants index
Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
And I see that each Merchant is listed in the appropriate section

29. Admin Merchant Create

As an admin,
When I visit the admin merchants index
I see a link to create a new merchant.
When I click on the link,
I am taken to a form that allows me to add merchant information.
When I fill out the form I click ‘Submit’
Then I am taken back to the admin merchants index page
And I see the merchant I just created displayed
And I see my merchant was created with a default status of disabled.

30. Admin Merchants: Top 5 Merchants by Revenue

As an admin,
When I visit the admin merchants index
Then I see the names of the top 5 merchants by total revenue generated
And I see that each merchant name links to the admin merchant show page for that merchant
And I see the total revenue generated next to each merchant name

Notes on Revenue Calculation:
- Only invoices with at least one successful transaction should count towards revenue
- Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
- Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

31. Admin Merchants: Top Merchant's Best Day

As an admin,
When I visit the admin merchants index
Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant.
And I see a label “Top selling date for <merchant name> was <date with most sales>"

Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.

Admin Invoices

32. Admin Invoices Index Page

As an admin,
When I visit the admin Invoices index ("/admin/invoices")
Then I see a list of all Invoice ids in the system
Each id links to the admin invoice show page

33. Admin Invoice Show Page

As an admin,
When I visit an admin invoice show page
Then I see information related to that invoice including:
- Invoice id
- Invoice status
- Invoice created_at date in the format "Monday, July 18, 2019"
- Customer first and last name

34. Admin Invoice Show Page: Invoice Item Information

As an admin
When I visit an admin invoice show page
Then I see all of the items on the invoice including:
- Item name
- The quantity of the item ordered
- The price the Item sold for
- The Invoice Item status

35. Admin Invoice Show Page: Total Revenue

As an admin
When I visit an admin invoice show page
Then I see the total revenue that will be generated from this invoice


36. Admin Invoice Show Page: Update Invoice Status

As an admin     
When I visit an admin invoice show page
I see the invoice status is a select field
And I see that the invoice's current status is selected
When I click this select field,
Then I can select a new status for the Invoice,
And next to the select field I see a button to "Update Invoice Status"
When I click this button
I am taken back to the admin invoice show page
And I see that my Invoice's status has now been updated
Unsplash API Consumption
For each of these stories, you will need to hit an endpoint provided by the Unsplash API in order to serve the data required on your site.



Unsplash API: App Logo

As a visitor or an admin user
When I visit any page on the site
I see the logo image at the top of every page

Note: You can choose which picture from Unsplash you'd like to be your app's logo. DO NOT save the image to your repo, but instead serve it up via the API.
Unsplash API: Item Image

As a visitor or an admin user
When I visit the Merchant Item Show page
I see a photo related to that item's name
Unsplash API: Merchant Image

As a visitor or an admin user
When I visit a Merchant's Dashboard
I see a random photo near their name
This photo should update to a new random photo each time the page is refreshed.
Unsplash API: Logo Image Like History

As a visitor or an admin user
When I visit any page on the site
I see that next to the app logo is the number of likes that image has. 

Note: Communicate with your teammate that is working on the first API story to make sure you're gathering statistics for the same image that they're displaying as the logo. 
</details>

## Group Summary

#### Linkedins: 

- Reilly Miller  [LinkedIn Profile](https://www.linkedin.com/in/reilly-miller-6b6131266/)
- Brandon Johnson [LinkedIn Profile](https://www.linkedin.com/in/brandon-j-94b740b2/)
- Dyson Breakstone [Linkedin Profile](https://www.linkedin.com/in/dyson-breakstone-4978291a2/)
- Andrew Bingham [LinkedIn Profile](https://www.linkedin.com/in/andrew-bingham1/)

#### DTR

[Our DTR for this Project](https://docs.google.com/document/d/15o00_780ppux6TBkeTCrZUQL7U3fXQ3O1-J-Lr4ejHY/edit)

#### Project description

This project is a fully functional application which simulates an online Etsy-style store, with individual merchants who each 
have their own stock of items. One can visit each Merchant's dashboard, which links to their item stock, which links to show pages 
for the particular item you want to view. There are statistics available on some pages for revenue generated by items and the top 
items's best day, as well as the top customers for that merchant. As a merchant, one can enable or disable items in their stock, 
add new items, edit existing ones, as well as view items that are ready to ship. One can also view one's invoices.

One can also visit the site as an administrator. Admins can add, edit, enable, or disable Merchants, view invoices, whether 
complete or incomplete, view top customers by number of transactions, manage invoices, view total revenue, and show the best
dates for the top 5 merchants on the site, with their total revenue generated.

Overall this site makes use of a SQL database seeded by CSV data in order to efficiently store and retrieve data for a hypothetical
online commerce platform. The work was split between the four contributors listed above in 9 days. 

<u>Ideas for how this could be improved by incoming contributors:</u>

There are some missing links. We added a welcome page, but it's missing the ability to checkout merchant pages so that information
has to be entered in the url. An option for admins to delete merchants could be added, but that might not be necessary since they can 
currently be disabled, which is reversible. The same could be said of Merchants' items. Another thing that should be added in a fully
deployed version of this app would be the ability to sign in and authenticate oneself as a merchant or administrator. The most obvious 
refactor would be that the styling on the page is relatively rudimentary. Since this project was primarily focused on backend functionality,
the UI leaves something to be desired (although we're all proud of the work that we put in).