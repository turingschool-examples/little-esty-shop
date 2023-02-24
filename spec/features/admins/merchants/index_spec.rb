require 'rails_helper'

RSpec.describe "The Admin Merchants Index" do
  describe "User Story 24" do
    it "When an admin visits the merchants index (/admin/merchants) they see the name of each merchant in the system" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)
      
      visit admin_merchants_path

      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content(merchant_2.name)
      expect(page).to have_content(merchant_3.name)
      expect(page).to have_content(merchant_4.name)
    end
  end
end