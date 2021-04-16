require 'rails_helper'

RSpec.describe "Admin Merchant Show page" do
  before(:each) do
    @parlour = Merchant.create!(name: 'Ice Cream Parlour')
    @tattoo = Merchant.create!(name: 'Tattoo Shop')
    visit "/admin/merchant/#{@parlour.id}"
  end

    it "has a link to updat merchant information" do
      expect(page).to have_link("Update")

      click_link "Update"

      expect(current_path).to eq("/admin/merchant/#{@parlour.id}/edit")

      fill_in 'Name', with: "Ice SCREAM"
      click_button 'Update Merchant'

      expect(page).to have_current_path("/admin/merchant/#{@parlour.id}")
      expect(page).to have_content("Ice SCREAM")
      expect(page).to have_content("Information has been successfully updated.")
      expect(page).to_not have_content("Ice Cream Parlour")
  end
end
