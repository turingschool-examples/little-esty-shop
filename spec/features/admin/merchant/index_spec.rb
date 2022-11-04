require "rails_helper"

RSpec.describe "admin/merchants index page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Marvel")
    @merchant_2 = Merchant.create!(name: "D.C.")
    @merchant_3 = Merchant.create!(name: "Darkhorse")
    @merchant_4 = Merchant.create!(name: "Image")
    
    
  end
# US 24 As an admin,
# When I visit the admin merchants index (/admin/merchants)
# Then I see the name of each merchant in the system
   describe 'when i visit the merchant index I see a name for each merchant'do
    it "shows the name of each merchant" do
      visit "/admin/merchants"
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to have_content(@merchant_4.name)
      
    end
   end

end