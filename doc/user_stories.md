# User Stories

These user stories will require you to build many pages. This repo includes wireframes for the following pages:

* [Merchant Dashboard](./wireframes/Merchant_Dashboard.png)
* [Merchant Items Index](./wireframes/Merchant_Items.png)
* [Merchant Items Show](./wireframes/Merchant_Item_Show.png)
* [Merchant Invoices Index](./wireframes/Merchant_Invoices.png)
* [Merchant Invoices Show](./wireframes/Merchant_Invoice_Show.png)
* [Admin Dashboard](./wireframes/Admin_Dashboard.png)
* [Admin Merchants Index](./wireframes/Admin_Merchants.png)
* [Admin Merchants Show](./wireframes/Admin_Merchant_Show.png)
* [Admin Invoices Index](./wireframes/Admin_Invoices.png)
* [Admin Invoices Show](./wireframes/Admin_Invoice_Show.png)

## Merchants

### Merchant Dashboard

```
Merchant Dashboard

As a merchant,
When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
Then I see the name of my merchant
```

```
Merchant Dashboard Links

As a merchant,
When I visit my merchant dashboard
Then I see link to my merchant items index (/merchants/merchant_id/items)
And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)
```

```
Merchant Dashboard Statistics - Favorite Customers

As a merchant,
When I visit my merchant dashboard
Then I see the names of the top 5 customers
who have conducted the largest number of successful transactions with my merchant
And next to each customer name I see the number of successful transactions they have
conducted with my merchant
```

```
Merchant Dashboard Items Ready to Ship

As a merchant
When I visit my merchant dashboard
Then I see a section for "Items Ready to Ship"
In that section I see a list of the names of all of my items that
have been ordered and have not yet been shipped,
And next to each Item I see the id of the invoice that ordered my item
And each invoice id is a link to my merchant's invoice show page
```

```
Merchant Dashboard Invoices sorted by least recent

As a merchant
When I visit my merchant dashboard
In the section for "Items Ready to Ship",
Next to each Item name I see the date that the invoice was created
And I see the date formatted like "Monday, July 18, 2019"
And I see that the list is ordered from oldest to newest
```

###  Merchant Items

```
Merchant Items Index Page

As a merchant,
When I visit my merchant items index page ("merchants/merchant_id/items")
I see a list of the names of all of my items
And I do not see items for any other merchant
```

```
Merchant Items Show Page

As a merchant,
When I click on the name of an item from the merchant items index page,
Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)
And I see all of the item's attributes including:

- Name
- Description
- Current Selling Price
```

```
Merchant Item Update

As a merchant,
When I visit the merchant show page of an item
I see a link to update the item information.
When I click the link
Then I am taken to a page to edit this item
And I see a form filled in with the existing item attribute information
When I update the information in the form and I click ‘submit’
Then I am redirected back to the item show page where I see the updated information
And I see a flash message stating that the information has been successfully updated.
```

```
Merchant Item Disable/Enable

As a merchant
When I visit my items index page
Next to each item name I see a button to disable or enable that item.
When I click this button
Then I am redirected back to the items index
And I see that the items status has changed
```

```
Merchant Items Grouped by Status

As a merchant,
When I visit my merchant items index page
Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
And I see that each Item is listed in the appropriate section
```

```
Merchant Item Create

As a merchant
When I visit my items index page
I see a link to create a new item.
When I click on the link,
I am taken to a form that allows me to add item information.
When I fill out the form I click ‘Submit’
Then I am taken back to the items index page
And I see the item I just created displayed in the list of items.
And I see my item was created with a default status of disabled.
```

```
Merchant Items Index: 5 most popular items

As a merchant
When I visit my items index page
Then I see the names of the top 5 most popular items ranked by total revenue generated
And I see that each item name links to my merchant item show page for that item
And I see the total revenue generated next to each item name

Notes on Revenue Calculation:
- Only invoices with at least one successful transaction should count towards revenue
- Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
- Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
```

```
Merchant Items Index: Top Item's Best Day

When I visit the items index page
Then next to each of the 5 most popular items I see the date with the most sales for each item.
And I see a label “Top selling date for <item name> was <date with most sales>"

Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
```

### Merchant Invoices

When a customer purchases something from the shop, a new invoice will be created in the system. A Merchant needs to be able to fulfill orders for their items on invoices.

```
Merchant Invoices Index

As a merchant,
When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
Then I see all of the invoices that include at least one of my merchant's items
And for each invoice I see its id
And each id links to the merchant invoice show page
```

```
Merchant Invoice Show Page

As a merchant
When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
Then I see information related to that invoice including:
- Invoice id
- Invoice status
- Invoice created_at date in the format "Monday, July 18, 2019"
- Customer first and last name
```

```
Merchant Invoice Show Page: Invoice Item Information

As a merchant
When I visit my merchant invoice show page
Then I see all of my items on the invoice including:
- Item name
- The quantity of the item ordered
- The price the Item sold for
- The Invoice Item status
And I do not see any information related to Items for other merchants
```

