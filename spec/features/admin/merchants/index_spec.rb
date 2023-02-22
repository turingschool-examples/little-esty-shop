require 'rails_helper'

RSpec.describe 'admin merchants index page' do
	let!(:merchant_1) { Merchant.create!(uuid: 8, name: 'John Doe') }
	let!(:merchant_2) { Merchant.create!(uuid: 43, name: 'Brians Beads') }
	let!(:merchant_3) { Merchant.create!(uuid: 46, name: 'Soras Chains') }


	describe 'shows all merchants' do
		it 'shows all merchants' do
			visit "/admin/merchants"

			expect(page).to have_content('Merchants List')
			save_and_open_page
			within "#merchant-list" do
				expect(page).to have_content('John Doe')
				expect(page).to have_content('Brians Beads')
				expect(page).to have_content('Soras Chains')
			end
		end
	end
end