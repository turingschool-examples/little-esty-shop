require 'rails_helper'

RSpec.describe 'Merchant Items Show Page Feature' do
  describe 'User Story 7 - Merchant Items Show Page' do
    describe 'When I click on the name of an item from the merchant items index page' do
      describe 'Then I am taken to that merchants items show page (/merchants/merchant_id/items/item_id)' do
        it 'And I see all of the items attributes including Name, Description, Current Selling Price' do

          merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
          merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

          item_toothpaste = merchant_stephen.items.create!(name: "Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )
          item_rock = merchant_stephen.items.create!(name: "Rock", description: "Decently cool rock", unit_price: 4000 )

          item_lamp = merchant_roger.items.create!(name: "Lamp", description: "You bet, it's a lamp", unit_price: 500 )

          visit "merchants/#{merchant_stephen.id}/items"
          click_button(item_toothpaste.name)

          expect(current_path).to eq("/merchants/#{merchant_stephen.id}/items/#{item_toothpaste.id}")
          expect(page).to have_content("Name: #{item_toothpaste.name}")
          expect(page).to have_content("Description: #{item_toothpaste.description}")
          expect(page).to have_content("Current Selling Price: $#{'%.2f' % (item_toothpaste.unit_price/100.to_f)}")
          expect(page).to have_content("Current Selling Price: $40.00")

          expect(page).to_not have_content(item_lamp.name)
          expect(page).to_not have_content(item_lamp.description)
          expect(page).to_not have_content("Current Selling Price: $#{'%.2f' % (item_lamp.unit_price/100.to_f)}")
          expect(page).to_not have_content("Current Selling Price: $5.00")
        end
      end
    end
  end
end