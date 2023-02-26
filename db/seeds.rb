# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

merchant1 = Merchant.create(name: 'merchant1')
merchant_2 = Merchant.create(name: 'merchant2')
merchant_3 = Merchant.create(name: 'merchant3')
merchant_4 = Merchant.create(name: 'merchant4', status: 'disabled')

customer1 = Customer.create(first_name: 'John1', last_name: 'Doe1')
customer2 = Customer.create(first_name: 'John2', last_name: 'Doe2')
customer3 = Customer.create(first_name: 'John3', last_name: 'Doe3')
customer4 = Customer.create(first_name: 'John4', last_name: 'Doe4')
customer5 = Customer.create(first_name: 'John5', last_name: 'Doe5')
customer5 = Customer.create(first_name: 'John6', last_name: 'Doe6')

invoice1 = customer1.invoices.create(created_at: Date.new(2014, 3, 1))
invoice2 = customer1.invoices.create(created_at: Date.new(2012, 3, 1))
invoice3 = customer1.invoices.create() 
invoice4 = customer1.invoices.create()
invoice5 = customer1.invoices.create()
invoice6 = customer1.invoices.create()
invoice7 = customer1.invoices.create()
invoice8 = customer1.invoices.create()
invoice9 = customer1.invoices.create()
invoice10 = customer1.invoices.create()
invoice11 = customer1.invoices.create()

item1 = merchant1.items.create(name: 'item1', unit_price: 1, description: 'item description')
item2 = merchant1.items.create(name: 'item2', unit_price: 1, description: 'item description')
item3 = merchant1.items.create(name: 'item3', unit_price: 1, description: 'item description')
item4 = merchant1.items.create(name: 'item4', unit_price: 1, description: 'item description')
item5 = merchant1.items.create(name: 'item5', unit_price: 1, description: 'item description')
item6 = merchant1.items.create(name: 'item6', unit_price: 1, description: 'item description')

transaction1 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 0, invoice: invoice1) 
transaction2 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 0, invoice: invoice2) 
transaction3 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 0, invoice: invoice3) 
transaction4 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 0, invoice: invoice4) 
transaction5 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 0, invoice: invoice5) 
transaction6 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 0, invoice: invoice6) 
transaction7 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 0, invoice: invoice8) 
transaction8 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 0, invoice: invoice9) 
transaction9 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 1, invoice: invoice10) 
transaction11 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 0, invoice: invoice11) 
transaction14 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 1, invoice: invoice7) 
transaction15 = Transaction.create(credit_card_number: 0, credit_card_expiration_date: '10/10/2014', result: 0, invoice: invoice7) 


InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 3, unit_price: 1)
InvoiceItem.create!(item: item1, invoice: invoice2, quantity: 1, unit_price: 1)
InvoiceItem.create!(item: item1, invoice: invoice4, quantity: 1, unit_price: 1)
InvoiceItem.create!(item: item1, invoice: invoice5, quantity: 1, unit_price: 1)
InvoiceItem.create!(item: item1, invoice: invoice8, quantity: 1, unit_price: 1)
InvoiceItem.create!(item: item1, invoice: invoice11, quantity: 1, unit_price: 1) # => 8

InvoiceItem.create!(item: item2, invoice: invoice1, quantity: 2, unit_price: 1)
InvoiceItem.create!(item: item2, invoice: invoice5, quantity: 2, unit_price: 1)
InvoiceItem.create!(item: item2, invoice: invoice9, quantity: 2, unit_price: 1)
InvoiceItem.create!(item: item2, invoice: invoice1, quantity: 1, unit_price: 1) # => 7

InvoiceItem.create!(item: item3, invoice: invoice8, quantity: 412, unit_price: 1)
InvoiceItem.create!(item: item3, invoice: invoice9, quantity: 4322, unit_price: 1)
InvoiceItem.create!(item: item3, invoice: invoice10, quantity: 54, unit_price: 1) # => failed transaction
InvoiceItem.create!(item: item3, invoice: invoice3, quantity: 453, unit_price: 1)
InvoiceItem.create!(item: item3, invoice: invoice1, quantity: 43, unit_price: 1)

InvoiceItem.create!(item: item4, invoice: invoice10, quantity: 1, unit_price: 1) # => failed transaction
InvoiceItem.create!(item: item4, invoice: invoice11, quantity: 1, unit_price: 1)
InvoiceItem.create!(item: item4, invoice: invoice2, quantity: 1, unit_price: 1)
InvoiceItem.create!(item: item4, invoice: invoice3, quantity: 1, unit_price: 1)
InvoiceItem.create!(item: item4, invoice: invoice4, quantity: 1, unit_price: 1) # => 4

InvoiceItem.create!(item: item5, invoice: invoice7, quantity: 3, unit_price: 1) # => failed transaction
InvoiceItem.create!(item: item5, invoice: invoice3, quantity: 2, unit_price: 1) # => 2

InvoiceItem.create!(item: item6, invoice: invoice3, quantity: 1, unit_price: 1) # => 1


