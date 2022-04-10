require 'rails_helper'

RSpec.describe 'merchant show page' do
	before :each do
		@merchant1 = Merchant.create!(name: "Schroeder-Jerde")
	end

	it 'displays the merchant name' do
		visit "/merchants/#{@merchant1.id}/dashboard"

		expect(page).to have_content(@merchant1.name)
	end

	it "has a link to the merchant item index" do
		visit "/merchants/#{@merchant1.id}/dashboard"
		click_link "My Items"

		expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
	end

	it "has a link to the merchant invoice index" do
		visit "/merchants/#{@merchant1.id}/dashboard"
		click_link "My Invoices"

		expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
	end

	

end
