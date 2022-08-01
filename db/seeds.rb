# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#merchants
merchant1 = Merchant.create!(name: "Ray's Handmade Jewelry", created_at: Time.now, updated_at: Time.now)
merchant2 = Merchant.create!(name: "Britches Eckles", created_at: Time.now, updated_at: Time.now)

#items
item1 = Item.create!(name: "Dangly Earrings", description: "electronic", unit_price: 500, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
item2 = Item.create!(name: "Gold Ring", description: "wearable", unit_price: 400, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
item3 = Item.create!(name: "Silver Ring", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
item3 = Item.create!(name: "Hoop Earrings", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
item3 = Item.create!(name: "Gold Necklace", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
item3 = Item.create!(name: "Toe Ring", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )
item3 = Item.create!(name: "Silver Necklace", description: "household", unit_price: 300, created_at: Time.now, updated_at: Time.now, merchant_id: merchant1.id )

item4 = Item.create!(name: "Bone", description: "dog treat", unit_price: 200, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )
item5 = Item.create!(name: "Kong", description: "dog toy", unit_price: 100, created_at: Time.now, updated_at: Time.now, merchant_id: merchant2.id )