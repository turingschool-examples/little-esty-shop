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

        visit "/merchants/#{merchant_stephen.id}/items"
        save_and_open_page
        expect(page).to have_content("Merchant Items Index Page")
        expect(page).to have_content(item_toothpaste.name)
        expect(page).to have_content(item_rock.name)
        expect(page).to_not have_content(item_lamp.name)

      end
    end
  end
end