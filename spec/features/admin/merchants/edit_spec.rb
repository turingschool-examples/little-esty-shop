require 'rails_helper'

RSpec.describe 'admin merchant edit page' do
	let!(:merchant_1) { Merchant.create!(uuid: 8, name: 'John Doe') }
	let!(:merchant_2) { Merchant.create!(uuid: 43, name: 'Brians Beads') }
	let!(:merchant_3) { Merchant.create!(uuid: 46, name: 'Soras Chains') }


	describe 'update merchant' do
		it 'form has a default value in name when visiting edit page' do
			visit edit_admin_merchant_path(merchant_1)

			expect(page).to have_content('John Doe')
		end

		it 'i can update merchant name and get redirected to merchant admin page' do
			visit edit_admin_merchant_path(merchant_1)

			fill_in :name, with: 'John Favreau'
			click_button 'Edit Name'
			
			expect(current_path).to eq(admin_merchants_path)
			expect(page).to_not have_content('John Doe')
			expect(page).to have_content('John Favreau')
		end

		it 'validates that name is not blank, displays flash message' do
			visit edit_admin_merchant_path(merchant_1)

			fill_in :name, with: ''
			click_button 'Edit Name'
			
			expect(page).to have_content("Name can't be blank")
		end
	end
end