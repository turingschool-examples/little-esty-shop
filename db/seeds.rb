# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@merchant1 = Merchant.create!(name: "Calvin Klein")
@merchant2 = Merchant.create!(name: "Marc Jacobs")
@merchant3 = Merchant.create!(name: "Yves Saint Laurent")

@item1 = Item.create!(name: "T-shirts", description: "Blue" , unit_price: 12 , merchant_id: merchant1.id)
@item2 = Item.create!(name: "Shorts", description: "Green", unit_price: 45, merchant_id: merchant2.id)
@item3 = Item.create!(name: "Chinos", description: "White", unit_price: 67, merchant_id: merchant1.id)
@item4 = Item.create!(name: "Hat", description: "Multicolor", unit_price: 84, merchant_id: merchant2.id)
@item5 = Item.create!(name:"Socks", description: "Grey", unit_price: 9, merchant_id: merchant3.id)
@item6 = Item.create!(name: "Sneakers", description: "Bone", unit_price: 122 , merchant_id: merchant3.id)