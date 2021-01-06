require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
    @merchant_6 = create(:merchant)
    @merchant_7 = create(:merchant)
  end
  describe 'List of Merchants' do
    it 'can show a list of each merchant in the system' do
      visit admin_merchants_path
      save_and_open_page
      within('#merchants') do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content(@merchant_4.name)
        expect(page).to have_content(@merchant_5.name)
        expect(page).to have_content(@merchant_6.name)
        expect(page).to have_content(@merchant_7.name)
      end
    end
  end
end