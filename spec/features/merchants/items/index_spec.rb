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
        end
        
        within "#enabled-items" do
          expect(page).to have_content("Enabled Items")
          expect(page).to_not have_content("Bowl")
          expect(page).to_not have_content("Knife")
        end
      end
    end
  end
end