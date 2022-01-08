# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create =  name: 'Star Wars'  =  name: 'Lord of the Rings' ])
#   Character.create(name: 'Luke', movie: movies.first)

merchant_1 = Merchant.create!(name: 'Billys Pet Rocks', status: 0)
merchant_2 = Merchant.create!(name: 'Jimmy Pet Stones', status: 1)


item_1 = merchant_1.items.create!(name: 'Obsidian Nobice', description: 'A beautiful obsidian', unit_price: 50)
item_2 = merchant_1.items.create!(name: 'Pleasure Geode', description: 'Glamourous Geode', unit_price: 100)
item_3 = merchant_1.items.create!(name: 'Brown Pebble', description: 'Classic rock', unit_price: 50)
item_4 = merchant_1.items.create!(name: 'Red Rock', description: 'A big red rock', unit_price: 50)
item_5 = merchant_1.items.create!(name: 'Solid Limestone', description: 'not crumbly', unit_price: 50)
item_6 = merchant_1.items.create!(name: 'Healing Crystal', description: 'does nothing', unit_price: 50)


customer_1 = Customer.create!(first_name: 'Billy', last_name: 'Carruthers')
customer_2 = Customer.create!(first_name: 'Dave', last_name: 'King')
customer_3 = Customer.create!(first_name: 'Reid', last_name: 'Anderson')
customer_4 = Customer.create!(first_name: 'Elvind', last_name: 'Opsvik')
customer_5 = Customer.create!(first_name: 'Ethan', last_name: 'Iverson')
customer_6 = Customer.create!(first_name: 'Chris', last_name: 'Speed')

invoice_1 = customer_1.invoices.create!(status: 'completed')
invoice_2 = customer_2.invoices.create!(status: 'completed')
invoice_3 = customer_3.invoices.create!(status: 'completed')
invoice_4 = customer_4.invoices.create!(status: 'completed')
invoice_5 = customer_5.invoices.create!(status: 'completed')
invoice_6 = customer_6.invoices.create!(status: 'completed')

transaction_1 = invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')
transaction_2 = invoice_2.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')
transaction_3 = invoice_3.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')
transaction_4 = invoice_4.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')
transaction_5 = invoice_5.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')
transaction_6 = invoice_6.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'failed')

transaction_7 = invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')
transaction_8 = invoice_1.transactions.create!(credit_card_number: '1234123412341234', credit_card_expiration_date: '11/22', result: 'success')

invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 1, unit_price: 50, status: 'shipped')
invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, quantity: 1, unit_price: 50, status: 'packaged')
invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2021))
invoice_item_4 = InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2020))
invoice_item_5 = InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_5.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2019))
invoice_item_6 = InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_6.id, quantity: 1, unit_price: 50, status: 'pending', created_at: Time.new(2018))
