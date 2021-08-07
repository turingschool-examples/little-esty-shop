# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@merchant1 = Merchant.create!(name: 'Tom Holland')
@merchant2 = Merchant.create!(name: 'Hom Tolland')
@discount1 = @merchant1.discounts.create(name: 'Threeteen', threshold: 3, percentage: 15)
@discount2 = @merchant1.discounts.create(name: 'Fourscore', threshold: 4, percentage: 20)
@discount3 = @merchant1.discounts.create(name: 'Ninetwentynine', threshold: 9, percentage: 29)
@discount4 = @merchant1.discounts.create(name: 'Twentyfifty', threshold: 20, percentage: 50)
@discount5 = @merchant1.discounts.create(name: 'Hundredseventyfive', threshold: 100, percentage: 75)
@discount6 = @merchant2.discounts.create(name: 'Two', threshold: 2, percentage: 2)
