
# Little Esty Shop
> Marketplace app allowing the selling of items.

Little Esty Shop offers a platform for Merchants to sell their wares without the fear of violating a naming copyright. The app allows for administrative access to manage the merchants and their invoices.

The app utilizes several Relationships which laid out looks like:

![image](https://user-images.githubusercontent.com/62969459/109731902-5eff9700-7b79-11eb-961f-fa6647176629.png)


## Installation

This steps will guide you through the installation process for the app:

# Set up

First, make sure the gems that are required are installed:

```
bundle
```
Next you will need to set up your local database:

```
rails db:setup
```
This creates a development and testing database. As well as migrating the migrations.

# Database seeding

If you require data for development there are included `csv` files that allow you to use dummy data.

Just run:

```
rails csv_load:all
```

This will run the rake import task and seed your database.

# Starting the app

First, you must start a local server:

```
rails server
```
or
```
rails s
```
With the local server running you can use the browser of your choice to visit http://localhost:3000


## Testing Environment

Rspec was used in testing the app. To run the test suite, simply type:

```
bundle exec rspec
```

## Release History

* 0.0.1
    * Work in progress

## Contributors

Diana20920 <br>
MGonzales26 <br>
kylejschulz <br>
javolpe <br>

### Base Repo

BrianZanti <br>
timomitchel <br>
scottalexandra

