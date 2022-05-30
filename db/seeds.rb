# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# We don't really need this seed data since our development is already seeded
# with info from our csv_load terminal commands. But we can use this for our
# spec tests

# InvoiceItem.destroy_all
# Item.destroy_all
# Merchant.destroy_all
# Transaction.destroy_all
# Invoice.destroy_all
# Customer.destroy_all
#
# customer1 = create(:customer)
# invoice1 = create(:invoice, customer: customer1)
# transaction1 = create(:transaction, invoice: invoice1)
# merchant1 = create(:merchant)
# item1 = create(:item)
# invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1)
#
# customer2 = Customer.create(first_name: "Rutger", last_name: "Hauer")
# invoice2 = Invoice.create(status: 0, customer: customer2)
# transaction2 = Transaction.create(credit_card_number: 1111222233334444, result: 0, invoice: invoice2)
# merchant2 = Merchant.create(name: "Funny lil Furries")
# item2 = Item.create(name: "Funny Cat Frame", description: "A picture frame that includes a humurous cat picture", unit_price: 9900)
# invoice_item2 = InvoiceItem.create(quantity: 2, unit_price: 9900, status: 0, item: item2, invoice: invoice2)
