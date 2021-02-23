require 'rails_helper'

RSpec.describe "admin dashboard" do
  describe "when I visit the admin dashboard" do
    it "shows a header indicating that I am on the admin dashboard" do
      visit '/admin'

      within(".header") do
        expect(page).to have_content("Admin Dashboard")
      end
    end

    it "has links to the admin merchant index page and admin invoice index page" do
      visit "/admin"

      within(".header") do
        expect(page).to have_link("Merchants")
        expect(page).to have_link("Invoices")
      end
    end
  end
end
