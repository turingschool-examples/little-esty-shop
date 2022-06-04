require 'rails_helper'
RSpec.describe 'New Merchant Items Page' do
  let!(:merchant) { create(:merchant) }
  describe 'form' do
    it 'takes the user to a new form page when clicked' do
      visit merchant_items_path(merchant.id)
      click_link 'Create New Item'
      expect(current_path).to eq(new_merchant_item_path(merchant.id))

      fill_in('item[unit_price]', with: 1337)
      fill_in('item[name]', with: 'Bow Tie Pasta')
      fill_in('item[description]', with: 'Tasty')
      click_on 'Submit'
      save_and_open_page
      expect(current_path).to eq(merchant_items_path(merchant.id))
      within '.merchant-items-disabled' do
        expect(page).to have_content('Bow Tie Pasta')
        expect(page).to have_button("Enable")
      end
    end
  end
end
