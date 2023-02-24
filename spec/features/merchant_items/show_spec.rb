require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before do
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

    visit "/merchants/#{@carlos.id}/items"
		save_and_open_page
		click_link "Bowl"
  end

  describe 'When I click on the name of an item from the merchant items index page' do
		it 'then I am taken to that merchants items show page' do
			expect(current_path).to eq("/merchants/#{@carlos.id}/items/#{@bowl.id}")		
		end

		it "I see all of the item's attributes" do

			expect(page).to have_content("Name: Bowl")
			expect(page).to have_content("Description: it's a bowl")
			expect(page).to have_content("Current Selling Price: 350")
		end
  end
end