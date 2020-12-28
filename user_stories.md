# User Stories

## Merchants

### Merchant Dashboard

```
Merchant Dashboard

As a merchant,
When I visit my merchant dashboard (/merchant/:merchant_id/dashboard)
Then I see the name of my merchant
```

```
Merchant Dashboard Links

As a merchant,
When I visit my merchant dashboard
Then I see link to my merchant items index (/merchant/:merchant_id/items)
And I see a link to my merchant invoices index (/merchant/:merchant_id/invoices)
```

```
Merchant Dashboard Statistics - Favorite Customer

As a merchant,
When I visit my merchant dashboard
Then I see the names of the top 5 customers
who have conducted the largest number of successful transactions with my merchant
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
When I visit my merchant items index page ("merchant/merchant_id/items")
I see a list of the names of all of my items
And I do not see items for any other merchant
```

```
Merchant Items Show Page

As a merchant,
When I click on the name of an item from the merchant items index page,
Then I am taken to that merchant's item's show page (/merchant/merchant_id/items/item_id)
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
```

```
Merchant Items Index: Top Item's Best Day

When I visit the items index page
Then next to each of the 5 most popular items I see the date with the most sales for each item.
And I see a label “Top selling date for <item name> was <date with most sales>"

Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
```

Possible extensions:
filtering items index page
Enabled/disabled
Sorting in items alphabetical order

### Merchant Invoices

When a customer purchases something from the shop, a new invoice will be created in the system. A Merchant needs to be able to fulfill orders for their items on invoices.

```
Merchant Invoice Show Page

As a merchant
When I click on an invoice id from the Merchant Dashboard
Then I am taken to my show page for that invoice (/merchant/:merchant_id/invoices/:invoice_id)
And I see information related to that invoice including:
- Invoice id
- Invoice status
- Invoice created_at date in the format "Monday, July 18, 2019"
```

```
Merchant Invoice Show Page: Customer Information

As a merchant
When I visit my merchant invoice show page
Then I see all of the customer information related to that invoice including:
- Customer First and last name
- Shipping Address
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

# Admins

### Admin Dashboard

```
As an admin,
When I visit the admin dashboard (/admin)
Then I see a header indicating that I am on the admin dashboard
```

```
Admin Dashboard Links
Then I see the following links:
- A link to the admin merchants index (/admin/merchants)
- A link to the admin invoices index (/admin/invoices)
```

### Admin Merchants

```
As an admin,

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
```

```
Admin Invoice Show Page: Customer Information

As an admin
When I visit an admin invoice show page
Then I see all of the customer information related to that invoice including:
- Customer First and last name
- Shipping Address
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
Admin Invoice Show Page: Update Invoice Item Status

As an admin
When I visit an admin invoice show page
I see that each invoice item status is a select field
And I see that the invoice item's current status is selected
When I click this select field,
Then I can select a new status for the Item,
And next to the select field I see a button to "Update Item Status"
When I click this button
I am taken back to the admin invoice show page
And I see that my Item's status has now been updated
```

```
Admin Invoice Show Page: Update Shipping

As an admin
When I visit an admin invoice show page
Then I see a link to "Update Shipping Address"
When I click this link
Then I am taken to a new page where I see a form
And in this form I see fields for each address component
And I see that the current address information is prepopulated in these fields
When I change any of this information
And I click submit
Then I am taken back to the admin invoice show page
And I see that the shipping information is now updated
```

```
Admin Invoice Show Page: Update Invoice Item Quantity and Price

As an admin
When I visit an admin invoice show page
Then next to each Item name I see a link to "Update Invoice Item"
When I click this link
Then I am taken to a new page where I see a form
And in this form I see fields for the quantity and unit price
And I see that the current quantity and unit price are prepopulated in these fields
When I change any of this information
And I click submit
Then I am taken back to the admin invoice show page
And I see that invoice item's information is now updated
```


### Admin Dashboard

```
Admin Dashboard Merchant Index
As an admin when I visit the admin dashboard, I see a list of all merchant’s names.
each merchant name links to the merchant dashboard
next to each name I see insights about the merchant
```

```
Total Revenue for each merchant

As an admin, when I visit the admin dashboard, I see a list of all the merchant’s names. Next to each name I see the total revenue for that merchant.

*include only successful transactions
```


### API CONSUMPTION

Github API
Add user stories for API consumption


## OPEN ENDED FEATURE

Merchant Item Discounts
As a merchant, I want to create bulk discounts on specific items so that customers are incentivised to purchase more from me.
* Add more information from the old bulk discounts final project.
This feature should include full CRUD functionality for discounts.
Discounts are specific to each merchant
Students are responsible for defining additional database tables, models and relationships. Use of a database diagram is highly encouraged.
Students are responsible for determining where the discount CRUD functionality lives in the app. Use of wireframes is highly encouraged.
Students do not need to add functionality to apply the discounts to invoices, only CRUD discounts for individual merchants.


```
Merchant Invoices Index Page

As a merchant when I visit the merchant invoices index page
I see a list of all of the invoices that belong to that merchant including the:
- invoice id
- status
```

```
Merchant Dashboard Statistics
Merchant Dashboard Statistics - customer count
When I visit the merchant dashboard for each specific merchant (/merchant/:merchant_id/dashboard) I see the total number of customers that merchant has.
```
