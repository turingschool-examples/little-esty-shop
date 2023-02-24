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
      visit "/merchant/#{@carlos.id}/items"
      expect(page).to have_content("Bowl")
      expect(page).to have_content("Knife")

      expect(page).to_not have_content("Scarf")
      expect(page).to_not have_content("Tshirt")
    end

    it 'Next to each item name I see a button to disable or enable that item' do
      visit "/merchant/#{@carlos.id}/items"
      # save_and_open_page

      within "#name-Bowl" do
        expect(page).to have_button("Disable")
        click_button "Disable"

        expect(current_path).to eq("/merchant/#{@carlos.id}/items")
        expect(page).to have_button("Enable")
        click_button "Enable"

        expect(current_path).to eq("/merchant/#{@carlos.id}/items")
        expect(page).to have_button("Disable")
      end
    end
  end
end