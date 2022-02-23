# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@merchant_1 = Merchant.create!(name: "Ana Maria")
@merchant_2 = Merchant.create!(name: "Juan Lopez")
@merchant_3 = Merchant.create!(name: "Jamie Fergerson")
@item_1 = @merchant_1.items.create!(name: "cheese", description: "european cheese", unit_price: 2400, item_status: 1)
@item_2 = @merchant_1.items.create!(name: "onion", description: "red onion", unit_price: 3450, item_status: 1)
@item_3 = @merchant_2.items.create!(name: "earing", description: "Lotus earings", unit_price: 14500)
@item_4 = @merchant_2.items.create!(name: "bracelet", description: "Silver bracelet", unit_price: 76000, item_status: 1)
@item_5 = @merchant_2.items.create!(name: "ring", description: "lotus ring", unit_price: 2345)
@item_6 = @merchant_3.items.create!(name: "skirt", description: "Hoop skirt", unit_price: 2175, item_status: 1)
@item_7 = @merchant_3.items.create!(name: "shirt", description: "Mike's Yellow Shirt", unit_price: 5405, item_status: 1)
@item_8 = @merchant_3.items.create!(name: "socks", description: "Cat Socks", unit_price: 934)
