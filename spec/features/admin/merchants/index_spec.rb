require 'rails_helper'

RSpec.describe 'admin merchants index page' do
	let!(:merchant_1) { Merchant.create!(name: 'John Doe') }
	let!(:merchant_2) { Merchant.create!(name: 'Brians Beads') }
	let!(:merchant_3) { Merchant.create!(name: 'Soras Chains') }


	describe 'shows all merchants' do
		it 'shows all merchants' do
			visit "/admin/merchants"

			expect(page).to have_content('Merchants List')
			
			within "#merchant-list" do
				expect(page).to have_content('John Doe')
				expect(page).to have_content('Brians Beads')
				expect(page).to have_content('Soras Chains')
			end
		end
	end

	describe 'link to admin/merchant show page' do
		it 'has links on all merchants in admin/merchants to each merchant index' do
			visit "/admin/merchants"

			within "#merchant-list" do
				expect(page).to have_link('John Doe', href: admin_merchant_path(merchant_1))
				expect(page).to have_link('Brians Beads', href: admin_merchant_path(merchant_2))
				expect(page).to have_link('Soras Chains', href: admin_merchant_path(merchant_3))
			end
		end

		it 'takes me to admin/merchant show page and I see the merchant name' do
			visit admin_merchants_path

			click_link "#{merchant_1.name}"

			expect(current_path).to eq(admin_merchant_path(merchant_1))
			expect(page).to have_content('John Doe')
			expect(page).to_not have_content('Brians Beads')
		end
	end
end