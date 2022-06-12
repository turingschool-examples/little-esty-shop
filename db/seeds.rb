# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# merchant1 = Merchant.create!(name: "REI")
# merchant2 = Merchant.create!(name: "Black Diamond")
#
discount1 = Discount.create!(percentage: 20, quantity_threshold: 10, merchant_id: 1)
discount2 = merchant1.discounts.create!(percentage: 30, quantity_threshold: 15, merchant_id: 1)
discount3 = merchant2.discounts.create!(percentage: 10, quantity_threshold: 5, merchant_id: 2)
discount4 = merchant3.discounts.create!(percentage: 50, quantity_threshold: 50, merchant_id: 3)
discount5 = merchant4.discounts.create!(percentage: 75, quantity_threshold: 60, merchant_id: 4)
#
# customer1 = Customer.create!(first_name: "Leanne", last_name: "Braun")
#
# item1 = merchant1.items.create!(name: "Boots", description: "Never get blisters again!", unit_price: 100)
# item2 = merchant1.items.create!(name: "Tent", description: "Will survive any storm", unit_price: 150)
# item3 = merchant2.items.create!(name: "Nalgene", description: "Put all your cool stickers here", unit_price: 12)
#
# invoice1 = customer1.invoices.create!(status: 2)
#
# invoice_item1 = InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 12, unit_price: 100, status: "shipped")
# invoice_item2 = InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 15, unit_price: 150, status: "pending")
# invoice_item3 = InvoiceItem.create!(item_id: item3.id, invoice_id: invoice1.id, quantity: 15, unit_price: 12, status: "pending")
