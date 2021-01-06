require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do
  before :each do
    @merchant_1 = create(:merchant)
  end
  describe 'Admin Merchant Edit Page' do
    it 'can fill in the edit form' do
      visit edit_admin_merchant_path(@merchant_1)
      fill_in 'merchant[name]', with: 'Test'
      click_on 'Update Merchant'

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content('Test')
      expect(page).to have_content("Merchant Test was updated successfully!")
    end
    
  end
end