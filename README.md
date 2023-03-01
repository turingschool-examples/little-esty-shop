# About the Project

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices. The learning goals for this project included practice designing a normalized database schema and defining model relationships, utilizing advanced routing techniques, utilizing advanced Active Record techniques to perform complex database queries, and to practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code.

👍Requirements

- ✔️Rails 5.2.x

- ✔️Ruby 2.7.4

# Setup

1. Fork this repository

1. Clone your fork
1. From the command line, install gems and set up your DB:
    - bundle
    - rails db:create
1. Run the test suite with bundle exec rspec.
1. Run your development server with rails s to see the app in action.


# 👉Visit our Little Esty Shop👈
Admin Dashboard: https://localhost:3000/admin/dashboard

Merchant Dashboard: http://localhost:3000/merchants/1/dashboard

# 🗒️Project Board

https://alluring-phlox-b74.notion.site/b1bd1bde2da44641ad7c9ee644548d82?v=bed2036963f34cd482be21876fd2c7fd

# Project Collaborators
Tori Enyart https://github.com/torienyart

Bradley Dunlap https://github.com/brad-dunlap

Andra Helton https://github.com/ALHelton

Conner Van Loan https://github.com/C-V-L

# Project Notes

- Our GitHub API's are working, but not very secure or reliable.  We would shift to using gems like faraday, vcr, and webmock to ensure they are secure and testable.

- Our Heroku is currently inoperable, we believe this is due to an auth token issue
