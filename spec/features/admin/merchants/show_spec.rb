require "rails_helper"

RSpec.describe "admin/merchants-show page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Marvel")
    @merchant_2 = Merchant.create!(name: "D.C.")
    @merchant_3 = Merchant.create!(name: "Darkhorse")
    @merchant_4 = Merchant.create!(name: "Image")
  end

    #US 25 As an admin,
    # When I click on the name of a merchant from the admin merchants index page,
    # Then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)
    # And I see the name of that merchant   
  describe 'when I click on the name of the merchant I am taken to the merchant show page' do 
    it "each name links to an merchants' show page" do
      visit "/admin/merchants"
      expect(page).to have_link(@merchant_1.name)
      expect(page).to have_link(@merchant_2.name)
      expect(page).to have_link(@merchant_3.name)
      expect(page).to have_link(@merchant_4.name)
      
      click_on "#{@merchant_1.name}"
      
      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
     
      expect(page).to have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end
  end
end