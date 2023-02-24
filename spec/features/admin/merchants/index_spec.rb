require 'rails_helper'

RSpec.describe 'admin merchants index page' do
	let!(:merchant_1) { Merchant.create!(uuid: 8, name: 'John Doe') }
	let!(:merchant_2) { Merchant.create!(uuid: 43, name: 'Brians Beads') }
	let!(:merchant_3) { Merchant.create!(uuid: 46, name: 'Soras Chains') }


	describe 'shows all merchants' do
		it 'shows all merchants' do
			visit "/admin/merchants"

			expect(page).to have_content('Merchants List')
			
			within "#merchant-list" do
				expect(page).to have_content('John Doe - Status: active')
				expect(page).to have_content('Brians Beads - Status: active')
				expect(page).to have_content('Soras Chains - Status: active')
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

	describe 'admin merchant enable/disable' do
		it 'has a button next to each merchant to disable merchant' do
			visit admin_merchants_path

			within "##{merchant_1.id}" do
				expect(page).to have_button('Disable')
			end

			within "##{merchant_2.id}" do
				expect(page).to have_button('Disable')
			end
		end

		it 'changes status of merchant when button is clicked' do
			visit admin_merchants_path

			expect(page).to have_content('John Doe - Status: active')

			within "##{merchant_1.id}" do
				click_button 'Disable'
			end

			expect(current_path).to eq(admin_merchants_path)
			expect(page).to have_content('John Doe - Status: disabled')
		end
	end
end