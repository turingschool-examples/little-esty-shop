require "rails_helper"

RSpec.describe "Admin Dashboard", type: :feature do
  it "shows admin dash header", :vcr do
    visit "/admin"

    within("#admin-header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end

  it "contains links to merchant and invoice admin views", :vcr do
    visit "/admin"

    within("#dashboard-links") do
      expect(page).to have_link("Merchants View", href: "/admin/merchants")
      expect(page).to have_link("Invoices View", href: "/admin/invoices")
    end
  end
end
