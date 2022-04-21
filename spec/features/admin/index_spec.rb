require "rails_helper"

RSpec.describe "Admin Dashboard", type: :feature do
  it "shows admin dash header", :vcr do
    visit admin_index_path

    within("#admin-header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end

  it "contains links to merchant and invoice admin views", :vcr do
    visit admin_index_path

    within("#dashboard-links") do
      expect(page).to have_link("Merchants View", href: admin_merchants_path)
      expect(page).to have_link("Invoices View", href: admin_invoices_path)
    end
  end
end
