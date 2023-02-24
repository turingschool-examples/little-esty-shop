# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

merchant1 = Merchant.create!(uuid: 101, name: "Brian's Beads")

customer1 = Customer.create!(uuid: 1, first_name: "Britney", last_name: "Spears")
customer2 = Customer.create!(uuid: 2, first_name: "Bob", last_name: "Smith")
customer3 = Customer.create!(uuid: 3, first_name: "Bill", last_name: "Johnson")
customer4 = Customer.create!(uuid: 4, first_name: "Boris", last_name: "Nelson")
customer5 = Customer.create!(uuid: 5, first_name: "Barbara", last_name: "Hilton")
customer6 = Customer.create!(uuid: 6, first_name: "Bella", last_name: "Thomas" )

invoice1 = customer1.invoices.create!(id: 10, status: 2)
invoice2 = customer1.invoices.create!(id: 11, status: 2)
invoice3 = customer2.invoices.create!(id: 12, status: 2)
invoice4 = customer2.invoices.create!(id: 13, status: 2)
invoice5 = customer3.invoices.create!(id: 14, status: 2)
invoice6 = customer3.invoices.create!(id: 15, status: 2)
invoice7 = customer4.invoices.create!(id: 16, status: 2)
invoice8 = customer5.invoices.create!(id: 17, status: 2)
invoice9 = customer5.invoices.create!(id: 18, status: 2)
invoice10 = customer6.invoices.create!(id: 19, status: 2)
invoice11 = customer6.invoices.create!(id: 20, status: 2)

item1 = merchant1.items.create!(name: "water bottle", description: "24oz metal container for water", unit_price: 8)    
item2 = merchant1.items.create!(name: "rubber duck", description: "toy for bath", unit_price: 1)    
item3 = merchant1.items.create!(name: "lamp", description: "12 inch desk lamp", unit_price: 16)    
item4 = merchant1.items.create!(name: "wireless mouse", description: "wireless computer mouse for mac", unit_price: 40)    
item5 = merchant1.items.create!(name: "chapstick", description: "coconut flavor chapstick", unit_price: 2)    

transaction1 =invoice1.transactions.create!(id: 1, credit_card_number: 4654405418249632, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")
transaction2 =invoice2.transactions.create!(id: 2, credit_card_number: 4654405418249632, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")

transaction3 =invoice3.transactions.create!(id: 3, credit_card_number: 4140149827486249, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")
transaction4 =invoice4.transactions.create!(id: 4, credit_card_number: 4140149827486249, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")

transaction5 =invoice5.transactions.create!(id: 6, credit_card_number: 4763141973880496, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")
transaction6 =invoice6.transactions.create!(id: 7, credit_card_number: 4763141973880496, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")

transaction14 =invoice7.transactions.create!(id: 15, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed")
transaction15 =invoice7.transactions.create!(id: 16, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")

transaction7 =invoice8.transactions.create!(id: 8, credit_card_number: 4173081602435789, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")
transaction8 =invoice9.transactions.create!(id: 9, credit_card_number: 4173081602435789, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")

transaction9 =invoice10.transactions.create!(id: 10, credit_card_number: 4972246905754900, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed")
transaction10 =invoice10.transactions.create!(id: 11, credit_card_number: 4972246905754900, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")
transaction11 =invoice11.transactions.create!(id: 12, credit_card_number: 4972246905754900, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success")



InvoiceItem.create!(item: item1, invoice: invoice1)
InvoiceItem.create!(item: item2, invoice: invoice1)
InvoiceItem.create!(item: item1, invoice: invoice2)
InvoiceItem.create!(item: item4, invoice: invoice2)
InvoiceItem.create!(item: item4, invoice: invoice3)
InvoiceItem.create!(item: item3, invoice: invoice3)
InvoiceItem.create!(item: item1, invoice: invoice4)
InvoiceItem.create!(item: item4, invoice: invoice4)
InvoiceItem.create!(item: item1, invoice: invoice5)
InvoiceItem.create!(item: item2, invoice: invoice5)
InvoiceItem.create!(item: item2, invoice: invoice6)
InvoiceItem.create!(item: item3, invoice: invoice6)
InvoiceItem.create!(item: item5, invoice: invoice7)
InvoiceItem.create!(item: item1, invoice: invoice8)
InvoiceItem.create!(item: item3, invoice: invoice8)
InvoiceItem.create!(item: item2, invoice: invoice9)
InvoiceItem.create!(item: item3, invoice: invoice9)
InvoiceItem.create!(item: item3, invoice: invoice10)
InvoiceItem.create!(item: item4, invoice: invoice10)
InvoiceItem.create!(item: item1, invoice: invoice11)
InvoiceItem.create!(item: item4, invoice: invoice11)