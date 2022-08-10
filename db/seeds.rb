# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

discount1 = BulkDiscount.create!(merchant_id: 1, percentage: 20, quantity_threshold: 20)
discount2 = BulkDiscount.create!(merchant_id: 1, percentage: 10, quantity_threshold: 10)
discount3 = BulkDiscount.create!(merchant_id: 1, percentage: 5, quantity_threshold: 5)
discount4 = BulkDiscount.create!(merchant_id: 2, percentage: 30, quantity_threshold: 10)
discount5 = BulkDiscount.create!(merchant_id: 3, percentage: 15, quantity_threshold: 10)
discount6 = BulkDiscount.create!(merchant_id: 4, percentage: 10, quantity_threshold: 5)
