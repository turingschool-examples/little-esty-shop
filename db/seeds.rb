# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Item.destroy_all
Merchant.destroy_all

# @merchant1 = Merchant.create!(name: 'Stevie Plunder')
# @merchant2 = Merchant.create!(name: 'Dave Einstein')
# @hammer = @merchant1.items.create!(name: 'hammer', description: 'it is hammer time', unit_price: 2500)                
# @candlestick = @merchant1.items.create!(name: 'candlestick', description: 'put a candle on it...or beat someone with it', unit_price: 2000)                
# @bat = @merchant2.items.create!(name: 'bat', description: 'Hit a baseball with it', unit_price: 4500) 

merchant1 = Merchant.create!(name: "Poke Retirement homes")
merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)

customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item2.id, invoice_id: invoice1.id)
invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item3.id, invoice_id: invoice2.id)     