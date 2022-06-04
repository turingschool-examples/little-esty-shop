# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Merchant.destroy_all
Item.destroy_all
Invoice.destroy_all
InvoiceItem.destroy_all
Customer.destroy_all
Transaction.destroy_all

@item11 = @merchant1.items.create!(name: 'Item11', description: 'Description11', unit_price: 1111, status: 0)

@merchant2 = Merchant.create!(name: 'Merchant2')
@item2 = @merchant2.items.create!(name: 'Item2', description: 'Description2', unit_price: 222, status: 0)