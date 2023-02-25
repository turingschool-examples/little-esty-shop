require 'rails_helper'

RSpec.describe "The Admin Merchants Index" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant, status: 1)
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

  describe "User Story 27" do
    it "shows a button next to each merchant to disable or enable that merchant. When I click this button, I am redirected back to the admin merchants index, and I see that the merchant's status has changed" do

      within("#Merchant-#{@merchant_1.id}")  {
        expect(page).to_not have_button("Enable")
        expect(page).to have_button("Disable")
        click_button "Disable"
      }
 
      within("#Merchant-#{@merchant_1.id}")  {
        expect(page).to have_button("Enable")
      }

      expect(current_path).to eq(admin_merchants_path)

      within("#Merchant-#{@merchant_2.id}")  {
        expect(page).to have_button("Enable")
        expect(page).to_not have_button("Disable")

        click_button "Enable"
      }
      
      within("#Merchant-#{@merchant_2.id}")  {
        expect(page).to have_button("Disable")
      }
    end
  end
end