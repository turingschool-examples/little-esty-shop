# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Customers:
@sally    = Customer.create!(first_name: 'Sally', last_name: 'Smith')
@joel     = Customer.create!(first_name: 'Joel', last_name: 'Hansen')
@billy    = Customer.create!(first_name: 'Billy', last_name: 'Joel')
@steve    = Customer.create!(first_name: 'Steve', last_name: 'Carrell')
@frank    = Customer.create!(first_name: 'Frank', last_name: 'Sinatra')
@Jon      = Customer.create!(first_name: 'Jon', last_name: 'Travolta')
# Merchants:
@amazon   = Merchant.create!(name: 'Amazon')
@alibaba  = Merchant.create!(name: 'Alibaba')
@all_birds = Merchant.create!(name: 'Al Birds')
@happy_cones = Merchant.create!(name: 'Happy Cones')
# Discounts
@discount_1 = Discount.create(discount_percentage: 15, quantity_threshold: 15, merchant_id: @amazon.id)
@discount_2 = Discount.create(discount_percentage: 15, quantity_threshold: 15, merchant_id: @amazon.id)
@discount_3 = Discount.create(discount_percentage: 15, quantity_threshold: 15, merchant_id: @amazon.id)
@discount_4 = Discount.create(discount_percentage: 15, quantity_threshold: 15, merchant_id: @alibaba.id)
@discount_5 = Discount.create(discount_percentage: 15, quantity_threshold: 15, merchant_id: @alibaba.id)
@discount_6 = Discount.create!(discount_percentage: 5, quantity_threshold: 10, merchant_id: @all_birds.id)
@discount_7 = Discount.create!(discount_percentage: 5, quantity_threshold: 10, merchant_id: @happy_cones.id)
# Invoices:
@invoice1 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: @amazon.id, created_at: 'Fri, 08 Dec 2020 14:42:18 UTC +00:00')
@invoice2 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: @alibaba.id)
@invoice3 = Invoice.create!(status: 0, customer_id: @billy.id, merchant_id: @alibaba.id)
@invoice4 = Invoice.create!(status: 0, customer_id: @steve.id, merchant_id: @amazon.id)
@invoice5 = Invoice.create!(status: 0, customer_id: @frank.id, merchant_id: @alibaba.id)
@invoice6 = Invoice.create!(status: 0, customer_id: @joel.id, merchant_id: @alibaba.id)
@invoice7 = Invoice.create!(status: 0, customer_id: @sally.id, merchant_id: @alibaba.id)
@invoice8  = Invoice.create!(status: 2, customer_id: @sally.id, merchant_id: @all_birds.id, created_at: 'Fri, 08 Dec 2020 14:42:18 UTC +00:00')
@invoice9  = Invoice.create!(status: 2, customer_id: @sally.id, merchant_id: @happy_cones.id, created_at: 'Fri, 08 Dec 2020 14:42:18 UTC +00:00')
# Transactions:
@tx1      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 0, invoice_id: @invoice2.id,)
@tx2      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 1, invoice_id: @invoice1.id,)
@tx3      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 0, invoice_id: @invoice3.id,)
@tx4      = Transaction.create!(credit_card_number: 010001001022, credit_card_expiration_date: 20251001, result: 0, invoice_id: @invoice4.id,)
@tx5      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 0, invoice_id: @invoice5.id,)
@tx6      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 0, invoice_id: @invoice5.id,)
@tx7      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 1, invoice_id: @invoice6.id,)
@tx8      = Transaction.create!(credit_card_number: 010001005555, credit_card_expiration_date: 20220101, result: 0, invoice_id: @invoice7.id,)
# Items:
@candle   = Item.create!(name: 'Lavender Candle', description: '8oz Soy Candle', unit_price: 7.0, merchant_id: @amazon.id)
@backpack = Item.create!(name: 'Camo Backpack', description: 'Double Zip Backpack', unit_price: 15.5, merchant_id: @alibaba.id)
@radio    = Item.create!(name: 'Retro Radio', description: 'Twist and Turn to your fav jams', unit_price: 9.75, merchant_id: @amazon.id)
@shoes     = @all_birds.items.create!(name: 'Pink Shoes', description: 'Light and warm booties!', unit_price: 120.0)
@ice_cream = @happy_cones.items.create!(name: 'Hockey Pokey', description: 'Toffee bits in vanilla ice cream.', unit_price: 3.0)
# InvoiceItems:
@invitm1  = InvoiceItem.create!(status: 0, quantity: 25, unit_price: 7.0, invoice_id: @invoice1.id, item_id: @candle.id)
@invitm2  = InvoiceItem.create!(status: 2, quantity: 10, unit_price: 15.5, invoice_id: @invoice2.id, item_id: @backpack.id)
@invitm3  = InvoiceItem.create!(status: 1, quantity: 100, unit_price: 9.75, invoice_id: @invoice3.id, item_id: @radio.id)
@invitm4   = InvoiceItem.create!(status: 1, quantity: 10, unit_price: 120.0, invoice_id: @invoice6.id, item_id: @shoes.id)
@invitm5   = InvoiceItem.create!(status: 1, quantity: 4, unit_price: 3.0, invoice_id: @invoice7.id, item_id: @ice_cream.id)
