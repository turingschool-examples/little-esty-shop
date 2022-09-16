require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bread Pitt")
    @merchant_2 = Merchant.create!(name: "Carrie Breadshaw")
    @merchant_3 = Merchant.create!(name: "Sheena Yeaston")
    @merchant_4 = Merchant.create!(name: "Taylor Sift")
  end

  describe 'US6' do
    it 'shows the name of all the merchants in the system' do
      visit "/admin/merchants"

      expect(page).to have_content("Bread Pitt")
      expect(page).to have_content("Carrie Breadshaw")
      expect(page).to have_content("Sheena Yeaston")
      expect(page).to have_content("Taylor Sift")
      expect(page).to_not have_content("Meat Loaf") #customer name
    end
  end

  describe 'US7' do
    it 'has a link on each merchants name taking you to their individual show page with their name' do
      visit "/admin/merchants"
      click_link "#{@merchant_1.name}"

      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
      expect(page).to have_content("Bread Pitt")
      expect(page).to_not have_content("Carrie Breadshaw")
    end
  end

  describe 'US9' do
    it 'can disable merchants' do
       # As an admin,
      # When I visit the admin merchants index
      visit "/admin/merchants"
      # Then next to each merchant name I see a button to disable or enable that merchant.
      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_button("Disable")
        # click_button("Disable")
        click_button("Disable")

        # Then I am redirected back to the admin merchants index
        expect(current_path).to eq("/admin/merchants")
        # And I see that the merchant's status has changed
        expect(page).to have_button("Enable")
      end
    end

    it 'can enable merchants' do
     visit "/admin/merchants"
     within("#merchant-#{@merchant_2.id}") do
     click_button("Disable")
     expect(page).to have_button("Enable")
     click_button("Enable")
     expect(current_path).to eq("/admin/merchants")
     expect(page).to have_button("Disable")
     end
   end

  end

end
