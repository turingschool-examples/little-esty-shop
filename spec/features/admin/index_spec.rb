require 'rails_helper'

describe "As an admin" do
  describe "When I visit the admin dashboard" do
    it "I see a header indicating that I am on the admin dashboard" do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end

    it "I see a link to the admin merchants index" do
      visit "/admin"

      expect(page).to have_link("Admin Merchants", href: admin_merchants_path)

      click_link "Admin Merchants"

      expect(current_path).to eq("/admin/merchants")
    end

    it "I see a link to the admin invoices index" do
      visit "/admin"

      expect(page).to have_link("Admin Invoices", href: admin_invoices_path)

      click_link "Admin Invoices"

      expect(current_path).to eq("/admin/invoices")
    end
  end
end