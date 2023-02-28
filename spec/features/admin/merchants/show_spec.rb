require 'rails_helper'

RSpec.describe 'admin merchant show page' do
	let!(:merchant_1) { create(:merchant) }
	let!(:merchant_2) { create(:merchant) }
	let!(:merchant_3) { create(:merchant) }


	describe 'update merchant' do
		it 'has a link to update merchant' do
			visit admin_merchant_path(merchant_1)

			expect(page).to have_link("Edit #{merchant_1.name}", href: edit_admin_merchant_path(merchant_1))
		end

		it 'link takes me to page to edit merchant' do
			visit admin_merchant_path(merchant_1)

			click_link "Edit #{merchant_1.name}"
			
			expect(page).to have_field(:name)
		end
	end
end