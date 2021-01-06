# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.destroy_all
Invoice.destroy_all
InvoiceItem.destroy_all
Item.destroy_all
Merchant.destroy_all
Transaction.destroy_all

FactoryBot.create_list(:customer, 10)
  Customer.all.each do |customer|
    FactoryBot.create(:invoice, customer: customer)
  end
  Invoice.all.each do |invoice|
    FactoryBot.create(:transaction, invoice: invoice)
  end

FactoryBot.create_list(:merchant, 10)
  Merchant.all.each do |merchant|
    FactoryBot.create(:item, merchant: merchant)
  end

FactoryBot.create_list(:invoice_item, 10)
  InvoiceItem.all.each do |ii|
  end 
