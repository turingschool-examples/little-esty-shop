require 'rails_helper'

RSpec.describe 'Admin/merchant new' do
  describe 'When I visit the admin merchants index I see a link to create a new merchant' do
    it 'When I click on the link I am taken to a form that allows me to add merchant information' do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)

      visit "/admin/merchants"

      click_link("New Merchant")

      expect(current_path).to eq("/admin/merchants/new")

      fill_in :name, :with => "New Merchant"
      click_button("Submit")

      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("New Merchant")
      expect(page).to have_content("disable")
    end
  end
end
