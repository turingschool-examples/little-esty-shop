# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@merchant1 = Merchant.create!(name: 'Stevie Plunder')
@merchant2 = Merchant.create!(name: 'Dave Einstein')
@hammer = @merchant1.items.create!(name: 'hammer', description: 'it is hammer time', unit_price: 2500)                
@candlestick = @merchant1.items.create!(name: 'candlestick', description: 'put a candle on it...or beat someone with it', unit_price: 2000)                
@bat = @merchant2.items.create!(name: 'bat', description: 'Hit a baseball with it', unit_price: 4500) 