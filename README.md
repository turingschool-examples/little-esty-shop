# Little Esty Shop

## __Turing School of Software & Design Module 3 group project__

### Learning Goals for Little Esty Shop
* Designing a normalized database schema and defining model relationships
* Utilizing advanced routing techniques, including namespacing to organize and group like functionality together
* Utilizing advanced ActiveRecord techniques to perform complex database queries
* Consuming a public API while utilizing POROs as a way to apply OOP principles to organize code
#

### Contents
1. Setup
1. Project Structure
1. Application
1. Future Goals
1. Contributing
#

### Setup 

Little Esty Shop is a group project that simulates an e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices. The app is built with Ruby on Rails and uses a PostgreSQL database to store data
#

### Project Structure

#### Models
The `app/models` directory contains ActiveRecord model classes for the various database tables used by the app. These models define the relationships between tables and provide methods for performing complex database queries.

#### Controllers
The `app/controllers` directory contains controller classes for handling HTTP requests and rendering views. These controllers use the models to retrieve data from the database and pass it to the views.

#### Views
The `app/views` directory contains ERB templates for rendering HTML responses to HTTP requests. These templates are used by the controllers to generate the HTML that is sent back to the user's web browser.

#### Routes
The `config/routes.rb` file contains the routing configuration for the app. This file defines the URLs that can be accessed by users and maps them to specific controller actions.

#### Services
The `app/services` directory contains PORO classes that encapsulate business logic for the app. These classes are used to consume external APIs and perform other complex operations that don't fit neatly into the models or controllers.

#### Tests
The `spec` directory contains RSpec tests for the various components of the app. These tests ensure that the app is working as expected and catches bugs and errors before they can be deployed to production.
 
#### Schema
This diagram for the project shows the database tables and their relationships to one another:
![Screenshot 2023-02-25 at 4 32 30 PM](https://user-images.githubusercontent.com/116698937/222281686-2f394e27-784e-48eb-ade4-d9030d435a60.png)

#### Design
This wireframe demostrates an example of design used in pages of the application and the CSS implemented  
![Screenshot 2023-02-27 at 2 17 28 PM](https://user-images.githubusercontent.com/116698937/222283907-484f82e8-19a6-472b-8f30-1e0df59725a1.png)
#

### Application

You can visit this application hosted on heroku(link here)


To get started on your local machine, you'll need to have Ruby and PostgreSQL installed on your system. You can then follow these steps:

1. Clone the repo to your local machine using git clone
1. Install the necessary gems by running `bundle install`.
1. Create the PostgreSQL database by running `rails db:create`.
1. Run the database migrations by running `rails db:migrate`.
1. Seed the database with sample data by running `rails db:seed`.

You can then start the Rails server by running rails server and visiting http://localhost:3000 in your web browser.
#

### Future Goals

Project Status: _In Progress_

* Add more functionality for admins and merchants: such as analytics, automated reporting, and user management.
* Implement user authentication and authorization
* mplement chat functionality on the site
* Implement the functionality for visitors to start adding items to their cart
* Expand the API integration
* Optimize database queries
* Improve the front-end design and user experience: While the app is functional, the user interface could be improved to make it more visually appealing and easier to navigate. Implementing responsive design would also make the app accessible to a wider range of users across different devices

These are just a few examples of potential future goals to improve the "Little Esty Shop" app. Ultimately, the direction and scope of future improvements will depend on the needs and goals of the businesses using the platform.
#
### Contributing
This application was developed by:
* [Adam Bailey](ab67319@gmail.com) Most Valuable Coder (MVC)
* [Dawson Timmons](dawsontimmons@gmail.com)
* [Chris Crane](chrisjcrane@gmail.com)
* [Harrison Ryan](https://github.com/hwryan12)

If you'd like to contribute to Little Esty Shop, you can fork the repo and make your changes in a new branch. Once you're happy with your changes, create a pull request to merge your changes back into the main branch.
#
### License 
By us.