```
Merchant Invoice Show Page: Total Revenue

As a merchant
When I visit my merchant invoice show page
Then I see the total revenue that will be generated from all of my items on the invoice
```

```
Merchant Invoice Show Page: Update Item Status

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
```

## Admins

### Admin Dashboard

```
Admin Dashboard

As an admin,
When I visit the admin dashboard (/admin)
Then I see a header indicating that I am on the admin dashboard
```

```
Admin Dashboard Links

As an admin,
When I visit the admin dashboard (/admin)
Then I see a link to the admin merchants index (/admin/merchants)
And I see a link to the admin invoices index (/admin/invoices)
```

```
Admin Dashboard Statistics - Top Customers

As an admin,
When I visit the admin dashboard
Then I see the names of the top 5 customers
who have conducted the largest number of successful transactions
And next to each customer name I see the number of successful transactions they have
conducted
```

```
Admin Dashboard Incomplete Invoices

As an admin,
When I visit the admin dashboard
Then I see a section for "Incomplete Invoices"
In that section I see a list of the ids of all invoices
That have items that have not yet been shipped
And each invoice id links to that invoice's admin show page
```

```
Admin Dashboard Invoices sorted by least recent

As an admin,
When I visit the admin dashboard
In the section for "Incomplete Invoices",
Next to each invoice id I see the date that the invoice was created
And I see the date formatted like "Monday, July 18, 2019"
And I see that the list is ordered from oldest to newest
```

### Admin Merchants

```
Admin Merchants Index

As an admin,
When I visit the admin merchants index (/admin/merchants)
Then I see the name of each merchant in the system
```

```
Admin Merchant Show

As an admin,
When I click on the name of a merchant from the admin merchants index page,
Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
And I see the name of that merchant
```

```
Admin Merchant Update

As an admin,
When I visit a merchant's admin show page
Then I see a link to update the merchant's information.
When I click the link
Then I am taken to a page to edit this merchant
And I see a form filled in with the existing merchant attribute information
When I update the information in the form and I click ‘submit’
Then I am redirected back to the merchant's admin show page where I see the updated information
And I see a flash message stating that the information has been successfully updated.
```

```
Admin Merchant Enable/Disable

As an admin,
When I visit the admin merchants index
Then next to each merchant name I see a button to disable or enable that merchant.
When I click this button
Then I am redirected back to the admin merchants index
And I see that the merchant's status has changed
```

```
Admin Merchants Grouped by Status

As an admin,
When I visit the admin merchants index
Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
And I see that each Merchant is listed in the appropriate section
```

```
Admin Merchant Create

As an admin,
When I visit the admin merchants index
I see a link to create a new merchant.
When I click on the link,
I am taken to a form that allows me to add merchant information.
When I fill out the form I click ‘Submit’
Then I am taken back to the admin merchants index page
And I see the merchant I just created displayed
And I see my merchant was created with a default status of disabled.
```

```
Admin Merchants: Top 5 Merchants by Revenue

As an admin,
When I visit the admin merchants index
Then I see the names of the top 5 merchants by total revenue generated
And I see that each merchant name links to the admin merchant show page for that merchant
And I see the total revenue generated next to each merchant name

Notes on Revenue Calculation:
- Only invoices with at least one successful transaction should count towards revenue
- Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
- Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
```

```
Admin Merchants: Top Merchant's Best Day

As an admin,
When I visit the admin merchants index
Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant.
And I see a label “Top selling date for <merchant name> was <date with most sales>"

Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
```

### Admin Invoices

```
Admin Invoices Index Page

As an admin,
When I visit the admin Invoices index ("/admin/invoices")
Then I see a list of all Invoice ids in the system
Each id links to the admin invoice show page
```

```
Admin Invoice Show Page

As an admin,
When I visit an admin invoice show page
Then I see information related to that invoice including:
- Invoice id
- Invoice status
- Invoice created_at date in the format "Monday, July 18, 2019"
- Customer first and last name
```

```
Admin Invoice Show Page: Invoice Item Information

As an admin
When I visit an admin invoice show page
Then I see all of the items on the invoice including:
- Item name
- The quantity of the item ordered
- The price the Item sold for
- The Invoice Item status
```

```
Admin Invoice Show Page: Total Revenue

As an admin
When I visit an admin invoice show page
Then I see the total revenue that will be generated from this invoice
```

```
Admin Invoice Show Page: Update Invoice Status

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
```

## Github API Consumption

For each of these stories, you will need to hit an endpoint provided by the GitHub API in order to serve the data required on your site.

```
GitHub API: Repo Name

As a visitor or an admin user
When I visit any page on the site
I see the name of the Github repo somewhere on the site
```

```
GitHub API: User Names

As a visitor or an admin user
When I visit any page on the site
I see the Github usernames of myself and my teammates somewhere on the site
The most up to date usernames are always displayed
```

```
GitHub API: Commits

As a visitor or an admin user
When I visit any page on the site
I see the number of commits next to each Github username
This number is updated as each member of the team contributes more commits
```

```
GitHub API: PRs

As a visitor or an admin user
When I visit any page on the site
I see the number of merged PRs across all team members
This number is updated as each member of the team merges more PRs
```
