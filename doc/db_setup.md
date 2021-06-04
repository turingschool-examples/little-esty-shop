# Database Setup

This repo contains a directory `/db/data` that includes six csv files. You will write a Rake task that will seed your database with the data in those files.

Rake tasks give you the ability to execute tasks within Rails. You may have seen this before with commands like `rake db:create` and `rake db:seed`. In more recent versions of Rails, these commands are usually executed as `rails db:create`, `rails db:seed`, etc. but they are still utilizing Rake to execute them under the hood even though they don't include the `rake` executable in the command.

Your project will include a Rake task for each of the six csv files. For example, from the command line you should be able to run something like:

```bash
rails csv_load:customers
rails csv_load:invoice_items
rails csv_load:invoices
rails csv_load:items
rails csv_load:merchants
rails csv_load:transactions
```

After these commands, your database should be seeded with the data from the CSVs. You should be able to verify this by running a Rails Console session and doing some checks on your models.

Additionally, your project should contain a Rake Task that will execute the other six Rake Tasks at once, for example:

```bash
rails csv_load:all
```

Reference [this documentation](https://guides.rubyonrails.org/v5.2/command_line.html) for additional information about running tasks from the command line.

## Primary Key Sequence

Normally, when creating records with ActiveRecord we do not want to manually set the primary key attribute, for example `Artist.create(id: 1)`. Instead, we want to rely on ActiveRecord and the Database to automatically assign the ids based on a primary key sequence. However, each CSV file includes an `id` column that you should include when creating each record to maintain data integrity. Manually assigning the `id` attribute will invalidate the primary key sequence, so you should include code in your rake tasks that resets the primary key sequence for each table after the data is seeded.

## Schema Notes

* items have a `unit_price`. This is the price that the item is **currently** selling at.
* invoice_items also have a `unit_price`. This is the price the item sold at.
* Both `unit_price` columns in the CSV files are stored as cents, for example the value 1300 for a unit price is 1,300 cents, or 13.00 dollars. When storing the unit prices in your database, you should also store them as integers (integers are more accurate than floats). When displaying prices or doing calculations, you made need to do some conversion into dollars.
* In the CSV files, both invoice and invoice_item status are stored as strings. In your database, you should not store strings, and instead store integers that represent the different statuses. In your models, you should include an [enum](https://api.rubyonrails.org/v5.2.4.4/classes/ActiveRecord/Enum.html) for these statuses
