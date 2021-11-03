# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

      merchant = FactoryBot.create :merchant
      merchant2 = FactoryBot.create :merchant

      customer = FactoryBot.create :customer

      invoice1 = FactoryBot.create :invoice, { customer_id: customer.id }
      invoice2 = FactoryBot.create :invoice, { customer_id: customer.id }
      invoice3 = FactoryBot.create :invoice, { customer_id: customer.id }

      item1 = FactoryBot.create :item, { merchant_id: merchant.id }
      item2 = FactoryBot.create :item, { merchant_id: merchant.id }
      item3 = FactoryBot.create :item, { merchant_id: merchant2.id }

      invoice_item1 = FactoryBot.create :invoice_item,
                              { invoice_id: invoice1.id, item_id: item1.id, unit_price: 50, quantity: 1 }
      invoice_item2 = FactoryBot.create :invoice_item,
                              { invoice_id: invoice2.id, item_id: item2.id, unit_price: 100, quantity: 1 }
      invoice_item3 = FactoryBot.create :invoice_item,
                              { invoice_id: invoice3.id, item_id: item3.id, unit_price: 200, quantity: 1 }



# 5.times do
#   FactoryBot.create(:merchant)
# end
#
# 5.times do
#   FactoryBot.create(:customer)
# end
#
# 5.times do
#   FactoryBot.create(:invoice)
# end
#
# 5.times do
#   FactoryBot.create(:item)
# end
#
# 5.times do
#   FactoryBot.create(:invoice_item)
# end
#
# 5.times do
#   FactoryBot.create(:transaction)
# end
