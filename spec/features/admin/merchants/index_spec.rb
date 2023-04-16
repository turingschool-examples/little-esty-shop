require 'rails_helper'

RSpec.describe 'Admin Merchants Index Page' do
  before :each do
    test_data
  end

  describe 'As an admin, when I visit the Admin Merchants Idex page' do
    it 'I see all merchants in the system' do
      visit admin_merchants_path
      
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to have_content(@merchant_4.name)
      expect(page).to have_content(@merchant_5.name)
    end
  end
end