require 'rails_helper'

RSpec.feature "Admin Merchant Show Page", type: :feature do
  describe 'when accessing the page' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Crystal Moon Designs")
    end
    it 'can be accessed by clicking the merchant name in the admin merchant index' do
      visit admin_merchants_path
      click_link 'Crystal Moon Designs'
    
      expect(page).to have_current_path(admin_merchant_path(@merchant_1))
    end
  end
  describe 'when visiting the page' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Crystal Moon Designs")
    end
    it 'has the name of the merchant' do
      visit admin_merchant_path(@merchant_1)

      expect(page).to have_content("Crystal Moon Designs")
    end
  end
end
