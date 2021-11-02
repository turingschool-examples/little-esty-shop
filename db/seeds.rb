# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

5.times do
  FactoryBot.create(:merchant)
end

5.times do
  FactoryBot.create(:customer)
end

5.times do
  FactoryBot.create(:invoice)
end

5.times do
  FactoryBot.create(:item)
end

5.times do
  FactoryBot.create(:invoice_item)
end

5.times do
  FactoryBot.create(:transaction)
end
