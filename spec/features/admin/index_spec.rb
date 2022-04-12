require 'rails_helper'
require 'rspec'

describe "Admin dashboard", type: :feature do
  describe "when I visit the admin dashboard page" do
    it "displays a header telling me where I am" do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end

    it "displays a link to admin/merchants" do
      visit "/admin"

      click_on "Admin: Merchants"

      expect(current_path).to eq("/admin/merchants")
    end

    it "displays a link to admin/invoices" do
      visit "/admin"

      click_on "Admin: Invoices"

      expect(current_path).to eq("/admin/invoices")
    end

    it "displays the name of the top 5 customers" do
      visit "/admin"

      expect(page).to have_content("blah")
      expect(page).to have_content("blah")
      expect(page).to have_content("blah")
      expect(page).to have_content("blah")
      expect(page).to have_content("blah")
    end
  end
end
