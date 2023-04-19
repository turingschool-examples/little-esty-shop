# Little Esty Shop

## About

**Little Esty Shop** is a fictitious e-commerce platform that allows Merchants and Admins to view and manage their inventory and fulfill customer invoices.

This project was built as part of the Turing School of Software and Design's Back End Engineering curriculum. Through this project, our contributor team accomplished the following learning goals:

- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs and service objects to apply OOP principles to organize code

More information about the project requirements can be found [here](https://github.com/turingschool-examples/little-esty-shop).

## Built With

- ruby 2.7.4
- RSpec 3.12.0
  - rspec-core 3.12.1
  - rspec-expectations 3.12.2
  - rspec-mocks 3.12.5
  - rspec-support 3.12.0

## Getting Started

1. In your terminal, navigate to the directory you would like to host the repository in.
2. Clone the project repository and navigate to the main project directory:

```
git clone git@github.com:Brianisthebest/little-esty-shop.git
cd little-esty-shop
```

3. Run `bundle install` in your terminal to install project gems.

4. Ensure that Postgres is running, and run these commands to initialize the databases and set up database structure:

```
rails db:drop
rails db:create
rails db:migrate
```

5. Run `rake csv_load:all` in your terminal to load in data from the six CSVs stored locally in the application.

6. Run the `bundle exec rspec` command to see all of the Rspec tests run and ensure the program is running properly.

7. Run `rails s` to start the Rails server, and navigate to [localhost:3000](http://localhost:3000/) in your browser to explore!

## Testing

- To run model tests for this app, type the following command in your terminal from inside the cloned project folder:

```
bundle exec rspec spec/models
```

- To run model tests for this app, type the following command in your terminal from inside the cloned project folder:

```
bundle exec rspec spec/features
```

This application uses the `Simplecov` gem to monitor test coverage. Current coverage is at 100% for both model and feature tests.

## Deployment

This application is deployed with Render [here](https://little-esty-shop.onrender.com/).

## Project Status and Potential Next Steps

View the project management tracker and any open issues on [GitHub Projects](https://github.com/users/Brianisthebest/projects/2).

### Completed Functionality as of April 2023

The application currently has ten distinct pages built out, along with a general Welcome page accessible at the root path. These include simulated functionality for both Merchant users and Admin users.

Merchants can visit their own dashboard to view their items and invoices, examine statistics about their customers, and see a list of items ready to ship with invoice details. Merchants also have access to statistics about their items and invoices.

Merchants can view details about their items on dedicated item pages, can create and update item information and change the enabled status of their items.

Administrators can visit their own dashboard to see an overview of merchants and invoices, along with statistics about the global top 5 customers and invoice statuses across the entire application. Administrators can see details about merchants, create and update merchant information, and change the enabled status of a given merchant. These users can also manage invoices and view the total revenue generated from a given invoice.

Administrators can access statistics about merchant performance, including the top 5 merchants by revenue along with their best sales day.

Additionally, this application is connected to the [Unsplash API](https://unsplash.com/developers). Hitting these API endpoints allows the application to display a logo image on all pages, display related images for each item, and display a random photo for each merchant. The application also displays the number of likes that the logo has across all pages.

More information on the User Stories that guide this functionality can be found [here](https://github.com/turingschool-examples/little-esty-shop/blob/main/doc/user_stories.md).

### Looking Ahead

Potential contributors to this application may want to address any of the following:

- Styling to implement a more consistent look and feel throughout the application
- Filtering items, invoices, merchants, or other data to customize views for specific users and allow for additional searching/querying. This could be implemented with search boxes, check boxes, or comparative filters.
- Authentication and authorization, for either or both of the Merchant and Administrator user types.
- Additional e-commerce site functionality, including a shopping cart and communication with users such as a chat feature or personalized e-mails to users.

## Contributors

Branden Ge

- [GitHub](https://github.com/brandenge)
- [LinkedIn](https://www.linkedin.com/in/brandenge/)

Brian Guthrie

- [GitHub](https://github.com/Brianisthebest)
- [LinkedIn](https://www.linkedin.com/in/brian-guthrie-1bba73232/)

Caroline Peri

- [GitHub](https://github.com/cariperi)
- [LinkedIn](https://www.linkedin.com/in/carolineperi/)

Young Heon Koh

- [GitHub](https://github.com/kohyoungheon)
- [LinkedIn](https://www.linkedin.com/in/kohyoungheon/)
