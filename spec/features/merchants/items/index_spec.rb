require 'rails_helper'

RSpec.describe 'Merchants Items' do
  describe "A merchants' items' names" do
    it 'shows the names of the items a merchant has and no other' do
      merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

      item1 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item2 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item3 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item4 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item5 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)

      visit merchant_items_path(merch1)
    end
  end
end