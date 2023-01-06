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

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
    end

    describe 'shows next to each merchant name a button to disable or enable that merchant' do
      it 'Then redirects back to the admin merchants index showing that the merchant\'s status has changed' do
        visit admin_merchants_path

        within ("#admin-merchants-#{@merchant.id}") do
          expect(page).to have_button("Disable/Enable")
        end

        expect(current_path).to eq('/admin/merchants')

        within ("#admin-merchants-#{@merchant.id}") do
          expect(page).to have_button("Disable/Enable")
        end
      end
    end
  end
end