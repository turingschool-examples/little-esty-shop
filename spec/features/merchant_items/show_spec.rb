require 'rails_helper'

RSpec.describe 'When I visit the merchant show page of an item' do
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

  describe 'I see a link to update the item information' do
		it 'has link' do
			expect(page).to have_link("Update Bowl", href: "/merchants/#{@carlos.id}/items/#{@bowl.id}/edit")		
		end

		it 'When I click the link then I am taken to a page to edit this item' do
			click_link("Update Bowl")
			expect(current_path).to eq("/merchants/#{@carlos.id}/items/#{@bowl.id}/edit")	
		end

		it 'I see a form filled in with the existing item attribute information' do
			click_link("Update Bowl")
			expect(find_field('Name').value).to eq('Bowl')
  		expect(find_field('Description').value).to eq("it's a bowl")
  		expect(find_field('Unit price').value).to eq('350')
		end

		it 'I update the information in the form and I click submit, I am redirected back to the item show page where I see the updated information' do
			click_link("Update Bowl")

			fill_in('Name', with: 'Blue bowl')
  		fill_in('Description', with: "it's a blue bowl")
  		fill_in('Unit price', with: '400')
			save_and_open_page

			click_button("Update Item")
			save_and_open_page
			expect(current_path).to eq("/merchants/#{@carlos.id}/items/#{@bowl.id}")		
			expect(page).to have_content("Item updated successfully")
			expect(page).to have_content("Name: Blue bowl")
			expect(page).to have_content("Description: it's a blue bowl")
			expect(page).to have_content("Current Selling Price: 400")
		end
  end
end