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

    it 'When I click on a merchants name, I am taken to that merchants admin show page' do
      visit admin_merchants_path

      click_link(@merchant_1.name)

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
    end
  end
end