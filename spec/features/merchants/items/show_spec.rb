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

          visit merchant_items_path(merchant_stephen)
          click_link(item_toothpaste.name)

          expect(current_path).to eq(merchant_item_path(merchant_stephen, item_toothpaste))
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


  describe 'Merchant Item Update' do
    describe 'When I visit the merchant show page of an item' do
      describe 'I see a link to update the item information' do
        describe 'When I click the link I am taken to a page to edit this item' do
          describe 'And I see a form filled in with the existing item attribute information' do
            describe 'When I update the information in the form and I click ‘submit’,redirected to item show page' do
              describe 'I see the updated information' do
                it 'And I see a flash message stating that the information has been successfully updated' do

                  merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
                  merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

                  item_toothpaste = merchant_stephen.items.create!(name: "Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )
                  item_rock = merchant_stephen.items.create!(name: "Rock", description: "Decently cool rock", unit_price: 4000 )

                  item_lamp = merchant_roger.items.create!(name: "Lamp", description: "You bet, it's a lamp", unit_price: 500 )

                  visit "merchants/#{merchant_stephen.id}/items"
                  click_link(item_toothpaste.name)
                  expect(current_path).to eq("/merchants/#{merchant_stephen.id}/items/#{item_toothpaste.id}")
                  expect(page).to have_link("Update Item")
                  click_link("Update Item")

                  expect(current_path).to eq("/merchants/#{merchant_stephen.id}/items/#{item_toothpaste.id}/edit")
                  fill_in "Name", with: "Mint Toothpaste"
                  fill_in "Description", with: "very minty toothpaste"
                  fill_in "Unit price", with: "4000"
                  click_button("Submit")

                  expect(current_path).to eq("/merchants/#{merchant_stephen.id}/items/#{item_toothpaste.id}")
                  expect(page).to have_content("Name: Mint Toothpaste")
                  expect(page).to have_content("Description: very minty toothpaste")
                  expect(page).to have_content("Current Selling Price: $#{'%.2f' % (4000/100.to_f)}")
                  expect(page).to have_content("Current Selling Price: $40.00")
                  expect(page).to have_content("***NOTICE: Merchant Item attribute information has been successfullly updated***")
                end
              end
            end
          end
        end
      end
    end
  end
end