require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before (:each) do
    Merchant.destroy_all
		Customer.destroy_all
		Invoice.destroy_all
		Item.destroy_all
		Transaction.destroy_all
		InvoiceItem.destroy_all

		@carlos = Merchant.create!(name: "Carlos Jenkins")
		@pete = Merchant.create!(name: "Pete Smith") 

    @bowl = @carlos.items.create!(name: "Bowl", description: "it's a bowl", unit_price: 350) 
		@knife = @carlos.items.create!(name: "Knife", description: "it's a knife", unit_price: 250)

    @scarf = @pete.items.create!(name: "Scarf", description: "scarf, knitted", unit_price: 350) 
		@tshirt = @pete.items.create!(name: "Tshirt", description: "tshirt, screenprinted", unit_price: 250)

  end
  
  describe 'As a merchant, when I visit my merchant items index page' do
    it 'I see a list of the names of all of my items, no items from other merchants' do
      visit "/merchants/#{@carlos.id}/items"
      expect(page).to have_content("Bowl")
      expect(page).to have_content("Knife")

      expect(page).to_not have_content("Scarf")
      expect(page).to_not have_content("Tshirt")
    end

    it 'Next to each item name I see a button to disable or enable that item' do
      visit "/merchants/#{@carlos.id}/items"

      within "#id-#{@bowl.id}" do
        expect(page).to have_button("Enable")
        click_button "Enable"

        expect(current_path).to eq("/merchants/#{@carlos.id}/items")
        expect(page).to have_button("Disable")
        click_button "Disable"

        expect(current_path).to eq("/merchants/#{@carlos.id}/items")
        expect(page).to have_button("Enable")
      end
    end

    describe 'I see two sections, one for "Enabled Items" and one for "Disabled Items' do
      it 'I see that each Item is listed in the appropriate section' do
        visit "/merchants/#{@carlos.id}/items"

        within "#disabled-items" do
          expect(page).to have_content("Disabled Items")
          expect(page).to have_content("Bowl")
          expect(page).to have_content("Knife")
          
          expect(page).to have_button("Enable")
          expect(page).to_not have_button("Disable")

          first(:button, "Enable").click
          expect(page).to_not have_content("Bowl")
        end

        within "#enabled-items" do
          expect(page).to have_content("Enabled Items")
          expect(page).to have_content("Bowl")
          expect(page).to_not have_content("Knife")

          first(:button, "Disable").click
          expect(page).to_not have_content("Bowl")
        end

        within "#disabled-items" do
          expect(page).to have_content("Bowl")
        end
      end
    end

    describe 'I see a link to create a new item' do
      it "When I click on the link, I am taken to a form to add item information" do
        visit "/merchants/#{@carlos.id}/items"
        expect(page).to have_link("Create New Item")

        click_link "Create New Item"
        expect(current_path).to eq("/merchants/#{@carlos.id}/items/new")
      end

      describe 'After a new item form is submitted' do
        it 'I see the item I just created in the items list with disabled status' do
          visit "/merchants/#{@carlos.id}/items/new"

          fill_in :name, with: "Teacup"
          fill_in :description, with: "Here's a Teacup"
          fill_in :unit_price, with: 300
  
          click_button "Create Item"
          
          expect(page).to have_content("Teacup")
          expect(current_path).to eq("/merchants/#{@carlos.id}/items")
        end

        it "If the information is not valid or missing, item is not created" do
          visit "/merchants/#{@carlos.id}/items/new"

          fill_in :name, with: ""
          fill_in :description, with: "Here's a Teacup"
          fill_in :unit_price, with: 300

          click_button "Create Item"
          expect(current_path).to eq("/merchants/#{@carlos.id}/items/new")
          expect(page).to have_content("Item not created: Required information missing")
        end
      end
    end
  end
end