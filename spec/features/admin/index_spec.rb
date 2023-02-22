require 'rails_helper'

describe "As an admin" do
  describe "When I visit the admin dashboard" do
    it "I see a header indicating that I am on the admin dashboard" do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end

    it "I see a link to the admin merchants index" do
      visit "/admin"

      expect(page).to have_link("Admin Merchants")
      expect(page).to have_link("Admin Invoices")
    end
  end
end