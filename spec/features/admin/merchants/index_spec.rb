require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  before :each do
    @merchant_1 = create(:merchant, status: 1)
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
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to have_content(@merchant_4.name)
      expect(page).to have_content(@merchant_5.name)
      expect(page).to have_content(@merchant_6.name)
      expect(page).to have_content(@merchant_7.name)
    end
    it 'can have show page links' do
      visit admin_merchants_path
      click_on @merchant_1.name

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
    end
    it 'can disable and enable merchants' do
      visit admin_merchants_path

      within('#merchants-enabled') do
        expect(page).to have_content(@merchant_1.name)
        click_on 'Disable'
      end
      within('#merchants-disabled') do
        expect(page).to have_content(@merchant_1.name)
        
        first('.merchant').click_on('Enable')
        expect(page).not_to have_content(@merchant_2.name)
      end
      within('#merchants-enabled') do
        expect(page).to have_content(@merchant_2.name)
      end
    end
  end
end