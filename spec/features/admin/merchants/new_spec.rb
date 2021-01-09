require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do
  describe 'Admin Merchant Edit Page' do
    it 'can fill in the new form' do
      visit new_admin_merchant_path
      fill_in 'Name', with: 'Test'
      click_on 'Create Merchant'

      expect(current_path).to eq(admin_merchants_path(@merchant_1))
      expect(page).to have_content('Test')
    end
  end
end