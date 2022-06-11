# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

merchant1 = Merchant.create!(name: "REI")
discount1 = Discount.create!(percentage: 20, quantity_threshold: 10, merchant_id: merchant1.id)
discount2 = Discount.create!(percentage: 50, quantity_threshold: 20, merchant_id: merchant1.id)
