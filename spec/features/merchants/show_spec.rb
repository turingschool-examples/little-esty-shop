require 'rails_helper'

RSpec.describe 'merchant show page' do 
	before :each do 
		@merchant1 = Merchant.create!(name: "Schroeder-Jerde")
	end

	it 'displays the merchant name' do 
		visit "/merchants/#{@merchant1.id}/dashboard"

		expect(page).to have_content(@merchant1.name)
	end

end