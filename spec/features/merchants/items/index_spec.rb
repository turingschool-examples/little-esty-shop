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

      within "#item-#{spatula.id}" do
        click_on('Spatula')
      end

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

  describe 'Merchant Item disable / enable button' do
    context 'button to enable / disable every item on merchant index page' do
      it 'has a button to enable / disable an item' do
        bob = Merchant.create!(name: "Bob The Burgerman")

        item_1 = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 599 )
        item_2 = bob.items.create!(name: "Fries", description: "Gene stop eating the fries, they`re for customers", unit_price: 250 )

        visit "/merchants/#{bob.id}/items"

        within "#item-#{item_1.id}" do
          expect(page).to have_selector(:link_or_button, "Enable Burgers")
          expect(page).to have_selector(:link_or_button, "Disable Burgers")
          expect(page).to_not have_selector(:link_or_button, "Enable Fries")
          expect(page).to_not have_selector(:link_or_button, "Disable Fries")
        end

        within "#item-#{item_2.id}" do
          expect(page).to have_selector(:link_or_button, "Enable Fries")
          expect(page).to have_selector(:link_or_button, "Disable Fries")
          expect(page).to_not have_selector(:link_or_button, "Enable Burgers")
          expect(page).to_not have_selector(:link_or_button, "Disable Burgers")
        end
      end
    end

    context 'change items status' do
      it 'changes the items status to enabled & disabled' do
        bob = Merchant.create!(name: "Bob The Burgerman")

        item_1 = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 599)
        item_2 = bob.items.create!(name: "Fries", description: "Gene stop eating the fries, they`re for customers", unit_price: 250)

        visit "/merchants/#{bob.id}/items"

        within "#item-#{item_1.id}" do
          expect(page).to have_content("Status:")
        end

        click_on "Enable Burgers"

        within "#item-#{item_1.id}" do
          expect(page).to have_current_path("/merchants/#{bob.id}/items")
          expect(page).to have_content("Status: Enabled")
          expect(page).to_not have_content("Status: Disabled")
        end

        click_on "Disable Fries"

        within "#item-#{item_2.id}" do
          expect(page).to have_current_path("/merchants/#{bob.id}/items")
          expect(page).to have_content("Status: Disabled")
          expect(page).to_not have_content("Status: Enabled")
        end
      end
    end
  end

  describe 'group by status' do
    context ' enable / disable' do
      it 'groups by Enabled Items / Disabled Items' do
        bob = Merchant.create!(name: "Bob The Burgerman")

        item_1 = bob.items.create!(name: "Burgers", description: "Best Burgers in Town!", unit_price: 599)
        item_2 = bob.items.create!(name: "Fries", description: "Gene stop eating the fries, they`re for customers", unit_price: 250)
        item_3 = bob.items.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3)
        item_4 = bob.items.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1)

        visit "/merchants/#{bob.id}/items"

        click_on "Enable Burgers"
        click_on "Enable Fries"

        click_on "Disable Spatula"
        click_on "Disable Spoon"

        within "#enabled_items" do
          expect(page).to have_content("Burgers")
          expect(page).to have_content("Fries")
          expect(page).to_not have_content("Spatula")
          expect(page).to_not have_content("Spoon")
        end

        within "#disabled_items" do
          expect(page).to have_content("Spatula")
          expect(page).to have_content("Spoon")
          expect(page).to_not have_content("Burgers")
          expect(page).to_not have_content("Fries")
        end
      end
    end
  end
end

# Merchant Items Grouped by Status::: 
# As a merchant, When I visit my merchant items index page 
# Then I see two sections, one for "Enabled Items" and one for "Disabled Items" 
# And I see that each Item is listed in the appropriate section