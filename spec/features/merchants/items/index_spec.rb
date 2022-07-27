require 'rails_helper'

RSpec.describe 'merchant items index page' do
  context 'merchant items user story' do
    it 'lets us see all the item names a merchant has' do
      khajit = Merchant.create!(name: "Khajit")
      bob = Merchant.create!(name: "Bob The Burgerman")

      item_1 = khajit.items.create!(name: "Skooma", description: "Khajit has wares if you have coin", unit_price: 1420 )
      item_2 = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 599 )
      item_3 = bob.items.create!(name: "Fries", description: "Gene stop eating the fries, they`re for customers", unit_price: 250 )

      visit "/merchants/#{bob.id}/items"

      within "#item-#{item_2.id}" do
        expect(page).to have_content("Burgers")
        expect(page).to_not have_content("Skooma")
      end

      within "#item-#{item_3.id}" do
        expect(page).to have_content("Fries")
        expect(page).to_not have_content("Skooma")
      end
    end
    
    it 'can click on the name of an item and be redirected to that merchants items show page' do 
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

      spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)

      visit "/merchants/#{merchant_1.id}/items"

      expect(page).to have_link('Spatula')
      expect(page).to have_link('Spoon')

      click_on('Spatula')

      expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{spatula.id}")
    end

      it 'has a link to that brings you to a form to add an item' do 
        merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

        spatula = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
        spoon = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)

        visit "/merchants/#{merchant_1.id}/items"

        within "#create-item" do
          expect(page).to have_link("New Item")
        end

        click_on('New Item')

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/new")
    end
  end
end