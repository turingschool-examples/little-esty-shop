# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


@discount1 = Discount.create(name: 'Threeteen', threshold: 3, percentage: 13, merchant_id: 1)
@discount2 = Discount.create(name: 'Fourscore', threshold: 4, percentage: 20, merchant_id: 1)
@discount3 = Discount.create(name: 'Ninetwentynine', threshold: 9, percentage: 29, merchant_id: 1)
@discount4 = Discount.create(name: 'Twentyfifty', threshold: 20, percentage: 50, merchant_id: 1)
@discount5 = Discount.create(name: 'Hundredseventyfive', threshold: 100, percentage: 75, merchant_id: 1)
@discount6 = Discount.create(name: 'Two', threshold: 2, percentage: 2, merchant_id: 1)

@discount7 = Discount.create(name: 'Twoten', threshold: 2, percentage: 10, merchant_id: 2)
@discount8 = Discount.create(name: 'Fourscore', threshold: 4, percentage: 20, merchant_id: 2)
@discount9 = Discount.create(name: 'Ninetwentynine', threshold: 9, percentage: 29, merchant_id: 2)
@discount10 = Discount.create(name: 'Twentyfifty', threshold: 20, percentage: 50, merchant_id: 2)
@discount11 = Discount.create(name: 'Hundredseventyfive', threshold: 100, percentage: 75, merchant_id: 2)
@discount12 = Discount.create(name: 'Two', threshold: 2, percentage: 2, merchant_id: 2)
