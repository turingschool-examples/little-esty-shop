require 'rails_helper'

RSpec.describe 'Merchants Items Show' do
  describe 'items can link to show page' do
    it 'can move from the index to show page' do
      merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)
      merch2 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

      item1 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item2 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item3 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch2.id)
      item4 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)
      item5 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch2.id)

      visit merchant_items_path(merch1)

      within '.items' do
        within "#item-#{item1.id}" do
          expect(page).to have_link("#{item1.name}")
          click_link "#{item1.name}"
        end
      end

      expect(current_path).to eq item_path(item1)
    end
    it 'shows the name, description, and current selling price' do
      merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

      item1 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price:Faker::Number.number(digits: 5), merchant_id: merch1.id)

      visit item_path(item1)

      within "#item-#{item1.id}" do
        expect(page).to have_content("#{item1.name}")
        expect(page).to have_content("#{item1.description}")
        expect(page).to have_content("Current Price: $#{((item1.unit_price.to_f) / 100).round(3)}")
      end
    end
  end
end