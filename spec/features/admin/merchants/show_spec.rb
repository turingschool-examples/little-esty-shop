require 'rails_helper'

RSpec.describe 'Admin Merchants Show Page' do
  before :each do
    test_data
  end

  describe 'As an admin, when I visit the Admin Merchants Show page' do
    it 'I see the Merchants name' do
      visit admin_merchant_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)

      visit(admin_merchant_path(@merchant_2))

      expect(page).to have_content(@merchant_2.name)
    end

    it 'has link to update merchant information' do
      visit admin_merchant_path(@merchant_1)

      expect(page).to have_content("Update Merchant Information")
    end

    it 'clicks link to update merchant information' do
      visit admin_merchant_path(@merchant_1)
        
      click_link("Update Merchant Information")
      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")
    end
  end
end