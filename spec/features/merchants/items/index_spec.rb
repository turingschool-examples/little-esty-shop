require 'rails_helper'

RSpec.describe 'Merchants Items' do
  describe "A merchants' items' names" do
    it 'shows the names of the items a merchant has and no other' do
      merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

      item1 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item2 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item3 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch2.id)
      item4 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item5 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch2.id)

      visit merchant_items_path(merch1)

      within '.items' do
        expect(page).to have_content("#{item1.name}")
        expect(page).to have_content("#{item2.name}")
        expect(page).to_not have_content("#{item3.name}")
        expect(page).to have_content("#{item4.name}")
        expect(page).to_not have_content("#{item5.name}")
      end
    end
  end


  describe 'Items can be grouped by status' do
    it 'items are in enabled_section that match their status' do
      merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

      item1 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item2 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item3 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item4 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item5 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)

      visit merchant_items_path(merch1)

      # within '.items' do
      #   within '.enabled-items' do
      #   end
      # end
    end
  end
end