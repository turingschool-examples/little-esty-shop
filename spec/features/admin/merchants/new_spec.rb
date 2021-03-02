require 'rails_helper'

RSpec.describe "New Admin Merchant Page", type: :feature do
  describe "When I visit the new admin merchants page" do
    it "has all the correct form fields" do
      visit "/admin/merchants/new"

      expect(page).to have_field("name")
      expect(page).to have_button("create")
    end

    it "can create a new merchant that is disabled" do
      visit "/admin/merchants/new"

      fill_in "name", with: "Trevor Suter"
      click_button "create"

      new_merchant = Merchant.where(name: "Trevor Suter").first
      expect(current_path).to eq("/admin/merchants")
      within("#merchant-#{new_merchant.id}") do
        expect(page).to have_content("Trevor Suter")
        expect(page).to have_content("disabled")
      end
    end
  end
end