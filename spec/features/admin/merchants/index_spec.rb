require 'rails_helper'

RSpec.describe 'Admin Merchants Index', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
  end
  describe "Admin Merchant Index Page (User Story 24)" do
    it "displays each merchant in system" do
      visit admin_merchants_path
      expect(page).to have_content("Admin Merchants Index")
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
    end
  end

  describe "Admin Merchant Show (User Story 25)" do
    it "Each merchant name is a link that takes you to their admin show page and it shows their name" do
      visit admin_merchants_path
      click_link(@merchant_1.name)
      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content(@merchant_1.name)

      expect(page).to_not have_content(@merchant_2.name)
      expect(page).to_not have_content(@merchant_3.name)


      visit admin_merchants_path
      click_link(@merchant_2.name)
      expect(current_path).to eq(admin_merchant_path(@merchant_2))
      expect(page).to have_content(@merchant_2.name)

      expect(page).to_not have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_3.name)

      visit admin_merchants_path
      click_link(@merchant_3.name)
      expect(current_path).to eq(admin_merchant_path(@merchant_3))
      expect(page).to have_content(@merchant_3.name)

      expect(page).to_not have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end
  end

end