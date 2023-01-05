require 'rails_helper'

RSpec.describe 'the admin merchants index' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
  end

  describe 'As an admin, When I visit the admin merchants index page' do
    it 'shows links to all merchants in the db' do
      visit admin_merchants_path

      expect(page).to have_link(@merchant_1.name)
      expect(page).to have_link(@merchant_2.name)
      expect(page).to have_link(@merchant_3.name)
      expect(page).to have_link(@merchant_4.name)
      expect(page).to have_link(@merchant_5.name)

      click_on(@merchant_1.name)

      save_and_open_page

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
    end
  end
end