require 'rails_helper'

RSpec.describe "The Admin Merchants Show Page" do
  describe "User Story 26" do
    it 'When an admin visits a merchants show page, there is a link to update merchant info and when clicked, are taken to the page to edit this merchant' do
      @merchant = create(:merchant)

      visit admin_merchant_path(@merchant)

      expect(page).to have_link("Update Merchant", href: edit_admin_merchant_path(@merchant))

      click_link "Update Merchant"

      expect(current_path).to eq(edit_admin_merchant_path(@merchant))
    end
  end
end