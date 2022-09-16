require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  describe 'User Story 6 - Merchant Items Index Page' do
    describe 'When I visit my merchant items index page ("merchants/merchant_id/items")' do
      it 'I see a list of the names of all of my items, and dont see items for other merchants' do

        merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
        merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

        item_toothpaste = merchant_stephen.items.create!(name: "Item Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )
        item_rock = merchant_stephen.items.create!(name: "Item Rock", description: "Decently cool rock", unit_price: 4000 )

        item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 4000 )

        # visit "/merchants/#{merchant_stephen.id}/items"
        visit merchant_items_path(merchant_stephen)
        save_and_open_page
        expect(page).to have_content("Merchant Items Index Page")
        expect(page).to have_content(item_toothpaste.name)
        expect(page).to have_content("Item Toothpaste")
        expect(page).to have_content(item_rock.name)
        expect(page).to_not have_content(item_lamp.name)
      end
    end
  end

  describe 'User Story 9 - Merchant Item Disable/Enable' do
    describe 'As merchant, When I visit my items index page' do
      describe 'Next to each item name I see a button to disable or enable that item.' do
        describe 'When I click this button then I am redirected back to the items index' do
          it 'And I see that the items status has changed' do

            merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
            merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

            item_toothpaste = merchant_stephen.items.create!(name: "Item Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )

            item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 4000 )

            visit merchant_items_path(merchant_stephen)

            expect(item_toothpaste.enabled).to eq(false)
            within("#item_#{item_toothpaste.id}") do
            click_button("Enable")
            end

            expect(current_path).to eq(merchant_items_path(merchant_stephen))
            within("#item_#{item_toothpaste.id}") do
            expect(page).to have_button("Disable")
            end
          end
        end
      end
    end
  end

    describe 'User Story 10 - Merchant Items Grouped by Status' do
      describe 'When I visit my merchant items index page' do
        describe 'I see two sections, "Enabled Items" and "Disabled Items"' do
          it 'each Item is listed in the appropriate section' do

            merchant_stephen = Merchant.create!(name: "Stephen's Shady Store")
            merchant_roger = Merchant.create!(name: "Roger's Fancy Store")

            item_toothpaste = merchant_stephen.items.create!(name: "Item Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )

            item_lamp = merchant_roger.items.create!(name: "Item Lamp", description: "You bet, it's a lamp", unit_price: 4000)

            visit merchant_items_path(merchant_stephen)
            # within("Disabled Items") do
            expect(page).to have_content(item_toothpaste.name)
            # end

            # within("Enabled Items") do
            # expect(page).to_not have_content(item_toothpaste.name)
            #end

            click_button("Enable")
            
             # within("Enabled Items") do
            expect(page).to have_content(item_toothpaste.name)
             #end
          end
        end
      end
    end
end