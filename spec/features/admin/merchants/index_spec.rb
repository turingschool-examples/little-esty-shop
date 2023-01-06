require 'rails_helper'

RSpec.describe 'the admin merchants index' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
    @merchant_6 = create(:merchant, status: 1)
    @merchant_7 = create(:merchant, status: 1)
    @merchant_8 = create(:merchant, status: 1)
    @merchant_9 = create(:merchant, status: 1)
    @merchant_10 = create(:merchant, status: 1)
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

        within ("#admin-merchants-#{@merchant_1.id}") do
          expect(page).to have_content("Status: #{@merchant_1.status}")
          expect(page).to have_content("Status: enabled")
          expect(page).to have_button("Disable/Enable")
          click_on("Disable/Enable")
        end

        expect(current_path).to eq("/admin/merchants")
        
        within ("#admin-merchants-#{@merchant_1.id}") do
          expect(page).to have_content("Status: disabled")
        end
      end
    end

    it 'shows merchants seperated by status' do
      visit admin_merchants_path

      within ("#admin-merchants-enabled") do
        expect(page).to have_content("Status: #{@merchant_1.status}")
        expect(page).to have_content("Status: #{@merchant_2.status}")
        expect(page).to have_content("Status: #{@merchant_3.status}")
        expect(page).to have_content("Status: #{@merchant_4.status}")
        expect(page).to have_content("Status: #{@merchant_5.status}")
      end

      within ("#admin-merchants-disabled") do
        expect(page).to have_content("Status: #{@merchant_6.status}")
        expect(page).to have_content("Status: #{@merchant_7.status}")
        expect(page).to have_content("Status: #{@merchant_8.status}")
        expect(page).to have_content("Status: #{@merchant_9.status}")
        expect(page).to have_content("Status: #{@merchant_10.status}")
      end
    end
  end
end
