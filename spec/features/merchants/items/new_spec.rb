require 'rails_helper'

RSpec.describe 'merchant items new page', type: :feature do
  describe "as a merchant, when i visit the new page, i can create a new item" do
    let!(:merchant1) { create(:merchant)}
    let!(:merchant2) { create(:merchant)}

    let!(:item1) {create(:item, merchant: merchant1)}  
    let!(:item2) {create(:item, merchant: merchant1, status: 'enabled')}
    let!(:item3) {create(:item, merchant: merchant1)}
    let!(:item4) {create(:item, merchant: merchant1)}
    let!(:item5) {create(:item, merchant: merchant2)}

		describe 'filling out form' do
			it 'has the fields to create a new item' do
				visit new_merchant_item_path(merchant1)

				expect(page).to have_field('Name')
				expect(page).to have_field('Description')
				expect(page).to have_field('Unit price')
			end

			describe 'creates a new item when I submit form' do
				before do
					visit new_merchant_item_path(merchant1)

					fill_in 'Name', with: 'Box'
					fill_in 'Description', with: 'Box Description'
					fill_in 'Unit price', with: '1.00'
					click_button
				end

				it 'takes us back to merchant items index page' do
					expect(current_path).to eq(merchant_items_path(merchant1))
				end

				it 'creates a new item and we can see the new item in the list' do
					within '#disabled_items' do
						expect(page).to have_content('Box')
					end

					within '#enabled_items' do
						expect(page).to_not have_content('Box')
					end
				end
			end
		end
	end
end