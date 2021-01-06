require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end
  describe 'Admin Merchant Show Page' do
    it 'can show a Merchant name' do
      visit admin_merchant_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)
    end
    it 'can have an update link to change merchant information' do
      visit admin_merchant_path(@merchant_1)
      click_on "Edit Merchant's Info"
      
      expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
    end
  end
end