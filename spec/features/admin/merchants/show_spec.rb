require 'rails_helper'

RSpec.describe 'admin merchant show page' do
	let!(:merchant_1) { Merchant.create!(uuid: 8, name: 'John Doe') }
	let!(:merchant_2) { Merchant.create!(uuid: 43, name: 'Brians Beads') }
	let!(:merchant_3) { Merchant.create!(uuid: 46, name: 'Soras Chains') }


	describe 'update merchant' do
		it 'has a link to update merchant' do
			visit admin_merchant_path(merchant_1)

			expect(page).to have_link('Edit John Doe', href: edit_admin_merchant_path(merchant_1))
		end

		it 'link takes me to page to edit merchant' do
			visit admin_merchant_path(merchant_1)

			click_link 'Edit John Doe'
			
			expect(page).to have_field(:name)
		end
	end
end