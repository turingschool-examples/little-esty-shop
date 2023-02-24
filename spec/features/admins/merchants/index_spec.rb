require 'rails_helper'

RSpec.describe "The Admin Merchants Index" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    
    visit admin_merchants_path
  end
  describe "User Story 24" do
    it "When an admin visits the merchants index (/admin/merchants) they see the name of each merchant in the system" do

      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to have_content(@merchant_4.name)
    end
  end

  describe "User Story 25" do
    it "When an admin visits the merchants index (/admin/merchants) and they click on the merchant's name, they are taken to that merchant's show page And they see the name of that merchant" do
      click_link(@merchant_1.name)

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end
  end
end